
import 'dart:developer';

import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart';

import '../../model/getSyncData.dart';
import '../../model/onBoardDealerModel.dart';
import '../../model/userModel.dart';

class DatabaseHelper {
  static const String dbName = 'moltyForm.db';
  static const String login = 'login';
  static const String user = 'user';
  static const String authToken = 'authToken';

  static const String currentPage = 'currentPage';
  static const String firstLogin = 'firstLogin';

  static const String requestForm = 'requestForm';
  static const String dFQRequestForm= 'dFQRequestForm';
  static const String submitFormInfo = 'submitFormInfo';
  static const String submitFormInfoDFQ = 'submitFormInfoDFQ';
  static const String kpiFormSaveID = 'kpiFormSaveID';
  static const String oSFormSaveID = 'oSFormSaveID';
  static const String cWMFormSaveID = 'cWMFormSaveID';
  // static const String dFQFormSaveID = 'dFQFormSaveID';
  static const String sendFilePath = 'sendFilePath';
  static const String oSFormFile = 'oSFormFile';
  static const String kpiFormFile = 'kpiFormFile';
  static const String cWMFormFile = 'CWMFormFile';
  static const String dFQFormFile = 'dFQFormFile';
  static const String onBoardDM = 'onBoardDM';

  static const String runTimes = 'RunTimes';
  static const String bgService = 'bgService';

  static const String kpiQuestionsForm = 'kpi_questions_form';
  static const String outdoorShopFascia = 'outdoor_Shop_fascia';
  static const String categoryWiseModelFormAssign = 'category_wise_model_form_assign';
  static const String dealerFeedbackQuestionForms = 'dealer_feedback_question_form';
  static const String onBoardDealerManagement = 'on_board_dealer_management';
  static const String kpiQuestions = 'kpi_questions';

  /// sync data table
  static const String cities = 'cities';
  static const String dealerType = 'DealerType';
  static const String answerType = 'AnswerType';
  static const String attachmentType = 'AttachmentType';
  static const String kPIFormAttachmentType = 'kPIFormAttachmentType';
  static const String feedbackType = 'FeedbackType';
  static const String kPIForm = 'KPIForm';
  static const String kPIFormAnswerType = 'KPIFormAnswerType';
  static const String kPIFormQuestions = 'KPIFormQuestions';
  static const String questionType = 'QuestionType';
  static const String zones = 'zones';
  static const String dealers = 'Dealers';
  static const String categories = 'categories';
  static const String oSForm = 'oSForm';
  static const String oSFormBoardDescription = 'oSFormBoardDescription';
  static const String oSFormBoardImages = 'oSFormBoardImages';
  static const String categoryWiseModelFormFormImages = 'categoryWiseModelFormFormImages';
  static const String oSFormAnswerType = 'OSFormAnswerType';
  static const String oSFormAttachmentType = 'OSFormAttachmentType';

  static const String categoryWiseModelForm = 'categoryWiseModelForm';
  static const String categoryWiseModelFormModels = 'CategoryWiseModelFormModels';
  static const String categoryWiseModelFormAttachmentType = 'categoryWiseModelFormAttachmentType';
  static const String categoryWiseModelFormAnswerType = 'CategoryWiseModelFormAnswerType';

  static const String dealerFeedbackFormAttachmentTypes = 'DealerFeedbackFormAttachmentTypes';
  static const String dealerFeedbackFormQuestions = 'DealerFeedbackFormQuestions';
  static const String dealerFeedbackForm = 'DealerFeedbackForm';
  static const String dealerFeedbackFormAsnwerTypes = 'dealerFeedbackFormAsnwerTypes';

  static const int dbVersion = 8;
  static Database? database;

  static DatabaseHelper get instance => _databaseHelper;

  DatabaseHelper._internal();

  static final DatabaseHelper _databaseHelper = DatabaseHelper._internal();
  static init() async {
    if (database != null) return database;

    database = await initDatabase();
    return database;
  }

  static initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, dbName);
    return await openDatabase(path, version: dbVersion, onCreate: _createDb, onUpgrade: _upgradeDb);
  }

  static void _createDb(Database db, int version) async {
    db.execute('''
          CREATE TABLE $bgService (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            bgService INTEGER
          )
        ''');

    db.execute('''
          CREATE TABLE $runTimes (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            runTime TEXT
          )
        ''');
    db.execute('''
          CREATE TABLE $firstLogin (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            isSync INTEGER
          )
        ''');
    await db.execute('''
      CREATE TABLE $requestForm (
        id INTEGER PRIMARY KEY,
        isSync INTEGER,
        KPIForms Text,
        OSForms Text,
        CWMForms Text
        )
    ''');

    // DFQForms Text
    await db.execute('''
      CREATE TABLE $dFQRequestForm (
        id INTEGER PRIMARY KEY,
        isSync INTEGER,
        DFQForms Text
        )
    ''');

    await db.execute('''
      CREATE TABLE $submitFormInfo (
        id INTEGER PRIMARY KEY,
        isSync INTEGER,
        requestFormId INTEGER,
        dealerId INTEGER,
        dealerTypeId INTEGER,
        dateTime Text,
        type Text
        )
    ''');

    await db.execute('''
      CREATE TABLE $submitFormInfoDFQ (
        id INTEGER PRIMARY KEY,
        isSync INTEGER,
        requestFormId INTEGER,
        dealerId INTEGER,
        dealerTypeId INTEGER,
        dateTime Text,
        type Text
        )
    ''');


    await db.execute('''
      CREATE TABLE $categoryWiseModelFormFormImages (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        category_type INTEGER,
        filepath TEXT,
        path Text,
        isSync INTEGER,
        createdate TEXT,
        createby INTEGER,
        updatedate TEXT,
        updateby INTEGER
      )
    ''');
    await db.execute('''
      CREATE TABLE $onBoardDM (
        name TEXT,
        mobileNumber TEXT,
        email TEXT,
        city TEXT,
        cnic TEXT PRIMARY KEY,
        address TEXT,
        area TEXT,
        education TEXT,
        profession TEXT,
        previousExperience TEXT,
        investmentAmount TEXT,
        dealerType TEXT,
        categoryType TEXT,
        userId TEXT,
        imageFile TEXT,
        isSync INTEGER
      )
    ''');
    await db.execute('''
      CREATE TABLE $kpiFormFile (
        id INTEGER PRIMARY KEY,
        requestId INTEGER,
        isSync INTEGER,
        kpiFormFile TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE $oSFormFile (
        id INTEGER PRIMARY KEY,
        requestId INTEGER,
        isSync INTEGER,
        oSFormFile TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE $cWMFormFile (
        id INTEGER PRIMARY KEY,
        requestId INTEGER,
        isSync INTEGER,
        cWMFormFile TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE $dFQFormFile (
        id INTEGER PRIMARY KEY,
        requestId INTEGER,
        isSync INTEGER,
        dFQFormFile TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE $kpiFormSaveID (
        id INTEGER PRIMARY KEY,
        dealerTypeID INTEGER,
        dealerID INTEGER,
        kpiFileID INTEGER,
        requestFormID INTEGER
      )
    ''');

    await db.execute('''
      CREATE TABLE $oSFormSaveID (
        id INTEGER PRIMARY KEY,
        dealerTypeID INTEGER,
        dealerID INTEGER,
        kpiFileID INTEGER,
        categoriesType INTEGER,
        oSFileID INTEGER,
        requestFormID INTEGER
      )
    ''');

    await db.execute('''
      CREATE TABLE $cWMFormSaveID (
        id INTEGER PRIMARY KEY,
        dealerTypeID INTEGER,
        dealerID INTEGER,
        cWMFileID INTEGER,
        oSFileID INTEGER,
        kpiFileID INTEGER,
        requestFormID INTEGER
      )
    ''');



    await db.execute('''
      CREATE TABLE $user (
        id INTEGER PRIMARY KEY,
        userid INTEGER,
        firstname TEXT,
        lastname TEXT,
        username TEXT,
        email TEXT,
        designationid INTEGER,
        departmentid INTEGER,
        grade TEXT,
        password TEXT,
        isactive INTEGER,
        zoneid INTEGER,
        createdate TEXT,
        updatedate TEXT,
        updateby INTEGER,
        passwordcreatedate TEXT,
        default_menuid INTEGER,
        Sessionid TEXT,
        IsLogin INTEGER,
        SessionDateTime TEXT,
        RoleId INTEGER,
        DefaultFormName TEXT,
        FormDisplayName TEXT,
        RoleName TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE $login (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT,
        password TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE $authToken (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        access_token TEXT,
        token_type TEXT,
        expires_in TEXT,
        start_date_time TEXT,
        end_date_time TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE $currentPage (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        currentPage TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE $kpiQuestionsForm (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        formObj TEXT,
        sync TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE $outdoorShopFascia (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        formObj TEXT,
        sync TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE $categoryWiseModelFormAssign (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        formObj TEXT,
        sync TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE $dealerFeedbackQuestionForms (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        formObj TEXT,
        sync TEXT
      )
    ''');
    await db.execute('''
      CREATE TABLE $onBoardDealerManagement (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        formObj TEXT,
        sync TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE $cities (
        ids INTEGER PRIMARY KEY AUTOINCREMENT,
        id INTEGER,
        city TEXT,
        createdate TEXT,
        updatedate TEXT,
        updateby INTEGER
      )
    ''');
    await db.execute('''
      CREATE TABLE $dealerType (
        ids INTEGER PRIMARY KEY AUTOINCREMENT,
        id INTEGER,
        dealer_type TEXT,
        createdate TEXT,
        updatedate TEXT,
        updateby INTEGER
      )
    ''');

    await db.execute('''
      CREATE TABLE $answerType (
        ids INTEGER PRIMARY KEY AUTOINCREMENT,
        id INTEGER,
        answers_type TEXT,
        createdate TEXT,
        updatedate TEXT,
        updateby INTEGER
      )
    ''');
    await db.execute('''
      CREATE TABLE $attachmentType (
        ids INTEGER PRIMARY KEY AUTOINCREMENT,
        id INTEGER,
        attachment_type TEXT,
        createdate TEXT,
        updatedate TEXT,
        updateby INTEGER
      )
    ''');
    await db.execute('''
      CREATE TABLE $feedbackType (
        ids INTEGER PRIMARY KEY AUTOINCREMENT,
        id INTEGER,
        feedback_type TEXT,
        createdate TEXT,
        updatedate TEXT,
        updateby INTEGER
      )
    ''');

    await db.execute('''
      CREATE TABLE $kPIForm (
        ids INTEGER PRIMARY KEY AUTOINCREMENT,
        id INTEGER,
        dealer_type INTEGER,
        question_type INTEGER,
        createdate TEXT,
        createby INTEGER,
        updatedate TEXT,
        updateby INTEGER
      )
    ''');

    await db.execute('''
      CREATE TABLE $kPIFormAnswerType (
        ids INTEGER PRIMARY KEY AUTOINCREMENT,
        kpiquestionsformid INTEGER,
        answer_type INTEGER,
        createdate TEXT,
        createby INTEGER,
        updatedate TEXT,
        updateby INTEGER,
        questionid INTEGER,
        correct_answer INTEGER
      )
    ''');

    await db.execute('''
      CREATE TABLE $kPIFormQuestions (
        ids INTEGER PRIMARY KEY AUTOINCREMENT,
        kpiquestionsform_id INTEGER,
        question TEXT,
        createdate TEXT,
        createby INTEGER,
        updatedate TEXT,
        updateby INTEGER,
        id INTEGER,
        remarks INTEGER,
        guideline TEXT,
        isactive INTEGER
      )
    ''');

    await db.execute('''
      CREATE TABLE $questionType (
        ids INTEGER PRIMARY KEY AUTOINCREMENT,
        id INTEGER,
        question_type TEXT,
        createdate TEXT,
        updatedate INTEGER,
        updateby INTEGER
      )
    ''');
    await db.execute('''
      CREATE TABLE $kPIFormAttachmentType (
        ids INTEGER PRIMARY KEY AUTOINCREMENT,
        kpiquestionsformid INTEGER,
        attachment_type INTEGER,
        createdate TEXT,    
        createby INTEGER,    
        updatedate TEXT,    
        updateby INTEGER,    
        questionid INTEGER   
      )
    ''');
    await db.execute('''
      CREATE TABLE $zones (
        ids INTEGER PRIMARY KEY AUTOINCREMENT,
        id INTEGER,
        zone TEXT,
        createdate TEXT,
        updatedate INTEGER,
        updateby INTEGER,
        isactive INTEGER
      )
    ''');
    await db.execute('''
      CREATE TABLE $dealers (
    ids INTEGER PRIMARY KEY AUTOINCREMENT,
    id INTEGER,
    username TEXT,
    dealer_type INTEGER,
    Dealership_name TEXT,
    owner_name TEXT,
    brand TEXT,
    dealer_contactno TEXT,
    email TEXT,
    education TEXT,
    profession TEXT,
    previousexperience TEXT,
    investment_amount Text,
    area TEXT,
    cityid INTEGER,
    main_group TEXT,
    address TEXT,
    createdate TEXT,
    createby INTEGER,
    updatedate TEXT,
    updateby INTEGER,
    cnic TEXT,
    category_type INTEGER,
    IsValidated TEXT,
    IsApproved TEXT,
    Verfication TEXT,
    Schedule_visitdate_to TEXT,
    Schedule_visitdate_from TEXT,
    reason TEXT,
    crc_name TEXT,
    crc_contact TEXT,
    cancellation_reason TEXT,
    additional_info TEXT,
    justification TEXT,
    validation_date TEXT,
    approval_date TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE $categories (
        ids INTEGER PRIMARY KEY AUTOINCREMENT,
        id INTEGER,
        category_type TEXT,
        createdate TEXT,
        updatedate INTEGER,
        updateby INTEGER
      )
    ''');

    await db.execute('''
      CREATE TABLE $oSForm (
        ids INTEGER PRIMARY KEY AUTOINCREMENT,
        id INTEGER,
        dealer_type INTEGER,
        category_type INTEGER,
        createdate Text,
        createby INTEGER,
        updatedate Text,
        updateby INTEGER
      )
    ''');
    await db.execute('''
      CREATE TABLE $oSFormBoardDescription (
        ids INTEGER PRIMARY KEY AUTOINCREMENT,
        id INTEGER,
        osform_id INTEGER,
        category_type INTEGER,
        boarddescription Text,
        createdate Text,
        createby INTEGER,
        updatedate Text,
        updateby INTEGER,
        remarks INTEGER,
        guideline Text,
        isactive INTEGER
      )
    ''');
    await db.execute('''
      CREATE TABLE $oSFormBoardImages (
        ids INTEGER PRIMARY KEY AUTOINCREMENT,
        id INTEGER,
        isSync INTEGER,
        formid INTEGER,
        boardid INTEGER,
        filepath Text,
        path Text,
        createby INTEGER,
        createdate Text
      )
    ''');

    await db.execute('''
      CREATE TABLE $oSFormAnswerType (
        ids INTEGER PRIMARY KEY AUTOINCREMENT,
        os_fiascaformid INTEGER,
        answer_type INTEGER,
        createdate Text,
        createby INTEGER,
        updatedate Text,
        updateby INTEGER,
        boardid INTEGER,
        correct_answer INTEGER
      )
    ''');
    await db.execute('''
      CREATE TABLE $categoryWiseModelForm (
        ids INTEGER PRIMARY KEY AUTOINCREMENT,
        id INTEGER,
        category_type INTEGER,
        createdate Text,
        createby INTEGER,
        updatedate Text,
        updateby INTEGER
      )
    ''');

    await db.execute('''
      CREATE TABLE $oSFormAttachmentType (
        ids INTEGER PRIMARY KEY AUTOINCREMENT,
        os_fiascaformid INTEGER,
        attachment_type INTEGER,
        createdate Text,
        createby INTEGER,
        updatedate Text,
        updateby INTEGER,
        boardid INTEGER
      )
    ''');

    await db.execute('''
      CREATE TABLE $categoryWiseModelFormAttachmentType (
        ids INTEGER PRIMARY KEY AUTOINCREMENT,
        cwmform_id INTEGER,
        attachment_type INTEGER,
        createdate Text,
        createby INTEGER,
        updatedate Text,
        updateby INTEGER,
        modelid INTEGER
      )
    ''');
    await db.execute('''
      CREATE TABLE $categoryWiseModelFormAnswerType (
        ids INTEGER PRIMARY KEY AUTOINCREMENT,
        cwmform_id INTEGER,
        answer_type INTEGER,
        createdate Text,
        createby INTEGER,
        updatedate Text,
        updateby INTEGER,
        modelid INTEGER,
        correct_answer Text
      )
    ''');

    await db.execute('''
      CREATE TABLE $dealerFeedbackFormAttachmentTypes (
        ids INTEGER PRIMARY KEY AUTOINCREMENT,
        dfqform_id INTEGER,
        attachment_type INTEGER,
        createdate Text,
        createby INTEGER,
        updatedate Text,
        updateby INTEGER,
        questionid INTEGER
      )
    ''');

    await db.execute('''
      CREATE TABLE $dealerFeedbackFormQuestions (
        ids INTEGER PRIMARY KEY AUTOINCREMENT,
        dfqform_id INTEGER,
        question Text,
        remarks INTEGER,
        guideline Text,
        isactive INTEGER,
        createby INTEGER,
        creatdate Text,
        updateby INTEGER,
        updatedate Text,
        id INTEGER
      )
    ''');
    await db.execute('''
      CREATE TABLE $dealerFeedbackForm (
        ids INTEGER PRIMARY KEY AUTOINCREMENT,
        id INTEGER,
        createdate Text,
        createby INTEGER,
        updatedate Text,
        updateby INTEGER
      )
    ''');

    await db.execute('''
      CREATE TABLE $dealerFeedbackFormAsnwerTypes (
        ids INTEGER PRIMARY KEY AUTOINCREMENT,
        dfqform_id INTEGER,
        answer_type INTEGER,
        createdate Text,
        createby INTEGER,
        updatedate Text,
        updateby INTEGER,
        questionid INTEGER,
        correct_answer Text
      )
    ''');
    await db.execute('''
      CREATE TABLE $categoryWiseModelFormModels (
        ids INTEGER PRIMARY KEY AUTOINCREMENT,
        id INTEGER,
        cwmform_id INTEGER,
        category_type INTEGER,
        company_standard Text,
        standard Text,
        remarks INTEGER,
        isactive INTEGER,
        guideline Text,
        createdate Text,
        createby INTEGER,
        updatedate Text,
        updateby INTEGER
      )
    ''');
    await db.execute('''
    CREATE TABLE IF NOT EXISTS $sendFilePath (
      id INTEGER PRIMARY KEY,
      ids INTEGER,
      path TEXT
    )
  ''');
  }


  static Future<void> _upgradeDb(Database db, int oldVersion, int newVersion) async {
    // Drop all existing tables
    await _dropAllTables(db);

    // Recreate all tables
     _createDb(db, newVersion);
  }
  static  Future<int> updateFORMFileSTATUS({required int requestId, var updatedValues, required String tableName,required String columName}) async {
    final db = await init();
    var value={
      columName:updatedValues
    };
    return await db.update(
      tableName, // Table name
      value, // Map of column names and their new values
      where: 'requestId = ?', // WHERE clause to match requestId
      whereArgs: [requestId], // Arguments for the WHERE clause
    );
  }

  static Future<void> insertUser(UserModel data) async {
    // await clearTable(user);
    final db = database;

    await db!.insert(user, data.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
  }


  static Future<void> _dropAllTables(Database db) async {
    // Query to get all table names
    final List<Map<String, dynamic>> tables = await db.rawQuery(
        "SELECT name FROM sqlite_master WHERE type='table' AND name NOT LIKE 'sqlite_%';"
    );

    // Drop each table
    for (var table in tables) {
      String tableName = table['name'];
      await db.execute('DROP TABLE IF EXISTS $tableName');
    }
  }
  static Future<void> clearDatabase() async {
    final db = await database;
    // Get all tables
    var tables = await db?.rawQuery('SELECT name FROM sqlite_master WHERE type = "table"');

    // Delete all data from each table
    for (var table in tables!) {
      var tableName = table['name'];
      if (tableName != null && tableName != 'sqlite_sequence') {
        await db?.execute('DELETE FROM $tableName');
      }
    }
  }

  // Future<void> refreshDatabase() async {
  //   final db = await database;
  //   // Get all tables
  //   var tables = await db?.rawQuery('SELECT name FROM sqlite_master WHERE type = "table"');
  //
  //   // Drop all tables
  //   for (var table in tables!) {
  //     var tableName = table['name'];
  //     if (tableName != null && tableName != 'sqlite_sequence') {
  //       await db?.execute('DROP TABLE IF EXISTS $tableName');
  //     }
  //   }
  //
  //   // Recreate tables
  //
  // }
  static Future<List<Map<String, dynamic>>> getDataById(String name, int id) async {
    // Initialize the database
    final db = await init();

    // Query to get the data by id
    List<Map<String, dynamic>> result = await db.query(
      name, // The table name
      where: 'id = ?', // The WHERE clause to filter by id
      whereArgs: [id], // Arguments for the WHERE clause
    );

    // Return the result, whether it contains data or is empty
    return result;
  }

  static Future<void> insertRunTime(String runTime) async {
    await clearTable(runTimes);
    final db = await init();
    await db.insert(runTimes, {'runTime': runTime});
  }
  static Future<void> insertBgService(int value) async {
    await clearTable(bgService);
    final db = await init();
    await db.insert(bgService, {'bgService': value});
  }
  static Future<int?> getBgService() async {
    final db = await init();
    final List<Map<String, dynamic>> maps = await db.query(
      bgService,
    );
    if (maps.isNotEmpty) {
      return maps.first['bgService'] as int;
    }
    return null;
  }
  static Future<String?> getLastRunTime() async {
    final db = await init();
    final List<Map<String, dynamic>> maps = await db.query(
      runTimes,
    );
    if (maps.isNotEmpty) {
      return maps.first['runTime'] as String;
    }
    return null;
  }

  // static Future<void> insertUser(UserModel data) async {
  //   await clearTable(user);
  //   final db = database;
  //
  //   await db!.insert(user, data.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
  // }

  // static Future<void> insertOnBoardDM(OnBoardDealerManagement data) async {
  //   final db = database;
  //
  //   await db!.insert(onBoardDM, data.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
  // }

  static Future<int> insertOnBoardDM(OnBoardDealerManagement data) async {
    final db = database;

    // Replace this with your table name
    // const String onBoardDM = 'your_table_name';

    // Convert the data to a Map
    final Map<String, dynamic> jsonData = data.toJson();

    try {
      // Insert the data into the database
      await db!.insert(
        onBoardDM,
        jsonData,
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );

      // Return 1 to indicate successful insertion
      return 1;
    } on DatabaseException catch (_) {
      // Return 0 if the record already exists
      return 0;
    }
  }

  static Future<void> insertCurrentPage(String currentPag) async {

    final db = database;
    await clearTable(currentPage);
    Map<String, dynamic> values = {
      'currentPage': currentPag,
    };
    await db!.insert(currentPage, values, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<void> insertFirstLogin() async {
    final db = database;
    Map<String, dynamic> values = {
      'isSync': 1,
    };
    await db!.insert(firstLogin, values, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> getFirstLogin() async {
    final db = await DatabaseHelper.init();
    return db.query(
      firstLogin,
    );
  }

  static Future<List<Map<String, dynamic>>> getCurrentPage() async {
    final db = await DatabaseHelper.init();
    return db.query(
      currentPage,
    );
  }

  static Future<void> insertUserAuthToken(AuthToken data) async {
    await clearTable(authToken);
    final db = database;
    await db!.insert(authToken, data.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
  }


  static Future<void> clearTable(String name) async {
    final db = await DatabaseHelper.init();
    int? count = Sqflite.firstIntValue(await db!.rawQuery('SELECT COUNT(*) FROM $name'));
    if (count! > 0) {
      await db.delete(name);
    }
  }

  static Future<List<Map<String, dynamic>>> getUsers() async {
    final db = await DatabaseHelper.init();
    return await db!.query(user);
  }

  // static Future<List<Map<String, dynamic>>> getFormFiles({required String tableName}) async {
  //   final db = await DatabaseHelper.init();
  //   int isSync=0;    return await db.query(
  //     tableName,
  //     where: 'isSync = ?',
  //     whereArgs: [isSync],
  //   );
  //   // return await db!.query(tableName);
  // }
  static Future<List<Map<String, dynamic>>> getFormFiles({required String tableName}) async {
    final db = await DatabaseHelper.init();
    int isSync = 0;
    return await db.query(
      tableName,
      where: 'isSync = ?',
      whereArgs: [isSync],
    );
  }

  static formFilesUpdateStatus({required int id, required String tableName,int? isSync}) async {
    final Database db = await initDatabase();
    Map<String, dynamic> values = {
      "isSync": isSync,
    };
    return await db.update(
      tableName,
      values,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // static updateFormFilePath({required int id, required String path,required String tableName,required int isSync}) async {
  //   final Database db = await initDatabase();
  //   Map<String, dynamic> values = {
  //     path: path,
  //   };
  //   return await db.update(
  //     tableName,
  //     values,
  //     where: 'isSync = ? AND id = ?', whereArgs: [isSync, id]
  //
  //   );
  // }
  static Future<int> updateFormFilePath({
    required int id,
    required String path,
    required String tableName,
    required int isSync,
  }) async {
    try {

      final Database db = await initDatabase();
      Map<String, dynamic> values = {
        'path': path.toString(),
        'isSync':isSync
      };
      return await db.update(
        tableName,
        values,
        where: 'isSync = ? AND id = ?',
        whereArgs: [0, id],
      );
    } catch (e) {
      // Handle exceptions here
      print("Error updating file path: $e");
      return -1; // Return a negative value to indicate failure
    }
  }
  static Future<int> osUpdateFormFilePath({
    required String filepath,
    required String path,
    // required int newIsSync,
  }) async {
    try {
      final Database db = await initDatabase();
      Map<String, dynamic> values = {
        'path': path,
        'isSync': 1,
      };
      return await db.update(
        "oSFormBoardImages",
        values,
        where: 'filepath = ?',
        whereArgs: [filepath],
      );
    } catch (e) {
      // Handle exceptions here
      print("Error updating file path: $e");
      return -1; // Return a negative value to indicate failure
    }
  }
  // static Future<int> osUpdateFormFilePath({
  //   required filepath,
  //   required int id,
  //   required String path,
  //   required int isSync,
  // }) async {
  //   try {
  //
  //     final Database db = await initDatabase();
  //     Map<String, dynamic> values = {
  //       'path': path.toString(),
  //       'isSync':isSync
  //     };
  //     return await db.update(
  //       "oSFormBoardImages",
  //       values,
  //       where: 'isSync = ? AND id = ?',
  //       whereArgs: [1, id],
  //     );
  //   } catch (e) {
  //     // Handle exceptions here
  //     print("Error updating file path: $e");
  //     return -1; // Return a negative value to indicate failure
  //   }
  // }

  static Future<int> updateOnBoardDM(String cnic) async {
    try {
      final Database db = await initDatabase();
      Map<String, dynamic> values = {
        'isSync': 1,
      };
      return await db.update(
        onBoardDM,
        values,
        where: 'cnic = ?',
        whereArgs: [cnic],
      );
    } catch (e) {
      // Handle exceptions here
      print("Error updating file path: $e");
      return -1; // Return a negative value to indicate failure
    }
  }

  // isSync INTEGER,
  //     formid INTEGER,
  // boardid INTEGER,
  //     filepath Text,
  // path Text,

  // Future<int> insertUser(Map<String, dynamic> user) async {
  //   Database? db = database;
  //   return await db!.insert(login, user);
  // }
  ///
  static Future<void> insertCity(List<Cities> city) async {
    await clearTable(cities); // Assuming clearTable exists and clears the 'cities' table
    final db = await DatabaseHelper.init(); // Assuming database is an asynchronous operation
    for (var element in city) {
      final row = element.toJson();
      await db!.insert(cities, row);
    }
  }

  static Future<void> insertDealerFeedbackFormQuestions(List<DealerFeedbackFormQuestions> dealerFeedbackFormQuestion) async {
    await clearTable(dealerFeedbackFormQuestions); // Assuming clearTable exists and clears the 'cities' table
    final db = await DatabaseHelper.init(); // Assuming database is an asynchronous operation
    for (var element in dealerFeedbackFormQuestion) {
      final row = element.toJson();
      await db!.insert(dealerFeedbackFormQuestions, row);
    }
  }

  static Future<void> insertDealerFeedbackForm(List<DealerFeedbackForm> dealerFeedbackForms) async {
    await clearTable(dealerFeedbackForm); // Assuming clearTable exists and clears the 'cities' table
    final db = await DatabaseHelper.init(); // Assuming database is an asynchronous operation
    for (var element in dealerFeedbackForms) {
      final row = element.toJson();
      await db!.insert(dealerFeedbackForm, row);
    }
  }

  static Future<void> insertDealerFeedbackFormAsnwerTypes(List<DealerFeedbackFormAsnwerTypes> dealerFeedbackFormAsnwerType) async {
    await clearTable(dealerFeedbackFormAsnwerTypes); // Assuming clearTable exists and clears the 'cities' table
    final db = await DatabaseHelper.init(); // Assuming database is an asynchronous operation
    for (var element in dealerFeedbackFormAsnwerType) {
      final row = element.toJson();
      await db!.insert(dealerFeedbackFormAsnwerTypes, row);
    }
  }

  static Future<void> insertDealerFeedbackFormAttachmentTypes(List<DealerFeedbackFormAttachmentTypes> dealerFeedbackFormAttachmentType) async {
    await clearTable(dealerFeedbackFormAttachmentTypes); // Assuming clearTable exists and clears the 'cities' table
    final db = await DatabaseHelper.init(); // Assuming database is an asynchronous operation
    for (var element in dealerFeedbackFormAttachmentType) {
      final row = element.toJson();
      await db!.insert(dealerFeedbackFormAttachmentTypes, row);
    }
  }

  /// dealer type insert data
  static Future<void> insertDealerType(List<DealerType> dealerTypes) async {
    await clearTable(dealerType); // Assuming clearTable exists and clears the 'cities' table
    final db = await DatabaseHelper.init(); // Assuming database is an asynchronous operation
    for (var element in dealerTypes) {
      final row = element.toJson();
      await db!.insert(dealerType, row);
    }
  }

  static Future<void> insertCategoryWiseModelFormAttachmentType(List<CategoryWiseModelFormAttachmentType> categoryWiseModelFormAttachmentTyp) async {
    await clearTable(categoryWiseModelFormAttachmentType); // Assuming clearTable exists and clears the 'cities' table
    final db = await DatabaseHelper.init(); // Assuming database is an asynchronous operation
    for (var element in categoryWiseModelFormAttachmentTyp) {
      final row = element.toJson();
      await db!.insert(categoryWiseModelFormAttachmentType, row);
    }
  }

  static Future<void> insertCategoryWiseModelFormAnswerType(List<CategoryWiseModelFormAnswerType> categoryWiseModelFormAnswerTyp) async {
    await clearTable(categoryWiseModelFormAnswerType); // Assuming clearTable exists and clears the 'cities' table
    final db = await DatabaseHelper.init(); // Assuming database is an asynchronous operation
    for (var element in categoryWiseModelFormAnswerTyp) {
      final row = element.toJson();
      await db!.insert(categoryWiseModelFormAnswerType, row);
    }
  }

  /// dealer type get data
  static Future<List<Map<String, dynamic>>> getDealerType() async {
    final db = await DatabaseHelper.init();
    return await db!.query(dealerType);
  }

  // static Future<List<Map<String, dynamic>>> getOnBoardDM() async {
  //   final db = await DatabaseHelper.init();
  //   return await db!.query(onBoardDM);
  // }
  static Future<List<Map<String, dynamic>>> getOnBoardDM() async {
    final db = await DatabaseHelper.init();
    return await db!.query(onBoardDM, where: 'isSync = ?', whereArgs: [0]);
  }

  /// dealer type get data
  static Future<List<Map<String, dynamic>>> getCity() async {
    final db = await DatabaseHelper.init();
    return await db!.query(cities);
  }

  /// categories type get data
  static Future<List<Map<String, dynamic>>> getCategories() async {
    final db = await DatabaseHelper.init();
    return await db!.query(categories);
  }

  static Future<List<Map<String, dynamic>>> getDealerFeedbackForm() async {
    final db = await DatabaseHelper.init();
    return await db!.query(dealerFeedbackForm);
  }

  /// getOSForm get data
  static Future<List<Map<String, dynamic>>> getOSForm({required int dealerTypeId, required int categoryType}) async {
    final db = await DatabaseHelper.init();
    return await db!.query(
      oSForm,
      where: 'dealer_type = ? AND category_type = ?',
      whereArgs: [dealerTypeId, categoryType],
    );
  }

  // static Future<List<Map<String, dynamic>>> getOSForm({ required int dealerTypeId, required categoryType}) async {
  //   final db = await DatabaseHelper.init();
  //   return await db!.query(oSForm, where: 'dealer_type = ? category_type = ? ', whereArgs: [dealerTypeId,categoryType]);
  // }

  static Future<List<Map<String, dynamic>>> getDealerFeedbackFormQuestions({int? dfqformId}) async {
    final db = await DatabaseHelper.init();
    return await db!.query(dealerFeedbackFormQuestions, where: 'dfqform_id = ?', whereArgs: [dfqformId]);
  }

  static Future<List<Map<String, dynamic>>> getDealerFeedbackFormAsnwerTypes({int? dfqformId}) async {
    final db = await DatabaseHelper.init();
    return await db!.query(dealerFeedbackFormAsnwerTypes, where: 'dfqform_id = ?', whereArgs: [dfqformId]);
  }

  static Future<List<Map<String, dynamic>>> getDealerFeedbackFormAttachmentTypes({int? dfqformId}) async {
    final db = await DatabaseHelper.init();
    return await db!.query(dealerFeedbackFormAttachmentTypes, where: 'dfqform_id = ?', whereArgs: [dfqformId]);
  }

  // static Future<List<Map<String, dynamic>>> getOSFormBoardDescription({required List<int> osformIds}) async {
  //   if (osformIds.isEmpty) {
  //     throw ArgumentError('osformIds list must be non-empty.');
  //   }
  //
  //   final db = await DatabaseHelper.init();
  //
  //   // Create a string with the same number of placeholders as the length of the list
  //   String placeholders = List.filled(osformIds.length, '?').join(',');
  //
  //   // Execute the query
  //   return await db!.query(
  //     oSFormBoardDescription,
  //     where: 'osform_id IN ($placeholders)',
  //     whereArgs: osformIds,
  //   );
  // }
  // static Future<List<Map<String, dynamic>>> getOSFormBoardDescription({required List<int> osformIds}) async {
  //   if (osformIds.isEmpty) {
  //     throw ArgumentError('osformIds list must be non-empty.');
  //   }
  //
  //   final db = await DatabaseHelper.init();
  //
  //   // Create a string with the same number of placeholders as the length of the list
  //   String placeholders = List.filled(osformIds.length, '?').join(',');
  //
  //   // Execute the query
  //   return await db!.query(
  //     oSFormBoardDescription,
  //     where: 'osform_id IN ($placeholders)',
  //     whereArgs: osformIds,
  //   );
  // }

  static Future<List<Map<String, dynamic>>> getOSFormBoardDescription({required int osformId, required int categoryType}) async {
    final db = await DatabaseHelper.init();
    return await db!.query(oSFormBoardDescription, where: 'osform_id = ? AND category_type = ?', whereArgs: [osformId, categoryType]);
  }

  // static Future<List<Map<String, dynamic>>> getOSFormAttachmentType({required int osformId}) async {
  //   final db = await DatabaseHelper.init();
  //   return await db!.query(oSFormAttachmentType, where: 'os_fiascaformid = ? ', whereArgs: [
  //     osformId,
  //   ]);
  // }
  static Future<List<Map<String, dynamic>>> getOSFormAttachmentType({required List<int> osformIds}) async {
    if (osformIds.isEmpty) {
      throw ArgumentError('osformIds list must be non-empty.');
    }

    final db = await DatabaseHelper.init();

    // Create a string with the same number of placeholders as the length of the list
    String placeholders = List.filled(osformIds.length, '?').join(',');

    // Execute the query
    return await db!.query(
      oSFormAttachmentType,
      where: 'os_fiascaformid IN ($placeholders)',
      whereArgs: osformIds,
    );
  }
  static Future<List<Map<String, dynamic>>> getOSFormAnswerType({required List<int> osformIds}) async {
    if (osformIds.isEmpty) {
      throw ArgumentError('osformIds list must be non-empty.');
    }

    final db = await DatabaseHelper.init();

    // Create a string with the same number of placeholders as the length of the list
    String placeholders = List.filled(osformIds.length, '?').join(',');

    // Execute the query
    return await db!.query(
      oSFormAnswerType,
      where: 'os_fiascaformid IN ($placeholders)',
      whereArgs: osformIds,
    );
  }

  // static Future<List<Map<String, dynamic>>> getOSFormAnswerType({required int osformId}) async {
  //   final db = await DatabaseHelper.init();
  //   return await db!.query(oSFormAnswerType, where: 'os_fiascaformid = ? ', whereArgs: [
  //     osformId,
  //   ]);
  // }

  // static Future<List<Map<String, dynamic>>> getOSFormBoardImages({required int osformId}) async {
  //   final db = await DatabaseHelper.init();
  //   return await db!.query(oSFormBoardImages, where: 'formid = ? ', whereArgs: [
  //     osformId,
  //   ]);
  // }
  static Future<List<Map<String, dynamic>>> getOSFormBoardImages({required List<int> osformIds}) async {
    if (osformIds.isEmpty) {
      throw ArgumentError('osformIds list must be non-empty.');
    }

    final db = await init();

    // Create a string with the same number of placeholders as the length of the list
    String placeholders = List.filled(osformIds.length, '?').join(',');

    // Execute the query
    return await db.query(
      oSFormBoardImages,
      where: 'formid IN ($placeholders)',
      whereArgs: osformIds,
    );
  }

  static Future<List<Map<String, dynamic>>> getCategoryWiseModelFormFormImages({required int osformId}) async {
    final db = await DatabaseHelper.init();
    return await db!.query(categoryWiseModelFormFormImages, where: 'category_type = ? ', whereArgs: [
      osformId,
    ]);
  }

  static Future<List<Map<String, dynamic>>> getCategoryWiseModelForm({required int catogryType}) async {
    final db = await DatabaseHelper.init();
    return await db!.query(categoryWiseModelForm, where: 'category_type = ? ', whereArgs: [catogryType]);
  }

  static Future<List<Map<String, dynamic>>> getCategoryWiseModelFormModels({required int catogryType, required int cwmformId}) async {
    final db = await DatabaseHelper.init();
    return await db!.query(categoryWiseModelFormModels, where: 'category_type = ? AND cwmform_id = ? ', whereArgs: [catogryType, cwmformId]);
  }

  static Future<List<Map<String, dynamic>>> getCategoryWiseModelFormAttachmentType({required int cwmformId}) async {
    final db = await DatabaseHelper.init();
    return await db!.query(categoryWiseModelFormAttachmentType, where: 'cwmform_id = ? ', whereArgs: [cwmformId]);
  }

  static Future<List<Map<String, dynamic>>> getCategoryWiseModelFormAnswerType({required int cwmformId}) async {
    final db = await DatabaseHelper.init();
    return await db!.query(categoryWiseModelFormAnswerType, where: 'cwmform_id = ? ', whereArgs: [cwmformId]);
  }

  static Future<void> insertAnswerType(List<AnswerType> answerTypes) async {
    await clearTable(answerType); // Assuming clearTable exists and clears the 'cities' table
    final db = await DatabaseHelper.init(); // Assuming database is an asynchronous operation
    for (var element in answerTypes) {
      final row = element.toJson();
      await db!.insert(answerType, row);
    }
  }

  static Future<void> insertCategoryWiseModelFormModels(List<CategoryWiseModelFormModels> categoryWiseModelFormModel) async {
    await clearTable(categoryWiseModelFormModels); // Assuming clearTable exists and clears the 'cities' table
    final db = await DatabaseHelper.init(); // Assuming database is an asynchronous operation
    for (var element in categoryWiseModelFormModel) {
      final row = element.toJson();
      await db!.insert(categoryWiseModelFormModels, row);
    }
  }

  static Future<void> insertCategoryWiseModelForm(List<CategoryWiseModelForm> categoryWiseModelForms) async {
    await clearTable(categoryWiseModelForm); // Assuming clearTable exists and clears the 'cities' table
    final db = await DatabaseHelper.init(); // Assuming database is an asynchronous operation
    for (var element in categoryWiseModelForms) {
      final row = element.toJson();
      await db!.insert(categoryWiseModelForm, row);
    }
  }

  static Future<void> insertAttachmentType(List<AttachmentType> attachmentTypes) async {
    await clearTable(attachmentType); // Assuming clearTable exists and clears the 'cities' table
    final db = await DatabaseHelper.init(); // Assuming database is an asynchronous operation
    for (var element in attachmentTypes) {
      final row = element.toJson();
      await db!.insert(attachmentType, row);
    }
  }

  static Future<void> insertFeedbackType(List<FeedbackType> feedbackTypes) async {
    await clearTable(feedbackType); // Assuming clearTable exists and clears the 'cities' table
    final db = await DatabaseHelper.init(); // Assuming database is an asynchronous operation
    for (var element in feedbackTypes) {
      final row = element.toJson();
      await db!.insert(feedbackType, row);
    }
  }

  static Future<void> insertKPIForm(List<KPIForm> kPIForms) async {
    await clearTable(kPIForm); // Assuming clearTable exists and clears the 'cities' table
    final db = await DatabaseHelper.init(); // Assuming database is an asynchronous operation
    for (var element in kPIForms) {
      final row = element.toJson();
      await db!.insert(kPIForm, row);
    }
  }

  static Future<void> insertKPIFormAnswerType(List<KPIFormAnswerType> kPIFormAnswerTypes) async {
    await clearTable(kPIFormAnswerType);
    final db = await DatabaseHelper.init();
    for (var element in kPIFormAnswerTypes) {
      final row = element.toJson();
      await db!.insert(kPIFormAnswerType, row);
    }
  }

  static Future<void> insertKPIFormQuestions(List<KPIFormQuestions> kPIFormQuestion) async {
    await clearTable(kPIFormQuestions);
    final db = await DatabaseHelper.init();
    for (var element in kPIFormQuestion) {
      final row = element.toJson();
      await db!.insert(kPIFormQuestions, row);
    }
  }

  static Future<void> insertQuestionType(List<QuestionType> questionTypes) async {
    await clearTable(questionType); // Assuming clearTable exists and clears the 'cities' table
    final db = await DatabaseHelper.init(); // Assuming database is an asynchronous operation
    for (var element in questionTypes) {
      final row = element.toJson();
      await db!.insert(questionType, row);
    }
  }

  static Future<void> insertZones(List<Zones> zone) async {
    await clearTable(zones);
    final db = await DatabaseHelper.init();
    for (var element in zone) {
      final row = element.toJson();
      await db!.insert(zones, row);
    }
  }

  static Future<void> insertKPIFormAttachmentType(List<KPIFormAttachmentType> kPIFormAttachmentTypes) async {
    await clearTable(kPIFormAttachmentType); // Assuming clearTable exists and clears the 'cities' table
    final db = await DatabaseHelper.init(); // Assuming database is an asynchronous operation
    for (var element in kPIFormAttachmentTypes) {
      final row = element.toJson();
      await db!.insert(kPIFormAttachmentType, row);
    }
  }

  /// os form
  static Future<void> insertOSForm(List<OSForm> oSForms) async {
    await clearTable(oSForm); // Assuming clearTable exists and clears the 'cities' table
    final db = await DatabaseHelper.init(); // Assuming database is an asynchronous operation
    for (var element in oSForms) {
      final row = element.toJson();
      await db!.insert(oSForm, row);
    }
  }

  /// form request data indert
  static Future<int> insertKpiRequest({var data}) async {
    final db = await DatabaseHelper.init();

    int id = await db.insert(
      requestForm,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return id;
  }

  static Future<int> insertDFQRequestForm({var data}) async {
    final db = await DatabaseHelper.init();

    int id = await db.insert(
      dFQRequestForm,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return id;
  }

  /// form request data indert
  static Future<void> insertSubmitFormInfo({var data}) async {
    final db = await DatabaseHelper.init();
    // Map<String, dynamic> data = {
    //   'requestFormId': requestFormId,
    //   'dealerId': dealerId,
    //   'dealerTypeId': dealerTypeId,
    //   'dateTime': dateTime,
    // };
    await db.insert(
      submitFormInfo,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> insertSubmitFormInfoDFQ({var data}) async {
    final db = await DatabaseHelper.init();
    // Map<String, dynamic> data = {
    //   'requestFormId': requestFormId,
    //   'dealerId': dealerId,
    //   'dealerTypeId': dealerTypeId,
    //   'dateTime': dateTime,
    // };
    await db.insert(
      submitFormInfoDFQ,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> updateSubmitFormInfo({var requestFormId}) async {
    final db = await DatabaseHelper.init();
    // Map<String, dynamic> data = {
    //   'isSync': 1,
    // };
    await db.update(
      submitFormInfo,
      {'isSync': 1},
      where: 'requestFormId = ?',
      whereArgs: [requestFormId],
    );
  }

  static Future<void> updatedFQRequestFormFormInfo({var requestFormId}) async {
    final db = await DatabaseHelper.init();
    // Map<String, dynamic> data = {
    //   'isSync': 1,
    // };
    await db.update(
      submitFormInfoDFQ,
      {'isSync': 1},
      where: 'requestFormId = ?',
      whereArgs: [requestFormId],
    );
  }


  static Future<List<Map<String, dynamic>>> getRequestFormData() async {
    final db = await DatabaseHelper.init();
    int isSync = 0;
    return await db.query(
      requestForm,
      where: 'isSync = ? AND KPIForms != "" AND OSForms != "" AND CWMForms != ""',
      whereArgs: [isSync],
    );
  }

  // static Future<List<Map<String, dynamic>>> getRequestDFQForms() async {
  //   final db = await DatabaseHelper.init();
  //   int isSync = 0;
  //   return await db.query(
  //     dFQRequestForm,
  //     where: 'isSync = ?',
  //     whereArgs: [isSync],
  //   );
  // }
  static Future<List<Map<String, dynamic>>> getRequestDFQForms(int id) async {
    final db = await DatabaseHelper.init();
    // int isSync = 0;
    return await db.query(
      dFQRequestForm,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Add the delete method here
  static Future<void> deleteRequestForm() async {
    final db = await init();
    await db.delete(
      'requestForm',
      where: 'DFQForms = ?',
      whereArgs: [''],
    );
  }

  static Future<int> updateRequestFormIsSync({
    required int id,
  }) async {
    final db = await init();
    return await db.update(
      dFQRequestForm,
      {'isSync': 1},
      where: 'id = ?',
      whereArgs: [id],
    );
  }




  static Future<int> updateIsSync({
    required int id,
  }) async {
    final db = await init();
    return await db.update(
      'requestForm',
      {'isSync': 1},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static formRequestUpdate({required int id, columnName, var val}) async {
    final Database db = await initDatabase();
    Map<String, dynamic> values = {
      columnName: val,
    };
    return await db.update(
      requestForm,
      values,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static Future<int> insertKpiFormFile(var kpiFormFil,int requestId) async {
    final db = database;
    Map<String, dynamic> data = {
      'requestId':requestId,
      'isSync': 2,
      'kpiFormFile': kpiFormFil,
    };

    int id = await db!.insert(kpiFormFile, data, conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  static Future<int> insertOSFormFile(var oSFormFil,int requestId,) async {
    final db = database;
    Map<String, dynamic> data = {
      'requestId':requestId,
      'isSync': 2,
      'oSFormFile': oSFormFil,
    };

    int id = await db!.insert(oSFormFile, data, conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  static Future<int> insertCWMFormFile(var cWMFormFil,int requestId,) async {
    final db = database;
    Map<String, dynamic> data = {
      'requestId':requestId,
      'isSync': 2,
      'cWMFormFile': cWMFormFil,
    };

    int id = await db!.insert(cWMFormFile, data, conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  static Future<int> insertDFQFormFile(var dFQFormFil,int id) async {
    final db = database;
    Map<String, dynamic> data = {
      'isSync': 0,
      'dFQFormFile': dFQFormFil,
    };

    int id = await db!.insert(dFQFormFile, data, conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  static Future<int> insertKpiFormSaveID({required int dealerType, required int dealerID, required kpiFileID, required int requestFormID}) async {
    final db = database;
    await clearTable(kpiFormSaveID);
    Map<String, dynamic> data = {
      'dealerTypeID': dealerType,
      'dealerID': dealerID,
      'kpiFileID': kpiFileID,
      'requestFormID': requestFormID,
    };

    int id = await db!.insert(kpiFormSaveID, data, conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  static Future<int> insertOSFormSaveID(
      {required int dealerType, required int dealerID, required int categoriesType, required oSFileID, required int requestFormID,required int kpiFileID})
async {
    final db = database;
    await clearTable(oSFormSaveID);
    Map<String, dynamic> data = {
      'dealerTypeID': dealerType,
      'dealerID': dealerID,
      'categoriesType': categoriesType,
      'oSFileID': oSFileID,
      'kpiFileID': kpiFileID,
      'requestFormID': requestFormID,
    };
    int id = await db!.insert(oSFormSaveID, data, conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  static Future<int> insertCWMFormSaveID({required int dealerType, required int dealerID, required int cWMFileID, required int requestFormID,
    required oSFileID,required int kpiFileID})
  async {
    final db = database;
    await clearTable(cWMFormSaveID);
    Map<String, dynamic> data = {
      'dealerTypeID': dealerType,
      'dealerID': dealerID,
      'cWMFileID': cWMFileID,
      'oSFileID': oSFileID,
      'kpiFileID': kpiFileID,
      'requestFormID': requestFormID,
    };

    int id = await db!.insert(cWMFormSaveID, data, conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getKpiFormIDS() async {
    final db = await DatabaseHelper.init();
    return await db!.query(kpiFormSaveID);
  }

  static Future<List<Map<String, dynamic>>> getOSFormIDS() async {
    final db = await DatabaseHelper.init();
    return await db!.query(oSFormSaveID);
  }

  static Future<List<Map<String, dynamic>>> getCwFormIDS() async {
    final db = await DatabaseHelper.init();
    return await db!.query(cWMFormSaveID);
  }

  static kpiFormFileUpdate({required int id, var val}) async {
    final Database db = await initDatabase();
    Map<String, dynamic> values = {
      "kpiFormFile": val,
    };
    return await db.update(
      kpiFormFile,
      values,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static updateKpiFormFileStatus({required int id,}) async {
    final Database db = await initDatabase();
    Map<String, dynamic> values = {
      "isSync": 0,
    };
    return await db.update(
      kpiFormFile,
      values,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static oSFormFileUpdate({required int id, var val}) async {
    final Database db = await initDatabase();
    Map<String, dynamic> values = {
      "oSFormFile": val,
    };
    return await db.update(
      oSFormFile,
      values,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static updateOSFormFileStatus({required int id,}) async {
    final Database db = await initDatabase();
    Map<String, dynamic> values = {
      "isSync": 0,
    };
    return await db.update(
      oSFormFile,
      values,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static dFQFormFileUpdate({required int id, var val}) async {
    final Database db = await initDatabase();
    Map<String, dynamic> values = {
      "dFQFormFile": val,
    };
    // 'dFQFormFile': dFQFormFile,
    return await db.update(
      dFQFormFile,
      values,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static cWMFormFileUpdate({required int id, var val}) async {
    final Database db = await initDatabase();
    Map<String, dynamic> values = {
      "cWMFormFile": val,
    };
    return await db.update(
      cWMFormFile,
      values,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static updateCWMFormFileStatus({required int id,}) async {
    final Database db = await initDatabase();
    Map<String, dynamic> values = {
      "isSync": 0,
    };
    return await db.update(
      cWMFormFile,
      values,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static Future<void> insertoSFormBoardDescription(List<OSFormBoardDescription> oSFormBoardDescriptions) async {
    await clearTable(oSFormBoardDescription); // Assuming clearTable exists and clears the 'cities' table
    final db = await DatabaseHelper.init();
    // Assuming database is an asynchronous operation
    for (var element in oSFormBoardDescriptions) {
      final row = element.toJson();
      await db!.insert(oSFormBoardDescription, row);
    }
  }

  static Future<void> insertOSFormBoardImages(List<OSFormBoardImages> oSFormBoardImage) async {
    await clearTable(oSFormBoardImages); // Assuming clearTable exists and clears the 'cities' table
    final db = await DatabaseHelper.init();
    // Assuming database is an asynchronous operation
    for (var element in oSFormBoardImage) {
      final row = element.toJson();
      await db!.insert(oSFormBoardImages, row);
    }
  }

  static Future<void> insertCategoryWiseModelFormFormImages(List<CategoryWiseModelFormFormImages> categoryWiseModelFormFormImage) async {
    await clearTable(categoryWiseModelFormFormImages); // Assuming clearTable exists and clears the 'cities' table
    final db = await DatabaseHelper.init();

    // Assuming database is an asynchronous operation
    for (var element in categoryWiseModelFormFormImage) {
      final row = element.toJson();
      await db!.insert(categoryWiseModelFormFormImages, row);
    }
  }

  static Future<void> insertOSFormAnswerType(List<OSFormAnswerType> oSFormAnswerTyp) async {
    await clearTable(oSFormAnswerType); // Assuming clearTable exists and clears the 'cities' table
    final db = await DatabaseHelper.init(); // Assuming database is an asynchronous operation
    for (var element in oSFormAnswerTyp) {
      final row = element.toJson();
      await db!.insert(oSFormAnswerType, row);
    }
  }

  static Future<void> insertOSFormAttachmentType(List<OSFormAttachmentType> oSFormAttachmentTyp) async {
    await clearTable(oSFormAttachmentType); // Assuming clearTable exists and clears the 'cities' table
    final db = await DatabaseHelper.init(); // Assuming database is an asynchronous operation
    for (var element in oSFormAttachmentTyp) {
      final row = element.toJson();
      await db!.insert(oSFormAttachmentType, row);
    }
  }

  static Future<void> insertDealer(List<Dealers> dealer) async {
    await clearTable(dealers); // Assuming clearTable exists and clears the 'cities' table
    final db = await DatabaseHelper.init();
   // Assuming database is an asynchronous operation
    for (var element in dealer) {
      final row = element.toJson();
      await db!.insert(dealers, row);
    }
  }

  static Future<void> insertCategories(List<Categories> categorie) async {
    await clearTable(categories); // Assuming clearTable exists and clears the 'cities' table
    final db = await DatabaseHelper.init(); // Assuming database is an asynchronous operation
    for (var element in categorie) {
      final row = element.toJson();
      await db!.insert(categories, row);
    }
  }

  static Future<List<Map<String, dynamic>>> getDealer(int id) async {
    final db = await DatabaseHelper.init();
    return db.query(dealers, where: 'dealer_type = ?', whereArgs: [id]);
  }



  static Future<List<Map<String, dynamic>>> getSubmitFormInfo() async {
    final db = await DatabaseHelper.init();
    return db.query(submitFormInfo);
  }
  static Future<List<Map<String, dynamic>>> getDFQRequestFormInfo() async {
    final db = await DatabaseHelper.init();
    return db.query(submitFormInfoDFQ);
  }


  static Future<List<Map<String, dynamic>>> getAllDealer() async {
    final db = await DatabaseHelper.init();
    return db.query(dealers,);
  }

  static Future<List<Map<String, dynamic>>> getKPIForm(int dealerTypeId) async {
    final db = await init();
    return db.query(kPIForm, where: 'dealer_type = ?', whereArgs: [dealerTypeId]);
  }

  // static Future<List<Map<String, dynamic>>> getKPIFormQuestions(int kpiQuestionsFormId) async {
  //   final db = await init();
  //   return db.query(kPIFormQuestions, where: 'kpiquestionsform_id = ?', whereArgs: [kpiQuestionsFormId]);
  // }
  static Future<List<Map<String, dynamic>>> getKPIFormQuestions(List<int> kpiQuestionsFormIds) async {
    final db = await init();

    // Create a string with the same number of placeholders as the length of the list
    String placeholders = List.filled(kpiQuestionsFormIds.length, '?').join(',');

    // Execute the query
    return db.query(
        kPIFormQuestions,
        where: 'kpiquestionsform_id IN ($placeholders)',
        whereArgs: kpiQuestionsFormIds
    );
  }


  static Future<List<Map<String, dynamic>>> getAttachmentType() async {
    final db = await init();
    return db.query(attachmentType);
  }

  static Future<List<Map<String, dynamic>>> getAnswerTypeData() async {
    final db = await init();
    return db.query(answerType);
  }

  // static Future<List<Map<String, dynamic>>> getKPIFormAnswerType(int kpiquestionsformid) async {
  //   final db = await init();
  //   return db.query(kPIFormAnswerType, where: 'kpiquestionsformid = ?', whereArgs: [kpiquestionsformid]);
  // }
  static Future<List<Map<String, dynamic>>> getKPIFormAnswerType(List<int> kpiQuestionsFormIds) async {
    final db = await init();

    // Create a string with the same number of placeholders as the length of the list
    String placeholders = List.filled(kpiQuestionsFormIds.length, '?').join(',');

    // Execute the query
    return db.query(
      kPIFormAnswerType,
      where: 'kpiquestionsformid IN ($placeholders)',
      whereArgs: kpiQuestionsFormIds,
    );
  }

  static Future<List<Map<String, dynamic>>> getKPIFormAttachmentType(List<int> kpiQuestionsFormIds) async {
    final db = await init();

    // Create a string with the same number of placeholders as the length of the list
    String placeholders = List.filled(kpiQuestionsFormIds.length, '?').join(',');

    // Execute the query
    return db.query(
      kPIFormAttachmentType,
      where: 'kpiquestionsformid IN ($placeholders)',
      whereArgs: kpiQuestionsFormIds,
    );
  }

  // static Future<List<Map<String, dynamic>>> getKPIFormAttachmentType(int kpiQuestionsFormId) async {
  //   final db = await init();
  //   return db.query(kPIFormAttachmentType, where: 'kpiquestionsformid = ?', whereArgs: [kpiQuestionsFormId]);
  // }
}
