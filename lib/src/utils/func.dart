import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:minto/src/utils/httpService.dart';

mixin Func {
  String pinataUrl = dotenv.get("PINATA_URL");
  String apiKey = dotenv.get("PINATA_API_KEY");
  String apiSecret = dotenv.get("API_SECRET");
  String pinataGateway = dotenv.get("PINATA_GATEWAY");
  String pinEndpoint = dotenv.get("PIN_ENDPOINT");

  uploadToPinata(File imageFile, String title) async {
    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(imageFile.path, filename: title)
    });

    HttpService httpService = HttpService();
    httpService.init(BaseOptions(
        baseUrl: pinataUrl,
        contentType: "multipart/form-data",
        headers: {
          "pinata_api_key": apiKey,
          "pinata_secret_api_key": apiSecret
        }));

    final response =
        await httpService.request(endpoint: pinEndpoint, formData: formData);
    return pinataGateway + response['IpfsHash'];
  }
}
