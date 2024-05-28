import 'dart:developer';

import 'package:dio/dio.dart';
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
    NftController nftController = NftController();
    await nftController.createNft(
        tokenUri.toString(), title, description, imageUrl);
  }

  Future<BigInt> getNftsCount() async {
    NftController nftController = NftController();
    final tokenId = await nftController.getNfsCount();
    return tokenId;
  }

  sendNft(BigInt tokenId) async {
    NftController nftController = NftController();
    log("nft send 호출: $tokenId");
    await nftController.sendNft(tokenId);
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
    String url = "https://api.openai.com/v1/images/generations";
    final baseOptions = BaseOptions(
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer: $openApiKey'
      },
    );

    Dio dio = Dio(baseOptions);
    Response response = await dio.post(url, data: {
      "model": "dall-e-2",
      "prompt": prompt,
      "n": 1,
      "size": "1024x1024"
    });

    Map<String, dynamic> responseMap = response.data;
    log(response.data.toString());
    log(responseMap['output'][0]);

    return responseMap['output'][0].toString();
  }
}