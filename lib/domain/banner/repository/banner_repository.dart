import 'package:smartup/data/banner/model/banner_response.dart';
import 'package:smartup/data/core/model/network_response.dart';

abstract class BannerRepository{
  Future<NetworkResponse<List<BannerData>>> getEventBanner({required int limit});
}