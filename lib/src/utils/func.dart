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

  Future<dynamic> uploadToPinata(String imageUrl, String title) async {
    Dio dio = Dio();
    final imageResponse = await dio.get<List<int>>(imageUrl,
        options: Options(responseType: ResponseType.bytes));
    List<int> imageBytes = imageResponse.data!;

    FormData formData = FormData.fromMap({
      'file': MultipartFile.fromBytes(
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
    Map<String, dynamic> responseMap = response.data;
    return responseMap;
  }

  createNft(String imageUrl, String title, String description) async {
    // Map<String, dynamic> uploadResponse = await uploadToPinata(imageUrl, title);
    // print(uploadResponse);
    Map<String, dynamic> tokenUri = ({
      "'description'": description,
      "'image'": "'$imageUrl'",
      "'title'": title,
      "'attributes'": [
        {"trait_type": "Base", "value": "Starfish"},
        {"trait_type": "Eyes", "value": "Big"},
        {"trait_type": "Mouth", "value": "Surprised"},
      ],
    });
    print("Create NFT");
    NftController nftController = NftController();
    await nftController.createNft(
        tokenUri.toString(), title, description, imageUrl);

    final tokenId = await nftController.getNfsCount();
    print("tokenId: $tokenId");
    await nftController.sendNft(tokenId - BigInt.from(1));
  }

  createAndSend(String imageUrl, String title, String description) async {
    Map<String, dynamic> tokenUri = ({
      '"description"': "\"$description\"",
      '"image"': "\"$imageUrl\"",
      '"title"': "\"$title\""
    });

    NftController nftController = NftController();
    await nftController.createAndSendNft(
        tokenUri.toString(), title, description, imageUrl);
  }

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
