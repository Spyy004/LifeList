import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../constants/index.dart';
import '../services/index.dart';

class MyDropDownScope extends StatefulWidget {
  const MyDropDownScope({super.key, required this.actions});
  final String actions;
  @override
  // ignore: library_private_types_in_public_api
  _MyDropDownScopeState createState() => _MyDropDownScopeState();
}

class _MyDropDownScopeState extends State<MyDropDownScope> {
  late String? selectedItem = null;
  final List<String> _items = createScopes;
  @override
  Widget build(
    BuildContext context,
  ) {
    return Container(
      width: MediaQuery.of(context).size.width, // Set width to screen width
      padding: const EdgeInsets.all(5.0), // Add padding
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0), // Add border radius
        border: Border.all(
            color: Colors.white,
            style: BorderStyle.solid,
            width: 0.3), // Add border color
      ),
      child: Consumer2<CreateBucketService, BucketService>(
        builder: (context, bucketModel, editBucketModel, child) =>
            DropdownButton<String>(
          hint: Text(AppLocalizations.of(context).selectscope, style: Theme.of(context).textTheme.bodyLarge),
          iconEnabledColor: Colors.white,
          value: selectedItem,
          onChanged: (newValue) {
            selectedItem = newValue!;

            if (widget.actions == 'CREATE') {
              bucketModel.toggleBucketScope(stringToBucketScope[selectedItem]);
            }
          
          },
          items: _items.map((item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
          isExpanded: true,
          underline: Container(), // Make the dropdown menu expand to full width
        ),
      ),
    );
  }
}
