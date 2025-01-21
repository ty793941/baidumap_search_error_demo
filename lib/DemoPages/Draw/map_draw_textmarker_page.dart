import 'package:flutter/material.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart';
import 'package:flutter_baidu_mapapi_map/flutter_baidu_mapapi_map.dart';
import 'package:flutter_bmfmap_example/CustomWidgets/map_appbar.dart';
import 'package:flutter_bmfmap_example/CustomWidgets/map_base_page_state.dart';
import 'package:flutter_bmfmap_example/constants.dart';
import 'package:flutter_bmfmap_example/general/alert_dialog_utils.dart';

/// marker绘制示例
class DrawTextMarkerPage extends StatefulWidget {
  DrawTextMarkerPage({
    Key? key,
  }) : super(key: key);

  @override
  _DrawTextMarkerPageState createState() => _DrawTextMarkerPageState();
}

class _DrawTextMarkerPageState extends BMFBaseMapState<DrawTextMarkerPage> {
  /// 地图controller
  late BMFTextMarker _textMarker;
  late BMFIconMarker _iconMarker;

  bool _addState = false;
  String _btnText = "删除";

  /// 创建完成回调
  @override
  void onBMFMapCreated(BMFMapController controller) {
    super.onBMFMapCreated(controller);

    if (!_addState) {
      addMarker();
    }

    controller.setMapOnClickedOverlayCallback(
        callback: (BMFOverlay textMarker) {
      print('地图点击覆盖物回调，ground=${textMarker.toMap()}');
      showToast(context, "textMarker");
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return MaterialApp(
      home: Scaffold(
          appBar: generateAppBar(),
          body: Stack(children: <Widget>[
            generateMap(),
            generateControlBar(),
          ])),
    );
  }

  /// 添加大头针
  void addMarker() {
    BMFTextMarkerStyle style = BMFTextMarkerStyle(
      textColor: Colors.pink,
      borderColor: Colors.red,
      fontOption: BMFFontOption.Bold,
      fontSize: 55,
      borderWidth: 3,
    );

    BMFMapTranslateAnimation translateAnimation = BMFMapTranslateAnimation(
        fromTranslate: BMFCoordinate(39.928617, 116.40329),
        toTranslate: BMFCoordinate(40.128617, 116.60329),
        duration: 10000,
        repeatCount: 3,
        repeatMode: BMFAnimationRepeatMode.ReleatReserse);
    BMFMapScaleAnimation scaleAnimation = BMFMapScaleAnimation(
        fromScale: BMFSize(1, 1),
        toScale: BMFSize(0.5, 0.5),
        duration: 3000,
        repeatCount: 3,
        repeatMode: BMFAnimationRepeatMode.ReleatReserse);
    BMFInterpolator interpolator = BMFInterpolator(
        interpolatorMode: BMFInterpolatorMode.AnticipateOvershoot);
    BMFMapRotateAnimation rotateAnimation = BMFMapRotateAnimation(
        fromDegrees: 0,
        toDegrees: 360,
        duration: 3000,
        repeatCount: 3,
        repeatMode: BMFAnimationRepeatMode.RepeatRestart,
        interpolator: interpolator);
    BMFMapAlphaAnimation alphaAnimation = BMFMapAlphaAnimation(
        fromAlpha: 0,
        toAlpha: 1,
        duration: 3000,
        repeatCount: 4,
        repeatMode: BMFAnimationRepeatMode.ReleatReserse);
    List<BMFMapAnimation> animationList = [];
    animationList.add(scaleAnimation);
    animationList.add(rotateAnimation);
    animationList.add(alphaAnimation);
    animationList.add(translateAnimation);

    List<BMFAnimationSetOrderType> animationOrderList = [];
    animationOrderList.add(BMFAnimationSetOrderType.OrderTypeWith);
    animationOrderList.add(BMFAnimationSetOrderType.OrderTypeWith);
    animationOrderList.add(BMFAnimationSetOrderType.OrderTypeWith);
    animationOrderList.add(BMFAnimationSetOrderType.OrderTypeWith);

    BMFMapAnimationSet animationSet = BMFMapAnimationSet(
        animationList: animationList,
        animationOrderTypeList: animationOrderList);
    BMFTextMarker marker = BMFTextMarker(
        position: BMFCoordinate(39.928617, 116.40329),
        textStyle: style,
        text: 'Text Marker',
        // animationSet: animationSet,
        animation: rotateAnimation);
    myMapController.addTextMarker(marker);
    _textMarker = marker;

    List<String> icons = [
      'resoures/animation_black.png',
      'resoures/animation_green.png',
      'resoures/animation_red.png'
    ];
    BMFIconMarker iconMarker = BMFIconMarker(
      position: BMFCoordinate(40.133617, 116.30329),
      icon: 'resoures/icon_end.png',
      icons: icons,
      animationType: BMFMarkerAnimateType.Jump,
      animationSet: animationSet,
    );
    myMapController.addIconMarker(iconMarker);
    _iconMarker = iconMarker;
  }

  BMFAppBar generateAppBar() {
    return BMFAppBar(
        title: 'marker示例',
        onBack: () {
          Navigator.pop(context);
        });
  }

  /// 创建地图
  @override
  Container generateMap() {
    return Container(
      height: screenSize.height,
      width: screenSize.width,
      child: BMFMapWidget(
        onBMFMapCreated: (controller) {
          onBMFMapCreated(controller);
        },
        mapOptions: initMapOptions(),
      ),
    );
  }

  @override
  Widget generateControlBar() {
    return Container(
      width: screenSize.width,
      height: 60,
      color: Color(int.parse(Constants.controlBarColor)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          ElevatedButton(
              style: ButtonStyle(backgroundColor: defaultBtnBgColor),
              child: Text(
                _btnText,
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                onBtnPress();
              }),
        ],
      ),
    );
  }

  void onBtnPress() {
    if (_addState) {
      addMarker();
    } else {
      removeMarker();
    }

    _addState = !_addState;
    setState(() {
      _btnText = _addState == true ? "添加" : "删除";
    });
  }

  /// 删除大头针
  void removeMarker() {
    myMapController.removeOverlay(_textMarker.id);
    myMapController.removeOverlay(_iconMarker.id);
  }

  @override
  void dispose() {
    super.dispose();
  }
}
