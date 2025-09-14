import 'package:flutter/material.dart';
import 'package:test_flutter/viewmodel/viewmodels.dart';
import 'package:test_flutter/views/BusinessListView.dart';
import 'package:test_flutter/views/BusinessDetailsView.dart';
import 'package:provider/provider.dart';


  final routes = <String, WidgetBuilder>{
    "/": (BuildContext context) => BusinessListView(context.read<BusinessViewModel>()),
    "/businessDetails": (BuildContext context) {
  final args = ModalRoute.of(context)!.settings.arguments as BusinessDetailsArgs;
  return BusinessDetailsView(index: args.index);
    },
  };

class BusinessDetailsArgs {
  final int index;
  BusinessDetailsArgs({required this.index});
}