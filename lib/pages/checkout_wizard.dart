import 'package:flutter/material.dart';

class CheckoutWizard extends StatefulWidget {
  const CheckoutWizard({super.key});

  @override
  State<CheckoutWizard> createState() => _CheckoutWizardState();
}

class _CheckoutWizardState extends State<CheckoutWizard> {
  int _step = 0;

  // Personal info controllers
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  final _postCodeController = TextEditingController();

  // Payment controllers
  final _cardNumberController = TextEditingController();
  final _cardNameController = TextEditingController();
  final _monthController = TextEditingController();
  final _yearController = TextEditingController();
  final _cvvController = TextEditingController();

  // Delivery selection
  int? _selectedDelivery;
  final List<Map<String, String>> _deliveryOptions = [
    {'date': '2025-05-16', 'time': '09:00-11:00'},
    {'date': '2025-05-16', 'time': '13:00-15:00'},
    {'date': '2025-05-17', 'time': '09:00-11:00'},
    {'date': '2025-05-17', 'time': '13:00-15:00'},
  ];

  void _nextStep() {
    if (_step < 2) {
      setState(() => _step++);
    } else {
      // Submit order logic here
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Order skickad!')),
      );
    }
  }

  void _prevStep() {
    if (_step > 0) setState(() => _step--);
  }

  Widget _buildStep() {
    switch (_step) {
      case 0:
        return _personalInfoStep();
      case 1:
        return _paymentStep();
      case 2:
        return _deliveryStep();
      default:
        return const SizedBox();
    }
  }

  Widget _buildStepIndicator() {
    final steps = [
      'Personlig information',
      'Betalnings metod',
      'Leverans dag',
    ];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(steps.length, (i) {
        final isActive = i == _step;
        final isCompleted = i < _step;
        return Expanded(
          child: Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: isActive
                    ? Colors.blue
                    : isCompleted
                        ? Colors.blue[200]
                        : Colors.white,
                child: Text(
                  steps[i][0],
                  style: TextStyle(
                    color: isActive || isCompleted ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                steps[i],
                style: TextStyle(
                  fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                  color: isActive ? Colors.blue : Colors.black,
                ),
              ),
              if (i < steps.length - 1)
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    height: 2,
                    color: isCompleted ? Colors.blue : Colors.grey[300],
                  ),
                ),
            ],
          ),
        );
      }),
    );
  }

  Widget _personalInfoStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Personlig information', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        TextField(controller: _firstNameController, decoration: const InputDecoration(labelText: 'Förnamn')),
        TextField(controller: _lastNameController, decoration: const InputDecoration(labelText: 'Efternamn')),
        TextField(controller: _phoneController, decoration: const InputDecoration(labelText: 'Telefonnummer')),
        TextField(controller: _emailController, decoration: const InputDecoration(labelText: 'E-post')),
        TextField(controller: _addressController, decoration: const InputDecoration(labelText: 'Adress')),
        TextField(controller: _postCodeController, decoration: const InputDecoration(labelText: 'Postnummer')),
      ],
    );
  }

  Widget _paymentStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Betalningsmetod', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        TextField(controller: _cardNumberController, decoration: const InputDecoration(labelText: 'Kortnummer')),
        TextField(controller: _cardNameController, decoration: const InputDecoration(labelText: 'Namn på kortet')),
        TextField(controller: _monthController, decoration: const InputDecoration(labelText: 'Giltig månad (MM)')),
        TextField(controller: _yearController, decoration: const InputDecoration(labelText: 'Giltigt år (YY)')),
        TextField(controller: _cvvController, decoration: const InputDecoration(labelText: 'CVV-kod')),
      ],
    );
  }

  Widget _deliveryStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Leveransdag', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        ...List.generate(_deliveryOptions.length, (i) {
          final opt = _deliveryOptions[i];
          return ListTile(
            title: Text('${opt['date']}  ${opt['time']}'),
            leading: Radio<int>(
              value: i,
              groupValue: _selectedDelivery,
              onChanged: (val) => setState(() => _selectedDelivery = val),
            ),
            onTap: () => setState(() => _selectedDelivery = i),
          );
        }),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
        leading: _step > 0
            ? IconButton(icon: const Icon(Icons.arrow_back), onPressed: _prevStep)
            : null,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            _buildStepIndicator(),
            const SizedBox(height: 16),
            LinearProgressIndicator(value: (_step + 1) / 3),
            const SizedBox(height: 24),
            Expanded(child: SingleChildScrollView(child: _buildStep())),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: _nextStep,
                  child: Text(_step < 2 ? 'Nästa' : 'Slutför'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
