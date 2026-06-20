class Address {
  final String id;
  final String name;
  final String fullAddress;

  const Address({
    required this.id,
    required this.name,
    required this.fullAddress,
  });
}

class PaymentMethod {
  final String id;
  final String type; // 'card', 'paypal', 'transfer'
  final String label;
  final String detail; // últimos 4 dígitos, etc.

  const PaymentMethod({
    required this.id,
    required this.type,
    required this.label,
    required this.detail,
  });
}

class User {
  final String name;
  final String role;
  final String professionalId;
  final String email;
  final String phone;
  final String taxId;
  final List<Address> addresses;
  final List<PaymentMethod> paymentMethods;

  const User({
    required this.name,
    required this.role,
    required this.professionalId,
    required this.email,
    required this.phone,
    required this.taxId,
    required this.addresses,
    required this.paymentMethods,
  });

  User copyWith({
    String? name,
    String? role,
    String? professionalId,
    String? email,
    String? phone,
    String? taxId,
    List<Address>? addresses,
    List<PaymentMethod>? paymentMethods,
  }) {
    return User(
      name: name ?? this.name,
      role: role ?? this.role,
      professionalId: professionalId ?? this.professionalId,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      taxId: taxId ?? this.taxId,
      addresses: addresses ?? this.addresses,
      paymentMethods: paymentMethods ?? this.paymentMethods,
    );
  }
}