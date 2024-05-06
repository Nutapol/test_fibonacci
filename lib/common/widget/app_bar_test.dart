import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_app/common/color/app_colors.dart';
import 'package:test_app/common/size_dimension/app_dimensions.dart';
import 'package:test_app/main/bloc/main_cubit.dart';
import 'package:test_app/main/bloc/main_state.dart';
import 'package:test_app/util/typography.dart';

class AppBarTest extends StatefulWidget implements PreferredSizeWidget {
  const AppBarTest({
    Key? key,
    this.imageProfile = '',
    this.onTapBack,
    this.onSearch,
    this.name = '',
  }) : super(key: key);

  final Function()? onTapBack;
  final Function()? onSearch;
  final String imageProfile;
  final String name;

  @override
  Size get preferredSize => _appBarSize;

  Size get _appBarSize {
    double screenHeight =
        ScreenUtil().screenHeight - ScreenUtil().statusBarHeight;
    double appBarHeight = screenHeight * 0.07;

    return Size.fromHeight(appBarHeight);
  }

  @override
  State<StatefulWidget> createState() => AppbarState();
}

class AppbarState extends State<AppBarTest> {
  final TextEditingController _filterTextController = TextEditingController();
  bool isSearch = false;
  late MainCubit _mainCubit;

  @override
  void initState() {
    _mainCubit = context.read<MainCubit>();
    _filterTextController.addListener(
      _filterTextControllerListener,
    );
    super.initState();
  }

  @override
  void dispose() {
    _filterTextController.removeListener(_filterTextControllerListener);
    super.dispose();
  }

  void _filterTextControllerListener() async {
    // final String query = _filterTextController.text;
    // _search(query);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
        buildWhen: (MainState previous, MainState current) =>
            previous.isSearch != current.isSearch,
        bloc: _mainCubit,
        builder: (BuildContext context, MainState mainState) {
          print("nutappbar:${mainState.isSearch}");

          return SafeArea(
            child: Container(
              height: widget.preferredSize.height,
              decoration: const BoxDecoration(
                color: AppColors.transparent,
              ),
              child: Row(
                children: <Widget>[
                  const Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: AppDimensions.size20,
                        right: AppDimensions.size20,
                      ),
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: !mainState.isSearch,
                    child: Expanded(
                      flex: 4,
                      child: Text(
                        widget.name,
                        style: SpotifyTypography.textStyle(
                          typography: SpotifyTypography.poppins().titleAppbar(),
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: mainState.isSearch,
                    child: Expanded(
                      flex: 4,
                      child: TextFormField(
                        controller: _filterTextController,
                        textAlign: TextAlign.left,
                        autofocus: mainState.isSearch,
                        decoration: InputDecoration(
                          hintText: 'ค้นหา',
                          hintStyle: SpotifyTypography.textStyle(
                            typography:
                                SpotifyTypography.poppins().titleAppbar(),
                            color: Colors.grey.shade700,
                          ),
                        ),
                        style: SpotifyTypography.textStyle(
                          typography: SpotifyTypography.poppins().titleAppbar(),
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: IconButton(
                      icon: Icon(
                        mainState.isSearch ? Icons.cancel : Icons.search,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        _mainCubit.isSearch();
                        _filterTextController.clear();
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
