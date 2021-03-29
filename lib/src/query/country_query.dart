const String query = r'''
  query GetCountry($ID : ID!){
    continent(code:$ID){
      name
      countries{
        name
        capital
        emoji
      }
    }
  }
''';
String get countriesQuery {
    return '''
    query Countries {
       countries {
        emoji
        name
        capital
        phone
        currency
        languages {
          name
        }
      }
    }
    ''';
}