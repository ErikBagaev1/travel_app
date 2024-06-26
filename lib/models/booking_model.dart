class BookingModel {
  final String checkIn;
  final String checkOut;
  final String guestName;
  final String phone;
  final String passportNumber;
  final String passportSeries;
  final String userId;

  BookingModel({
    required this.checkIn,
    required this.checkOut,
    required this.guestName,
    required this.phone,
    required this.passportNumber,
    required this.passportSeries,
    required this.userId,
  });
}
