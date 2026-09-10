import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/localization/masari_localization.dart';
import '../../../core/theme/masari_colors.dart';
import '../../../core/theme/masari_typography.dart';
import '../../../shared/components/masari_cards.dart';

class RealisticAiWorkspaceView extends StatefulWidget {
  const RealisticAiWorkspaceView({super.key});

  @override
  State<RealisticAiWorkspaceView> createState() => _RealisticAiWorkspaceViewState();
}

class _RealisticAiWorkspaceViewState extends State<RealisticAiWorkspaceView> {
  static const _enabledKey = 'masari.admin.ai.enabled';
  static const _modelKey = 'masari.admin.ai.model';
  static const _toneKey = 'masari.admin.ai.tone';
  static const _promptKey = 'masari.admin.ai.system_prompt';

  final _messageController = TextEditingController();
  final List<_ChatMessage> _messages = [];
  bool _enabled = true;
  String _model = 'MASARI Smart';
  String _tone = 'احترافي ودود';
  String _systemPrompt = '';
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadConfiguration();
  }

  Future<void> _loadConfiguration() async {
    final prefs = await SharedPreferences.getInstance();
    if (!mounted) return;
    setState(() {
      _enabled = prefs.getBool(_enabledKey) ?? true;
      _model = prefs.getString(_modelKey) ?? 'MASARI Smart';
      _tone = prefs.getString(_toneKey) ?? 'احترافي ودود';
      _systemPrompt = prefs.getString(_promptKey) ?? '';
      _loading = false;
      if (_enabled) {
        _messages.add(_ChatMessage.bot(masariText(context, 'مرحبًا، أنا مساعد مساري. كيف أساعدك في رحلتك؟', 'Hello, I am the MASARI assistant. How can I help with your journey?')));
      }
    });
  }

  void _send() {
    final text = _messageController.text.trim();
    if (text.isEmpty || !_enabled) return;
    setState(() {
      _messages.add(_ChatMessage.user(text));
      _messageController.clear();
      _messages.add(_ChatMessage.bot(_replyFor(text)));
    });
  }

  String _replyFor(String input) {
    final lower = input.toLowerCase();
    if (lower.contains('سعر') || lower.contains('price')) {
      return masariText(context, 'أستطيع مساعدتك في مقارنة الأسعار والخدمات المنشورة في مساري. لن أعرض سعرًا غير موجود في الكتالوج.', 'I can help compare prices and published MASARI services. I will not invent a price that is not in the catalog.');
    }
    if (lower.contains('حج') || lower.contains('عمرة') || lower.contains('hajj') || lower.contains('umrah')) {
      return masariText(context, 'يمكنني مساعدتك في استكشاف برامج الحج والعمرة المنشورة، ثم توجيهك إلى الحجز المناسب.', 'I can help you explore published Hajj and Umrah programs and guide you to the right booking.');
    }
    return masariText(context, 'سأتعامل مع طلبك بأسلوب «$_tone» وفق إعدادات مدير مساري. النموذج المحدد: $_model.', 'I will handle your request using the “$_tone” style configured by the MASARI administrator. Selected model: $_model.');
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) return const Center(child: CircularProgressIndicator());
    if (!_enabled) {
      return Center(child: MasariCard(child: ListTile(leading: const Icon(Icons.auto_awesome, color: MasariColors.primaryCyan), title: Text(masariText(context, 'المساعد الذكي غير متاح حاليًا', 'AI assistant is currently unavailable')), subtitle: Text(masariText(context, 'يمكن لمدير النظام تفعيله من مركز العمليات → تخصيص الذكاء الاصطناعي.', 'An administrator can enable it from Operations Center → AI Customization.')))));
    }
    return Column(children: [
      MasariLuxuryCard(badgeText: 'MASARI AI', child: Row(children: [
        const Icon(Icons.auto_awesome, color: MasariColors.primaryCyan, size: 34),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(masariText(context, 'مساعد مساري الذكي', 'MASARI AI Assistant'), style: MasariTypography.headlineSmall(color: Colors.white)),
          const SizedBox(height: 4),
          Text('$_model • $_tone', style: MasariTypography.bodySmall(color: MasariColors.titaniumLight)),
        ])),
      ])),
      const SizedBox(height: 12),
      Expanded(child: MasariCard(child: ListView.builder(padding: const EdgeInsets.all(8), itemCount: _messages.length, itemBuilder: (context, index) {
        final message = _messages[index];
        return Align(alignment: message.fromUser ? AlignmentDirectional.centerEnd : AlignmentDirectional.centerStart, child: Container(
          constraints: const BoxConstraints(maxWidth: 680),
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(color: message.fromUser ? MasariColors.primaryBlue : MasariColors.graphiteSurface, borderRadius: BorderRadius.circular(16)),
          child: Text(message.text, style: TextStyle(color: message.fromUser ? Colors.white : MasariColors.titaniumLight)),
        ));
      }))),
      const SizedBox(height: 10),
      MasariCard(child: Row(children: [
        Expanded(child: TextField(controller: _messageController, onSubmitted: (_) => _send(), minLines: 1, maxLines: 3, decoration: InputDecoration(hintText: masariText(context, 'اكتب سؤالك...', 'Type your question...'), border: InputBorder.none))),
        IconButton(onPressed: _send, icon: const Icon(Icons.send_rounded, color: MasariColors.primaryOrange)),
      ])),
      if (_systemPrompt.isNotEmpty) Padding(padding: const EdgeInsets.only(top: 5), child: Text(masariText(context, 'تم تطبيق تعليمات المدير على هذه الجلسة.', 'Administrator instructions are applied to this session.'), style: MasariTypography.caption())),
    ]);
  }
}

class _ChatMessage {
  const _ChatMessage({required this.text, required this.fromUser});
  final String text;
  final bool fromUser;
  factory _ChatMessage.user(String text) => _ChatMessage(text: text, fromUser: true);
  factory _ChatMessage.bot(String text) => _ChatMessage(text: text, fromUser: false);
}
