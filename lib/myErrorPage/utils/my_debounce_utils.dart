import 'dart:async';

/// 防抖工具类，请使用MyDebounceInstance，请勿直接使用MyDebounceUtils
class MyDebounceUtils {
  final int? milliseconds;
  MyDebounceUtils(this.milliseconds);
  Timer? _timer;

  /// Debounce function to prevent multiple calls within a certain time frame
  debounce({
    required Function callback,
  }) {
    if (_timer?.isActive ?? false) _timer?.cancel();
    _timer = Timer(Duration(milliseconds: milliseconds ?? 1000), () async {
      callback();
    });
  }
}

/// 按钮防抖实例
/// uniqueKey 防抖唯一标识符，一组防抖为一个key，一般为一个按钮一个key
/// 使用示例：MyDebounceInstance.debounce('uniqueKey', callback: () {print('debounce');}, milliseconds: 1000);
class MyDebounceInstance {
  static final Map<String, MyDebounceUtils> _debounceMap = {};

  /// Debounce function to prevent multiple calls within a certain time frame
  static debounce(String key, {required Function callback, int? milliseconds}) {
    MyDebounceUtils debounceUtils;
    if (_debounceMap.containsKey(key)) {
      debounceUtils = _debounceMap[key]!;
    } else {
      debounceUtils = MyDebounceUtils(milliseconds);
      _debounceMap[key] = debounceUtils;
    }
    debounceUtils.debounce(callback: () {
      callback();
      _debounceMap.remove(key);
    });
  }
}
