import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preference_project/common/height_size_box.dart';
import 'package:shared_preference_project/common/width_size_box.dart';
import 'package:shared_preference_project/services/shared_preference_service.dart';
import 'package:shared_preference_project/utils/preference_key.dart';
import 'package:shared_preference_project/utils/routes_constants.dart';

class EmployeesRegisterScreen extends StatefulWidget {
  const EmployeesRegisterScreen({super.key});

  @override
  State<EmployeesRegisterScreen> createState() =>
      _EmployeesRegisterScreenState();
}

class _EmployeesRegisterScreenState extends State<EmployeesRegisterScreen> {
  @override
  void initState() {
    getEmployeeData();
    super.initState();
  }

  List employeesDataList = [];

  void getEmployeeData() {
    String getEmployeeDataString =
        PreferenceService.getString(PreferenceKey.employeesDetails);
    print('getEmployeeDataString --> $getEmployeeDataString');
    if (getEmployeeDataString != '') {
      employeesDataList = json.decode(getEmployeeDataString);
    }
  }

  void navigateTOEmployeeForm() {
    Navigator.pushNamed(context, RoutesConstants.employeeForm).then((value) {
      getEmployeeData();

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employees Register ( Records )'),
      ),
      body: employeesDataList.isEmpty
          ? const Center(
              child: Text('NO EMPLOYEES RECORD'),
            )
          : ListView.builder(
              itemCount: employeesDataList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              employeeDetails(
                                icon: Icons.perm_contact_cal_outlined,
                                title:
                                    '${(employeesDataList[index]['name']).toUpperCase()}',
                              ),
                              const Spacer(),
                              PopupMenuButton(
                                onSelected: (value) {
                                  if (value == RoutesConstants.employeeForm) {
                                    employeesDataList[index]['id'] = index;
                                    Navigator.of(context).pushNamed(
                                      RoutesConstants.employeeForm,
                                      arguments: employeesDataList[index],
                                    );
                                  } else if (value == 'Delete') {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return CupertinoAlertDialog(
                                          title: const Text(
                                            "Are you sure DELETE this details ?",
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                employeesDataList
                                                    .removeAt(index);
                                                PreferenceService.setValue(
                                                  PreferenceKey
                                                      .employeesDetails,
                                                  jsonEncode(employeesDataList),
                                                );

                                                Navigator.of(context).pop();
                                                getEmployeeData();
                                                setState(() {});
                                              },
                                              child: const Text(
                                                'YES',
                                                style: TextStyle(
                                                  color: Colors.green,
                                                ),
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text(
                                                'NO',
                                                style: TextStyle(
                                                  color: Colors.red,
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  }
                                },
                                itemBuilder: (BuildContext bc) {
                                  return [
                                    PopupMenuItem(
                                      value: RoutesConstants.employeeForm,
                                      child: const Text("Edit"),
                                    ),
                                    const PopupMenuItem(
                                      value: 'Delete',
                                      child: Text("Delete"),
                                    ),
                                  ];
                                },
                              )
                            ],
                          ),
                          heightSizeBox(5),
                          employeeDetails(
                            icon: Icons.person_2_outlined,
                            title: '${(employeesDataList[index]['gender'])}',
                          ),
                          heightSizeBox(5),
                          employeeDetails(
                            icon: Icons.date_range_outlined,
                            title:
                                '${(employeesDataList[index]['joiningDate'])}',
                          ),
                          heightSizeBox(5),
                          if (employeesDataList[index]['mobileNumber'] != null)
                            employeeDetails(
                              icon: Icons.mobile_friendly,
                              title:
                                  '${(employeesDataList[index]['mobileNumber'])}',
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          navigateTOEmployeeForm();
        },
        label: const Text('New Employee'),
        icon: const Icon(Icons.person),
        backgroundColor: Colors.deepPurple,
      ),
    );
  }
}

Widget employeeDetails({required IconData icon, required String title}) {
  return Row(
    children: [
      Icon(icon),
      widthSizeBox(8),
      Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
      ),
    ],
  );
}
