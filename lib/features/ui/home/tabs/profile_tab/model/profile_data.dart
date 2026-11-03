class ProfileData {
  final String name;
  final String phone;
  final int avatarIndex;

  const ProfileData({
    required this.name,
    required this.phone,
    required this.avatarIndex,
  });

  static const ProfileData initial = ProfileData(
    name: 'John Safwat',
    phone: '01200000000',
    avatarIndex: 7,
  );
}
