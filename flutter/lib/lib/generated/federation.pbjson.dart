//
//  Generated code. Do not modify.
//  source: federation.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use queryTypeDescriptor instead')
const QueryType$json = {
  '1': 'QueryType',
  '2': [
    {'1': 'Nearest', '2': 0},
    {'1': 'AntiNearest', '2': 1},
  ],
};

/// Descriptor for `QueryType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List queryTypeDescriptor = $convert.base64Decode(
    'CglRdWVyeVR5cGUSCwoHTmVhcmVzdBAAEg8KC0FudGlOZWFyZXN0EAE=');

@$core.Deprecated('Use addResultDescriptor instead')
const AddResult$json = {
  '1': 'AddResult',
  '2': [
    {'1': 'Fail', '2': 0},
    {'1': 'Success', '2': 1},
  ],
};

/// Descriptor for `AddResult`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List addResultDescriptor = $convert.base64Decode(
    'CglBZGRSZXN1bHQSCAoERmFpbBAAEgsKB1N1Y2Nlc3MQAQ==');

@$core.Deprecated('Use checkRequestDescriptor instead')
const CheckRequest$json = {
  '1': 'CheckRequest',
  '2': [
    {'1': 'query_type', '3': 1, '4': 1, '5': 14, '6': '.QueryType', '10': 'queryType'},
    {'1': 'position_x', '3': 2, '4': 1, '5': 5, '10': 'positionX'},
    {'1': 'position_y', '3': 3, '4': 1, '5': 5, '10': 'positionY'},
    {'1': 'query_num', '3': 4, '4': 1, '5': 5, '10': 'queryNum'},
    {'1': 'encrypt', '3': 5, '4': 1, '5': 8, '10': 'encrypt'},
  ],
};

/// Descriptor for `CheckRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List checkRequestDescriptor = $convert.base64Decode(
    'CgxDaGVja1JlcXVlc3QSKQoKcXVlcnlfdHlwZRgBIAEoDjIKLlF1ZXJ5VHlwZVIJcXVlcnlUeX'
    'BlEh0KCnBvc2l0aW9uX3gYAiABKAVSCXBvc2l0aW9uWBIdCgpwb3NpdGlvbl95GAMgASgFUglw'
    'b3NpdGlvblkSGwoJcXVlcnlfbnVtGAQgASgFUghxdWVyeU51bRIYCgdlbmNyeXB0GAUgASgIUg'
    'dlbmNyeXB0');

@$core.Deprecated('Use checkResultDescriptor instead')
const CheckResult$json = {
  '1': 'CheckResult',
  '2': [
    {'1': 'position_x', '3': 1, '4': 1, '5': 5, '10': 'positionX'},
    {'1': 'position_y', '3': 2, '4': 1, '5': 5, '10': 'positionY'},
    {'1': 'database_id', '3': 3, '4': 1, '5': 5, '10': 'databaseId'},
  ],
};

/// Descriptor for `CheckResult`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List checkResultDescriptor = $convert.base64Decode(
    'CgtDaGVja1Jlc3VsdBIdCgpwb3NpdGlvbl94GAEgASgFUglwb3NpdGlvblgSHQoKcG9zaXRpb2'
    '5feRgCIAEoBVIJcG9zaXRpb25ZEh8KC2RhdGFiYXNlX2lkGAMgASgFUgpkYXRhYmFzZUlk');

@$core.Deprecated('Use checkResponseDescriptor instead')
const CheckResponse$json = {
  '1': 'CheckResponse',
  '2': [
    {'1': 'results', '3': 1, '4': 3, '5': 11, '6': '.CheckResult', '10': 'results'},
  ],
};

/// Descriptor for `CheckResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List checkResponseDescriptor = $convert.base64Decode(
    'Cg1DaGVja1Jlc3BvbnNlEiYKB3Jlc3VsdHMYASADKAsyDC5DaGVja1Jlc3VsdFIHcmVzdWx0cw'
    '==');

@$core.Deprecated('Use addRequestDescriptor instead')
const AddRequest$json = {
  '1': 'AddRequest',
  '2': [
    {'1': 'address', '3': 1, '4': 1, '5': 9, '10': 'address'},
  ],
};

/// Descriptor for `AddRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addRequestDescriptor = $convert.base64Decode(
    'CgpBZGRSZXF1ZXN0EhgKB2FkZHJlc3MYASABKAlSB2FkZHJlc3M=');

@$core.Deprecated('Use addResponseDescriptor instead')
const AddResponse$json = {
  '1': 'AddResponse',
  '2': [
    {'1': 'add_result', '3': 1, '4': 1, '5': 14, '6': '.AddResult', '10': 'addResult'},
  ],
};

/// Descriptor for `AddResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addResponseDescriptor = $convert.base64Decode(
    'CgtBZGRSZXNwb25zZRIpCgphZGRfcmVzdWx0GAEgASgOMgouQWRkUmVzdWx0UglhZGRSZXN1bH'
    'Q=');

@$core.Deprecated('Use mapResponseDescriptor instead')
const MapResponse$json = {
  '1': 'MapResponse',
  '2': [
    {'1': 'map', '3': 1, '4': 1, '5': 12, '10': 'map'},
  ],
};

/// Descriptor for `MapResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List mapResponseDescriptor = $convert.base64Decode(
    'CgtNYXBSZXNwb25zZRIQCgNtYXAYASABKAxSA21hcA==');

@$core.Deprecated('Use distDiffDescriptor instead')
const DistDiff$json = {
  '1': 'DistDiff',
  '2': [
    {'1': 'dis_diff', '3': 1, '4': 1, '5': 12, '10': 'disDiff'},
  ],
};

/// Descriptor for `DistDiff`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List distDiffDescriptor = $convert.base64Decode(
    'CghEaXN0RGlmZhIZCghkaXNfZGlmZhgBIAEoDFIHZGlzRGlmZg==');

@$core.Deprecated('Use diffResponseDescriptor instead')
const DiffResponse$json = {
  '1': 'DiffResponse',
  '2': [
    {'1': 'cmp_result', '3': 1, '4': 1, '5': 5, '10': 'cmpResult'},
  ],
};

/// Descriptor for `DiffResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List diffResponseDescriptor = $convert.base64Decode(
    'CgxEaWZmUmVzcG9uc2USHQoKY21wX3Jlc3VsdBgBIAEoBVIJY21wUmVzdWx0');

