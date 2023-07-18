import 'package:smartup/core/values/urls.dart';
import 'package:smartup/data/banner/model/banner_response.dart';
import 'package:smartup/data/core/model/network_response.dart';
import 'package:smartup/data/core/services/dio_client.dart';

abstract class BannerApiService{
  Future<NetworkResponse<List<BannerData>>> getEventBanner({required int limit});
}

class BannerApiServiceImpl implements BannerApiService{
  final DioClient dioClient;
  const BannerApiServiceImpl({required this.dioClient});

  @override
  Future<NetworkResponse<List<BannerData>>> getEventBanner({required int limit}) async {
    try{
      var queryParam = {
        "limit":limit
      };
      var response = await dioClient.get(Urls.banners, queryParameters: queryParam);
      if(response.statusCode == 200){
        if(response.data != null){
          var bannerResponse = BannerResponse.fromJson(response.data);
          if(bannerResponse.status == 0){
            return NetworkResponse.error(message: bannerResponse.message);
          }
          return NetworkResponse.success(bannerResponse.data);
        }else{
          return NetworkResponse.error(message: response.statusMessage);
        }
      }else{
        return NetworkResponse.error(message: response.statusMessage);
      }
    } on Exception catch(e){
      return NetworkResponse.error(message: e.toString());
    }
  }

}