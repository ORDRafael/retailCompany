import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:obramat/utils/colors.dart';
import 'package:obramat/widgets/appbar.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final PageController _pageController = PageController();

  int _selectedDate = 0;

  final List<Map<String, String>> _dates = [
    {'day': 'Today', 'date': 'OCT 12', 'type': 'Express'},
    {'day': 'Tomorrow', 'date': 'OCT 13', 'type': 'Standard'},
    {'day': 'Monday', 'date': 'OCT 14', 'type': 'Standard'},
    {'day': 'Tuesday', 'date': 'OCT 15', 'type': 'Scheduled'},
  ];

  int _currentStep = 0;

  final List<String> _steps = ['Revisión', 'Entrega', 'Pago', 'Confirmación'];

  void _nextPage() {
    _pageController.nextPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _previousPage() {
    _pageController.previousPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: 'CHECKOUT',
        showSearch: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Column(
        children: [
          // Indicador de pasos
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: List.generate(_steps.length, (index) {
                final isCompleted = index < _currentStep;
                final isActive = index == _currentStep;
                return Expanded(
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Container(
                            width: 28,
                            height: 28,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isCompleted || isActive
                                  ? AppColors.primaryColor
                                  : Colors.grey[300],
                            ),
                            child: Center(
                              child: isCompleted
                                  ? Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 14,
                                    )
                                  : Text(
                                      '${index + 1}',
                                      style: TextStyle(
                                        color: isActive
                                            ? Colors.white
                                            : Colors.grey[600],
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            _steps[index],
                            style: TextStyle(
                              fontSize: 10,
                              color: isActive
                                  ? AppColors.primaryColor
                                  : Colors.grey[500],
                              fontWeight: isActive
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                      // Línea conectora entre pasos
                      if (index < _steps.length - 1)
                        Expanded(
                          child: Container(
                            height: 1,
                            margin: EdgeInsets.only(bottom: 20),
                            color: index < _currentStep
                                ? AppColors.primaryColor
                                : Colors.grey[300],
                          ),
                        ),
                    ],
                  ),
                );
              }),
            ),
          ),
          // Contenido de cada paso
          Expanded(
            child: PageView(
              controller: _pageController,
              physics:
                  NeverScrollableScrollPhysics(), // 👈 solo avanza con botones
              onPageChanged: (index) {
                setState(() => _currentStep = index);
              },
              children: [
                _buildStepRevision(),
                _buildStepEntrega(),
                _buildStepPago(),
                _buildStepConfirmacion(),
              ],
            ),
          ),
          // Botones de navegación
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                if (_currentStep > 0)
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _previousPage,
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: AppColors.primaryColor),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Atrás',
                        style: TextStyle(color: AppColors.primaryColor),
                      ),
                    ),
                  ),
                if (_currentStep > 0) SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _currentStep < _steps.length - 1
                        ? _nextPage
                        : () {}, // confirmar pedido
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      _currentStep < _steps.length - 1
                          ? 'Continuar'
                          : 'Confirmar Pedido',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepRevision() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Revisión del pedido'),
            SizedBox(height: 8),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Full Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            Text('Contact number'),
            SizedBox(height: 8),
            TextFormField(
              decoration: InputDecoration(
                labelText: '+34 650 58 47 69',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            Text('Delivery Address'),
            SizedBox(height: 8),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Paseo de Canalejas',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('City'),
                      SizedBox(height: 8),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Salamanca',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Postal Code'),
                      SizedBox(height: 8),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: '00000',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text('Country'),
            SizedBox(height: 8),
            DropdownButtonFormField<String>(
              initialValue: 'SP',
              decoration: InputDecoration(border: OutlineInputBorder()),
              items: [
                DropdownMenuItem(value: 'SP', child: Text('España')),
                DropdownMenuItem(value: 'IT', child: Text('Italia')),
                DropdownMenuItem(value: 'PT', child: Text('Portugal')),
              ],
              onChanged: (value) {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepEntrega() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.5,
            ),
            itemCount: _dates.length,
            itemBuilder: (context, index) {
              final isSelected = _selectedDate == index;
              final date = _dates[index];
              return GestureDetector(
                onTap: () => setState(() => _selectedDate = index),
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isSelected
                          ? AppColors.primaryColor
                          : Colors.grey[300]!,
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        date['date']!,
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey[500],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        date['day']!,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        date['type']!,
                        style: TextStyle(
                          fontSize: 12,
                          color: isSelected
                              ? AppColors.primaryColor
                              : Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Icon(Icons.info),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Large items may require crane delivery. Ensure site access is clear.',
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStepPago() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Center(child: Text('Método de pago')),
    );
  }

  Widget _buildStepConfirmacion() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Center(child: Text('Confirmación')),
    );
  }
}
