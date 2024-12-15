//
//  Generated code. Do not modify.
//  source: federation.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'federation.pbenum.dart';

export 'federation.pbenum.dart';

class CheckRequest extends $pb.GeneratedMessage {
  factory CheckRequest({
    QueryType? queryType,
    $core.int? positionX,
    $core.int? positionY,
    $core.int? queryNum,
    $core.bool? encrypt,
  }) {
    final $result = create();
    if (queryType != null) {
      $result.queryType = queryType;
    }
    if (positionX != null) {
      $result.positionX = positionX;
    }
    if (positionY != null) {
      $result.positionY = positionY;
    }
    if (queryNum != null) {
      $result.queryNum = queryNum;
    }
    if (encrypt != null) {
      $result.encrypt = encrypt;
    }
    return $result;
  }
  CheckRequest._() : super();
  factory CheckRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CheckRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CheckRequest', createEmptyInstance: create)
    ..e<QueryType>(1, _omitFieldNames ? '' : 'queryType', $pb.PbFieldType.OE, defaultOrMaker: QueryType.Nearest, valueOf: QueryType.valueOf, enumValues: QueryType.values)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'positionX', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'positionY', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'queryNum', $pb.PbFieldType.O3)
    ..aOB(5, _omitFieldNames ? '' : 'encrypt')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CheckRequest clone() => CheckRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CheckRequest copyWith(void Function(CheckRequest) updates) => super.copyWith((message) => updates(message as CheckRequest)) as CheckRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CheckRequest create() => CheckRequest._();
  CheckRequest createEmptyInstance() => create();
  static $pb.PbList<CheckRequest> createRepeated() => $pb.PbList<CheckRequest>();
  @$core.pragma('dart2js:noInline')
  static CheckRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CheckRequest>(create);
  static CheckRequest? _defaultInstance;

  @$pb.TagNumber(1)
  QueryType get queryType => $_getN(0);
  @$pb.TagNumber(1)
  set queryType(QueryType v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasQueryType() => $_has(0);
  @$pb.TagNumber(1)
  void clearQueryType() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get positionX => $_getIZ(1);
  @$pb.TagNumber(2)
  set positionX($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPositionX() => $_has(1);
  @$pb.TagNumber(2)
  void clearPositionX() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get positionY => $_getIZ(2);
  @$pb.TagNumber(3)
  set positionY($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPositionY() => $_has(2);
  @$pb.TagNumber(3)
  void clearPositionY() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get queryNum => $_getIZ(3);
  @$pb.TagNumber(4)
  set queryNum($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasQueryNum() => $_has(3);
  @$pb.TagNumber(4)
  void clearQueryNum() => clearField(4);

  @$pb.TagNumber(5)
  $core.bool get encrypt => $_getBF(4);
  @$pb.TagNumber(5)
  set encrypt($core.bool v) { $_setBool(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasEncrypt() => $_has(4);
  @$pb.TagNumber(5)
  void clearEncrypt() => clearField(5);
}

class CheckResult extends $pb.GeneratedMessage {
  factory CheckResult({
    $core.int? positionX,
    $core.int? positionY,
    $core.int? databaseId,
  }) {
    final $result = create();
    if (positionX != null) {
      $result.positionX = positionX;
    }
    if (positionY != null) {
      $result.positionY = positionY;
    }
    if (databaseId != null) {
      $result.databaseId = databaseId;
    }
    return $result;
  }
  CheckResult._() : super();
  factory CheckResult.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CheckResult.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CheckResult', createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'positionX', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'positionY', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'databaseId', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CheckResult clone() => CheckResult()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CheckResult copyWith(void Function(CheckResult) updates) => super.copyWith((message) => updates(message as CheckResult)) as CheckResult;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CheckResult create() => CheckResult._();
  CheckResult createEmptyInstance() => create();
  static $pb.PbList<CheckResult> createRepeated() => $pb.PbList<CheckResult>();
  @$core.pragma('dart2js:noInline')
  static CheckResult getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CheckResult>(create);
  static CheckResult? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get positionX => $_getIZ(0);
  @$pb.TagNumber(1)
  set positionX($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPositionX() => $_has(0);
  @$pb.TagNumber(1)
  void clearPositionX() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get positionY => $_getIZ(1);
  @$pb.TagNumber(2)
  set positionY($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPositionY() => $_has(1);
  @$pb.TagNumber(2)
  void clearPositionY() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get databaseId => $_getIZ(2);
  @$pb.TagNumber(3)
  set databaseId($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasDatabaseId() => $_has(2);
  @$pb.TagNumber(3)
  void clearDatabaseId() => clearField(3);
}

class CheckResponse extends $pb.GeneratedMessage {
  factory CheckResponse({
    $core.Iterable<CheckResult>? results,
  }) {
    final $result = create();
    if (results != null) {
      $result.results.addAll(results);
    }
    return $result;
  }
  CheckResponse._() : super();
  factory CheckResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CheckResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CheckResponse', createEmptyInstance: create)
    ..pc<CheckResult>(1, _omitFieldNames ? '' : 'results', $pb.PbFieldType.PM, subBuilder: CheckResult.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CheckResponse clone() => CheckResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CheckResponse copyWith(void Function(CheckResponse) updates) => super.copyWith((message) => updates(message as CheckResponse)) as CheckResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CheckResponse create() => CheckResponse._();
  CheckResponse createEmptyInstance() => create();
  static $pb.PbList<CheckResponse> createRepeated() => $pb.PbList<CheckResponse>();
  @$core.pragma('dart2js:noInline')
  static CheckResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CheckResponse>(create);
  static CheckResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<CheckResult> get results => $_getList(0);
}

class AddRequest extends $pb.GeneratedMessage {
  factory AddRequest({
    $core.String? address,
  }) {
    final $result = create();
    if (address != null) {
      $result.address = address;
    }
    return $result;
  }
  AddRequest._() : super();
  factory AddRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AddRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AddRequest', createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'address')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AddRequest clone() => AddRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AddRequest copyWith(void Function(AddRequest) updates) => super.copyWith((message) => updates(message as AddRequest)) as AddRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AddRequest create() => AddRequest._();
  AddRequest createEmptyInstance() => create();
  static $pb.PbList<AddRequest> createRepeated() => $pb.PbList<AddRequest>();
  @$core.pragma('dart2js:noInline')
  static AddRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AddRequest>(create);
  static AddRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get address => $_getSZ(0);
  @$pb.TagNumber(1)
  set address($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAddress() => $_has(0);
  @$pb.TagNumber(1)
  void clearAddress() => clearField(1);
}

class AddResponse extends $pb.GeneratedMessage {
  factory AddResponse({
    AddResult? addResult,
  }) {
    final $result = create();
    if (addResult != null) {
      $result.addResult = addResult;
    }
    return $result;
  }
  AddResponse._() : super();
  factory AddResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AddResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AddResponse', createEmptyInstance: create)
    ..e<AddResult>(1, _omitFieldNames ? '' : 'addResult', $pb.PbFieldType.OE, defaultOrMaker: AddResult.Fail, valueOf: AddResult.valueOf, enumValues: AddResult.values)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AddResponse clone() => AddResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AddResponse copyWith(void Function(AddResponse) updates) => super.copyWith((message) => updates(message as AddResponse)) as AddResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AddResponse create() => AddResponse._();
  AddResponse createEmptyInstance() => create();
  static $pb.PbList<AddResponse> createRepeated() => $pb.PbList<AddResponse>();
  @$core.pragma('dart2js:noInline')
  static AddResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AddResponse>(create);
  static AddResponse? _defaultInstance;

  @$pb.TagNumber(1)
  AddResult get addResult => $_getN(0);
  @$pb.TagNumber(1)
  set addResult(AddResult v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasAddResult() => $_has(0);
  @$pb.TagNumber(1)
  void clearAddResult() => clearField(1);
}

class MapResponse extends $pb.GeneratedMessage {
  factory MapResponse({
    $core.List<$core.int>? map,
  }) {
    final $result = create();
    if (map != null) {
      $result.map = map;
    }
    return $result;
  }
  MapResponse._() : super();
  factory MapResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MapResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'MapResponse', createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, _omitFieldNames ? '' : 'map', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MapResponse clone() => MapResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MapResponse copyWith(void Function(MapResponse) updates) => super.copyWith((message) => updates(message as MapResponse)) as MapResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MapResponse create() => MapResponse._();
  MapResponse createEmptyInstance() => create();
  static $pb.PbList<MapResponse> createRepeated() => $pb.PbList<MapResponse>();
  @$core.pragma('dart2js:noInline')
  static MapResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MapResponse>(create);
  static MapResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get map => $_getN(0);
  @$pb.TagNumber(1)
  set map($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMap() => $_has(0);
  @$pb.TagNumber(1)
  void clearMap() => clearField(1);
}

/// ======= 以下无需前端实现！ =======
/// 因为需要有database到federation的请求,所以把定义也放在这里
class DistDiff extends $pb.GeneratedMessage {
  factory DistDiff({
    $core.List<$core.int>? disDiff,
  }) {
    final $result = create();
    if (disDiff != null) {
      $result.disDiff = disDiff;
    }
    return $result;
  }
  DistDiff._() : super();
  factory DistDiff.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DistDiff.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DistDiff', createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, _omitFieldNames ? '' : 'disDiff', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DistDiff clone() => DistDiff()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DistDiff copyWith(void Function(DistDiff) updates) => super.copyWith((message) => updates(message as DistDiff)) as DistDiff;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DistDiff create() => DistDiff._();
  DistDiff createEmptyInstance() => create();
  static $pb.PbList<DistDiff> createRepeated() => $pb.PbList<DistDiff>();
  @$core.pragma('dart2js:noInline')
  static DistDiff getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DistDiff>(create);
  static DistDiff? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get disDiff => $_getN(0);
  @$pb.TagNumber(1)
  set disDiff($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasDisDiff() => $_has(0);
  @$pb.TagNumber(1)
  void clearDisDiff() => clearField(1);
}

/// 服务端解密后比较大小,dis1<dis2返回-1,反则返回1
class DiffResponse extends $pb.GeneratedMessage {
  factory DiffResponse({
    $core.int? cmpResult,
  }) {
    final $result = create();
    if (cmpResult != null) {
      $result.cmpResult = cmpResult;
    }
    return $result;
  }
  DiffResponse._() : super();
  factory DiffResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DiffResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DiffResponse', createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'cmpResult', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DiffResponse clone() => DiffResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DiffResponse copyWith(void Function(DiffResponse) updates) => super.copyWith((message) => updates(message as DiffResponse)) as DiffResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DiffResponse create() => DiffResponse._();
  DiffResponse createEmptyInstance() => create();
  static $pb.PbList<DiffResponse> createRepeated() => $pb.PbList<DiffResponse>();
  @$core.pragma('dart2js:noInline')
  static DiffResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DiffResponse>(create);
  static DiffResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get cmpResult => $_getIZ(0);
  @$pb.TagNumber(1)
  set cmpResult($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCmpResult() => $_has(0);
  @$pb.TagNumber(1)
  void clearCmpResult() => clearField(1);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
