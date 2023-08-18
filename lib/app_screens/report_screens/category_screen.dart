import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app_components/bottom_nav.dart';
import '../../main.dart';
import '../../utils/sql_helper.dart';
import '../asset_screens/asset_form_screen.dart';

class CategoryScreen extends StatefulWidget {
  final String? header;
  const CategoryScreen({super.key, this.header});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
  List<Map<String, dynamic>> _assetsList = [];
  bool _isLoading = true;

  String? header;

  Future<void> fetchAssetByCategory() async {
    setState(() {
      _isLoading = true;
    });
    //fetch from db
    final data = await SQLHelper.getAllAssets();
    setState(() {
      _isLoading = false;
      _assetsList =
          data.where((element) => element['asset_type'] == header).toList();
    });
  }

  void _showFormDialog(int id) async {
    final assetData = _assetsList.firstWhere((element) => element['id'] == id);
    print(assetData);
    await showDialog(
        context: context,
        builder: (_) => AlertDialog(
            title: Text('Edit  ${assetData['asset_name']}'),
            contentPadding: const EdgeInsets.all(10),
            content: SizedBox(
              width: 400,
              height: 550,
              child: AssetForm(
                isEditForm: true,
                initialData: AssetFormData(
                    id: assetData['id'],
                    assetName: assetData['asset_name'],
                    assetType: assetData['asset_type'],
                    assetQuantity: assetData['quantity'].toString()),
              ),
            )));
  }

  void deleteAssetLogic(BuildContext context, int id) async {
    try {
      await SQLHelper.deleteAsset(id);
      if (!mounted) return;

      Navigator.pop(context, 'Yes');
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Asset deleted successfully'),
        duration: Duration(seconds: 2),
      ));
      fetchAssetByCategory();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error deleting asset: $e'),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  //delete asset
  void _deleteAsset(int id) async {
    await showDialog(
        context: context,
        builder: (_) => AlertDialog(
                title: const Text('Confirm Delete Action'),
                content:
                    const Text('Are you sure you want to delete this asset'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'Cancel'),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                      onPressed: () {
                        // SQLHelper.deleteAsset(id);
                        // Navigator.pop(context, 'Yes');
                        // _fetchAssets();
                        deleteAssetLogic(context, id);
                      },
                      child: const Text('Yes')),
                ]));
  }

  @override
  void initState() {
    super.initState();
    if (widget.header != null) {
      header = widget.header;
      fetchAssetByCategory();
    }
  }

  @override
  Widget build(BuildContext context) {
    final authModel = Provider.of<AuthModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(capitalize(header ?? '')),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _assetsList.length,
              itemBuilder: (context, index) => Card(
                    color: Colors.orange[200],
                    margin: const EdgeInsets.all(15),
                    child: ListTile(
                      title: Text(capitalize(_assetsList[index]['asset_name'])),
                      subtitle: SizedBox(
                          child: Row(
                        children: [
                          Text('Quantity: ${_assetsList[index]['quantity']}'),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      )),
                      trailing: SizedBox(
                        width: 100,
                        child: Row(children: [
                          IconButton(
                              onPressed: () =>
                                  {_showFormDialog(_assetsList[index]['id'])},
                              icon: const Icon(Icons.edit)),
                          IconButton(
                              onPressed: () =>
                                  {_deleteAsset(_assetsList[index]['id'])},
                              icon: const Icon(Icons.delete)),
                        ]),
                      ),
                    ),
                  )),
      bottomNavigationBar: authModel.loggedIn ? const BottomNav() : null,
    );
  }
}
