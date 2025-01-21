import 'package:flutter/material.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart';
import 'package:flutter_baidu_mapapi_map/flutter_baidu_mapapi_map.dart';
import 'package:flutter_baidu_mapapi_search/flutter_baidu_mapapi_search.dart';
import 'package:flutter_baidu_mapapi_map/flutter_baidu_mapapi_map.dart';
import 'package:flutter_bmfmap_example/CustomWidgets/map_appbar.dart';
import 'package:flutter_bmfmap_example/CustomWidgets/map_base_page_state.dart';
import 'package:flutter_bmfmap_example/general/alert_dialog_utils.dart';
import 'package:flutter_bmfmap_example/CustomWidgets/input_box.dart';
import 'package:flutter_bmfmap_example/CustomWidgets/search_btn.dart';
import 'package:flutter_bmfmap_example/DemoPages/search/other_search_params/show_suggestion_search_params_page.dart';
import 'package:flutter_baidu_mapapi_search/flutter_baidu_mapapi_search.dart';
import 'package:flutter_bmfmap_example/general/utils.dart';
import 'package:flutter_bmfmap_example/main.dart';
import 'package:flutter_bmfmap_example/myErrorPage/utils/my_debounce_utils.dart';
import 'package:flutter_bmfmap_example/myErrorPage/utils/my_dragable_sheet_widget.dart';
import 'package:flutter_bmfmap_example/myErrorPage/utils/my_map_utils.dart';
import 'package:flutter_bmfmap_example/myErrorPage/my_location_map_widget.dart';
import 'package:flutter_bmfmap_example/styles/my_theme.dart';

class MyLocationMapWidget extends StatefulWidget {
  final Function(MyMapPlace)? onPlaceConfirmed;
  const MyLocationMapWidget({this.onPlaceConfirmed});

  @override
  State<MyLocationMapWidget> createState() => _MyLocationMapWidgetState();
}

class _MyLocationMapWidgetState extends BMFBaseMapState<MyLocationMapWidget> {
  final TextEditingController _locationController = TextEditingController();
  BMFCoordinate? centerCoordinate;
  List<MyMapPlace>? _suggestionList;
  MyMapPlace? selectedSuggestion;
  final MyDebounceUtils _debounceUtils = MyDebounceUtils(1000);
  double _dragSize = 0.5 * MediaQuery.of(navigatorKey.currentState!.context).size.height;

  String? cityname = '杭州';
  // LocationUtils locationUtils = LocationUtils();
  MyMapPlace? locationPlace;

  @override
  void initState() {
    super.initState();
// cityname = '杭州';
    // LocationUtils().singleLocation((result) {
    //   cityname = result.city;
    // });
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   locationUtils.singleLocation((r) {
    //     if (locationPlace != null) {
    //       return;
    //     }
    //     cityname = r.city;
    //     locationPlace = MyMapPlace(
    //       location: MyLocation(latitude: r.latitude ?? 0, longitude: r.longitude ?? 0),
    //       uid: r.locationID ?? "",
    //       district: r.district ?? "",
    //       city: r.city ?? "",
    //       key: r.city ?? "",
    //       tag: '',
    //     );
    //     _showMap(locationPlace!);
    //   });
    // });
  }

  ///这个是屏幕中心位置
  BMFPoint get screenPoint {
    return BMFPoint(MyTheme.size.mediaSize.width / 2, mapEdgeInsets.top);
  }

  EdgeInsets get mapEdgeInsets {
    return EdgeInsets.only(top: MyTheme.size.appBarHeight + 60, bottom: _dragSize, left: 10, right: 10);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          generateMap2(center: centerCoordinate),
          Padding(
              padding: EdgeInsets.only(top: MyTheme.size.statusBarHeiget, left: 18, right: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FilledButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.white),
                      foregroundColor: WidgetStateProperty.all(Colors.black),
                    ),
                    child: const Text("取消"),
                  ),
                  FilledButton(
                      onPressed: () async {
                        if (selectedSuggestion == null) {
                          print("请先选择一个地点");
                          return;
                        }
                        var coordinate = await myMapController.convertScreenPointToCoordinate(screenPoint);
                        var myPlace = selectedSuggestion!;
                        widget.onPlaceConfirmed?.call(MyMapPlace(
                          //更改为重新定位的坐标
                          location: MyLocation(latitude: coordinate?.latitude ?? 0, longitude: coordinate?.longitude ?? 0),
                          uid: myPlace.uid,
                          district: myPlace.district,
                          city: myPlace.city,
                          key: myPlace.city,
                          tag: myPlace.tag,
                        ));
                      },
                      child: const Text("确定"))
                ],
              )),
          MyDraggableSheetWidget(
            maxChildSize: 0.6,
            initialChildSize: 0.4,
            snapSizes: const [0.4, 0.6],
            onDragUpdate: (s) {
              _debounceUtils.debounce(callback: () {
                _dragSize = s;
                if (selectedSuggestion != null) {
                  _showMap(selectedSuggestion!);
                }
              });
            },
            itemBuilder: (context, scrollController) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextField(
                        controller: _locationController,
                        autofocus: true,
                        decoration: const InputDecoration(
                          hintText: "请输入地点名称。",
                        ),
                        style: MyTheme.textStyle.contextLarge.copyWith(color: MyTheme.colorTheme.fontColorSecondary),
                        onSubmitted: (str) {},
                        onChanged: (str) {
                          _debounceUtils.debounce(callback: () {
                            if (str.isNotEmpty) {
                              _searchSuggestions(str);
                            } else {
                              setState(() {
                                _suggestionList = null;
                              });
                            }
                          });
                        }),
                  ),
                  _buildSuggestionContent(scrollController)
                ],
              );
            },
          )
        ],
      ),
    );
  }

  Future<void> _searchSuggestions(String keyword) async {
    MyMapUtils.searchSuggestions(
        keyword: keyword,
        cityname: cityname ?? "",
        callback: (BMFSuggestionSearchResult result, BMFSearchErrorCode errorCode) {
          print('sug检索回调 result = ${result.toMap()}, errorCode = $errorCode');
          // if (_locationController.text.isEmpty) {
          //   return;
          // }
          setState(() {
            _suggestionList = [];
            result.suggestionList?.forEach((suggestion) {
              _suggestionList!.add(MyMapPlace.fromJson(suggestion.toMap()));
            });

            // if (_suggestionList!.isEmpty) {
            //   selectedSuggestion = _suggestionList![0];
            // }
          });

          _showMap(selectedSuggestion!);

          // 解析reslut，具体参考demo
        });
  }

  Widget _buildSuggestionContent(ScrollController scrollController) {
    if (_suggestionList == null) {
      return Container();
    } else if (_suggestionList!.isEmpty) {
      return const Center(child: Text("暂无搜索结果，请更换关键词再尝试下。"));
    } else {
      return Column(
          children: List.generate(_suggestionList!.length, (index) {
        var suggestion = _suggestionList![index];
        return ListTile(
          title: Text(
            suggestion.key,
          ),
          subtitle: Text(
            "${suggestion.tag}  ${suggestion.address}",
          ),
          trailing: selectedSuggestion == suggestion ? const Icon(Icons.check) : null,
          onTap: () {
            setState(() {
              selectedSuggestion = suggestion;
            });
            _debounceUtils.debounce(callback: () {
              _showMap(suggestion);
            });
          },
        );
      }));
    }
  }

  void _showMap(MyMapPlace place) {
    String title = place.key;
    var coordinates = BMFCoordinate(place.location.latitude, place.location.longitude);

    BMFCoordinate position = coordinates;

    List<BMFCoordinate> mergeCoordinates = [];

    ///添加marker
    var markers = _addMarkers(title, position);

    ///补偿措施，如果没有路线，则以点为中心显示
    if (mergeCoordinates.isEmpty && markers.isNotEmpty) {
      mergeCoordinates.add(markers.first.position);
    }

    /// 根据polyline设置地图显示范围,看是否需要聚焦到某个地点
    BMFCoordinateBounds coordinateBounds = getVisibleMapRect(mergeCoordinates);

    myMapController.setVisibleMapRectWithPadding(
      visibleMapBounds: coordinateBounds,
      insets: mapEdgeInsets,
      animated: true,
    );
  }

  List<BMFMarker> _addMarkers(String title, BMFCoordinate position) {
    List<BMFMarker> markers = [];

    ///清除已有覆盖物
    myMapController.cleanAllMarkers();

    /// 起点marker
    BMFMarker startMarker = BMFMarker.icon(
      position: position,
      title: title,
      centerOffset: BMFPoint(0, 0),
      icon: "resoures/pin_red.png",
      zIndex: 1,
      isLockedToScreen: true,
      //需要与地图的edgeInsets padding top保持一致，否则会有偏差
      screenPointToLock: screenPoint,
    );
    markers.add(startMarker);

    myMapController.addMarkers(markers);

    return markers;
  }
}
