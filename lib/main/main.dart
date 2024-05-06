import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_app/common/color/app_colors.dart';
import 'package:test_app/common/widget/app_bar_test.dart';
import 'package:test_app/common/widget/responsive_base.dart';
import 'package:test_app/injection.dart';
import 'package:test_app/main/bloc/main_cubit.dart';
import 'package:test_app/main/bloc/main_state.dart';
import 'package:test_app/main/page/album_list/widget/first_list_page.dart';
import 'package:test_app/main/page/play_list/widget/secound_list_page.dart';

void main() {
  setupInjection();
  runApp(MultiBlocProvider(providers: <BlocProvider<dynamic>>[
    BlocProvider<MainCubit>(
      lazy: false,
      create: (BuildContext context) {
        return getIt<MainCubit>();
      },
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    _setScreenUtil(context);
    return MultiBlocProvider(
      providers: <BlocProvider<dynamic>>[
        BlocProvider<MainCubit>(
          lazy: false,
          create: (BuildContext context) {
            return getIt<MainCubit>();
          },
        ),
      ],
      child: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }

  void _setScreenUtil(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: const Size(
        ResponsiveBaseWidget.baseMobileWidth,
        ResponsiveBaseWidget.baseMobileHeight,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late MainCubit _mainCubit;

  @override
  void initState() {
    _mainCubit = context.read<MainCubit>();
    _mainCubit.setPageController(PageController());
    _mainCubit.getItem();
    super.initState();
  }

  final List<Widget> pages = [
    const FirstListPage(
      title: 'First',
      color: Colors.white,
    ),
    const SecoundListPage(
      title: 'Second',
      color: Colors.white,
    ),
    const SecoundListPage(
      title: 'Third',
      color: Colors.white,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
        bloc: _mainCubit,
        builder: (BuildContext context, MainState mainState) {
          return MaterialApp(
            title: 'ViewPager Test',
            theme: ThemeData(primarySwatch: Colors.grey),
            home: Scaffold(
              primary: true,
              resizeToAvoidBottomInset: false,
              backgroundColor: AppColors.backgroundDark,
              appBar: AppBarTest(
                onSearch: () async {},
                onTapBack: () async {},
                imageProfile: '',
                name: 'Test',
              ),
              body: PageView(
                controller: mainState.pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: pages,
              ),
              bottomNavigationBar: BottomNavigationBar(
                backgroundColor: AppColors.backgroundDark,
                currentIndex: mainState.pageSelected,
                onTap: (index) {
                  setState(() {
                    _mainCubit.onPageSelectChanged(index);
                  });
                },
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home_filled),
                    label: 'First',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.add),
                    label: 'Second',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.settings),
                    label: 'Third',
                  ),
                ],
              ),
            ),
          );
        });
  }
}
