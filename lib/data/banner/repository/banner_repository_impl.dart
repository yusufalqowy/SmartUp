import 'package:smartup/data/banner/data_source/remote/banner_api_service.dart';
import 'package:smartup/data/banner/model/banner_response.dart';
import 'package:smartup/data/core/model/network_response.dart';
import 'package:smartup/domain/banner/repository/banner_repository.dart';

class BannerRepositoryImpl implements BannerRepository{
  final BannerApiService bannerApiService;
  const BannerRepositoryImpl({required this.bannerApiService});

  @override
  Future<NetworkResponse<List<BannerData>>> getEventBanner({required int limit}) async => await bannerApiService.getEventBanner(limit: limit);

}