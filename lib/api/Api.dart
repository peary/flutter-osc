class Api {
  static const String HOST = "https://www.oschina.net";

  // 资讯列表
  // static const String NEWS_LIST = "http://osc.yubo725.top/news/list";
  static const String NEWS_LIST = "https://blockshare.top/wp-json/wp/v2/posts?per_page=10";

  // 资讯详情
  static const String NEWS_DETAIL = HOST + "/action/openapi/news_detail";

  // 动弹列表
  static const String TWEETS_LIST = HOST + "/action/openapi/tweet_list";

  // 评论列表
  static const String COMMENT_LIST = HOST + "/action/openapi/comment_list";

  // 评论回复
  static const String COMMENT_REPLY = HOST + "/action/openapi/comment_reply";

  // 获取用户信息
  static const String USER_INFO = HOST + "/action/openapi/user";

  // 发布动弹
  static const String PUB_TWEET = HOST + "/action/openapi/tweet_pub";

  // 添加到小黑屋
  static const String ADD_TO_BLACK = "http://osc.yubo725.top/black/add";

  // 查询小黑屋
  static const String QUERY_BLACK = "http://osc.yubo725.top/black/query";

  // 从小黑屋中删除
  static const String DELETE_BLACK = "http://osc.yubo725.top/black/delete";

  // 开源活动
  static const String EVENT_LIST = "http://osc.yubo725.top/events/";

  // 微博热搜
  static const String WEIBO_HOT_TOPICS = "https://m.weibo.cn/api/container/getIndex?containerid=106003type%3D25%26t%3D3%26disable_hot%3D1%26filter_type%3Drealtimehot&title=%E5%BE%AE%E5%8D%9A%E7%83%AD%E6%90%9C&extparam=filter_type%3Drealtimehot%26mi_cid%3D100103%26pos%3D0_0%26c_type%3D30%26display_time%3D1545930104&luicode=10000011&lfid=231583";
}