import 'package:recase/recase.dart';

import '../../common/utils/pubspec/pubspec_utils.dart';
import '../interface/sample_interface.dart';

/// [Sample] file from Repository file creation.
class RepositorySample extends Sample {
  final String _fileName;
  final bool isServer;
  final bool createEndpoints;
  final String modelPath;
  String? _namePascal;
  String? _nameLower;
  RepositorySample(this._fileName,
      {bool overwrite = false,
      this.createEndpoints = false,
      this.modelPath = '',
      this.isServer = false,
      String path = ''})
      : super(path, overwrite: overwrite) {
    _namePascal = _fileName.pascalCase;
    _nameLower = _fileName.toLowerCase();
  }

  String get _import => isServer
      ? "import 'package:get_server/get_server.dart';"
      : "import 'package:get/get.dart';";
  String get _importModelPath => createEndpoints
      ? "import 'package:${PubspecUtils.projectName}/$modelPath';\nimport '../../base/repository_base.dart';"
      : '\n';

  @override
  String get content => '''
$_import
$_importModelPath

class ${_fileName.pascalCase}Repository extends RepositoryBase<$_namePascal> {

@override
String get endpoint => '$_nameLower';

@override
$_namePascal Function(dynamic data) get parser => (json) => $_namePascal.fromJson(json);

$_defaultEndpoint

}

''';

  String get _defaultEndpoint => createEndpoints
      ? '''
Future<$_namePascal?> get$_namePascal(int id) async {
final response = await get('\$endpoint/\$id');
return response.body;
}

Future<Response<$_namePascal>> post$_namePascal($_namePascal $_nameLower) async => await post(endpoint, $_nameLower);

Future<Response> delete$_namePascal(int id) async => await delete('\$endpoint/\$id');
'''
      : '\n';
}
