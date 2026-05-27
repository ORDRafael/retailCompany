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
  int _currentStep = 0;

  final List<String> _steps = [
    'Revisión',
    'Entrega',
    'Pago',
    'Confirmación',
  ];

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
      appBar: AppBarWidget(title: 'CHECKOUT', leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () => context.pop())),
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
                                  ? Icon(Icons.check, color: Colors.white, size: 14)
                                  : Text(
                                      '${index + 1}',
                                      style: TextStyle(
                                        color: isActive ? Colors.white : Colors.grey[600],
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
                              color: isActive ? AppColors.primaryColor : Colors.grey[500],
                              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
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
              physics: NeverScrollableScrollPhysics(), // 👈 solo avanza con botones
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
                      child: Text('Atrás',
                        style: TextStyle(color: AppColors.primaryColor)),
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
      child: Center(child: Text('Revisión del pedido')),
    );
  }

  Widget _buildStepEntrega() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Center(child: Text('Dirección de entrega')),
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