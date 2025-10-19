import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../models/user_model.dart';
import '../../../../common/theme/app_colors.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../provider/user_provider.dart';

class SettingsHeader extends StatelessWidget {
  const SettingsHeader({super.key});


  @override
  Widget build(BuildContext context) {

  UserModel userModel = Provider.of<UserProvider>(context).userModel!;

  double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      height: screenHeight * 0.25,
      decoration: BoxDecoration(
        color: AppColors.mainColor,
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(64)),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            spacing: 16,
            children: [
              Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(Assets.images.route.path),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(1000),
                    bottomLeft: Radius.circular(1000),
                    topRight: Radius.circular(1000),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userModel.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: AppColors.lightBg,
                      ),
                    ),
                    Text(
                      userModel.email,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: AppColors.lightBg,
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
