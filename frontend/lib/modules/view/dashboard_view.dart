import 'package:data_tables/data_tables.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:kacasentrum/modules/view_model/dashboard_view_model.dart';
import 'package:kacasentrum/rpc/tksh.pbgrpc.dart' as rpc;

class DashboardView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DashboardViewModel>.reactive(
      viewModelBuilder: () => DashboardViewModel(),
      onModelReady: (DashboardViewModel model) async {
        await model.fetchReports();
      },
      builder: (BuildContext ctx, DashboardViewModel model, Widget w) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: true,
            title: Text('Laporan Kaca Sentrum ${model.getDateTimeNow()}'),
            centerTitle: true,
          ),
          body: model.isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : model.totalCount == 0 || model.transferRecordList == null
                  ? Center(
                      child: Text('Not Found',
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).copyWith().textTheme.headline4),
                    )
                  : NativeDataTable.builder(
                      sortAscending: false,
                      rowsPerPage: model.totalCount,
                      itemCount: model.totalCount,
                      firstRowIndex: 0,
                      handleNext: () {},
                      handlePrevious: () {},
                      itemBuilder: (int index) {
                        final rpc.TransferRecord item =
                            model.transferRecordList[index];
                        return DataRow.byIndex(index: index,
                            // selected: item.selected,
                            // onSelectChanged: (bool value) {},
                            cells: <DataCell>[
                              DataCell(
                                  Text('${model.getDateTime(item.tanggal)}')),
                              DataCell(Text('${item.transfer}')),
                            ]);
                      },
                      alwaysShowDataTable: true,
                      header: Text(
                          'Total Saldo: Rp. ${model.getTotalSaldo().toString()}'),
                      // sortColumnIndex: _sortColumnIndex,
                      // sortAscending: _sortAscending,
                      onRefresh: () async {
                        model.fetchReports();
                      },
                      onRowsPerPageChanged: (int i) {},
                      rowCountApproximate: true,
                      actions: <Widget>[
                        IconButton(
                          icon: Icon(Icons.info_outline),
                          onPressed: () {},
                        ),
                      ],
                      columns: <DataColumn>[
                        DataColumn(
                          label: const Text('Tanggal'),
                          tooltip: 'Tanggal ditransfer.',
                        ),
                        DataColumn(
                          label: const Text('Jumlah Transfer'),
                          numeric: true,
                        ),
                      ],
                    ),
        );
      },
    );
    //
  }
}
