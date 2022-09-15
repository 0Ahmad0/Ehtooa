import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../resources/values_manager.dart';

class GetDataView extends StatelessWidget {
  const GetDataView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitPouringHourGlass(
          color: Theme.of(context).primaryColor,
          size: AppSize.s40,
        ),
      ),
    );
  }
}
