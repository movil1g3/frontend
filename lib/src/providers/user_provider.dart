import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../environment/environment.dart';
import '../models/responde_api.dart';
import '../models/user.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class UsersProvider extends GetConnect {
  String url = '${Environment.API_URL}api/users';

  User userSession = User.fromJson(GetStorage().read('user') ?? {});

  Future<Response> create(User user) async {
    Response response = await post(
        '$url/create',
        user.toJson(),
        headers: {
          'Content-Type': 'application/json'
        }
    );

    return response;
  }

  Future<ResponseApi> login(String email, String password) async {
    Response response = await post(
        '$url/login',
        {
          'email': email,
          'password': password
        },
        headers: {
          'Content-Type': 'application/json'
        }
    ); // ESPERAR HASTA QUE EL SERVIDOR NOS RETORNE LA RESPUESTA

    if (response.body == null) {
      Get.snackbar('Error', 'No se pudo ejecutar la peticion');
      return ResponseApi();
    }

    ResponseApi responseApi = ResponseApi.fromJson(response.body);
    return responseApi;
  }

  Future<Stream> createWithImage(User user, File image) async {
    Uri uri = Uri.http(Environment.API_URL_OLD, '/api/users/createWithImage');
    print('URL ---> $uri');
    final request = http.MultipartRequest('POST', uri);
    request.files.add(http.MultipartFile(
        'image',
        http.ByteStream(image.openRead().cast()),
        await image.length(),
        filename: basename(image.path)
    ));
    request.fields['user'] = json.encode(user);
    final response = await request.send();
    return response.stream.transform(utf8.decoder);
  }

  Future<Response> findByCode(String code) async {
    Response response = await get(
        '$url/findByCode/$code',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': userSession.sessionToken ?? ''
        }
    ); // ESPERAR HASTA QUE EL SERVIDOR NOS RETORNE LA RESPUESTA

    if (response.statusCode == 404) {

    }
    return response;
  }

}