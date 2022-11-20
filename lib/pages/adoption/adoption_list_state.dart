import 'package:food_ppopgi/domain/food/model/adoption.dart';

import '../../domain/domain.dart';

class AdoptionListState {
  AdoptionListState({required this.dataList});

  final List<Adoption> dataList;

  copyWith({List<Adoption>? dataList}) {
    return AdoptionListState(dataList: dataList ?? this.dataList);
  }
}
