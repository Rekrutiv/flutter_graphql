import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_graphql/src/bloc/graphql_bloc.dart';
import 'package:flutter_graphql/src/presentation/widget/text_widget.dart';
import 'package:flutter_graphql/src/query/country_query.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String selectedItem = "SOUTH AMERICA";
  String selectedItem3;

  final List<String> countryItemList = <String>[
    "ASIA",
    "NORTH AMERICA",
    "OCEANIA",
    "AFRIKA",
    "EUROPE",
    "SOUTH AMERICA"
  ];

  String itemSelected(String selectvalue) {
    switch (selectvalue) {
      case 'ASIA':
        selectedItem3 = 'AS';
        break;
      case 'NORTH AMERICA':
        selectedItem3 = 'NA';
        break;
      case 'OCEANIA':
        selectedItem3 = 'OC';
        break;
      case 'AFRIKA':
        selectedItem3 = 'AF';
        break;
      case 'EUROPE':
        selectedItem3 = 'EU';
        break;
      case 'SOUTH AMERICA':
        selectedItem3 = 'SA';
        break;
      default:
        {
          print("Invalid choice");
        }
        break;
    }

    return selectedItem3;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedItem),
      ),
      body: BlocProvider(
        create: (context) => GraphqlBloc()
          ..add(
            CountryGraphQLEvent(
              query,
              variables: {'ID': "SA"},
            ),
          ),
        child: BlocBuilder<GraphqlBloc, GraphqlState>(
          builder: (context, state) {
            if (state is Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is LoadDataSuccess) {
              final List _repositories = state.data['continent']['countries'];
              return Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.cyan,
                        border: Border.all()),
                    child: buildDropdownButton(),
                  ),
                  Expanded(
                      child: RefreshIndicator(
                    // ignore: missing_return
                    onRefresh: () {
                      // ignore: close_sinks
                      final itemsBloc = BlocProvider.of<GraphqlBloc>(context)
                        ..add(CountryGraphQLEvent(
                          query,
                          variables: {'ID': selectedItem3},
                        ));

                      return itemsBloc
                          .firstWhere((e) => e is! CountryGraphQLEvent);
                    },
                    child: buildListView(_repositories),
                  )),
                ],
              );
            }
            if (state is LoadDataFail) {
              return Center(
                child: const AutoSizeText('something went wrong',
                    style: TextStyle(fontSize: 40),
                    minFontSize: 10,
                    stepGranularity: 10,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  ListView buildListView(List _repositories) {
    return ListView.builder(
      itemCount: _repositories.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          leading: AutoTextWidget(
              autoText: _repositories[index]['emoji'].toString(),
              textFontSize: 40,
              textStep: 10),
          title: AutoTextWidget(
              autoText: _repositories[index]['name'].toString(),
              textFontSize: 30,
              textStep: 5),
          subtitle: AutoTextWidget(
              autoText: _repositories[index]['capital'].toString(),
              textFontSize: 30,
              textStep: 5),
        );
      },
    );
  }

  DropdownButton<String> buildDropdownButton() {
    return DropdownButton<String>(
      value: selectedItem,
      isExpanded: true,
      dropdownColor: Colors.blueGrey,
      icon: const Icon(Icons.arrow_drop_down),
      iconSize: 24,
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String _newValue) {
        setState(() {
          itemSelected(_newValue);
          selectedItem = _newValue;
        });
      },
      items: countryItemList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
