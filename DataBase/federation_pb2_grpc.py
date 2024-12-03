# Generated by the gRPC Python protocol compiler plugin. DO NOT EDIT!
"""Client and server classes corresponding to protobuf-defined services."""
import grpc
import warnings

import federation_pb2 as federation__pb2

GRPC_GENERATED_VERSION = '1.68.0'
GRPC_VERSION = grpc.__version__
_version_not_supported = False

try:
    from grpc._utilities import first_version_is_lower
    _version_not_supported = first_version_is_lower(GRPC_VERSION, GRPC_GENERATED_VERSION)
except ImportError:
    _version_not_supported = True

if _version_not_supported:
    raise RuntimeError(
        f'The grpc package installed is at version {GRPC_VERSION},'
        + f' but the generated code in federation_pb2_grpc.py depends on'
        + f' grpcio>={GRPC_GENERATED_VERSION}.'
        + f' Please upgrade your grpc module to grpcio>={GRPC_GENERATED_VERSION}'
        + f' or downgrade your generated code using grpcio-tools<={GRPC_VERSION}.'
    )


class FederationServiceStub(object):
    """Missing associated documentation comment in .proto file."""

    def __init__(self, channel):
        """Constructor.

        Args:
            channel: A grpc.Channel.
        """
        self.Check = channel.unary_unary(
                '/FederationService/Check',
                request_serializer=federation__pb2.CheckRequest.SerializeToString,
                response_deserializer=federation__pb2.CheckResponse.FromString,
                _registered_method=True)
        self.AddDatabase = channel.unary_unary(
                '/FederationService/AddDatabase',
                request_serializer=federation__pb2.AddRequest.SerializeToString,
                response_deserializer=federation__pb2.AddResponse.FromString,
                _registered_method=True)
        self.GenerateMap = channel.unary_unary(
                '/FederationService/GenerateMap',
                request_serializer=federation__pb2.CheckResponse.SerializeToString,
                response_deserializer=federation__pb2.MapResponse.FromString,
                _registered_method=True)
        self.CompareDist = channel.unary_unary(
                '/FederationService/CompareDist',
                request_serializer=federation__pb2.DistDiff.SerializeToString,
                response_deserializer=federation__pb2.DiffResponse.FromString,
                _registered_method=True)


class FederationServiceServicer(object):
    """Missing associated documentation comment in .proto file."""

    def Check(self, request, context):
        """前端向federation发送的消息类型
        """
        context.set_code(grpc.StatusCode.UNIMPLEMENTED)
        context.set_details('Method not implemented!')
        raise NotImplementedError('Method not implemented!')

    def AddDatabase(self, request, context):
        """Missing associated documentation comment in .proto file."""
        context.set_code(grpc.StatusCode.UNIMPLEMENTED)
        context.set_details('Method not implemented!')
        raise NotImplementedError('Method not implemented!')

    def GenerateMap(self, request, context):
        """Missing associated documentation comment in .proto file."""
        context.set_code(grpc.StatusCode.UNIMPLEMENTED)
        context.set_details('Method not implemented!')
        raise NotImplementedError('Method not implemented!')

    def CompareDist(self, request, context):
        """database向federation发送的消息类型
        """
        context.set_code(grpc.StatusCode.UNIMPLEMENTED)
        context.set_details('Method not implemented!')
        raise NotImplementedError('Method not implemented!')


def add_FederationServiceServicer_to_server(servicer, server):
    rpc_method_handlers = {
            'Check': grpc.unary_unary_rpc_method_handler(
                    servicer.Check,
                    request_deserializer=federation__pb2.CheckRequest.FromString,
                    response_serializer=federation__pb2.CheckResponse.SerializeToString,
            ),
            'AddDatabase': grpc.unary_unary_rpc_method_handler(
                    servicer.AddDatabase,
                    request_deserializer=federation__pb2.AddRequest.FromString,
                    response_serializer=federation__pb2.AddResponse.SerializeToString,
            ),
            'GenerateMap': grpc.unary_unary_rpc_method_handler(
                    servicer.GenerateMap,
                    request_deserializer=federation__pb2.CheckResponse.FromString,
                    response_serializer=federation__pb2.MapResponse.SerializeToString,
            ),
            'CompareDist': grpc.unary_unary_rpc_method_handler(
                    servicer.CompareDist,
                    request_deserializer=federation__pb2.DistDiff.FromString,
                    response_serializer=federation__pb2.DiffResponse.SerializeToString,
            ),
    }
    generic_handler = grpc.method_handlers_generic_handler(
            'FederationService', rpc_method_handlers)
    server.add_generic_rpc_handlers((generic_handler,))
    server.add_registered_method_handlers('FederationService', rpc_method_handlers)


 # This class is part of an EXPERIMENTAL API.
class FederationService(object):
    """Missing associated documentation comment in .proto file."""

    @staticmethod
    def Check(request,
            target,
            options=(),
            channel_credentials=None,
            call_credentials=None,
            insecure=False,
            compression=None,
            wait_for_ready=None,
            timeout=None,
            metadata=None):
        return grpc.experimental.unary_unary(
            request,
            target,
            '/FederationService/Check',
            federation__pb2.CheckRequest.SerializeToString,
            federation__pb2.CheckResponse.FromString,
            options,
            channel_credentials,
            insecure,
            call_credentials,
            compression,
            wait_for_ready,
            timeout,
            metadata,
            _registered_method=True)

    @staticmethod
    def AddDatabase(request,
            target,
            options=(),
            channel_credentials=None,
            call_credentials=None,
            insecure=False,
            compression=None,
            wait_for_ready=None,
            timeout=None,
            metadata=None):
        return grpc.experimental.unary_unary(
            request,
            target,
            '/FederationService/AddDatabase',
            federation__pb2.AddRequest.SerializeToString,
            federation__pb2.AddResponse.FromString,
            options,
            channel_credentials,
            insecure,
            call_credentials,
            compression,
            wait_for_ready,
            timeout,
            metadata,
            _registered_method=True)

    @staticmethod
    def GenerateMap(request,
            target,
            options=(),
            channel_credentials=None,
            call_credentials=None,
            insecure=False,
            compression=None,
            wait_for_ready=None,
            timeout=None,
            metadata=None):
        return grpc.experimental.unary_unary(
            request,
            target,
            '/FederationService/GenerateMap',
            federation__pb2.CheckResponse.SerializeToString,
            federation__pb2.MapResponse.FromString,
            options,
            channel_credentials,
            insecure,
            call_credentials,
            compression,
            wait_for_ready,
            timeout,
            metadata,
            _registered_method=True)

    @staticmethod
    def CompareDist(request,
            target,
            options=(),
            channel_credentials=None,
            call_credentials=None,
            insecure=False,
            compression=None,
            wait_for_ready=None,
            timeout=None,
            metadata=None):
        return grpc.experimental.unary_unary(
            request,
            target,
            '/FederationService/CompareDist',
            federation__pb2.DistDiff.SerializeToString,
            federation__pb2.DiffResponse.FromString,
            options,
            channel_credentials,
            insecure,
            call_credentials,
            compression,
            wait_for_ready,
            timeout,
            metadata,
            _registered_method=True)
