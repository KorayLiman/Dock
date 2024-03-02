import 'package:dock_flutter_example/core/core.dart';
import 'package:dock_flutter_example/presentation/authentication/login/model/model.dart';
import 'package:dock_flutter_example/product/product.dart';

final class LoginService extends BaseService {
  const LoginService();

  Future<BaseResponse<LoginResponseModel>> login() async {
    return request<LoginResponseModel, LoginResponseModel>(
      path: RequestPath.login,
      type: RequestType.post,
      responseEntityModel: const LoginResponseModel(),
      showLoader: true,
    );
  }
}
