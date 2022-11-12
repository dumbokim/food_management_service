import 'package:flutter/material.dart';
import 'package:food_management_service/pages/splash/splash_page.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TempListPage extends ConsumerWidget {
  const TempListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repository = ref.watch(foodRepository);

    final restaurantList = repository.getRestaurantList;

    return ListView.separated(
        itemCount: restaurantList.length,
        separatorBuilder: (BuildContext context, int index) {
          return const Divider(
            color: Colors.purple,
            thickness: 1.5,
          );
        },
        itemBuilder: (BuildContext context, int index) {
          return Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 12,
            ),
            decoration: const BoxDecoration(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      restaurantList[index].name,
                      style: const TextStyle(
                        color: Colors.purple,
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      '(${restaurantList[index].food.food})',
                      style: const TextStyle(
                        color: Colors.purple,
                        fontSize: 15,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 7),
                Text(
                  restaurantList[index].description,
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          );
        });
  }
}
