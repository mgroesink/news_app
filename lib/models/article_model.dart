class ArticleModel {
  String author;

  ArticleModel(
      {this.author,
      this.title,
      this.description,
      this.url,
      this.urlToImage,
      this.content,
      this.publishedAt});

  String title;
  String description;
  String url;
  String urlToImage;
  String content;
  DateTime publishedAt;
}
