import 'package:flutter/material.dart';
import 'package:food_management_service/pages/splash/splash_page.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RestaurantListPage extends ConsumerWidget {
  const RestaurantListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repository = ref.watch(foodRepository);

    final restaurantList = repository.getRestaurantList;

    print(restaurantList.length);

    return ListView.separated(
        itemCount: restaurantList.length,
        separatorBuilder: (BuildContext context, int index) {
          return Divider(color: Colors.purple, thickness: 1.5,);
        },
        itemBuilder: (BuildContext context, int index) {
          return Container(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 12,
            ),
            decoration: BoxDecoration(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      '${restaurantList[index].name}',
                      style: TextStyle(
                        color: Colors.purple,
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(width: 5),
                    Text('(${restaurantList[index].food.food})',
                      style: TextStyle(
                        color: Colors.purple,
                        fontSize: 15,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 7),
                Text(restaurantList[index].description,
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          );
        });
  }
}
