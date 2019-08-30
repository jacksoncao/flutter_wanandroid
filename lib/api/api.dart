class Api{
  //主机地址
  static const String HOST_URL = "https://www.wanandroid.com";

  //首页banner
  static const String HOME_BANNER = HOST_URL + "/banner/json";
  //首页文章列表  /article/list/{pageIndex}/json  需要拼接当前页面在url地址上 ==> 从0开始
  static const String HOME_ARTICLE_LIST = HOST_URL + "/article/list/";
  //置顶文章
  static const String TOP_ARTICLE = HOST_URL + "/article/top/json";

  //项目分类
  static const String PROJECT_CATEGORY = HOST_URL + "/project/tree/json";
  //项目某个分类下的列表数据  /project/list/{pageIndex}/json?cid=294  ==> 从1开始
  static const String PROJECT_CATRGORY_ARTICLES = HOST_URL + "/project/list/";

  //知识体系
  static const String KNOWLEDGE_CATEGORY = HOST_URL + "/tree/json";
  //知识体系下面的文章  /article/list/{pageIndex}/json?cid=60  需要拼接当前页面在url地址上  ==> 从0开始
  static const String KNOWLEDGE_CATEGORY_ARTICLES = HOST_URL + "/article/list/";

  //导航页面
  static const String NAVIGATION = HOST_URL + "/navi/json";

  //用户注册  POST方式
  static const String USER_REGISTER = HOST_URL + "/user/register";
  //用户登录  POST方式
  static const String USER_LOGIN = HOST_URL + "/user/login";
  //用户退出  GET方式
  static const String USER_LOGOUT = HOST_URL + "/user/logout/json";


  //常用网站   GET方式
  static const String FRIEND_WAP = HOST_URL + "/friend/json";

  //公众号列表  GET方式
  static const String WECHAT_LIST = HOST_URL + "/wxarticle/chapters/json";
  //查看某个公众号的历史数据  /article/list/{公众号id}/{页码}/json  GET方式
  static const String WECHAT_ARTICLE_LIST = HOST_URL + "/wxarticle/list/";
  //在某个公众号中搜索历史文章  /wxarticle/list/{公众号id}/{页码}/json  拼接键值对  GET方式
  static const String WECHAT_ARTICLE_SEARCH = HOST_URL + "/wxarticle/list/405/1/json?k=Java";

  //收藏文章列表  /lg/collect/list/{pageIndex}/json  GET
  static const String COLLECT_ARTICLE_LIST = HOST_URL + "/lg/collect/list/";
  //收藏站内文章  /lg/collect/{pageIndex}/json
  static const String COLLECT_ARTICLE = HOST_URL + "/lg/collect/";
  //文章列表中的取消收藏  /lg/uncollect_originId/{articleId}/json
  static const String UNCOLLECT_ARTICLE_LIST_ITEM = HOST_URL + "/lg/uncollect_originId/";
  //我的收藏页面取消收藏  /lg/uncollect/2805/json  参数 originId列表中下发
  static const String COLLECT_PAGE_UNCOLLECT_ARTICLE = HOST_URL + "/lg/uncollect/";
  //收藏网址列表
  static const String COLLECT_WAP_LIST = HOST_URL + "/lg/usertools/json";
  //收藏网址
  static const String COLLECT_WAP = HOST_URL + "/lg/collect/addtool/json";
  //取消收藏wap网址
  static const String UNCOLLECT_WAP = HOST_URL + "/lg/collect/deletetool/json"; 

  //查询todo列表  /lg/todo/v2/list/{pageIndex}/json  POST方式
  /*
   *  参数列表：
   *  页码从1开始，拼接在url上
   *  status 状态， 1-完成；0未完成; 默认全部展示；
   *  type 创建时传入的类型, 默认全部展示
   * 	priority 创建时传入的优先级；默认全部展示
   * 	orderby 1:完成日期顺序；2.完成日期逆序；3.创建日期顺序；4.创建日期逆序(默认)；
   */
  static const String TODO_LIST = HOST_URL + "/lg/todo/v2/list/";

  //增加一个todo  POST
  /*
   *  参数列表：
   *  title: 新增标题（必须）*  
	 *  content: 新增详情（必须）
	 *  date: 2018-08-01 预定完成时间（不传默认当天，建议传）
	 *  type: 大于0的整数（可选）；  可以在代码中预定义一些type类型
	 *  priority 大于0的整数（可选）； 定义优先级  1 重要   2一般
   */
  static const String TODO_ADD = HOST_URL + "/lg/todo/add/json";

  //更新todo  /lg/todo/update/{todoId}/json
  /*
   *  参数列表：
   *  id: 拼接在链接上，为唯一标识，列表数据返回时，每个todo 都会有个id标识 （必须）
	 *  title: 更新标题 （必须）
	 *  content: 新增详情（必须）
	 *  date: 2018-08-01（必须）
	 *  status: 0   // 0为未完成，1为完成
	 *  type: ；
	 *  priority: ；
   */
  static const String TODO_UPDATE = HOST_URL + "/lg/todo/update/";

  //删除一个Todo   /lg/todo/{todoId}/json  POST方式
  /*
   * 参数列表：
   * id: 拼接在链接上，为唯一标识
   */
  static const String TODO_DELETE = HOST_URL + "/lg/todo/delete";

  //仅更新完成状态
  /*
   * 参数列表：
   * id: 拼接在链接上，为唯一标识
	 * status: 0或1，传1代表未完成到已完成，反之则反之。
   */
  static const String TODO_COMPLETE = HOST_URL + "/lg/todo/done/";

  //搜索接口  POST方式   k搜索关键词 /article/query/{pageIndex}/json
  static const String SEARCH = HOST_URL + "/article/query/";

  //大家都在搜搜索热词  https://www.wanandroid.com//hotkey/json
  static const String SEARCH_HOT_KEY = HOST_URL + "/hotkey/json";
}