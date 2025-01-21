package com.baidu.flutter_bmfmap_example;

import com.baidu.mapapi.base.BmfMapApplication;
//import android.app.Application;
//import android.content.Context;
//
//import com.baidu.mapapi.CoordType;
//import com.baidu.mapapi.SDKInitializer;
//import com.baidu.mapapi.common.BaiduMapSDKException;
//import com.baidu.mapapi.map.OverlayUtil;

public class MyApplication extends BmfMapApplication {
    @Override
    public void onCreate() {
        super.onCreate();
        // 初始化方法2，Android项目内集成一份jar引用，extends继承改为Application
//        SDKInitializer.setAgreePrivacy(this, true);
//        try {
//            SDKInitializer.initialize(this);
//            OverlayUtil.setOverlayUpgrade(false);
//        } catch (BaiduMapSDKException e) {
//
//        }
    }
}