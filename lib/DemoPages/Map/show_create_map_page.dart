import 'dart:io';
import 'package:flutter/material.dart';

import 'package:flutter_bmfmap_example/CustomWidgets/function_item.widget.dart';
import 'package:flutter_bmfmap_example/CustomWidgets/map_appbar.dart';
import 'package:flutter_bmfmap_example/DemoPages/Map/show_custommap_page.dart';
import 'package:flutter_bmfmap_example/DemoPages/Map/show_indoormap_page.dart';
import 'package:flutter_bmfmap_example/DemoPages/Map/show_map_on_list_page.dart';
import 'package:flutter_bmfmap_example/DemoPages/Map/show_map_type_page.dart';
import 'package:flutter_bmfmap_example/DemoPages/Map/show_multi_map_page.dart';
import 'package:flutter_bmfmap_example/DemoPages/Map/show_offline_page.dart';
import 'package:flutter_bmfmap_example/DemoPages/Map/show_particleeffect_page.dart';
import 'package:flutter_bmfmap_example/DemoPages/Map/show_textureviewmap_page.dart';
import 'package:flutter_bmfmap_example/general/utils.dart';

/// 地图入创建入口
class ShowCreateMapPage extends StatelessWidget {
  const ShowCreateMapPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: BMFAppBar(
          title: '创建地图',
          isBack: false,
        ),
        body: Container(
            child: ListView(children: <Widget>[
          FunctionItem(
            label: '地图类型示例',
            sublabel: '普通地图、卫星地图展示',
            target: ShowMapTypePage(),
          ),
          generatePlatformizationItem(Platform.isAndroid, 'TextureView地图示例',
              '地图由TextureView渲染', ShowTextureViewMapPage()),
          FunctionItem(
            label: '粒子效果',
            sublabel: '多种例子效果展示',
            target: ShowParticleEffectPage(),
          ),
          FunctionItem(
            label: '多地图示例',
            sublabel: '在同一个页面中创建多个地图展示',
            target: ShowMultiMapPage(),
          ),
          FunctionItem(
            label: '室内图示例',
            sublabel: '介绍室内图功能，显示室内图',
            target: ShowIndoorMapPage(),
          ),
          FunctionItem(
            label: '个性化地图示例',
            sublabel: '介绍个性化地图的创建和使用',
            target: ShowCustomMapPage(),
          ),
          FunctionItem(
            label: '离线地图',
            sublabel: '展示离线地图的下载和管理',
            target: ShowOfflineMapPage(),
          ),
          FunctionItem(
              label: 'listView上展示百度地图',
              sublabel: '地图与listView共存',
              target: ShowMapOnListViewPage())
        ])));
  }
}
