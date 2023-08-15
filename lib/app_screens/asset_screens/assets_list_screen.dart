import 'package:flutter/material.dart';
import 'package:sample_report_app/app_screens/asset_screens/asset_form_screen.dart';
import 'package:sample_report_app/utils/sql_helper.dart';

class AssetsList extends StatefulWidget {
  const AssetsList({super.key});

  @override
  State<AssetsList> createState() => _AssetsListState();
}

class _AssetsListState extends State<AssetsList> {
  List<Map<String, dynamic>> _assetsList = [];

  bool _isLoading = true;

  //fetch from db
  Future<void> _fetchAssets() async {
    setState(() {
      _isLoading = true;
    });
    //fetch from db
    final data = await SQLHelper.getAllAssets();

    setState(() {
      _assetsList = data;
      _isLoading = false;
    });
  }

  //open dialog
  void _showFormDialog(int id) async {
    final assetData = _assetsList.firstWhere((element) => element['id'] == id);

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
                    assetName: assetData['asset_name'],
                    assetType: assetData['asset_type'],
                    assetQuantity: assetData['quantity'].toString()),
              ),
            )));
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
                        SQLHelper.deleteAsset(id);
                        Navigator.pop(context, 'Yes');
                        _fetchAssets();
                      },
                      child: const Text('Yes')),
                ]));
  }

  @override
  void initState() {
    super.initState();
    _fetchAssets(); //fetch the page loads
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Assets List'),
          actions: <Widget>[
            IconButton(
                onPressed: () {}, icon: const Icon(Icons.account_circle)),
          ],
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
                        title: Text(_assetsList[index]['asset_name']),
                        subtitle: Text(_assetsList[index]['asset_type']),
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => const AssetForm(
                          isEditForm: false,
                        )));
          },
          child: const Icon(Icons.add),
        ));
  }
}
