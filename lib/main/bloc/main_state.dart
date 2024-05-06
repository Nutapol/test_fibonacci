import 'package:flutter/material.dart';
import 'package:test_app/model/fibonacciModel.dart';

class MainState {
  final int pageSelected;
  final PageController? pageController;
  final bool isSearch;
  final String typeSelect;
  final List<FibonacciModel>? itemFibonacciList;
  final List<FibonacciModel>? itemCircleList;
  final List<FibonacciModel>? itemSquareList;
  final List<FibonacciModel>? itemCrossList;
  final List<FibonacciModel>? itemOnBottomSheet;
  final FibonacciModel? selectFibonacciModel;

  const MainState({
    this.pageSelected = 0,
    this.pageController,
    this.isSearch = false,
    this.typeSelect = '',
    this.itemFibonacciList,
    this.itemCircleList,
    this.itemSquareList,
    this.itemCrossList,
    this.itemOnBottomSheet,
    this.selectFibonacciModel,
  });

  MainState copyWith({
    int? pageSelected,
    PageController? pageController,
    bool? isSearch,
    String? typeSelect,
    List<FibonacciModel>? itemFibonacciList,
    List<FibonacciModel>? itemCircleList,
    List<FibonacciModel>? itemSquareList,
    List<FibonacciModel>? itemCrossList,
    List<FibonacciModel>? itemOnBottomSheet,
    FibonacciModel? selectFibonacciModel,
  }) {
    return MainState(
      pageSelected: pageSelected ?? this.pageSelected,
      pageController: pageController ?? this.pageController,
      isSearch: isSearch ?? this.isSearch,
      typeSelect: typeSelect ?? this.typeSelect,
      itemFibonacciList: itemFibonacciList ?? this.itemFibonacciList,
      itemCircleList: itemCircleList ?? this.itemCircleList,
      itemSquareList: itemSquareList ?? this.itemSquareList,
      itemCrossList: itemCrossList ?? this.itemCrossList,
      itemOnBottomSheet: itemOnBottomSheet ?? this.itemOnBottomSheet,
      selectFibonacciModel: selectFibonacciModel ?? this.selectFibonacciModel,
    );
  }
}
