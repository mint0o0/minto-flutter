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
    print("Create NFT");
    NftController nftController = NftController();
    await nftController.createNft(
        tokenUri.toString(), title, description, imageUrl);
  }
  sendNft(BigInt tokenId) async{
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
    String url = "https://stablediffusionapi.com/api/v4/dreambooth";
    final baseOptions = BaseOptions(
      headers: {'Content-Type': 'application/json'},
    );

    Dio dio = Dio(baseOptions);
    Response response = await dio.post(url, data: {
      "key": stableDiffusionKey,
      "prompt": "$prompt ((digital art 8K, cyberpunc style))",
      "model_id": "midjourney",
      "negative_prompt":
          "human, ugly, tiling, poorly drawn hands, poorly drawn feet, poorly drawn face, out of frame, extra limbs, disfigured, deformed, body out of frame, bad anatomy, watermark, signature, cut off, low contrast, underexposed, overexposed, bad art, beginner, amateur, distorted face, b&w, watermark EasyNegative",
      "width": "512",
      "height": "512",
      "samples": "1",
      "num_inference_steps": "30",
      "seed": null,
      "guidance_scale": 7.5,
      "webhook": null,
      "track_id": null
    });

    Map<String, dynamic> responseMap = response.data;
    log(response.data.toString());
    log(responseMap['output'][0]);

    return responseMap['output'][0].toString();
  }
}
