import 'package:evently_application/common/theme/app_colors.dart';
import 'package:evently_application/models/category_model.dart';
import 'package:evently_application/network/auth_service.dart';
import 'package:evently_application/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/event_model.dart';

class EventCard extends StatefulWidget {
  const EventCard({super.key, required this.event});

  final EventModel event;

  @override
  State<EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  @override
  Widget build(BuildContext context) {
    bool isFav =
        ((Provider.of<UserProvider>(context).userModel?.favEvents ?? [])
                .indexWhere((e) => e.id == widget.event.id) !=
            -1);
    String catCardPath =
        CategoryModel.categories
            .firstWhere((e) => e.id == widget.event.catId)
            .image!;
    return Consumer(
      builder: (context, value, child) => Container(
        height: 200,
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(catCardPath),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.mainColor),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(9),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
                child: Text(
                  widget.event.date,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.mainColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.event.title,
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 24,
                      width: 24,
                      child: IconButton(
                        onPressed: () async {
                          if(isFav){
                            Provider.of<UserProvider>(context,listen: false).removeFavEvent(widget.event.id!);
                          }
                          else {
                            await AuthService.addFavEvent(widget.event);
                            Provider.of<UserProvider>(context, listen: false)
                                .userModel = await AuthService.getUSerInfo();
                            widget.event.isFav = !widget.event.isFav;
                            setState(() {

                            });
                          }
                        },
                        icon: Icon(
                         isFav
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: AppColors.mainColor,
                        ),
                        padding: EdgeInsets.zero,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
