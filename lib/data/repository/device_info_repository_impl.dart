import '../../domain/entities/device_info.dart';
import '../../domain/repositories/device_info_repository.dart';
import '../datasource/device_info_remote_datasource.dart';

class DeviceInfoRepositoryImpl implements DeviceInfoRepository {
  final DeviceInfoRemoteDatasource datasource;
  DeviceInfoRepositoryImpl(this.datasource);

  @override
  Future<DeviceInfo> fetchDeviceInfo() => datasource.fetchDeviceInfo();
}
