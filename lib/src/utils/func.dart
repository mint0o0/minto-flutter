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
  String stableDiffusionKey = dotenv.get("STABLE_DIFFUSION_API_KEY");

  Future<String> uploadToPinata(String imageUrl, String title) async {
    Dio dio = Dio();
    final imageResponse = await dio.get<List<int>>(imageUrl,
        options: Options(responseType: ResponseType.bytes));
    List<int> imageBytes = imageResponse.data!;

    FormData formData = FormData.fromMap({
      'file': await MultipartFile.fromBytes(
        imageBytes,
        filename: title,
      ),
      'title': title,
    });

    dynamic response = await dio.post(
      'https://api.pinata.cloud/pinning/pinFileToIPFS',
      data: formData,
      options: Options(
        headers: {
          "authorization": "Bearer $pinataJwt",
        },
      ),
    );
    // return pinataGateway + response['IpfsHash'];
    print("call");
    print(response.data.toString());
    return response.data.toString();
  }

  createNft(String imageUrl, String title, String description, 
      BuildContext context) async {
    String tokenUri = await uploadToPinata(imageUrl, title);
    NftController nftController = NftController();
    await nftController.createNft(tokenUri, title, description, imageUrl);
    final tokenId = await nftController.getNfsCount();
    await nftController.sendNft(tokenId);
  }

/*
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
*/
  Future<String> createImage(String prompt) async {
    String url = "https://stablediffusionapi.com/api/v3/text2img";
    final baseOptions = BaseOptions(
      headers: {'Content-Type': 'application/json'},
    );

    Dio dio = Dio(baseOptions);
    Response response = await dio.post(url, data: {
      "key": stableDiffusionKey,
      "prompt": prompt,
      "negative_prompt":
          "ugly, tiling, poorly drawn hands, poorly drawn feet, poorly drawn face, out of frame, extra limbs, disfigured, deformed, body out of frame, bad anatomy, watermark, signature, cut off, low contrast, underexposed, overexposed, bad art, beginner, amateur, distorted face, b&w, watermark EasyNegative",
      "width": "512",
      "height": "512",
      "samples": "1",
      "num_inference_steps": "20",
      "safety_checker": "no",
      "enhance_prompt": "yes",
      "seed": null,
      "guidance_scale": 7.5,
      "multi_lingual": "no",
      "panorama": "no",
      "self_attention": "no",
      "upscale": "no",
      "embeddings_model": null,
      "webhook": null,
      "track_id": null
    });
    Map<String, dynamic> responseMap = response.data;
    print(response.data);
    print(responseMap['output'][0]);

    return responseMap['output'][0].toString();
  }
}
