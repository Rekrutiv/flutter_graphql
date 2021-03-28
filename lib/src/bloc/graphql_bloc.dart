import 'dart:async';
import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_graphql/src/helper/graphql_helper.dart';

import 'package:meta/meta.dart';

part 'graphql_event.dart';

part 'graphql_state.dart';

class GraphqlBloc extends Bloc<GraphqlEvent, GraphqlState> {
  GraphqlBloc() : super(GraphqlInitial());
  final _random = Random();
  final _itemNames = [
    'AS', 'NA', 'OC', 'AF','EU','SA'
  ];


  GraphQLServiceImplRepo graphQLServiceImplRepo = GraphQLServiceImplRepo();

  @override
  Stream<GraphqlState> mapEventToState(
    GraphqlEvent event,
  ) async* {
    if (event is CountryGraphQLEvent) {
      yield* _mapFetchHomeDataToStates(event);
    }
  }

  Stream<GraphqlState> _mapFetchHomeDataToStates(CountryGraphQLEvent event) async* {
    final query = event.query;
    final variables = event.variables ?? {};

    try {
      yield Loading();
      final result = await graphQLServiceImplRepo.performMutation(
        query,
        variables: variables,
      );

      if (result.hasException) {
        yield LoadDataFail(result.exception.graphqlErrors[0]);
      } else {
        yield LoadDataSuccess(result.data);
      }
    } catch (e) {
      yield LoadDataFail(e.toString());
    }
  }
}
