import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sample_report_app/app_screens/asset_screens/assets_list_screen.dart';
import 'package:sample_report_app/utils/sql_helper.dart';

import '../../main.dart';

class AssetFormData {
  final int id;
  final String assetType;
  final String assetName;
  final String assetQuantity;

  AssetFormData({
    required this.id,
    required this.assetType,
    required this.assetName,
    required this.assetQuantity,
  });
}

class AssetForm extends StatefulWidget {
  final AssetFormData? initialData;
  final bool isEditForm;
  const AssetForm({
    super.key,
    this.initialData,
    required this.isEditForm,
  });

  @override
  State<AssetForm> createState() => _AssetFormState();
}

class _AssetFormState extends State<AssetForm> {
  final _formKey = GlobalKey<FormState>();
  int assetId = 0;

  TextEditingController assetTypeController = TextEditingController();
  TextEditingController assetNameController = TextEditingController();
  TextEditingController assetQuantityController = TextEditingController();
  String selectedValue = 'furniture';

  //insert new asset into database
  Future<void> _addNewAsset(BuildContext context) async {
    await SQLHelper.createAsset(assetNameController.text, selectedValue,
        int.parse(assetQuantityController.text));

    if (!mounted) return;
    // context.go('/asset-list');
    ScaffoldMessenger.of(context)
        .showSnackBar(
          const SnackBar(
            content: Text('Asset added successfully'),
            duration: Duration(seconds: 2),
          ),
        )
        .closed
        .then((reason) {
      // Navigate after the SnackBar is closed
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => const AssetsList()));
    });
  }

  Future<void> _editAsset(BuildContext context) async {
    try {
      await SQLHelper.updateAsset(assetId, assetNameController.text,
          int.parse(assetQuantityController.text), selectedValue);

      if (!mounted) return;
      Navigator.of(context).pop();
      // Show a success message using SnackBar
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Asset edited successfully'),
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error editing asset: $e'),
          duration: const Duration(seconds: 2),
        ),
      );
      // Handle any errors that might occur during the edit process
    }
  }

  @override
  void initState() {
    super.initState();
    print(widget.initialData);
    if (widget.initialData != null) {
      assetId = widget.initialData!.id;
      assetNameController =
          TextEditingController(text: widget.initialData!.assetName);
      assetQuantityController =
          TextEditingController(text: widget.initialData!.assetQuantity);
      selectedValue = widget.initialData!.assetType;
    }
  }

  @override
  void dispose() {
    assetNameController.dispose();
    assetQuantityController.dispose();
    assetTypeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authModel = Provider.of<AuthModel>(context);

    bool isEditForm = widget.isEditForm;
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(
        value: 'furniture',
        child: Text('Furniture'),
      ),
      const DropdownMenuItem(
        value: 'accessories',
        child: Text('Computer Accessories'),
      ),
      const DropdownMenuItem(
        value: 'electronics',
        child: Text('Electronics'),
      ),
    ];

    return Scaffold(
        appBar: isEditForm
            ? null
            : AppBar(
                title: const Text('Add Asset'),
                actions: <Widget>[
                  PopupMenuButton(
                      itemBuilder: (BuildContext context) => [
                            PopupMenuItem(
                              child: TextButton(
                                onPressed: () {
                                  authModel.logout();
                                  context.go('/');
                                },
                                child: const Text('Logout'),
                              ),
                            )
                          ])
                ],
              ),
        body: SingleChildScrollView(
            child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(children: <Widget>[
            Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Center(
                  child: SizedBox(
                    width: 200,
                    height: 150,
                    child: Image.asset('asset/images/desk.jpg'),
                  ),
                )),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              child: DropdownButtonFormField(
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Asset Type',
                      hintText: 'Select asset type'),
                  value: selectedValue,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedValue = newValue!;
                    });
                  },
                  validator: (value) => value == null ? "Select a type" : null,
                  items: menuItems),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              child: TextFormField(
                controller: assetNameController,
                decoration: const InputDecoration(
                  labelText: 'Asset Name',
                  hintText: 'Enter valid asset name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter asset name';
                  }

                  return null; // Return null if the input is valid
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              child: TextFormField(
                controller: assetQuantityController,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Quantity',
                    hintText: 'Enter asset quantity'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter asset quantity';
                  }

                  return null; // Return null if the input is valid
                },
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              child: isEditForm
                  ? TextButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await _editAsset(context);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Please fill the form')),
                          );
                        }
                      },
                      child: const Text(
                        'Edit Asset',
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                    )
                  : TextButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await _addNewAsset(context);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Please fill the form')),
                          );
                        }
                      },
                      child: const Text(
                        'Add Asset',
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      )),
            )
          ]),
        )));
  }
}
