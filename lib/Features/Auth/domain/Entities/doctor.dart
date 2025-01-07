class Doctor {
  final int id;
  final String userId;
  final String name;
  final String phoneNumber;
  final bool isActive;
  final String email;

  Doctor({
    required this.email,
    required this.isActive,
    required this.id,
    required this.userId,
    required this.name,
    required this.phoneNumber,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json['doctor_id'], // استبدل doctor_id بالاسم الصحيح في جدول Supabase
      userId: json['user_id'], // استبدل user_id بالاسم الصحيح
      name: json['doctor_name'], // استبدل doctor_name بالاسم الصحيح
      phoneNumber: json['phone_number'],
      isActive: json['isActive'],
      email: json['users']['email'], // استبدل phone_number بالاسم الصحيح
    );
  }
}
