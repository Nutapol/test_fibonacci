import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/main/bloc/main_cubit.dart';
import 'package:test_app/main/bloc/main_state.dart';
import 'package:test_app/model/fibonacciModel.dart';

class FirstListPage extends StatefulWidget {
  final String title;
  final Color color;

  const FirstListPage({super.key, required this.title, required this.color});

  @override
  State<StatefulWidget> createState() => FirstListPageState();
}

class FirstListPageState extends State<FirstListPage> {
  List<int> fibonacciSequence = [0, 1];
  late MainCubit _mainCubit;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _mainCubit = context.read<MainCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      bloc: _mainCubit,
      builder: (BuildContext context, MainState mainState) {
        return Container(
          color: widget.color,
          child: ListView.builder(
            itemCount: mainState.itemFibonacciList?.length ?? 0,
            itemBuilder: (BuildContext context, int index) {
              return itemList(
                mainState.itemFibonacciList ?? <FibonacciModel>[],
                index,
              );
            },
          ),
        );
      },
    );
  }

  Widget itemList(List<FibonacciModel> itemFibonacci, int index) {
    return InkWell(
      onTap: () {
        _mainCubit.chooseAndSaveItemToState(itemFibonacci[index]);
        showInBottomSheet(itemFibonacci[index]);
        setState(() {});
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 4,
              child: Text(
                  'Index: ${itemFibonacci[index].index.toString()},Number: ${itemFibonacci[index].number.toString()}'),
            ),
            Icon(itemFibonacci[index].icon.icon)
          ],
        ),
      ),
    );
  }

  Widget itemSupShapeList(
    FibonacciModel fibonacciModel,
    List<FibonacciModel> itemFibonacci,
    int indexSup,
  ) {
    return InkWell(
      onTap: () {
        setState(() {});
      },
      child: Container(
        color: fibonacciModel.index == itemFibonacci[indexSup].index
            ? Colors.green
            : Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 4,
                child: Text(
                    'Index: ${itemFibonacci[indexSup].index.toString()},Number: ${itemFibonacci[indexSup].number.toString()}'),
              ),
              Icon(itemFibonacci[indexSup].icon.icon)
            ],
          ),
        ),
      ),
    );
  }

  Future showInBottomSheet(FibonacciModel fibonacciModel) {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return BlocBuilder<MainCubit, MainState>(
          bloc: _mainCubit,
          builder: (BuildContext context, MainState mainState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.5,
              padding: const EdgeInsets.all(6.0),
              child: ListView.builder(
                controller: _scrollController,
                itemCount: mainState.itemOnBottomSheet?.length ?? 0,
                itemBuilder: (BuildContext context, int indexSup) {
                  return itemSupShapeList(
                    mainState.selectFibonacciModel ??
                        const FibonacciModel(
                            icon: Icon(Icons.circle),
                            index: 0,
                            number: 0,
                            type: 'Circle'),
                    mainState.itemOnBottomSheet ?? <FibonacciModel>[],
                    indexSup,
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
