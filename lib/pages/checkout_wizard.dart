import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  // Add saved personal information and payment method
  Map<String, String> _savedPersonalInfo = {};
  Map<String, String> _savedPaymentMethod = {};

  @override
  void initState() {
    super.initState();
    _loadSavedData();
  }

  Future<void> _loadSavedData() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      _savedPersonalInfo = {
        'Förnamn': prefs.getString('personal_first_name') ?? '',
        'Efternamn': prefs.getString('personal_last_name') ?? '',
        'Telefonnummer': prefs.getString('personal_phone') ?? '',
        'E-post': prefs.getString('personal_email') ?? '',
        'Adress': prefs.getString('personal_address') ?? '',
        'Postnummer': prefs.getString('personal_postcode') ?? '',
      };

      _savedPaymentMethod = {
        'Kortnummer': prefs.getString('payment_card_number') ?? '',
        'Namn på kortet': prefs.getString('payment_card_name') ?? '',
        'Giltig månad (MM)': prefs.getString('payment_card_month') ?? '',
        'Giltigt år (YY)': prefs.getString('payment_card_year') ?? '',
        'CVV-kod': prefs.getString('payment_card_cvv') ?? '',
      };
    });
  }

  Future<void> _savePersonalInfo() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('personal_first_name', _firstNameController.text);
    await prefs.setString('personal_last_name', _lastNameController.text);
    await prefs.setString('personal_phone', _phoneController.text);
    await prefs.setString('personal_email', _emailController.text);
    await prefs.setString('personal_address', _addressController.text);
    await prefs.setString('personal_postcode', _postCodeController.text);
  }

  Future<void> _savePaymentMethod() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('payment_card_number', _cardNumberController.text);
    await prefs.setString('payment_card_name', _cardNameController.text);
    await prefs.setString('payment_card_month', _monthController.text);
    await prefs.setString('payment_card_year', _yearController.text);
    await prefs.setString('payment_card_cvv', _cvvController.text);
  }

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

  Widget _buildInfoCards({required String title, required Map<String, String> data, required VoidCallback onSelectCallback, required VoidCallback onRemoveCallback}) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4), // Reduced margin for smaller height
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8), // Reduced padding for smaller height
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('$title', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(
              data.isEmpty
                  ? 'Empty'
                  : title.contains('Payment')
                      ? '${data['Namn på kortet'] ?? ''}, ${data['Kortnummer'] ?? ''}' // Show name on card and card number for payment
                      : '${data['Förnamn'] ?? ''}, ${data['Adress'] ?? ''}', // Show first name and address for personal info
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(onPressed: onSelectCallback, child: const Text('Välj')),
                const SizedBox(width: 8),
                ElevatedButton(onPressed: onRemoveCallback, child: const Text('Remove')),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _personalInfoStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Personlig information', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        _buildInfoCards(
          title: 'Saved Personal Information',
          data: _savedPersonalInfo,
          onSelectCallback: () {
            if (_savedPersonalInfo.isNotEmpty) {
              _firstNameController.text = _savedPersonalInfo['Förnamn'] ?? '';
              _lastNameController.text = _savedPersonalInfo['Efternamn'] ?? '';
              _phoneController.text = _savedPersonalInfo['Telefonnummer'] ?? '';
              _emailController.text = _savedPersonalInfo['E-post'] ?? '';
              _addressController.text = _savedPersonalInfo['Adress'] ?? '';
              _postCodeController.text = _savedPersonalInfo['Postnummer'] ?? '';
            }
          },
          onRemoveCallback: () {
            setState(() => _savedPersonalInfo.clear());
          },
        ),
        const SizedBox(height: 16),
        TextField(controller: _firstNameController, decoration: const InputDecoration(labelText: 'Förnamn')),
        TextField(controller: _lastNameController, decoration: const InputDecoration(labelText: 'Efternamn')),
        TextField(controller: _phoneController, decoration: const InputDecoration(labelText: 'Telefonnummer')),
        TextField(controller: _emailController, decoration: const InputDecoration(labelText: 'E-post')),
        TextField(controller: _addressController, decoration: const InputDecoration(labelText: 'Adress')),
        TextField(controller: _postCodeController, decoration: const InputDecoration(labelText: 'Postnummer')),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () async {
            setState(() {
              _savedPersonalInfo = {
                'Förnamn': _firstNameController.text,
                'Efternamn': _lastNameController.text,
                'Telefonnummer': _phoneController.text,
                'E-post': _emailController.text,
                'Adress': _addressController.text,
                'Postnummer': _postCodeController.text,
              };
            });
            await _savePersonalInfo();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Personlig information sparad!')),
            );
          },
          child: const Text('Spara'),
        ),
      ],
    );
  }

  Widget _paymentStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Betalningsmetod', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        _buildInfoCards(
          title: 'Saved Payment Method',
          data: _savedPaymentMethod,
          onSelectCallback: () {
            if (_savedPaymentMethod.isNotEmpty) {
              _cardNumberController.text = _savedPaymentMethod['Kortnummer'] ?? '';
              _cardNameController.text = _savedPaymentMethod['Namn på kortet'] ?? '';
              _monthController.text = _savedPaymentMethod['Giltig månad (MM)'] ?? '';
              _yearController.text = _savedPaymentMethod['Giltigt år (YY)'] ?? '';
              _cvvController.text = _savedPaymentMethod['CVV-kod'] ?? '';
            }
          },
          onRemoveCallback: () {
            setState(() => _savedPaymentMethod.clear());
          },
        ),
        const SizedBox(height: 16),
        TextField(controller: _cardNumberController, decoration: const InputDecoration(labelText: 'Kortnummer')),
        TextField(controller: _cardNameController, decoration: const InputDecoration(labelText: 'Namn på kortet')),
        TextField(controller: _monthController, decoration: const InputDecoration(labelText: 'Giltig månad (MM)')),
        TextField(controller: _yearController, decoration: const InputDecoration(labelText: 'Giltigt år (YY)')),
        TextField(controller: _cvvController, decoration: const InputDecoration(labelText: 'CVV-kod')),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () async {
            setState(() {
              _savedPaymentMethod = {
                'Kortnummer': _cardNumberController.text,
                'Namn på kortet': _cardNameController.text,
                'Giltig månad (MM)': _monthController.text,
                'Giltigt år (YY)': _yearController.text,
                'CVV-kod': _cvvController.text,
              };
            });
            await _savePaymentMethod();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Betalningsmetod sparad!')),
            );
          },
          child: const Text('Spara'),
        ),
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
        leading: TextButton(
          onPressed: () => Navigator.of(context).pop(), // Quit checkout
          child: const Text('Quit', style: TextStyle(color: Colors.black)), // Changed color to black
        ),
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
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (_step > 0) {
                      _prevStep(); // Go back one step
                    } else {
                      Navigator.of(context).pop(); // Quit checkout if on the first step
                    }
                  },
                  child: const Text('Tillbaka'),
                ),
                const SizedBox(width: 8),
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
