part of 'DioImports.dart';

class DioHelper {
  Dio _dio;
  DioCacheManager _manager;
  final bool forceRefresh;
  static String _baseUrl = "https://horizonsapp.sa/api/v1/";
  static String _secretKey = "Vui2b616FctXOWovBnFja1203";
  final String _branch = "2";
  String _lang;

  DioHelper(BuildContext buildContext, {this.forceRefresh = true}) {
    _lang = buildContext.read<LangCubit>().state.lang ?? "ar";
    if (_dio == null) {
      _dio = Dio(
        BaseOptions(
            baseUrl: _baseUrl,
            contentType: "application/x-www-form-urlencoded; charset=utf-8"),
      )
        ..interceptors.add(_getCacheManager().interceptor)
        ..interceptors.add(LogInterceptor(responseBody: true));
    }
  }

  DioCacheManager _getCacheManager() {
    if (null == _manager) {
      _manager = DioCacheManager(
          CacheConfig(baseUrl: _baseUrl, defaultRequestMethod: "POST"));
    }
    return _manager;
  }

  Options _buildCacheOptions(Map<String, dynamic> body, {bool subKey = true}) {
    return buildCacheOptions(Duration(days: 3),
        maxStale: Duration(days: 7),
        forceRefresh: forceRefresh,
        subKey: subKey ? json.encode(body) : "");
  }

  Future<dynamic> getGET(
    String url,
  ) async {
    // body.addAll({"fk_branch": "$_branch"});
    _dio.options.headers = await _getHeader();

    try {
      var response = await _dio.get(
        "$_baseUrl$url",
      );
      print("response ${response.statusCode}");
      var data = response.data;
      return data;
    } on DioError catch (e) {
      if (e.response.statusCode == 422) {
        LoadingDialog.showToastNotification(
            e.response.data["message"].toString());
      } else if (e.response.statusCode == 401 || e.response.statusCode == 301) {
        LoadingDialog.showToastNotification(
            e.response.data["error"].toString());
        // tokenExpired();
      } else {
        LoadingDialog.showToastNotification(tr("chickNet"));
      }
    }
    return null;
  }

  Future<dynamic> get(String url, Map<String, dynamic> body) async {
    // body.addAll({"fk_branch": "$_branch"});
    _printRequestBody(body);
    _dio.options.headers = await _getHeader();
    try {
      var response = await _dio.post("$_baseUrl$url",
          data: json.encode(body), options: _buildCacheOptions(body));
      print("response ${response.statusCode}");
      var data = response.data;
      return data;
    } on DioError catch (e) {
      if (e.response.statusCode == 422) {
        LoadingDialog.showToastNotification(
            e.response.data["message"].toString());
      } else if (e.response.statusCode == 401 || e.response.statusCode == 301) {
        tokenExpired();
      } else if (e.response.statusCode == 403) {
        LoadingDialog.showToastNotification(
            e.response.data["error"].toString());
      } else {
        LoadingDialog.showToastNotification(tr("chickNet"));
      }
    }
    return null;
  }

  Future<dynamic> post(String url, Map<String, dynamic> body,
      {bool showLoader = true}) async {
    // body.addAll({"fk_branch": "$_branch"});

    if (showLoader) LoadingDialog.showLoadingDialog();
    _printRequestBody(body);
    _dio.options.headers = await _getHeader();

    try {
      var response = await _dio.post("$_baseUrl$url",
          data: FormData.fromMap(body), options: _buildCacheOptions(body));
      print("response ${response.statusCode}");
      if (showLoader) EasyLoading.dismiss();
      response.data["msg"] == null
          ? null
          : LoadingDialog.showToastNotification(
              response.data["msg"].toString());
      var data = response.data;
      return data;
    } on DioError catch (e) {
      if (showLoader) EasyLoading.dismiss();
      if (e.response.statusCode == 422) {
        LoadingDialog.showToastNotification(
            e.response.data["message"].toString());
      } else if (e.response.statusCode == 401 || e.response.statusCode == 301) {
        tokenExpired();
      } else {
        LoadingDialog.showToastNotification(tr("chickNet"));
      }
    }

    return null;
  }

  Future<dynamic> patch(String url, Map<String, dynamic> body,
      {bool showLoader = true}) async {
    // body.addAll({"fk_branch": "$_branch"});

    if (showLoader) LoadingDialog.showLoadingDialog();
    _printRequestBody(body);
    _dio.options.headers = await _getHeader();

    try {
      var response = await _dio.patch("$_baseUrl$url",
          data: FormData.fromMap(body), options: _buildCacheOptions(body));
      print("response ${response.statusCode}");
      if (showLoader) EasyLoading.dismiss();
      response.data["msg"] == null
          ? null
          : LoadingDialog.showToastNotification(
              response.data["msg"].toString());
      var data = response.data;
      return data;
    } on DioError catch (e) {
      if (showLoader) EasyLoading.dismiss();
      if (e.response.statusCode == 422) {
        LoadingDialog.showToastNotification(
            e.response.data["message"].toString());
      } else if (e.response.statusCode == 401 || e.response.statusCode == 301) {
        tokenExpired();
      } else {
        LoadingDialog.showToastNotification(tr("chickNet"));
      }
    }

    return null;
  }

  Future<dynamic> uploadFile(String url, Map<String, dynamic> body,
      {bool showLoader = true}) async {
    // body.addAll({"fk_branch": "$_branch"});

    if (showLoader) LoadingDialog.showLoadingDialog();
    _printRequestBody(body);
    FormData formData = FormData.fromMap(body);
    body.forEach((key, value) async {
      if ((value) is File) {
        //create multipart using filepath, string or bytes
        MapEntry<String, MultipartFile> pic = MapEntry(
          "$key",
          MultipartFile.fromFileSync(value.path,
              filename: value.path.split("/").last),
        );
        //add multipart to request
        formData.files.add(pic);
      } else if ((value) is List<File>) {
        List<MapEntry<String, MultipartFile>> files = [];
        value.forEach((element) async {
          MapEntry<String, MultipartFile> pic = MapEntry(
              "$key",
              MultipartFile.fromFileSync(
                element.path,
                filename: element.path.split("/").last,
              ));
          files.add(pic);
        });
        formData.files.addAll(files);
      } else {
        // requestData.addAll({"$key":"$value"});

      }
    });

    _dio.options.headers = await _getHeader();
    //create multipart request for POST or PATCH method

    try {
      var response = await _dio.post("$_baseUrl$url",
          data: formData, options: _buildCacheOptions(body, subKey: false));
      print("response ${response.data}");
      if (showLoader) EasyLoading.dismiss();
      if (response.statusCode >= 200 || response.statusCode <= 300) {
        return response.data;
      } else {
        response.data["message"] == null
            ? null
            : LoadingDialog.showToastNotification(
                response.data["message"].toString());
        return null;
      }
    } on DioError catch (e) {
      if (showLoader) EasyLoading.dismiss();
      if (e.response.statusCode == 422) {
        LoadingDialog.showToastNotification(
            e.response.data["message"].toString());
      } else if (e.response.statusCode == 401 || e.response.statusCode == 301) {
        tokenExpired();
      } else {
        // LoadingDialog.showToastNotification(tr("chickNet"));
      }
    }

    return null;
  }

  Future<dynamic> uploadFilePut(String url, Map<String, dynamic> body,
      {bool showLoader = true}) async {
    // body.addAll({"fk_branch": "$_branch"});

    if (showLoader) LoadingDialog.showLoadingDialog();
    _printRequestBody(body);
    FormData formData = FormData.fromMap(body);
    body.forEach((key, value) async {
      if ((value) is File) {
        //create multipart using filepath, string or bytes
        MapEntry<String, MultipartFile> pic = MapEntry(
          "$key",
          MultipartFile.fromFileSync(value.path,
              filename: value.path.split("/").last),
        );
        //add multipart to request
        formData.files.add(pic);
      } else if ((value) is List<File>) {
        List<MapEntry<String, MultipartFile>> files = [];
        value.forEach((element) async {
          MapEntry<String, MultipartFile> pic = MapEntry(
              "$key",
              MultipartFile.fromFileSync(
                element.path,
                filename: element.path.split("/").last,
              ));
          files.add(pic);
        });
        formData.files.addAll(files);
      } else {
        // requestData.addAll({"$key":"$value"});

      }
    });

    _dio.options.headers = await _getHeader();
    //create multipart request for POST or PATCH method

    try {
      var response = await _dio.put("$_baseUrl$url",
          data: formData, options: _buildCacheOptions(body, subKey: false));
      print("response ${response.statusCode}");
      if (showLoader) EasyLoading.dismiss();
      if (response.statusCode >= 200 || response.statusCode <= 300) {
        return response.data;
      } else {
        LoadingDialog.showToastNotification(
            response.data["message"].toString());
        return null;
      }
    } on DioError catch (e) {
      if (showLoader) EasyLoading.dismiss();
      if (e.response.statusCode == 422) {
        LoadingDialog.showToastNotification(
            e.response.data["message"].toString());
      } else if (e.response.statusCode == 401 || e.response.statusCode == 301) {
        tokenExpired();
      } else {
        // LoadingDialog.showToastNotification(tr("chickNet"));
      }
    }

    return null;
  }

  void _printRequestBody(Map<String, dynamic> body) {
    print(
        "-------------------------------------------------------------------");
    print(body);
    print(
        "-------------------------------------------------------------------");
  }

  _getHeader() async {
    String token = GlobalState.instance.get("token");
    return {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Client-Secret": _secretKey,
      "Authorization": "Bearer $token",
      "Locale": _lang
    };
  }

  void tokenExpired() {
    LoadingDialog.showToastNotification(tr("accountIsNotValid"));
    // Future.delayed(Duration(seconds: 1), (() {
    //   Utils.clearSavedData();
    //   ExtendedNavigator.root.pushAndRemoveUntil(Routes.login, (route) => false);
    // }));
  }
}
