class RoomModel {
  final int roomId;
  final int residents;
  final String name;
  final List<String> photo;
  final int hotelId;
  final int price;

  RoomModel({
    required this.price,
    required this.roomId,
    required this.residents,
    required this.name,
    required this.photo,
    required this.hotelId,
  });

  factory RoomModel.fromMap(Map<String, dynamic> data) {
    return RoomModel(
      roomId: data['room_id'],
      residents: data['residents'],
      name: data['name'],
      photo: List<String>.from(data['photo']),
      hotelId: data['hotel_id'],
      price: data['price'],
    );
  }
}
