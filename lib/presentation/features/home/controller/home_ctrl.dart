import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do/data/sqldb.dart';

class HomeController extends GetxController {
  SqlDb sqlDb = SqlDb();
  RxBool isButtonPressed = false.obs;
  RxString taskTitle = "".obs;
  RxString taskDescription = "".obs;
  var taskDate = "".obs;
  var taskTime = "".obs;
  var recordCount = 0.obs;
  var searchQuery = ''.obs;
  var filteredTasks = <Map<dynamic, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    filterTasks();
  }

  void insertNewTask(BuildContext context) async {
    int response = await sqlDb.insertData(
        ''' INSERT INTO Tasks (taskTitle, taskDescription, taskDate, taskTime, taskCategory, taskPrivacy)
       VALUES ('$taskTitle', '$taskDescription', '$taskDate', '$taskTime', 'Home', 0) ''');

    final scaffoldMessenger = ScaffoldMessenger.of(context);

    if (response > 0) {
      scaffoldMessenger.showSnackBar(
        const SnackBar(
          content: Text('Task added successfully.'),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      scaffoldMessenger.showSnackBar(
        const SnackBar(
          content: Text('Task insertion failed.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  Future<List<Map>> readAllTasks() async {
    List<Map<dynamic, dynamic>> response =
        await sqlDb.readData("SELECT * FROM 'Tasks'");
    return response;
  }

  Future<int> readTotalTableRecords() async {
    List<Map<dynamic, dynamic>> response =
        await sqlDb.readData("SELECT COUNT(*) as count FROM 'Tasks'");

    if (response.isNotEmpty) {
      int count = response[0]['count'];
      recordCount.value = count;
      return count;
    } else {
      return 0;
    }
  }

  bool isToday(String taskDate) {
    DateTime now = DateTime.now();
    String formattedDate =
        "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";
    return taskDate == formattedDate;
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query;
    filterTasks();
  }

  void filterTasks() async {
    final List<Map<dynamic, dynamic>> allTasks =
        await Get.find<HomeController>().readAllTasks();

    final query = searchQuery.value.toLowerCase();
    filteredTasks.value = query.isEmpty
        ? allTasks
        : allTasks.where((task) {
            final taskTitle = task['taskTitle'].toString().toLowerCase();
            return taskTitle.contains(query);
          }).toList();
  }
}
