// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:khosousi_online/core/managers/color_manager.dart';


class CustomDataTable extends StatelessWidget {
  final List<String> columns;
   final List<DataRow> rows;
  const CustomDataTable({
    Key? key,
    required this.columns,
    required this.rows,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
       scrollDirection: Axis.horizontal,
      child: Column(
        children: [
          DataTable(
            showCheckboxColumn: false,
            border: TableBorder.all(
              width: 1.0,
              color: ColorManager.gray1,
            ),
            headingRowColor: MaterialStateColor.resolveWith(
              (states) {
                return ColorManager.black;
              },
            ),
            headingTextStyle: TextStyle(color: Colors.white),
            columnSpacing: 30,
            dataRowMaxHeight: double.infinity,
            columns: getColums(),
            rows: rows,
          ),
        ],
      ),
    );
  }

  List<DataColumn> getColums() {
    return columns
        .map(
          (e) => DataColumn(
            label:  Text(
                e,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                ),

            ),
          ),
        )
        .toList();
  }
}
