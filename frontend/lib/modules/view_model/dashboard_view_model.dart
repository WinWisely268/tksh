import 'package:flutter/material.dart';
import 'package:kacasentrum/modules/repo/tksh_repo.dart';
import 'package:kacasentrum/rpc/tksh.pbgrpc.dart' as rpc;
import 'package:kacasentrum/shared/widgets/notify.dart';

class DashboardViewModel extends ChangeNotifier {
  int _totalCount = 0;
  bool _isLoading = true;
  bool _hasError = false;
  String _errMsg = '';
  String _sortBy = '';
  double _total = 0.0;
  rpc.ReportAll _reportAll;
  List<rpc.TransferRecord> _transferRecordList;

  String get errMsg => _errMsg;

  bool get isLoading => _isLoading;

  bool get hasError => _hasError;

  int get totalCount => _totalCount;

  rpc.ReportAll get allReports => _reportAll;

  List<rpc.TransferRecord> get transferRecordList => _transferRecordList;

  void _setLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  void _setHasError(bool val) {
    _hasError = val;
    notifyListeners();
  }

  void _setErrMsg(String val) {
    _errMsg = val;
    notifyListeners();
  }

  void _setTotalCount(int val) {
    _totalCount = val;
    notifyListeners();
  }

  void _setSortBy(String val) {
    _sortBy = val;
    notifyListeners();
  }

  Future<void> fetchReports() async {
    _setLoading(true);
    try {
      final resp = await TkshRepo.getReport(sortBy: 'Tanggal');
      if (resp != null && resp.reportItems?.length > 0) {
        _reportAll = resp;
        _setTotalCount(_reportAll.reportItems.length);
        _transferRecordList = _reportAll.reportItems;
        notifyListeners();
      }
    } catch (e) {
      _setHasError(true);
      _setErrMsg(e.toString());
    }
    _setLoading(false);
  }

  double getTotalSaldo() {
    _total = 0.0;
    if (_reportAll == null) {
      return 0.0;
    }
    _reportAll.reportItems.forEach((el) {
      _total += el.transfer;
    });
    notifyListeners();
    return _total;
  }
}
