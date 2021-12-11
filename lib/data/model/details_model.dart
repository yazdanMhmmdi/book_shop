class DetailsModel {
  DetailsModel({
    required this.details,
  });
  late final Details details;

  DetailsModel.fromJson(Map<String, dynamic> json) {
    details = Details.fromJson(json['details']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['details'] = details.toJson();
    return _data;
  }
}

class Details {
  Details({
    required this.id,
    required this.cover,
    required this.pagesCount,
    required this.voteCount,
    required this.writer,
    required this.description,
    required this.name,
    required this.price,
    required this.language,
    required this.coverType,
    required this.pictureThumb,
    required this.picture,
    required this.salesCount,
    required this.isBanner,
    required this.categoryId,
  });

  late final String id;
  late final String cover;
  late final String pagesCount;
  late final String voteCount;
  late final String writer;
  late final String description;
  late final String name;
  late final String price;
  late final String language;
  late final String coverType;
  late final String pictureThumb;
  late final String picture;
  late final String salesCount;
  late final String isBanner;
  late final String categoryId;

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
    categoryId = json['category_id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['cover'] = cover;
    _data['pages_count'] = pagesCount;
    _data['vote_count'] = voteCount;
    _data['writer'] = writer;
    _data['description'] = description;
    _data['name'] = name;
    _data['price'] = price;
    _data['language'] = language;
    _data['cover_type'] = coverType;
    _data['picture_thumb'] = pictureThumb;
    _data['picture'] = picture;
    _data['sales_count'] = salesCount;
    _data['is_banner'] = isBanner;
    _data['category_id'] = categoryId;
    return _data;
  }
}
