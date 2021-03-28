part of 'graphql_bloc.dart';

@immutable
abstract class GraphqlEvent extends Equatable {}

class CountryGraphQLEvent extends GraphqlEvent {
  final String query;
  final Map<String, dynamic> variables;

  CountryGraphQLEvent(this.query, {this.variables}) : super();

  @override
  List<Object> get props => [query, variables];
}

// ignore: must_be_immutable
class ItemsGraphqlEventRefresh extends GraphqlEvent {
  String query;
  final Map<String, dynamic> variables;

  ItemsGraphqlEventRefresh( {this.variables}) : super();

  @override
  List<Object> get props => [query, variables];
}
