//
//  Generated code. Do not modify.
//  source: federation.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'federation.pb.dart' as $0;

export 'federation.pb.dart';

@$pb.GrpcServiceName('FederationService')
class FederationServiceClient extends $grpc.Client {
  static final _$checkData = $grpc.ClientMethod<$0.CheckRequest, $0.CheckResponse>(
      '/FederationService/CheckData',
      ($0.CheckRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.CheckResponse.fromBuffer(value));
  static final _$addDatabase = $grpc.ClientMethod<$0.AddRequest, $0.AddResponse>(
      '/FederationService/AddDatabase',
      ($0.AddRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.AddResponse.fromBuffer(value));
  static final _$generateMap = $grpc.ClientMethod<$0.CheckResponse, $0.MapResponse>(
      '/FederationService/GenerateMap',
      ($0.CheckResponse value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.MapResponse.fromBuffer(value));
  static final _$compareDist = $grpc.ClientMethod<$0.DistDiff, $0.DiffResponse>(
      '/FederationService/CompareDist',
      ($0.DistDiff value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.DiffResponse.fromBuffer(value));

  FederationServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$0.CheckResponse> checkData($0.CheckRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$checkData, request, options: options);
  }

  $grpc.ResponseFuture<$0.AddResponse> addDatabase($0.AddRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$addDatabase, request, options: options);
  }

  $grpc.ResponseFuture<$0.MapResponse> generateMap($0.CheckResponse request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$generateMap, request, options: options);
  }

  $grpc.ResponseFuture<$0.DiffResponse> compareDist($0.DistDiff request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$compareDist, request, options: options);
  }
}

@$pb.GrpcServiceName('FederationService')
abstract class FederationServiceBase extends $grpc.Service {
  $core.String get $name => 'FederationService';

  FederationServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.CheckRequest, $0.CheckResponse>(
        'CheckData',
        checkData_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.CheckRequest.fromBuffer(value),
        ($0.CheckResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AddRequest, $0.AddResponse>(
        'AddDatabase',
        addDatabase_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.AddRequest.fromBuffer(value),
        ($0.AddResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CheckResponse, $0.MapResponse>(
        'GenerateMap',
        generateMap_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.CheckResponse.fromBuffer(value),
        ($0.MapResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.DistDiff, $0.DiffResponse>(
        'CompareDist',
        compareDist_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.DistDiff.fromBuffer(value),
        ($0.DiffResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.CheckResponse> checkData_Pre($grpc.ServiceCall call, $async.Future<$0.CheckRequest> request) async {
    return checkData(call, await request);
  }

  $async.Future<$0.AddResponse> addDatabase_Pre($grpc.ServiceCall call, $async.Future<$0.AddRequest> request) async {
    return addDatabase(call, await request);
  }

  $async.Future<$0.MapResponse> generateMap_Pre($grpc.ServiceCall call, $async.Future<$0.CheckResponse> request) async {
    return generateMap(call, await request);
  }

  $async.Future<$0.DiffResponse> compareDist_Pre($grpc.ServiceCall call, $async.Future<$0.DistDiff> request) async {
    return compareDist(call, await request);
  }

  $async.Future<$0.CheckResponse> checkData($grpc.ServiceCall call, $0.CheckRequest request);
  $async.Future<$0.AddResponse> addDatabase($grpc.ServiceCall call, $0.AddRequest request);
  $async.Future<$0.MapResponse> generateMap($grpc.ServiceCall call, $0.CheckResponse request);
  $async.Future<$0.DiffResponse> compareDist($grpc.ServiceCall call, $0.DistDiff request);
}
