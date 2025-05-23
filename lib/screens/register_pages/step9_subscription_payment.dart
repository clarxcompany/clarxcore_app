// lib/screens/register_pages/step9_subscription_payment.dart

import 'package:flutter/material.dart';
import '../register_flow.dart';

class Step9SubscriptionPayment extends StatefulWidget {
  final RegisterData data;
  final VoidCallback onNext;
  final VoidCallback onBack;

  const Step9SubscriptionPayment({
    Key? key,
    required this.data,
    required this.onNext,
    required this.onBack,
  }) : super(key: key);

  @override
  _Step9SubscriptionPaymentState createState() =>
      _Step9SubscriptionPaymentState();
}

class _Step9SubscriptionPaymentState extends State<Step9SubscriptionPayment> {
  final _formKey = GlobalKey<FormState>();

  String? _subscriptionPlan;
  String? _paymentMethod;
  late TextEditingController _billingAddressCtrl;

  final List<String> _planOptions = ['Aylık', 'Yıllık'];
  final List<String> _paymentOptions = [
    'Kredi Kartı',
    'Havale/EFT',
    'PayPal',
    'Diğer'
  ];

  @override
  void initState() {
    super.initState();
    _subscriptionPlan = widget.data.subscriptionPlan.isNotEmpty
        ? widget.data.subscriptionPlan
        : null;
    _paymentMethod = widget.data.paymentMethod.isNotEmpty
        ? widget.data.paymentMethod
        : null;
    _billingAddressCtrl =
        TextEditingController(text: widget.data.billingAddress);
  }

  @override
  void dispose() {
    _billingAddressCtrl.dispose();
    super.dispose();
  }

  void _next() {
    if (!_formKey.currentState!.validate()) return;
    widget.data
      ..subscriptionPlan = _subscriptionPlan!
      ..paymentMethod = _paymentMethod!
      ..billingAddress = _billingAddressCtrl.text.trim();
    widget.onNext();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '💳 Abonelik & Ödeme Bilgileri',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 20),

            // Abonelik Planı
            DropdownButtonFormField<String>(
              value: _subscriptionPlan,
              decoration: const InputDecoration(
                labelText: 'Premium Plan Seçimi',
                border: OutlineInputBorder(),
              ),
              items: _planOptions
                  .map((p) => DropdownMenuItem(value: p, child: Text(p)))
                  .toList(),
              onChanged: (v) => setState(() => _subscriptionPlan = v),
              validator: (v) =>
              v == null ? 'Bir plan seçmelisiniz' : null,
            ),
            const SizedBox(height: 16),

            // Ödeme Yöntemi
            DropdownButtonFormField<String>(
              value: _paymentMethod,
              decoration: const InputDecoration(
                labelText: 'Ödeme Yöntemi',
                border: OutlineInputBorder(),
              ),
              items: _paymentOptions
                  .map((pay) =>
                  DropdownMenuItem(value: pay, child: Text(pay)))
                  .toList(),
              onChanged: (v) => setState(() => _paymentMethod = v),
              validator: (v) =>
              v == null ? 'Bir ödeme yöntemi seçmelisiniz' : null,
            ),
            const SizedBox(height: 16),

            // Faturalama Adresi
            TextFormField(
              controller: _billingAddressCtrl,
              decoration: const InputDecoration(
                labelText: 'Faturalama Adresi',
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
              validator: (v) =>
              v == null || v.trim().isEmpty ? 'Gerekli alan' : null,
            ),
            const Spacer(),

            // Geri / İleri Butonları
            Row(
              children: [
                TextButton(
                  onPressed: widget.onBack,
                  child: const Text('Geri'),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: _next,
                  child: const Text('İleri'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
