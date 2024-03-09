import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

mixin Func {
  String pinataUrl = dotenv.get("PINATA_URL");
  String apiKey = dotenv.get("PINATA_API_KEY");
  String apiSecret = dotenv.get("API_SECRET");
  String pinataGateway = dotenv.get("PINATA_GATEWAY");
  String pinEndpoint = dotenv.get("PIN_ENDPOINT");
  String pinataJwt = dotenv.get("PINATA_JWT");

  uploadToPinata(dynamic imageFile, String title) async {
    print("uploadto pinata call");

    FormData formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(
        imageFile.path,
        filename: title,
      ),
      'title': title,
    });
    final baseOptions = BaseOptions(
      baseUrl: pinataUrl,
      headers: {'Authorization': 'Bearer $pinataJwt'},
    );
    Dio dio = Dio(baseOptions);

    dynamic response = await dio.post('/pinning/pinFileToIPFS', data: formData);
    // return pinataGateway + response['IpfsHash'];
    print("call");
  }
}
