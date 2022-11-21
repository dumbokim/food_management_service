import 'package:flutter/material.dart';
import 'package:food_ppopgi/data/data.dart';
import 'package:food_ppopgi/domain/food/model/adoption.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:isar/isar.dart';

import '../../common/common.dart';
import 'adoption_list_state.dart';

final adoptionNotifier =
    StateNotifierProvider.autoDispose<AdoptionDataNotifier, AdoptionListState>(
        (ref) => AdoptionDataNotifier(ref));

class AdoptionListPage extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AdoptionListPageState();
}

class _AdoptionListPageState extends ConsumerState<AdoptionListPage> {
  @override
  Widget build(BuildContext context) {
    final noti = ref.watch(adoptionNotifier);

    final dataList = noti.dataList.reversed.toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('채택한 음식점'),
      ),
      body: dataList.isEmpty
          ? Center(
              child: Text('쿨타임이 남아있는 음식점이 없습니다!'),
            )
          : RefreshIndicator(
              onRefresh: () async {
                ref.refresh(adoptionNotifier);
              },
              child: ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 8,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                      text: '${dataList[index].id}',
                                      style: TextStyle(
                                        color: defaultColor,
                                        fontSize: 20,
                                      )),
                                  TextSpan(text: ' 번째 채택'),
                                ],
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            const SizedBox(height: 7),
                            Text(
                              '${dataList[index].restaurant}',
                              style: TextStyle(
                                fontSize: 20,
                                color: defaultColor,
                              ),
                            ),
                            const SizedBox(height: 7),
                            Text(
                              '쿨타임: ${(24 * 7) - DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(dataList[index].adoptedDate ?? 0)).inHours}시간',
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                            onPressed: () {
                              _showDeleteDialog(dataList[index].id);
                            },
                            icon: Icon(Icons.delete_outline))
                      ],
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Container(
                    color: defaultColor,
                    height: 1,
                  );
                },
                itemCount: dataList.length,
              ),
            ),
    );
  }

  _showDeleteDialog(int id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 15,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 20),
                Text(
                  '쿨타임을 초기화시키겠습니까?',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('취소')),
                    TextButton(
                        onPressed: () async {
                          final isar = await ref.read(isarProvider.future);
                          try {
                            await isar.writeTxn(
                                () async => await isar.adoptions.delete(id));
                            ref.refresh(adoptionNotifier);
                          } catch (e) {
                            showDefaultSnackBar(context,
                                content: '오류가 발생했습니다.');
                          } finally {
                            Navigator.pop(context);
                          }
                        },
                        child: Text('초기화')),
                  ],
                )
              ],
            ),
          ),
        );
      },
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
