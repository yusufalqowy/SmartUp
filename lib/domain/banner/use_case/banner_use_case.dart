import 'package:smartup/data/banner/model/banner_response.dart';
import 'package:smartup/data/core/model/network_response.dart';
import 'package:smartup/domain/banner/repository/banner_repository.dart';

abstract class BannerUseCase{
  Future<NetworkResponse<List<BannerData>>> getEventBanner({required int limit});
}

class BannerUseCaseImpl implements BannerUseCase{
  final BannerRepository bannerRepository;
  const BannerUseCaseImpl({required this.bannerRepository});

  @override
  Future<NetworkResponse<List<BannerData>>> getEventBanner({required int limit}) async => await bannerRepository.getEventBanner(limit: limit);

}