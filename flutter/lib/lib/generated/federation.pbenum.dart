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

class QueryType extends $pb.ProtobufEnum {
  static const QueryType Nearest = QueryType._(0, _omitEnumNames ? '' : 'Nearest');
  static const QueryType AntiNearest = QueryType._(1, _omitEnumNames ? '' : 'AntiNearest');

  static const $core.List<QueryType> values = <QueryType> [
    Nearest,
    AntiNearest,
  ];

  static final $core.Map<$core.int, QueryType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static QueryType? valueOf($core.int value) => _byValue[value];

  const QueryType._($core.int v, $core.String n) : super(v, n);
}

class AddResult extends $pb.ProtobufEnum {
  static const AddResult Fail = AddResult._(0, _omitEnumNames ? '' : 'Fail');
  static const AddResult Success = AddResult._(1, _omitEnumNames ? '' : 'Success');

  static const $core.List<AddResult> values = <AddResult> [
    Fail,
    Success,
  ];

  static final $core.Map<$core.int, AddResult> _byValue = $pb.ProtobufEnum.initByValue(values);
  static AddResult? valueOf($core.int value) => _byValue[value];

  const AddResult._($core.int v, $core.String n) : super(v, n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
