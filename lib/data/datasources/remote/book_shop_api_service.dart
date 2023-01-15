import 'package:book_shop/core/network/remote_api_service.dart';
import 'package:book_shop/core/params/account_params.dart';
import 'package:book_shop/core/params/auth_params.dart';
import 'package:book_shop/core/params/basket_params.dart';
import 'package:book_shop/core/params/titles_post_params.dart';
import 'package:book_shop/data/model/auth_model.dart';
import 'package:book_shop/data/model/basket_model.dart';
import 'package:book_shop/data/model/function_response_model.dart';
import 'package:book_shop/data/model/home_model.dart';
import 'package:book_shop/data/model/title_posts_model.dart';
import 'package:book_shop/data/model/user_model.dart';
import 'package:retrofit/retrofit.dart';

import '../../../core/error/exceptions.dart';
import '../../../domain/entities/book_shop_client.dart';

class RemoteApiServiceImpl extends RemoteApiService {
  BookShopClient? bookShopClient;
  RemoteApiServiceImpl(this.bookShopClient);
  @override
  Future<HomeModel> getHome() async {
    try {
      final HttpResponse response = await bookShopClient!.fetchHome();

      if (response.response.statusCode == 200) {
        return response.data;
      } else {
        throw ServerException();
      }
    } catch (error) {
      throw ServerException(
          message: "gethome->book_shop_api_service: ${error.toString()}");
    }
  }

  @override
  Future<TitlePostsModel> getTitlePost(TitlesPostRequestParams params) async {
    try {
      final HttpResponse response = await bookShopClient!.fetchTitlesPost(
          categoryId: params.categoryId.toString(),
          page: params.page.toString());

      if (response.response.statusCode == 200) {
        return response.data;
      } else {
        throw ServerException();
      }
    } catch (error) {
      throw ServerException(
          message: "getTitlePost->book_shop_api_service: ${error.toString()}");
    }
  }

  @override
  Future<AuthModel> login(AuthRequestParams params) async {
    try {
      final HttpResponse response = await bookShopClient!.login(
          password: params.password.toString(),
          username: params.username.toString());

      if (response.response.statusCode == 200) {
        return response.data;
      } else {
        throw ServerException();
      }
    } catch (error) {
      throw ServerException(
          message: "login->book_shop_api_service: ${error.toString()}");
    }
  }

  @override
  Future<AuthModel> signUp(AuthRequestParams params) async {
    try {
      final HttpResponse response = await bookShopClient!
          .signUp(password: params.password!, username: params.username!);

      if (response.response.statusCode == 200) {
        return response.data;
      } else {
        throw ServerException();
      }
    } catch (error) {
      throw ServerException(
          message: "signUp->book_shop_api_service: ${error.toString()}");
    }
  }

  @override
  Future<BasketModel> getBasket(BasketRequestParams params) async {
    try {
      final HttpResponse response = await bookShopClient!
          .getBasket(page: params.page, userId: params.userId);

      if (response.response.statusCode == 200) {
        return response.data;
      } else {
        throw ServerException();
      }
    } catch (error) {
      throw ServerException(
          message: "getBasket->book_shop_api_service: ${error.toString()}");
    }
  }

  @override
  Future<FunctionResponseModel> addBasket(BasketRequestParams params) async {
    try {
      final HttpResponse response = await bookShopClient!
          .addBasket(bookId: params.bookId, userId: params.userId);

      if (response.response.statusCode == 200) {
        return response.data;
      } else {
        throw ServerException();
      }
    } catch (error) {
      throw ServerException(
          message: "addBasket->book_shop_api_service: ${error.toString()}");
    }
  }

  @override
  Future<FunctionResponseModel> deleteBasket(BasketRequestParams params) async {
    try {
      final HttpResponse response = await bookShopClient!
          .deleteBasket(bookId: params.bookId, userId: params.userId);

      if (response.response.statusCode == 200) {
        return response.data;
      } else {
        throw ServerException();
      }
    } catch (error) {
      throw ServerException(
          message: "deleteBasket->book_shop_api_service: ${error.toString()}");
    }
  }

  @override
  Future<FunctionResponseModel> editAccount(AccountRequestParams params) async {
    try {
      final HttpResponse response = await bookShopClient!.editAccount(
        userId: params.userId,
        newPassword: params.password,
        newUsername: params.username,
      );

      if (response.response.statusCode == 200) {
        return response.data;
      } else {
        throw ServerException();
      }
    } catch (error) {
      throw ServerException(
          message: "editAccount->book_shop_api_service: ${error.toString()}");
    }
  }

  @override
  Future<UserModel> getAccount(AccountRequestParams params) async {
    try {
      final HttpResponse response =
          await bookShopClient!.getAccount(userId: params.userId);

      if (response.response.statusCode == 200) {
        return response.data;
      } else {
        throw ServerException();
      }
    } catch (error) {
      throw ServerException(
          message: "getAccount->book_shop_api_service: ${error.toString()}");
    }
  }
}
