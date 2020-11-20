class DetailsModel {
  Details details;

  DetailsModel({this.details});

  DetailsModel.fromJson(Map<String, dynamic> json) {
    details =
        json['details'] != null ? new Details.fromJson(json['details']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.details != null) {
      data['details'] = this.details.toJson();
    }
    return data;
  }
}

class Details {
  String id;
  String cover;
  String pagesCount;
  String voteCount;
  String writer;
  String description;
  String name;
  String price;
  String language;
  String coverType;
  String pictureThumb;
  String picture;
  String salesCount;
  String isBanner;

  Details(
      {this.id,
      this.cover,
      this.pagesCount,
      this.voteCount,
      this.writer,
      this.description,
      this.name,
      this.price,
      this.language,
      this.coverType,
      this.pictureThumb,
      this.picture,
      this.salesCount,
      this.isBanner});

  Details.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cover = json['cover'];
    pagesCount = json['pages_count'];
    voteCount = json['vote_count'];
    writer = json['writer'];
    description = json['description'];
    name = json['name'];
    price = json['price'];
    language = json['language'];
    coverType = json['cover_type'];
    pictureThumb = json['picture_thumb'];
    picture = json['picture'];
    salesCount = json['sales_count'];
    isBanner = json['is_banner'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['id'] = this.id;
    data['cover'] = this.cover;
    data['pages_count'] = this.pagesCount;
    data['vote_count'] = this.voteCount;
    data['writer'] = this.writer;
    data['description'] = this.description;
    data['name'] = this.name;
    data['price'] = this.price;
    data['language'] = this.language;
    data['cover_type'] = this.coverType;
    data['picture_thumb'] = this.pictureThumb;
    data['picture'] = this.picture;
    data['sales_count'] = this.salesCount;
    data['is_banner'] = this.isBanner;
    return data;
  }
}
