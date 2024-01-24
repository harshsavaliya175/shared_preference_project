import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:shared_preference_project/common/height_size_box.dart';
import 'package:shared_preference_project/common/text_filed.dart';
import 'package:shared_preference_project/common/width_size_box.dart';
import 'package:shared_preference_project/services/shared_preference_service.dart';
import 'package:shared_preference_project/utils/preference_key.dart';

class EmployeeFormScreen extends StatefulWidget {
  const EmployeeFormScreen({super.key});

  @override
  State<EmployeeFormScreen> createState() => _EmployeeFormScreenState();
}

class _EmployeeFormScreenState extends State<EmployeeFormScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController joiningDateController = TextEditingController();
  TextEditingController mobileController = TextEditingController();

  DateTime? pickedDate;

  bool checkGender = false;
  bool male = false;
  bool female = false;

  Future<void> showDatePickerFunction() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);

      setState(() {
        joiningDateController.text = formattedDate;
      });
    }
  }

  void submitButton() {
    checkGender = true;

    if (_formKey.currentState!.validate()) {
      List employeesList = [];

      Map employeeMap = {
        'name': nameController.text,
        'gender': genderController.text,
        if (mobileController.text.isNotEmpty)
          'mobileNumber': mobileController.text,
        'joiningDate': joiningDateController.text,
      };

      String employeeDataString =
          PreferenceService.getString(PreferenceKey.employeesDetails);

      if (employeeDataString == '') {
        employeesList.add(employeeMap);
      } else {
        employeesList = jsonDecode(employeeDataString);
        employeesList.add(employeeMap);
      }

      PreferenceService.setValue(
        PreferenceKey.employeesDetails,
        jsonEncode(employeesList),
      );
      checkGender = false;
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: const Text(
            'Please Enter Valid Data',
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(
              color: Colors.white,
            ),
          ),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)!.settings.arguments as Map?;
    if (data != null) {
      nameController.text = data['name'];
      genderController.text = data['gender'];
      joiningDateController.text = data['joiningDate'];
      mobileController.text = data['mobileNumber'] ?? '';
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(data == null ? 'Employee Form' : 'Edit Employee'),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  commonTextFiled(
                    controller: nameController,
                    keyboardType: TextInputType.name,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
                    ],
                    textFiledText: 'Name',
                    hintText: 'Enter Name',
                    prefixIcon: Icons.person,
                    validator: (String? value) {
                      String? checkValidation = value == null || value.isEmpty
                          ? 'Please Enter Your Name'
                          : value.length < 2
                              ? 'Please Enter a Valid Name'
                              : null;
                      return checkValidation;
                    },
                  ),
                  heightSizeBox(20),
                  const Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: Text(
                      'Gender',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                    ),
                  ),
                  heightSizeBox(5),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            male = true;
                            female = false;
                            checkGender = true;
                            genderController.text = 'male';
                            setState(() {});
                          },
                          child: Container(
                            height: 60,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: genderController.text == '' &&
                                        checkGender &&
                                        male == false &&
                                        female == false
                                    ? Colors.red
                                    : genderController.text != '' &&
                                            checkGender &&
                                            male
                                        ? Colors.deepPurple
                                        : Colors.grey.shade700,
                                width: (genderController.text == '' &&
                                            checkGender &&
                                            male == false &&
                                            female == false) ||
                                        (genderController.text != '' &&
                                            checkGender &&
                                            male)
                                    ? 2
                                    : 1,
                              ),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.face,
                                    size: 27,
                                    color: Colors.grey,
                                  ),
                                  widthSizeBox(16),
                                  Text(
                                    'Male',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.grey.shade500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      widthSizeBox(8),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            male = false;
                            female = true;
                            checkGender = true;
                            genderController.text = 'female';
                            setState(() {});
                          },
                          child: Container(
                            height: 60,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: genderController.text == '' &&
                                        checkGender &&
                                        male == false &&
                                        female == false
                                    ? Colors.red
                                    : genderController.text != '' &&
                                            checkGender &&
                                            female
                                        ? Colors.deepPurple
                                        : Colors.grey.shade700,
                                width: (genderController.text == '' &&
                                            checkGender &&
                                            male == false &&
                                            female == false) ||
                                        (genderController.text != '' &&
                                            checkGender &&
                                            female)
                                    ? 2
                                    : 1,
                              ),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.face_2,
                                    size: 25,
                                    color: Colors.grey,
                                  ),
                                  widthSizeBox(20),
                                  Text(
                                    'Female',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.grey.shade500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  genderController.text == '' &&
                          checkGender &&
                          male == false &&
                          female == false
                      ? const Padding(
                          padding: EdgeInsets.only(left: 10, top: 8),
                          child: Text(
                            'Please Select a Gender',
                            style: TextStyle(fontSize: 13, color: Colors.red),
                          ),
                        )
                      : const SizedBox(),
                  heightSizeBox(20),
                  commonTextFiled(
                    controller: joiningDateController,
                    textFiledText: 'Joining Date',
                    hintText: 'Choose Date',
                    prefixIcon: Icons.date_range,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Choose a Joining Date';
                      } else {
                        return null;
                      }
                    },
                    readOnly: true,
                    onTap: () {
                      showDatePickerFunction();
                    },
                  ),
                  heightSizeBox(20),
                  commonTextFiled(
                    controller: mobileController,
                    textFiledText: 'Mobile Number',
                    hintText: 'Enter Number',
                    prefixIcon: Icons.mobile_friendly,
                    // validator: (String? value) {
                    //   if (value == null || value.isEmpty) {
                    //     return "Please Enter Your Number";
                    //   } else if (value.length < 10) {
                    //     return "Please Enter a Valid Mobile Number";
                    //   } else {
                    //     return null;
                    //   }
                    // },
                    keyboardType: TextInputType.phone,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),
                  heightSizeBox(30),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        submitButton();
                      },
                      child: Text(data == null ? 'Submit' : 'Save'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
