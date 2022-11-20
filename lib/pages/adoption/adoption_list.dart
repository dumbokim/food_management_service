import 'package:flutter/material.dart';
import 'package:food_ppopgi/data/data.dart';
import 'package:food_ppopgi/domain/food/model/adoption.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:isar/isar.dart';

import 'adoption_list_state.dart';

final adoptionNotifier =
    StateNotifierProvider.autoDispose<AdoptionDataNotifier, AdoptionListState>(
        (ref) => AdoptionDataNotifier(ref));

class AdoptionListPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final noti = ref.watch(adoptionNotifier);

    return Scaffold(
      appBar: AppBar(
        title: Text('채택한 음식점'),
      ),
      body: noti.dataList.isEmpty
          ? Center(
              child: Text('쿨타임이 남아있는 음식점이 없습니다!'),
            )
          : ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${noti.dataList[index].id}번째 채택'),
                      Text('${noti.dataList[index].restaurant}'),
                      Text('${noti.dataList[index].adoptedDate}'),
                    ],
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Container(
                  color: Colors.purple,
                  height: 1,
                );
              },
              itemCount: noti.dataList.length,
            ),
    );
  }
}

class AdoptionDataNotifier extends StateNotifier<AdoptionListState> {
  AdoptionDataNotifier(this.ref) : super(AdoptionListState(dataList: [])) {
    load();
  }

  final Ref ref;

  Future<void> load() async {
    final isar = await ref.read(isarProvider.future);

    try {
      final data = await isar.adoptions.where().findAll();

      state = state.copyWith(dataList: data);
    } catch (e) {}
  }
}
