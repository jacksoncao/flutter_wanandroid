import '../provider/search_provider.dart';
import '../dao/search_dao.dart';
import '../model/base_result_model.dart';

class HotkeyUtils{

  static bool isLoading = false;

  static int _reqHotkeyCnt = 0; //最多请求3次

  static _incrementReqCnt() => _reqHotkeyCnt++;

  static bool _isNeedReq() => _reqHotkeyCnt < 3;

  //请求搜索热词
  static void requestHotkeyList(SearchProvider provider){
    if(provider.hotkeyList.length == 0 && _isNeedReq() && !isLoading){
      isLoading = true;
      SearchDao.getSearchHotkey().then((result){
        if(result.resultCode == BaseResultModel.STATE_OK){
          provider.addSearchHotKeyList(result.data);
        }else{
          _incrementReqCnt();
        }
        isLoading = false;
      });
    }
  }


}