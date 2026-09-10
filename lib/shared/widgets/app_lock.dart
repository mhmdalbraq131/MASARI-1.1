import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/security/protected_route_guard.dart';
import '../../core/theme/masari_colors.dart';
import '../../core/theme/masari_typography.dart';
import '../../features/foundation/presentation/providers/app_providers.dart';

const _pinKey = 'masari.app_lock.pin.v1';

class AppLockState {
  final String? pin;
  final bool locked;
  const AppLockState({this.pin, this.locked = false});

  AppLockState copyWith({String? pin, bool? locked}) => AppLockState(
        pin: pin ?? this.pin,
        locked: locked ?? this.locked,
      );
}

class AppLockNotifier extends StateNotifier<AppLockState> {
  AppLockNotifier() : super(const AppLockState());

  Future<void> initialize() async {
    final prefs = await SharedPreferences.getInstance();
    state = state.copyWith(pin: prefs.getString(_pinKey));
  }

  Future<void> setPin(String pin) async {
    final normalized = pin.trim();
    if (!RegExp(r'^\d{4}$').hasMatch(normalized)) return;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_pinKey, normalized);
    state = state.copyWith(pin: normalized, locked: false);
  }

  void lockIfProtected(UserRole role) {
    if (role != UserRole.guest && state.pin != null) {
      state = state.copyWith(locked: true);
    }
  }

  bool unlock(String pin, UserRole role) {
    if (role == UserRole.guest || state.pin == null || pin == state.pin) {
      state = state.copyWith(locked: false);
      return true;
    }
    return false;
  }
}

final appLockProvider = StateNotifierProvider<AppLockNotifier, AppLockState>((ref) {
  final notifier = AppLockNotifier();
  notifier.initialize();
  return notifier;
});

class AppLockGate extends ConsumerStatefulWidget {
  final Widget child;
  const AppLockGate({super.key, required this.child});

  @override
  ConsumerState<AppLockGate> createState() => _AppLockGateState();
}

class _AppLockGateState extends ConsumerState<AppLockGate> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused || state == AppLifecycleState.inactive) {
      ref.read(appLockProvider.notifier).lockIfProtected(ref.read(userRoleProvider));
    }
  }

  @override
  Widget build(BuildContext context) {
    final session = ref.watch(userSessionProvider);
    final lock = ref.watch(appLockProvider);

    if (!session.isAuthenticated || session.role == UserRole.guest) return widget.child;

    if (lock.pin == null) {
      return Stack(children: [widget.child, const _PinSetupOverlay()]);
    }

    if (lock.locked) {
      return Stack(children: [widget.child, const _PinUnlockOverlay()]);
    }

    return widget.child;
  }
}

class _PinSetupOverlay extends ConsumerStatefulWidget {
  const _PinSetupOverlay();
  @override
  ConsumerState<_PinSetupOverlay> createState() => _PinSetupOverlayState();
}

class _PinSetupOverlayState extends ConsumerState<_PinSetupOverlay> {
  final _controller = TextEditingController();
  final _confirm = TextEditingController();
  String? _error;

  @override
  void dispose() {
    _controller.dispose();
    _confirm.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!RegExp(r'^\d{4}$').hasMatch(_controller.text) || _controller.text != _confirm.text) {
      setState(() => _error = 'أدخل رمزًا من 4 أرقام متطابقًا.');
      return;
    }
    await ref.read(appLockProvider.notifier).setPin(_controller.text);
  }

  @override
  Widget build(BuildContext context) => _LockBackdrop(
        title: 'حماية حساب مساري',
        subtitle: 'لأنك دخلت بحساب مستخدم أو مدير، أنشئ رمزًا من 4 أرقام لحماية التطبيق.',
        icon: Icons.lock_outline,
        children: [
          TextField(controller: _controller, obscureText: true, maxLength: 4, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'رمز الحماية', counterText: '')),
          const SizedBox(height: 12),
          TextField(controller: _confirm, obscureText: true, maxLength: 4, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'تأكيد الرمز', counterText: '')),
          if (_error != null) ...[const SizedBox(height: 8), Text(_error!, style: const TextStyle(color: MasariColors.error))],
          const SizedBox(height: 20),
          SizedBox(width: double.infinity, child: ElevatedButton(onPressed: _save, child: const Text('تفعيل الحماية'))),
        ],
      );
}

class _PinUnlockOverlay extends ConsumerStatefulWidget {
  const _PinUnlockOverlay();
  @override
  ConsumerState<_PinUnlockOverlay> createState() => _PinUnlockOverlayState();
}

class _PinUnlockOverlayState extends ConsumerState<_PinUnlockOverlay> {
  final _controller = TextEditingController();
  String? _error;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _unlock() {
    final role = ref.read(userRoleProvider);
    if (!ref.read(appLockProvider.notifier).unlock(_controller.text, role)) {
      setState(() => _error = 'رمز الحماية غير صحيح.');
    }
  }

  @override
  Widget build(BuildContext context) => _LockBackdrop(
        title: 'التطبيق مقفل',
        subtitle: 'أدخل رمز الحماية للمتابعة إلى مساري.',
        icon: Icons.lock,
        children: [
          TextField(controller: _controller, autofocus: true, obscureText: true, maxLength: 4, keyboardType: TextInputType.number, onSubmitted: (_) => _unlock(), decoration: const InputDecoration(labelText: 'رمز الحماية', counterText: '')),
          if (_error != null) ...[const SizedBox(height: 8), Text(_error!, style: const TextStyle(color: MasariColors.error))],
          const SizedBox(height: 20),
          SizedBox(width: double.infinity, child: ElevatedButton(onPressed: _unlock, child: const Text('فتح التطبيق'))),
        ],
      );
}

class _LockBackdrop extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final List<Widget> children;

  const _LockBackdrop({required this.title, required this.subtitle, required this.icon, required this.children});

  @override
  Widget build(BuildContext context) => Material(
        color: MasariColors.primaryBlueDark.withValues(alpha: 0.96),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 430),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(28),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(radius: 30, backgroundColor: MasariColors.primaryCyan.withValues(alpha: 0.15), child: Icon(icon, color: MasariColors.primaryCyan, size: 30)),
                      const SizedBox(height: 18),
                      Text(title, style: MasariTypography.headlineSmall(), textAlign: TextAlign.center),
                      const SizedBox(height: 8),
                      Text(subtitle, style: MasariTypography.bodyMedium(color: MasariColors.titaniumGray), textAlign: TextAlign.center),
                      const SizedBox(height: 22),
                      ...children,
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}
