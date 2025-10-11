class EventModel{
  String title;
  String date;
  String description;
  bool isFav;
  int catId;

  EventModel({
    required this.title,
    required this.date,
    required this.description,
    required this.isFav,
    required this.catId,
});
}