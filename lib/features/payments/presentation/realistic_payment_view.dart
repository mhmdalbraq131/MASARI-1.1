import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/localization/masari_localization.dart';
import '../../../core/theme/masari_colors.dart';
import '../../../core/theme/masari_typography.dart';
import '../../../shared/components/masari_cards.dart';

class RealisticPaymentView extends StatefulWidget {
  const RealisticPaymentView({super.key});

  @override
  State<RealisticPaymentView> createState() => _RealisticPaymentViewState();
}

class _RealisticPaymentViewState extends State<RealisticPaymentView> {
  static const _balanceKey = 'masari.wallet.balance.v2';
  static const _transactionsKey = 'masari.wallet.transactions.v2';
  double _balance = 0;
  List<String> _transactions = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    if (!mounted) return;
    setState(() {
      _balance = prefs.getDouble(_balanceKey) ?? 0;
      _transactions = prefs.getStringList(_transactionsKey) ?? [];
      _loading = false;
    });
  }

  Future<void> _openTopUp() async {
    final amount = await showModalBottomSheet<double>(
      context: context,
      isScrollControlled: true,
      builder: (context) => const _PaymentCheckoutSheet(),
    );
    if (amount == null || amount <= 0) return;
    final prefs = await SharedPreferences.getInstance();
    final now = DateTime.now();
    final nextBalance = _balance + amount;
    final nextTransactions = [
      'إيداع • +${amount.toStringAsFixed(2)} SAR • ${now.toString().substring(0, 16)}',
      ..._transactions,
    ].take(20).toList();
    await prefs.setDouble(_balanceKey, nextBalance);
    await prefs.setStringList(_transactionsKey, nextTransactions);
    if (!mounted) return;
    setState(() {
      _balance = nextBalance;
      _transactions = nextTransactions;
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(masariText(context, 'تمت محاكاة عملية الدفع بنجاح وإضافة الرصيد.', 'Payment simulated successfully and balance was updated.'))));
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) return const Center(child: CircularProgressIndicator());
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        MasariLuxuryCard(
          badgeText: 'MASARI PAY',
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(masariText(context, 'الدفع والمحفظة', 'Payments & Wallet'), style: MasariTypography.headlineSmall(color: Colors.white)),
            const SizedBox(height: 8),
            Text(masariText(context, 'دفع تجريبي واقعي الشكل مع اختيار وسيلة الدفع، بيانات البطاقة، مراجعة العملية وإيصال محلي.', 'A realistic prototype checkout with payment method, card details, review, and a local receipt.'), style: MasariTypography.bodySmall(color: MasariColors.titaniumLight)),
          ]),
        ),
        const SizedBox(height: 16),
        MasariCard(child: Column(children: [
          Text(masariText(context, 'الرصيد المتاح', 'Available balance'), style: MasariTypography.bodyMedium()),
          const SizedBox(height: 5),
          Text('${_balance.toStringAsFixed(2)} SAR', style: MasariTypography.headlineSmall(color: MasariColors.primaryCyan)),
          const SizedBox(height: 14),
          SizedBox(width: double.infinity, child: ElevatedButton.icon(onPressed: _openTopUp, icon: const Icon(Icons.lock_outline), label: Text(masariText(context, 'إضافة رصيد عبر دفع آمن', 'Add funds with secure checkout')))),
        ])),
        const SizedBox(height: 14),
        MasariCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(masariText(context, 'آخر العمليات', 'Recent transactions'), style: MasariTypography.titleMedium(color: MasariColors.primaryCyan)),
          const SizedBox(height: 8),
          if (_transactions.isEmpty)
            Text(masariText(context, 'لا توجد عمليات حتى الآن.', 'No transactions yet.'))
          else
            ..._transactions.map((transaction) => ListTile(leading: const Icon(Icons.receipt_long, color: MasariColors.primaryOrange), title: Text(transaction), dense: true)),
        ])),
        const SizedBox(height: 12),
        MasariCard(child: ListTile(
          leading: const Icon(Icons.verified_user_outlined, color: MasariColors.success),
          title: Text(masariText(context, 'حماية الدفع', 'Payment protection')),
          subtitle: Text(masariText(context, 'بيانات البطاقة في هذه النسخة لا تُرسل إلى أي جهة. العملية محاكاة محليًا، والربط الحقيقي يحتاج بوابة دفع وخادمًا آمنًا.', 'Card data is not sent anywhere in this prototype. The transaction is simulated locally; real payments require a secure gateway and backend.')),
        )),
      ]),
    );
  }
}

class _PaymentCheckoutSheet extends StatefulWidget {
  const _PaymentCheckoutSheet();

  @override
  State<_PaymentCheckoutSheet> createState() => _PaymentCheckoutSheetState();
}

class _PaymentCheckoutSheetState extends State<_PaymentCheckoutSheet> {
  final _amount = TextEditingController(text: '500');
  final _name = TextEditingController();
  final _card = TextEditingController();
  final _expiry = TextEditingController();
  final _cvv = TextEditingController();
  String _method = 'بطاقة بنكية';

  @override
  void dispose() {
    _amount.dispose();
    _name.dispose();
    _card.dispose();
    _expiry.dispose();
    _cvv.dispose();
    super.dispose();
  }

  void _pay() {
    final value = double.tryParse(_amount.text.replaceAll(',', '').trim());
    final card = _card.text.replaceAll(' ', '');
    if (value == null || value < 10 || value > 100000) {
      _error('أدخل مبلغًا بين 10 و100,000 SAR.');
      return;
    }
    if (_method == 'بطاقة بنكية' && (card.length < 12 || _cvv.text.trim().length < 3 || _expiry.text.trim().length < 4)) {
      _error('أكمل بيانات البطاقة بشكل صحيح.');
      return;
    }
    if (_method == 'بطاقة بنكية' && _name.text.trim().isEmpty) {
      _error('أدخل اسم حامل البطاقة.');
      return;
    }
    Navigator.pop(context, value);
  }

  void _error(String message) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(masariText(context, message, 'Please complete the payment details correctly.'))));

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20, top: 18, bottom: MediaQuery.viewInsetsOf(context).bottom + 20),
      child: SingleChildScrollView(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Center(child: Container(width: 42, height: 4, decoration: BoxDecoration(color: Colors.grey.shade400, borderRadius: BorderRadius.circular(4)))),
        const SizedBox(height: 16),
        Text(masariText(context, 'إتمام الدفع', 'Complete payment'), style: MasariTypography.headlineSmall()),
        const SizedBox(height: 5),
        Text(masariText(context, 'اختر الطريقة ثم راجع بيانات العملية قبل التأكيد.', 'Choose a method and review the transaction before confirmation.')),
        const SizedBox(height: 14),
        TextField(controller: _amount, keyboardType: TextInputType.number, decoration: InputDecoration(labelText: masariText(context, 'المبلغ (SAR)', 'Amount (SAR)'), prefixIcon: const Icon(Icons.payments_outlined))),
        const SizedBox(height: 10),
        DropdownButtonFormField<String>(initialValue: _method, decoration: InputDecoration(labelText: masariText(context, 'وسيلة الدفع', 'Payment method')), items: const [
          DropdownMenuItem(value: 'بطاقة بنكية', child: Text('Visa / Mastercard')),
          DropdownMenuItem(value: 'تحويل بنكي', child: Text('Bank transfer')),
          DropdownMenuItem(value: 'محفظة رقمية', child: Text('Digital wallet')),
        ], onChanged: (value) => setState(() => _method = value ?? _method)),
        if (_method == 'بطاقة بنكية') ...[
          const SizedBox(height: 10),
          TextField(controller: _name, decoration: InputDecoration(labelText: masariText(context, 'اسم حامل البطاقة', 'Cardholder name'), prefixIcon: const Icon(Icons.person_outline))),
          const SizedBox(height: 10),
          TextField(controller: _card, keyboardType: TextInputType.number, maxLength: 19, decoration: InputDecoration(labelText: masariText(context, 'رقم البطاقة', 'Card number'), prefixIcon: const Icon(Icons.credit_card), counterText: '')),
          const SizedBox(height: 10),
          Row(children: [Expanded(child: TextField(controller: _expiry, keyboardType: TextInputType.number, maxLength: 5, decoration: InputDecoration(labelText: 'MM/YY', counterText: ''))), const SizedBox(width: 10), Expanded(child: TextField(controller: _cvv, keyboardType: TextInputType.number, obscureText: true, maxLength: 4, decoration: InputDecoration(labelText: 'CVV', counterText: '')))]),
        ],
        const SizedBox(height: 18),
        SizedBox(width: double.infinity, child: ElevatedButton.icon(onPressed: _pay, icon: const Icon(Icons.lock), label: Text(masariText(context, 'تأكيد ودفع', 'Confirm & Pay')))),
        const SizedBox(height: 8),
        Center(child: Text(masariText(context, '🔒 وضع تجريبي — لا يتم إرسال بيانات البطاقة.', '🔒 Demo mode — card data is never transmitted.'), style: MasariTypography.caption())),
      ])),
    );
  }
}
