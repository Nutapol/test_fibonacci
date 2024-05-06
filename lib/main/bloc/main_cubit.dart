import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/main/bloc/main_state.dart';
import 'package:test_app/model/fibonacciModel.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(const MainState());

  void onPageSelectChanged(int index) {
    emit(
      state.copyWith(
        pageSelected: index,
      ),
    );

    Future<void>.delayed(const Duration(milliseconds: 150), () {
      try {
        state.pageController?.jumpToPage(index);
      } catch (_) {
        state.pageController?.jumpToPage(0);
      }
    });
  }

  void setPageController(PageController controller) {
    emit(
      state.copyWith(
        pageController: controller,
      ),
    );
  }

  void isSearch() {
    bool isSearch = state.isSearch;
    if (isSearch) {
      isSearch = false;
    } else {
      isSearch = true;
    }
    emit(
      state.copyWith(
        isSearch: isSearch,
      ),
    );
  }

  void getItem() {
    final List<Icon> fibonacciShapes = [
      const Icon(Icons.circle),
      const Icon(Icons.square_outlined),
      const Icon(Icons.cancel_outlined),
    ];

    final List<String> fibonacciShapesType = [
      'Circle',
      'Square',
      'Cross',
    ];

    final List<FibonacciModel> itemList = <FibonacciModel>[];
    for (int i = 0; i < 40; i++) {
      int fibonacciValue = fibonacci(i);
      Icon shape = fibonacciShapes[fibonacciValue % fibonacciShapes.length];
      String shapesType =
          fibonacciShapesType[fibonacciValue % fibonacciShapesType.length];

      itemList.add(
        FibonacciModel(
          icon: Icon(shape.icon),
          index: i,
          number: fibonacci(i),
          type: shapesType,
        ),
      );
    }
    emit(
      state.copyWith(
        itemFibonacciList: itemList,
      ),
    );
  }

  int fibonacci(int i) {
    if (i == 0 || i == 1) {
      return i;
    }
    return fibonacci(i - 1) + fibonacci(i - 2);
  }

  Future<void> chooseAndSaveItemToState(FibonacciModel fibonacciModel) async {
    if (fibonacciModel.type == 'Circle') {
      List<FibonacciModel> fibonacciList =
          state.itemCircleList ?? <FibonacciModel>[];
      fibonacciList.add(fibonacciModel);
      fibonacciList.sort(
          (FibonacciModel a, FibonacciModel b) => a.index.compareTo(b.index));

      (state.itemFibonacciList ?? <FibonacciModel>[]).remove(fibonacciModel);
      emit(
        state.copyWith(
          selectFibonacciModel: fibonacciModel,
          itemCircleList: fibonacciList,
          typeSelect: 'Circle',
          itemOnBottomSheet: fibonacciList,
        ),
      );
    } else if (fibonacciModel.type == 'Square') {
      List<FibonacciModel> fibonacciList =
          state.itemSquareList ?? <FibonacciModel>[];
      fibonacciList.add(fibonacciModel);
      fibonacciList.sort(
          (FibonacciModel a, FibonacciModel b) => a.index.compareTo(b.index));
      (state.itemFibonacciList ?? <FibonacciModel>[]).remove(fibonacciModel);
      emit(
        state.copyWith(
          selectFibonacciModel: fibonacciModel,
          itemSquareList: fibonacciList,
          typeSelect: 'Square',
          itemOnBottomSheet: fibonacciList,
        ),
      );
    } else {
      List<FibonacciModel> fibonacciList =
          state.itemCrossList ?? <FibonacciModel>[];
      fibonacciList.add(fibonacciModel);
      fibonacciList.sort(
          (FibonacciModel a, FibonacciModel b) => a.index.compareTo(b.index));
      (state.itemFibonacciList ?? <FibonacciModel>[]).remove(fibonacciModel);
      emit(
        state.copyWith(
          selectFibonacciModel: fibonacciModel,
          itemCrossList: fibonacciList,
          typeSelect: 'Cross',
          itemOnBottomSheet: fibonacciList,
        ),
      );
    }
  }
}
