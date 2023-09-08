/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'dart:async' as _i2;
import 'dart:io' as _i3;
import 'protocol.dart' as _i4;

class _EndpointQuestServer extends _i1.EndpointRef {
  _EndpointQuestServer(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'questServer';

  _i2.Future<int> getQuestionNum() => caller.callServerEndpoint<int>(
        'questServer',
        'getQuestionNum',
        {},
      );

  _i2.Future<String> getQuestion(int index) =>
      caller.callServerEndpoint<String>(
        'questServer',
        'getQuestion',
        {'index': index},
      );

  _i2.Future<int> getQuestionChoiceNum(int index) =>
      caller.callServerEndpoint<int>(
        'questServer',
        'getQuestionChoiceNum',
        {'index': index},
      );

  _i2.Future<List<String>> getQuestionChoices(int index) =>
      caller.callServerEndpoint<List<String>>(
        'questServer',
        'getQuestionChoices',
        {'index': index},
      );

  _i2.Future<bool> checkQuestionChoices(
    int index,
    List<int> choiceIndices,
  ) =>
      caller.callServerEndpoint<bool>(
        'questServer',
        'checkQuestionChoices',
        {
          'index': index,
          'choiceIndices': choiceIndices,
        },
      );
}

class Client extends _i1.ServerpodClient {
  Client(
    String host, {
    _i3.SecurityContext? context,
    _i1.AuthenticationKeyManager? authenticationKeyManager,
  }) : super(
          host,
          _i4.Protocol(),
          context: context,
          authenticationKeyManager: authenticationKeyManager,
        ) {
    questServer = _EndpointQuestServer(this);
  }

  late final _EndpointQuestServer questServer;

  @override
  Map<String, _i1.EndpointRef> get endpointRefLookup =>
      {'questServer': questServer};
  @override
  Map<String, _i1.ModuleEndpointCaller> get moduleLookup => {};
}
