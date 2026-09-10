import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/localization/masari_localization.dart';
import '../../../../core/theme/masari_colors.dart';
import '../../../../core/theme/masari_typography.dart';
import '../../../../shared/components/masari_cards.dart';

class AdminAiSettingsView extends ConsumerStatefulWidget {
  const AdminAiSettingsView({super.key});

  @override
  ConsumerState<AdminAiSettingsView> createState() => _AdminAiSettingsViewState();
}

class _AdminAiSettingsViewState extends ConsumerState<AdminAiSettingsView> {
  static const _enabledKey = 'masari.admin.ai.enabled';
  static const _modelKey = 'masari.admin.ai.model';
  static const _toneKey = 'masari.admin.ai.tone';
  static const _temperatureKey = 'masari.admin.ai.temperature';
  static const _systemPromptKey = 'masari.admin.ai.system_prompt';

  bool _enabled = true;
  String _model = 'MASARI Smart';
  String _tone = 'احترافي ودود';
  double _temperature = 0.35;
  final _promptController = TextEditingController(
    text: 'أنت مساعد مساري الذكي. ساعد العميل في السفر والحج والعمرة، وقدّم معلومات واضحة ومختصرة، ولا تخترع أسعارًا أو حجوزات غير موجودة.',
  );
  bool _loaded = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    if (!mounted) return;
    setState(() {
      _enabled = prefs.getBool(_enabledKey) ?? true;
      _model = prefs.getString(_modelKey) ?? 'MASARI Smart';
      _tone = prefs.getString(_toneKey) ?? 'احترافي ودود';
      _temperature = prefs.getDouble(_temperatureKey) ?? 0.35;
      _promptController.text = prefs.getString(_systemPromptKey) ?? _promptController.text;
      _loaded = true;
    });
  }

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_enabledKey, _enabled);
    await prefs.setString(_modelKey, _model);
    await prefs.setString(_toneKey, _tone);
    await prefs.setDouble(_temperatureKey, _temperature);
    await prefs.setString(_systemPromptKey, _promptController.text.trim());
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(masariText(context, 'تم حفظ تخصيص المساعد الذكي.', 'AI assistant customization saved.'))),
    );
  }

  @override
  void dispose() {
    _promptController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_loaded) return const Center(child: CircularProgressIndicator());
    return SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(masariText(context, 'تخصيص مساري AI', 'MASARI AI Customization'), style: MasariTypography.headlineSmall(color: Colors.white)),
        const SizedBox(height: 5),
        Text(masariText(context, 'تحكم في شخصية المساعد وسلوكه من مركز المدير. الإعدادات محفوظة محليًا في هذه النسخة التجريبية.', 'Control the assistant persona and behavior from the admin center. Settings are stored locally in this prototype.'), style: MasariTypography.bodySmall(color: MasariColors.titaniumGray)),
        const SizedBox(height: 18),
        MasariCard(child: Column(children: [
          SwitchListTile.adaptive(
            contentPadding: EdgeInsets.zero,
            title: Text(masariText(context, 'تفعيل المساعد', 'Enable assistant')),
            subtitle: Text(masariText(context, 'إظهار مساعد مساري للعملاء.', 'Show the MASARI assistant to customers.')),
            value: _enabled,
            onChanged: (value) => setState(() => _enabled = value),
          ),
          const Divider(),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(masariText(context, 'نموذج الذكاء الاصطناعي', 'AI model')),
            trailing: DropdownButton<String>(
              value: _model,
              items: const [
                DropdownMenuItem(value: 'MASARI Smart', child: Text('MASARI Smart')),
                DropdownMenuItem(value: 'MASARI Fast', child: Text('MASARI Fast')),
                DropdownMenuItem(value: 'MASARI Pro', child: Text('MASARI Pro')),
              ],
              onChanged: (value) { if (value != null) setState(() => _model = value); },
            ),
          ),
          const Divider(),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(masariText(context, 'أسلوب الرد', 'Response tone')),
            trailing: DropdownButton<String>(
              value: _tone,
              items: const [
                DropdownMenuItem(value: 'احترافي ودود', child: Text('احترافي ودود')),
                DropdownMenuItem(value: 'مختصر ومباشر', child: Text('مختصر ومباشر')),
                DropdownMenuItem(value: 'فاخر وتسويقي', child: Text('فاخر وتسويقي')),
                DropdownMenuItem(value: 'إرشادي وروحاني', child: Text('إرشادي وروحاني')),
              ],
              onChanged: (value) { if (value != null) setState(() => _tone = value); },
            ),
          ),
        ])),
        const SizedBox(height: 12),
        MasariCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(masariText(context, 'درجة الإبداع', 'Creativity'), style: MasariTypography.titleMedium(color: MasariColors.primaryCyan)),
          const SizedBox(height: 4),
          Text('${_temperature.toStringAsFixed(2)}  •  ${_temperature < .3 ? masariText(context, 'دقيق', 'Precise') : _temperature > .7 ? masariText(context, 'إبداعي', 'Creative') : masariText(context, 'متوازن', 'Balanced')}', style: MasariTypography.bodySmall()),
          Slider(value: _temperature, min: 0, max: 1, divisions: 20, label: _temperature.toStringAsFixed(2), onChanged: (value) => setState(() => _temperature = value)),
        ])),
        const SizedBox(height: 12),
        MasariCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(masariText(context, 'تعليمات المساعد الأساسية', 'System instructions'), style: MasariTypography.titleMedium(color: MasariColors.primaryCyan)),
          const SizedBox(height: 8),
          TextField(controller: _promptController, maxLines: 7, decoration: InputDecoration(border: const OutlineInputBorder(), hintText: masariText(context, 'اكتب قواعد المساعد...', 'Write assistant rules...'))),
          const SizedBox(height: 12),
          Align(alignment: AlignmentDirectional.centerEnd, child: ElevatedButton.icon(onPressed: _save, icon: const Icon(Icons.save_outlined), label: Text(masariText(context, 'حفظ التخصيص', 'Save customization')))),
        ])),
      ],
    );
  }
}
