import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:obramat/models/projects.dart';
import 'package:obramat/models/user.dart';
import 'package:obramat/providers/cart_provider.dart';
import 'package:obramat/providers/orders_provider.dart';
import 'package:obramat/providers/project_provider.dart';
import 'package:obramat/providers/user_provider.dart';
import 'package:obramat/utils/colors.dart';
import 'package:obramat/widgets/appbar.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final ordersCount = ref.watch(ordersProvider).length; // 👈 reusa el provider de pedidos
    final activeProjectsCount = ref.watch(projectsByStatusProvider(ProjectStatus.active)).length; // 👈

    return Scaffold(
      appBar: AppBarWidget(
        title: 'Perfil',
        showMenu: true,
        showSearch: false,
        onConfigPressed: () {
          // Acción para el botón de configuración
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned.fill(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            'lib/images/avatar.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: -13,
                        right: -8,
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.2),
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          height: MediaQuery.of(context).size.height * 0.04,
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: Center(
                            child: Text(
                              'Profesional',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  user.name,
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      user.role,
                      style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'ID: ${user.professionalId}',
                      style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'TOTAL ORDERS',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey[600],
                                ),
                              ),
                              Text(
                                '$ordersCount',
                                style: TextStyle(
                                  fontSize: 28,
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'ACTIVE SITES',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey[600],
                                ),
                              ),
                              Text(
                                '$activeProjectsCount',
                                style: TextStyle(
                                  fontSize: 28,
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30.0,
                      vertical: 20.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'INFORMACION PERSONAL',
                              style: TextStyle(
                                letterSpacing: 1.2,
                                color: Colors.grey[700],
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Spacer(),
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                'Editar',
                                style: TextStyle(
                                  color: AppColors.primaryColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text('Nombre', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[600])),
                        Text(user.name, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)), // 👈
                        SizedBox(height: 16),
                        Text('Email', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[600])),
                        Text(user.email, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)), // 👈
                        SizedBox(height: 16),
                        Text('Teléfono', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[600])),
                        Text(user.phone, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)), // 👈
                        SizedBox(height: 16),
                        Text('TAX ID / CIF', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[600])),
                        Text(user.taxId, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)), // 👈
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Alerts',
                          style: TextStyle(
                            letterSpacing: 1.2,
                            color: Colors.grey[700],
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Order Updates',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            Switch(value: false, onChanged: (value) {}),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Bulk Pricing Alerts',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[700],
                              ),
                            ),
                            Switch(value: false, onChanged: (value) {}),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Site Delivery SMS',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            Switch(
                              value: true,
                              activeThumbColor: AppColors.primaryColor,
                              onChanged: (value) {},
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        'ACTIVE OBRA ADDRESSES',
                        style: TextStyle(
                          letterSpacing: 1.2,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[700],
                        ),
                      ),
                      Spacer(),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Manage',
                          style: TextStyle(
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: user.addresses.length, // 👈
                itemBuilder: (context, index) => adressesCard(user.addresses[index]), // 👈
              ),
              Text(
                'PAYMENT METHODS',
                style: TextStyle(
                  letterSpacing: 1.2,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(height: 16),
              creditCard(context, user),
              SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(onPressed: () {}, 
                child: Row(
                  children: [
                    Icon(Icons.help, color: Colors.black),
                    SizedBox(width: 8),
                    Text('Help', style: TextStyle(color: Colors.black)),
                    Spacer(),
                    Icon(Icons.arrow_forward, color: Colors.black),
                  ],
                )
                ),
              ),
              SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(onPressed: () {}, 
                child: Row(
                  children: [
                    Icon(Icons.support_agent, color: Colors.black),
                    SizedBox(width: 8),
                    Text('Contact Professional Support', style: TextStyle(color: Colors.black)),
                    Spacer(),
                    Icon(Icons.arrow_forward, color: Colors.black),
                  ],
                )
                ),
              ),
              SizedBox(height: 16),
             Divider(),
             SizedBox(height: 16),
              SizedBox(
  width: MediaQuery.of(context).size.width * 0.8,
  height: 48,
  child: ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
    onPressed: () {
      // 👈 limpia el carrito al cerrar sesión (buena práctica)
      ref.read(cartProvider.notifier).clearCart();
      context.go('/login');
    },
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.logout, color: Colors.red, size: 20),
        SizedBox(width: 8),
        Text('CERRAR SESIÓN', style: TextStyle(letterSpacing: 1.2, color: Colors.red, fontWeight: FontWeight.bold)),
      ],
    ),
  ),
),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container adressesCard(Address address) {
    return Container(
                margin: EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(address.name, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)), // 👈
                          Text(address.fullAddress, style: TextStyle(color: Colors.grey[600])),
                        ],
                      ),
                    ],
                  ),
                ),
              );
  }

  Widget creditCard(BuildContext context, User user) {
  return Container(
    height: 200,
    width: double.infinity,
    decoration: BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF0F0F0F), // más oscuro abajo derecha
      Color(0xFF2A2A2A), // más claro arriba izquierda
    ],
  ),
  borderRadius: BorderRadius.circular(16),
),
    padding: EdgeInsets.all(24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Fila superior: icono + nombre
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.credit_card,
              color: Colors.white54,
              size: 32,
            ),
            Text(
              user.paymentMethods[0].label.toUpperCase(),
              style: TextStyle(
                color: Color(0xFFFF671F), // Naranja Obramat
                fontSize: 12,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.5,
              ),
            ),
          ],
        ),
        Spacer(),
        // Número de tarjeta
        Row(
          children: [
            Text(
              '• • • •   • • • •   • • • •',
              style: TextStyle(
                color: Colors.white54,
                fontSize: 16,
                letterSpacing: 4,
              ),
            ),
            SizedBox(width: 8),
            Text(
              user.paymentMethods[0].detail.replaceAll('**** ', ''),
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        // Expiración
        Text(
          'EXP 12/26',
          style: TextStyle(
            color: Colors.white54,
            fontSize: 12,
            letterSpacing: 1.2,
          ),
        ),
      ],
    ),
  );
}
}