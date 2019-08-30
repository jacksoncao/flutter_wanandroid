/*
 * 服务端返回的响应结果数据的基本结构，所有的响应数据都要继承这个model，
 * 通过泛型来分别使用普通数据和以页为单位的数据
 */
class BaseResultModel<T>{

  static const int STATE_OK = 0 ;  //本次请求成功
  static const int STATE_ERROR = -1; //本次请求失败
  static const int NO_DATA = 1; //本次请求成功，但没有数据
  static const int INVALID_LOGIN = 2;  //需要重新登录

  final T data; 
  int errorCode; //服务器返回的请求结果码  0代表成功   小于0代表失败
  String errorMsg;  //返回的错误信息（如果发生错误）
  int resultCode; // 返给UI上层用的请求结果状态，屏蔽服务端的直接结果码

  BaseResultModel({this.data,Map<String,dynamic> json}){
    errorCode = json["errorCode"];
    errorMsg = json["errorMsg"];
    resultCode = parseErrorCode(errorCode);
  }

  //转换服务端返回的响应结果码
  int parseErrorCode(int code){
    if(code == -1001){
      return INVALID_LOGIN;
    }else if(code == 0){
      return hasNoData() ? NO_DATA : STATE_OK;
    }
    return STATE_ERROR;
  }

  //是否没有数据
  bool hasNoData() => false;

  factory BaseResultModel.from(Map<String,dynamic> json){
    return BaseResultModel(
      data: null,
      json: json
    );
  }

}