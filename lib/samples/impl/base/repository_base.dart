import '../../interface/sample_interface.dart';

/// [Sample] file from repository_base.dart file creation.
class RepositoryBaseSample extends Sample {
  RepositoryBaseSample({String path = 'lib/app/base/repository_base.dart'})
      : super(path);
  @override
  String get content => '''
import 'package:get/get.dart';

abstract class RepositoryBase<T> extends GetConnect {
  String get endpoint;

  T Function(dynamic data) get parser;

  @override
  void onInit() {
    //TODO: Change your api url
    httpClient.baseUrl = 'YOUR-API-URL';

    _initDecoder();
  }

  void _initDecoder() {
    httpClient.defaultDecoder = (map) {
      if (map is String) return Exception('Api error');

      final data = map['data'];
      if (data == null) return Exception('Api error');

      if (!data.containsKey('current_page')) return parser.call(data);

      final dataList = data['data'] as List?;

      return dataList?.map((item) => parser.call(item)).toList() ?? [];
    };
  }
}

''';
}
