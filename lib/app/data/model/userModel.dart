class UserModel {
  final int? userId;
  final String? firstName;
  final String? lastName;
  final String? username;
  final String? email;
  final int? designationId;
  final int? departmentId;
  final String? grade;
  final String? password;
  final int? isActive;
  final int? zoneId;
  final String? createDate;
  final String? updateDate;
  final String? updateBy;
  final String? passwordCreateDate;
  final int? defaultMenuId;
  final String? sessionId;
  final int? isLogin;
  final String? sessionDateTime;
  final int? roleId;
  final String? defaultFormName;
  final String? formDisplayName;
  final String? roleName;

  UserModel({
     this.userId,
     this.firstName,
     this.lastName,
     this.username,
     this.email,
     this.designationId,
     this.departmentId,
     this.grade,
     this.password,
     this.isActive,
     this.zoneId,
     this.createDate,
     this.updateDate,
     this.updateBy,
     this.passwordCreateDate,
     this.defaultMenuId,
     this.sessionId,
     this.isLogin,
     this.sessionDateTime,
     this.roleId,
     this.defaultFormName,
     this.formDisplayName,
     this.roleName,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['userid'],
      firstName: json['firstname'],
      lastName: json['lastname']??"",
      username: json['username'],
      email: json['email'],
      designationId: json['designationid'],
      departmentId: json['departmentid'],
      grade: json['grade'],
      password: json['password'],
      isActive: json['isactive']==true?1:0,
      zoneId: json['zoneid'],
      createDate:json['createdate']??"",
      updateDate: json['updatedate'] != null ? json['updatedate'] :"",
      updateBy: json['updateby']??"",
      passwordCreateDate: json['passwordcreatedate'] ?? "",
      defaultMenuId: json['default_menuid'],
      sessionId: json['SessionId'],
      isLogin: json['IsLogin']==true?1:0,
      sessionDateTime:json['SessionDateTime']??"",
      roleId: json['RoleID'],
      defaultFormName: json['DefaultFormName'],
      formDisplayName: json['FormDisplayName'],
      roleName: json['RoleName'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'userid': userId,
      'firstname': firstName,
      'lastname': lastName,
      'username': username,
      'email': email,
      'designationid': designationId,
      'departmentid': departmentId,
      'grade': grade,
      'password': password,
      'isactive': isActive,
      'zoneid': zoneId,
      'createdate': createDate,
      'updatedate': updateDate,
      'updateby': updateBy,
      'passwordcreateDate': passwordCreateDate,
      'default_menuid': defaultMenuId,
      'SessionId': sessionId,
      'IsLogin': isLogin,
      'SessionDateTime': sessionDateTime,
      'RoleID': roleId,
      'DefaultFormName': defaultFormName,
      'FormDisplayName': formDisplayName,
      'RoleName': roleName,
    };
  }
}


class AuthToken {
  String? accessToken;
  String? tokenType;
  String? expiresIn;
  String? startDateTime;
  String? endDateTime;

  AuthToken(
      {this.accessToken,
        this.tokenType,
        this.expiresIn,
        this.startDateTime,
        this.endDateTime});

  AuthToken.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    tokenType = json['token_type'];
    expiresIn = json['expires_in'];
    startDateTime = json['start_date_time'];
    endDateTime = json['end_date_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access_token'] = this.accessToken;
    data['token_type'] = this.tokenType;
    data['expires_in'] = this.expiresIn;
    data['start_date_time'] = this.startDateTime;
    data['end_date_time'] = this.endDateTime;
    return data;
  }
}
