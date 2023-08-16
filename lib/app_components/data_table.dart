import 'package:flutter/material.dart';

import '../utils/sql_helper.dart';

class DataTableWidget extends StatefulWidget {
  const DataTableWidget({super.key});
  @override
  State<DataTableWidget> createState() => _DataTableWidgetState();
}

class _DataTableWidgetState extends State<DataTableWidget> {
  List<Map<String, dynamic>> _assetsList = [];
  late final DataTableSource _data;
  // final DataTableSource _data = MyData(
  //   assetsList: _assetsList,
  // );

  bool _isLoading = true;

  Future<void> _fetchAssets() async {
    setState(() {
      _isLoading = true;
    });
    //fetch from db
    final data = await SQLHelper.getAllAssets();

    setState(() {
      _assetsList = data;
      _isLoading = false;
      _data = MyData(assetsList: _assetsList);
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchAssets(); //fetch the page loads
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        if (_isLoading) // Show loading indicator if data is being fetched
          const CircularProgressIndicator()
        else
          PaginatedDataTable(
            source: _data,
            header: const Text('Asset List'),
            columns: const [
              DataColumn(label: Text('ID')),
              DataColumn(label: Text('Asset Name')),
              DataColumn(label: Text('Asset Type')),
              DataColumn(label: Text('Quantity'))
            ],
            columnSpacing: 50,
            horizontalMargin: 10,
            rowsPerPage: 8,
            showCheckboxColumn: false,
          ),
      ],
    );
  }
}

class MyData extends DataTableSource {
  List<Map<String, dynamic>> assetsList = [];

  MyData({required this.assetsList});

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => assetsList.length;

  @override
  int get selectedRowCount => 0;

  @override
  DataRow getRow(int index) {
    return DataRow(cells: [
      DataCell(Text(assetsList[index]['id'].toString())),
      DataCell(Text(assetsList[index]['asset_name'])),
      DataCell(Text(assetsList[index]['asset_type'])),
      DataCell(Text(assetsList[index]['quantity'].toString())),
    ]);
  }
}
