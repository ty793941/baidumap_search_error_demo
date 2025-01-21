import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bmfmap_example/main.dart';

class MyThemeData {
  //浅色主题
  static ThemeData lightTheme() => ThemeData(
        scaffoldBackgroundColor: _MyLightTheme().backgroundColor,
        // 设置应用栏的主题样式
        appBarTheme: AppBarTheme(
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarBrightness: Brightness.light,
            ),
            backgroundColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            titleTextStyle: _MyTextStyle().titleLarge.copyWith(color: _MyLightTheme().fontColor)),
        // 设置应用的主色调
        primaryColor: _MyLightTheme().primaryColor,
        // 字体主题
        textTheme: TextTheme(
          labelSmall: _MyTextStyle().contextSmall,
          titleLarge: _MyTextStyle().titleLarge,
          // bodySmall: const TextStyle(color: _MyLightTheme.fontColor),
        ),

        checkboxTheme: CheckboxThemeData(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ), // 设置复选框的形状为圆角矩形
            side: BorderSide(color: _MyLightTheme().outlineColor),
            fillColor: WidgetStateProperty.resolveWith((Set<WidgetState> states) {
              if (states.contains(WidgetState.disabled)) {
                return Colors.grey;
              }

              if (states.contains(WidgetState.selected)) {
                return _MyLightTheme().secondaryColor;
              }
              return _MyLightTheme().secondaryColor; // 设置未选中时的透明度
            }), // 根据复选框的状态设置填充颜色
            visualDensity: const VisualDensity(horizontal: -4.0, vertical: -4.0)), // 设置视觉密度
        // 设置卡片的主题样式
        cardTheme: CardTheme(color: _MyLightTheme().backgroundColor),
        // 设置弹出菜单的主题样式
        popupMenuTheme: PopupMenuThemeData(
          color: _MyLightTheme().backgroundColor,
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
        ),
        dividerTheme: DividerThemeData(color: _MyLightTheme().outlineColor),
        bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: _MyLightTheme().backgroundColor,
        ),
        listTileTheme: ListTileThemeData(
          dense: true,
          tileColor: Colors.transparent,
          textColor: _MyLightTheme().fontColor,
          titleTextStyle: _MyTextStyle().contextLarge,
          subtitleTextStyle: _MyTextStyle().contextMedium,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: _MyLightTheme().backgroundColor,
        ),
        iconButtonTheme: const IconButtonThemeData(style: ButtonStyle()),
        textButtonTheme: TextButtonThemeData(style: ButtonStyle(iconColor: WidgetStateProperty.all<Color?>(_MyLightTheme().fontColor), foregroundColor: WidgetStateProperty.all<Color?>(_MyLightTheme().fontColor))),
        filledButtonTheme: FilledButtonThemeData(
            style: ButtonStyle(
          textStyle: WidgetStateProperty.all(_MyTextStyle().contextLarge),
        )),
        outlinedButtonTheme: OutlinedButtonThemeData(
            style: ButtonStyle(
          textStyle: WidgetStateProperty.all(_MyTextStyle().contextLarge),
          backgroundColor: WidgetStateProperty.all<Color?>(Colors.transparent),
          foregroundColor: WidgetStateProperty.all<Color?>(_MyLightTheme().fontColor),
          side: WidgetStateProperty.all<BorderSide>(BorderSide(color: _MyLightTheme().fontColorTertiary)),
        )),
        switchTheme: SwitchThemeData(
          thumbColor: WidgetStateProperty.all<Color?>(_MyLightTheme().backgroundColor),
          trackOutlineColor: WidgetStateProperty.all<Color?>(_MyLightTheme().backgroundColor),
          // trackColor:
        ),
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: MyTheme.textStyle.contextMedium.copyWith(color: _MyLightTheme().fontColorTertiary),
          isDense: true,
          filled: true,
          fillColor: _MyLightTheme().outlineColor,
          hoverColor: _MyLightTheme().primaryColor,
          border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10)), borderSide: BorderSide.none),
        ),
        dialogTheme: DialogTheme(
          titleTextStyle: _MyTextStyle().titleSmall.copyWith(color: _MyLightTheme().fontColor),
          contentTextStyle: _MyTextStyle().contextMedium.copyWith(color: _MyLightTheme().fontColorSecondary),
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: _MyLightTheme().primaryColor, primary: _MyLightTheme().primaryColor),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: _MyLightTheme().primaryColor,
          foregroundColor: _MyLightTheme().onPrimaryColor,
          extendedIconLabelSpacing: 5,
          extendedPadding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          // sizeConstraints: const BoxConstraints(maxHeight: 180),
          extendedSizeConstraints: const BoxConstraints.tightFor(
            height: 35.0,
          ),
        ),
        drawerTheme: DrawerThemeData(
          backgroundColor: _MyLightTheme().backgroundColor,
        ),
        menuButtonTheme: MenuButtonThemeData(
            style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(_MyLightTheme().backgroundColor),
          textStyle: WidgetStateProperty.all(_MyTextStyle().contextMedium),
        )),
        menuTheme: MenuThemeData(
            style: MenuStyle(
                backgroundColor: WidgetStateProperty.all(_MyLightTheme().backgroundColor),
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15), // 设置圆角的大小
                  ),
                ))),
        progressIndicatorTheme: ProgressIndicatorThemeData(
          color: _MyLightTheme().primarySubColor,
        ),
        tabBarTheme: TabBarTheme(
          labelColor: _MyLightTheme().fontColor,
          dividerColor: _MyLightTheme().outlineColor,
          labelStyle: _MyTextStyle().contextLarge,
          unselectedLabelStyle: _MyTextStyle().contextLarge,
          splashFactory: NoSplash.splashFactory, // 禁用水波纹效果
          mouseCursor: WidgetStateProperty.all(SystemMouseCursors.click),
        ),
        sliderTheme: SliderThemeData(
          // 激活的刻度颜色
          activeTrackColor: _MyLightTheme().secondaryColor,
          // 未激活的刻度颜色
          inactiveTrackColor: Colors.grey,
          // 滑块颜色
          thumbColor: _MyLightTheme().secondaryColor,
          overlayColor: _MyLightTheme().secondaryColor.withAlpha(32),
          //  滑块形状，可以自定义
          thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8.0),
          // 滑块外圈形状，可以自定义
          overlayShape: const RoundSliderOverlayShape(overlayRadius: 14.0),
          trackShape: const RectangularSliderTrackShape(),
        ),
        // colorScheme: ColorScheme.fromSeed(
        //     seedColor: _MyLightTheme.primaryColor,
        //     primary: _MyLightTheme.primaryColor,
        //     onPrimary: _MyLightTheme.backgroundColor,
        //     secondary: _MyLightTheme.fontColoSecondary,
        //     onSecondary: _MyLightTheme.backgroundColor,
        //     tertiary: _MyLightTheme.fontColoTertiary,
        //     onTertiary: _MyLightTheme.backgroundColor,
        //     surface: _MyLightTheme.backgroundColor,
        //     surfaceContainer: _MyLightTheme.surfaceColor,
        //     error: _MyLightTheme.highlightColor,
        //     onError: _MyLightTheme.highlightColor,
        //     outline: _MyLightTheme.surfaceColor),
        buttonTheme: const ButtonThemeData(
          splashColor: Colors.transparent, // 去掉水波纹
          highlightColor: Colors.transparent, // 去掉点击高亮
        ),

        // 全局覆盖 Material 的默认点击效果
        splashColor: Colors.transparent, // 禁用水波纹颜色
        highlightColor: Colors.transparent, // 禁用高亮颜色

        bottomAppBarTheme: BottomAppBarTheme(
            color: _MyLightTheme().surfaceColor,
            shape: const CircularNotchedRectangle(), // 这行代码设置凹口弧度
            elevation: 8),
        useMaterial3: true,
      );

  //暗黑主题
  static ThemeData darkTheme() => lightTheme(); //暂时先用浅色调代替
}

abstract class ColorTheme {
  Color get primaryColor;
  Color get primarySubColor;
  Color get onPrimaryColor;
  Color get secondaryColor;
  Color get fontColor;
  Color get fontColorSecondary;

  /// 这个颜色去除有影响，暂时先用上一个颜色代替
  Color get fontColorTertiary;
  Color get backgroundColor;
  // Color get backgroundSecondary;
  Color get backgroundLightWhite;
  Color get onBackgroundColor;
  Color get surfaceColor;
  Color get outlineColor;
  Color get outlineColorSecondary;
  Color get shadowColor;
  Color get highlightColor;
  Color get highlightTintColor;
  Color get onHighlightColor;
  Color get barrierColor;
  Color get placeholderColor;

  Color get lightGreen;
  Color get lightBlue;
  Color get lightYellow;
  Color get lightXYellow;
  Color get lightPink;
  Color get lightpurple;
  Color get mediumGreen;
  Color get tinyBlue;

  // Color get color1;
  // Color get color2;
  // Color get color3;
}

class _MyLightTheme implements ColorTheme {
  @override
  Color get primaryColor => const Color.fromRGBO(25, 25, 25, 1);
  @override
  Color get primarySubColor => const Color.fromRGBO(14, 37, 139, 1);
  @override
  Color get secondaryColor => const Color.fromRGBO(14, 37, 139, 1);

  @override
  Color get onPrimaryColor => const Color(0xFFFFFFFF);

  ///字体颜色
  @override
  Color get fontColor => const Color.fromRGBO(25, 25, 25, 1);
  @override
  Color get fontColorSecondary => const Color.fromRGBO(150, 150, 150, 1);
  @override
  Color get fontColorTertiary => const Color.fromRGBO(217, 217, 217, 1);

  ///背景
  @override
  Color get backgroundColor => const Color(0xFFFFFFFF);
  // @override
  // Color get backgroundSecondary => const Color(0xFFE7E7EA);
  @override
  Color get backgroundLightWhite => const Color.fromRGBO(247, 248, 248, 1);
  @override
  Color get onBackgroundColor => const Color.fromRGBO(25, 25, 25, 1);
  @override
  Color get surfaceColor => const Color(0xFFF7F7F9);

  ///边框
  @override
  Color get outlineColor => surfaceColor;
  @override
  Color get outlineColorSecondary => const Color(0xFFF0F0F0);

  ///高亮色
  @override
  Color get highlightColor => const Color.fromRGBO(227, 73, 73, 1);
  @override
  Color get highlightTintColor => const Color.fromRGBO(255, 157, 193, 1);

  @override
  Color get onHighlightColor => const Color(0xFFFFFFFF);

  @override
  Color get barrierColor => const Color.fromRGBO(255, 255, 255, 0.8);

  //提示文本颜色
  @override
  Color get placeholderColor => const Color.fromRGBO(150, 150, 150, 0.85);

  ///阴影
  @override
  Color get shadowColor => const Color.fromRGBO(180, 188, 201, 0.16);

  @override
  Color get lightGreen => const Color.fromRGBO(173, 221, 192, 1);
  @override
  Color get lightBlue => const Color.fromRGBO(95, 162, 239, 1);
  @override
  Color get lightYellow => const Color.fromRGBO(242, 226, 162, 1);
  @override
  Color get lightXYellow => const Color.fromRGBO(234, 234, 219, 1);
  @override
  Color get lightPink => const Color.fromRGBO(238, 196, 198, 1);
  @override
  Color get lightpurple => const Color.fromRGBO(143, 135, 231, 1);
  @override
  Color get mediumGreen => const Color.fromRGBO(91, 207, 119, 1);
  @override
  Color get tinyBlue => const Color.fromRGBO(163, 199, 240, 1);
}

class _MyTextStyle {
  /// 返回一个标题大号的文本样式，
  ///
  /// 字体大小为20，字体粗细为w700
  TextStyle get displayLarge => TextStyle(
        fontSize: 40,
        fontWeight: FontWeight.w700,
      );

  // 返回一个标题大号的文本样式，
  //
  // 字体大小为20，字体粗细为w700
  TextStyle get displayMedium => TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.w700,
      );

  /// 返回一个标题大号的文本样式，
  ///
  /// 字体大小为20，字体粗细为w700
  TextStyle get displaySmall => TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w700,
      );

  /// 返回一个标题大号的文本样式，字体大小为20，字体粗细为w700
  TextStyle get titleLarge => TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w700,
      );

  /// 返回一个标题中号的文本样式，
  ///
  /// 字体大小为16，字体粗细为w700
  TextStyle get titleMedium => TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700,
      );

  /// 返回一个标题中号的文本样式，
  ///
  /// 字体大小为16，字体粗细为w700
  TextStyle get titleSmall => TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
      );

  /// 返回一个标题中号的文本样式，
  ///
  /// 字体大小为16，字体粗细为w500
  TextStyle get contextLarge => TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
      );

  /// 返回一个内容大号的文本样式，
  ///
  /// 字体大小为14
  TextStyle get contextMedium => TextStyle(
        fontSize: 14,
        // fontWeight: FontWeight.bold,
      );

  /// 返回一个内容小号的文本样式，
  ///
  /// 字体大小为12
  TextStyle get contextSmall => TextStyle(
        fontSize: 12,
        // fontWeight: FontWeight.bold,
      );

  /// 返回一个内容小号的文本样式，
  ///
  /// 字体大小为12
  TextStyle get contextXSmall => TextStyle(
        fontSize: 10,
        // fontWeight: FontWeight.bold,
      );

  /// 返回一个内容小号的文本样式，
  ///
  /// 字体大小为12
  TextStyle get contextXXSmall => TextStyle(
        fontSize: 8,
        // fontWeight: FontWeight.bold,
      );

  /// 返回一个内容小号的文本样式，
  ///
  /// 字体大小为12
  TextStyle get contextXXXSmall => TextStyle(
        fontSize: 6,
        // fontWeight: FontWeight.bold,
      );

  TextStyle get pageTitle => titleMedium;
}

class _MyShadowStyle {
  BoxShadow get shadow1 => BoxShadow(
        color: MyTheme.colorTheme.shadowColor,
        spreadRadius: 0,
        blurRadius: 16,
        offset: const Offset(0, 6), // 影子的偏移量
      );
}

class _MyEdgeInsets {
  double get paddingXLarge => 20;
  double get paddingXXLarge => 40;
  double get paddingLarge => 16;
  double get paddingMedium => 12;
  double get paddingSmall => 8;
}

class _size {
  double get statusBarHeiget => MediaQuery.of(navigatorKey.currentContext!).padding.top;

  double get safeAreaBottomHeight => MediaQuery.of(navigatorKey.currentContext!).padding.bottom;

  /// APPbar高度 ,包含appbar+状态栏
  double get appBarHeight => MediaQuery.of(navigatorKey.currentContext!).padding.top + 56;

  /// 整个屏幕Size ,包含appbar+状态栏
  Size get mediaSize => MediaQuery.of(navigatorKey.currentContext!).size;
  EdgeInsets get safeArea => MediaQuery.of(navigatorKey.currentContext!).padding;
}

class MyTheme {
  static ColorTheme colorTheme = Theme.of(navigatorKey.currentContext!).brightness == Brightness.light ? _MyLightTheme() : _MyLightTheme(); //没有暗色调，先用浅色调代替
  static final textStyle = _MyTextStyle();
  static final edgeInsets = _MyEdgeInsets();
  static final shadowStyle = _MyShadowStyle();
  static final size = _size();
}
