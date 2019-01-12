
class Post {
    final String title;
    final String mediaName;
    final String mediaAvatar;
    final String imageLink;
    final String hrefLink;
    final String comments;
    final String postDate;

    Post({this.title, this.mediaName, this.mediaAvatar, this.imageLink, this.hrefLink, this.comments, this.postDate, });

   factory Post.fromJson(Map<String, dynamic> json) {
    return new Post(
      title: json['article_title'],
      mediaName: json['media_name'],
      mediaAvatar: json['media_avatar'],
      imageLink: json['article_image'],
      hrefLink: json['article_url'],
      comments: json['article_comments'].toString(),
      postDate: json['article_ctime'],
    );
   }
}