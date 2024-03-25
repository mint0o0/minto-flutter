import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:minto/src/controller/contract/contract_controller.dart';

mixin Func {
  String pinataUrl = dotenv.get("PINATA_URL");
  String apiKey = dotenv.get("PINATA_API_KEY");
  String apiSecret = dotenv.get("API_SECRET");
  String pinataGateway = dotenv.get("PINATA_GATEWAY");
  String pinEndpoint = dotenv.get("PIN_ENDPOINT");
  String pinataJwt = dotenv.get("PINATA_JWT");
  String openApiKey = dotenv.get("OPEN_API_KEY");

  uploadToPinata(dynamic imageFile, String title) async {
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

  createNft(File imageFile, String title, String description, String image,
      BuildContext context) async {
    String tokenUri = await uploadToPinata(imageFile, title);
    NftController nftController = NftController();
    await nftController.createNft(tokenUri, title, description, image);
    final tokenId = await nftController.getNfsCount();
    await nftController.sendNft(tokenId);
  }

  Future<String> createImage(String prompt) async {
    String url = "https://api.openai.com/v1/images/generations";
    final baseOptions = BaseOptions(
      headers: {
        'Authorization': 'Bearer $openApiKey',
        'Content-Type': 'application/json'
      },
    );

    Dio dio = Dio(baseOptions);
    Response response = await dio.post(
      url,
      data: {
        'model': 'dall-e-2',
        'prompt': prompt,
        'size': '512x512',
      },
    );
    print(response.statusCode);
    print(response.data);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.data;
    } else {
      return 'wrong prompt';
    }
  }
}
