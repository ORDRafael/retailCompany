import 'package:flutter_riverpod/legacy.dart';
import 'package:obramat/models/user.dart';

class UserNotifier extends StateNotifier<User> {
  UserNotifier() : super(_mockUser);

  static final User _mockUser = User(
    name: 'Juan Pérez',
    role: 'Master Contractor',
    professionalId: 'OBR-31223',
    email: 'juan.perez@example.com',
    phone: '123456789',
    taxId: 'B12345678',
    addresses: [
      Address(
        id: '1',
        name: 'Residencial Los Olivos',
        fullAddress: 'Calle Mayor 45, planta 2, Salamanca',
      ),
      Address(
        id: '2',
        name: 'Obra Polígono Norte',
        fullAddress: 'Calle Industria 12, Nave 4, Salamanca',
      ),
    ],
    paymentMethods: [
      PaymentMethod(
        id: '1',
        type: 'card',
        label: 'Constructa Pro Card',
        detail: '**** 8829',
      ),
    ],
  );

  void updateProfile({
    String? name,
    String? email,
    String? phone,
    String? taxId,
  }) {
    state = state.copyWith(
      name: name,
      email: email,
      phone: phone,
      taxId: taxId,
    );
  }

  void addAddress(Address address) {
    state = state.copyWith(addresses: [...state.addresses, address]);
  }

  void removeAddress(String id) {
    state = state.copyWith(
      addresses: state.addresses.where((a) => a.id != id).toList(),
    );
  }
}

final userProvider = StateNotifierProvider<UserNotifier, User>((ref) {
  return UserNotifier();
});