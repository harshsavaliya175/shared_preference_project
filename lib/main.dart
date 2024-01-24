import 'package:flutter/material.dart';
import 'package:shared_preference_project/screens/employee_form.dart';
import 'package:shared_preference_project/screens/employees_register.dart';
import 'package:shared_preference_project/services/shared_preference_service.dart';
import 'package:shared_preference_project/utils/routes_constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferenceService.inIt();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: false,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: RoutesConstants.employeeRegister,
      routes: {
        RoutesConstants.employeeRegister: (context) {
          return const EmployeesRegisterScreen();
        },
        RoutesConstants.employeeForm: (context) {
          return const EmployeeFormScreen();
        }
      },
    );
  }
}
