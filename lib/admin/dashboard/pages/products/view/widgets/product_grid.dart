///Package imports
import 'package:flutter/material.dart';
/// Core theme import
// ignore: depend_on_referenced_packages
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../../../resources/resources.dart';
import '../../../../../../utils/syncfusion_data_grid/sample_view.dart';
import 'product_data_grid_source.dart';

late ProductGridSource productDataSource;

class ProductGrid extends SampleView {
  const ProductGrid({Key? key}) : super(key: key);

  @override
  UserGridState createState() => UserGridState();
}

class UserGridState extends SampleViewState {
  static const double dataPagerHeight = 60;
  int _rowsPerPage = 10;
  bool isWebOrDesktop = true;

  @override
  void initState() {
    productDataSource = ProductGridSource(isWebOrDesktop: isWebOrDesktop);
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // UserVM vm = Provider.of<UserVM>(context, listen: false);
      // vm.searchController.addListener(() {
      //   debugPrint(vm.searchController.text);
      //   userDataSource = UserModelGridSource(isWebOrDesktop: isWebOrDesktop);
      //   vm.update();
      // });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  Widget _buildDataGrid() {
    return SfDataGridTheme(
      data: SfDataGridThemeData(
        headerColor: R.colors.themePink,
        gridLineColor: R.colors.offWhite,
        rowHoverColor: R.colors.themePink.withOpacity(0.1),
        sortIcon: Icon(
          Icons.sort,
          color: R.colors.offWhite,
        ),
      ),
      child: SfDataGrid(
        headerRowHeight: 56,
        source: productDataSource,
        rowsPerPage: _rowsPerPage,
        allowSorting: true,
        isScrollbarAlwaysShown: false,
        gridLinesVisibility: GridLinesVisibility.both,
        headerGridLinesVisibility: GridLinesVisibility.both,
        columns: <GridColumn>[
          _gridColumn(columnName: 'sr no.', width: 90),
          _gridColumn(columnName: 'Image', width: 160),
          _gridColumn(columnName: 'Name', width: 160),
          _gridColumn(columnName: 'Description', width: 200),
          _gridColumn(columnName: 'Created At', width: 160),
          _gridColumn(columnName: 'Status', width: 100),
          _gridColumn(columnName: 'Action', width: 100),
        ],
      ),
    );
  }

  GridColumn _gridColumn({double? width, required String columnName, AlignmentGeometry? alignment}) {
    return GridColumn(
      width: width ?? 100,
      autoFitPadding: const EdgeInsets.all(8),
      columnName: columnName,
      label: Container(
        padding: const EdgeInsets.all(8),
        alignment: alignment ?? Alignment.centerLeft,
        child: Text(
          columnName,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: R.textStyles.poppins(fontSize: 15),
        ),
      ),
    );
  }

  Widget _buildDataPager() {
    return SfDataPagerTheme(
      data: SfDataPagerThemeData(
          itemColor: R.colors.themePink,
          selectedItemColor: R.colors.themePink,
          backgroundColor: R.colors.lightGreyColor,
          disabledItemColor: R.colors.themePink.withOpacity(0.5),
          itemBorderColor: R.colors.lightGreyColor,
          dropdownButtonBorderColor: R.colors.themePink,
          itemTextStyle: R.textStyles.poppins(color: R.colors.black),
          disabledItemTextStyle: R.textStyles.poppins(color: R.colors.white),
          selectedItemTextStyle: R.textStyles.poppins(color: R.colors.white)),
      child: SfDataPager(
        direction: Axis.horizontal,
        delegate: productDataSource,
        availableRowsPerPage: const <int>[10, 20, 25],
        visibleItemsCount: 5,
        pageCount: (productDataSource.tickets.length / _rowsPerPage).ceilToDouble(),
        onRowsPerPageChanged: (int? rowsPerPage) {
          setState(() {
            _rowsPerPage = rowsPerPage!;
          });
        },
      ),
    );
  }

  Widget _buildLayoutBuilder() {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraint) {
      return Column(
        children: [
          SizedBox(
            height: constraint.maxHeight - dataPagerHeight,
            width: constraint.maxWidth,
            child: _buildDataGrid(),
          ),
          Container(
            height: dataPagerHeight,
            decoration: BoxDecoration(
              color: R.colors.lightGreyColor,
            ),
            child: Align(alignment: Alignment.center, child: _buildDataPager()),
          )
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return _buildLayoutBuilder();
  }
}
