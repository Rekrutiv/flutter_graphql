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

class ItemsGraphqlEventRefresh extends GraphqlEvent {
  final String query;
  final Map<String, dynamic> variables;

  ItemsGraphqlEventRefresh(this.query, {this.variables}) : super();

  @override
  List<Object> get props => [query, variables];
}
