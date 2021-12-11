class HomeModel {
  HomeModel({
    required this.mostSalesBooks,
    required this.freshsBooks,
    required this.poster,
  });
  late final List<MostSalesBooks> mostSalesBooks;
  late final List<FreshsBooks> freshsBooks;
  late final List<Poster> poster;

  HomeModel.fromJson(Map<String, dynamic> json) {
    mostSalesBooks = List.from(json['mostSalesBooks'])
        .map((e) => MostSalesBooks.fromJson(e))
        .toList();
    freshsBooks = List.from(json['freshsBooks'])
        .map((e) => FreshsBooks.fromJson(e))
        .toList();
    poster = List.from(json['poster']).map((e) => Poster.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['mostSalesBooks'] = mostSalesBooks.map((e) => e.toJson()).toList();
    _data['freshsBooks'] = freshsBooks.map((e) => e.toJson()).toList();
    _data['poster'] = poster.map((e) => e.toJson()).toList();
    return _data;
  }
}

class MostSalesBooks {
  MostSalesBooks({
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
  late final double voteCount;
  late final String writer;
  late final String description;
  late final String name;
  late final double price;
  late final String language;
  late final String coverType;
  late final String pictureThumb;
  late final String picture;
  late final String salesCount;
  late final String isBanner;
  late final String categoryId;

  MostSalesBooks.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cover = json['cover'] ?? "";
    pagesCount = json['pages_count'] ?? "";
    voteCount = double.parse(json['vote_count'] ?? "0");
    writer = json['writer'] ?? "";
    description = json['description'] ?? "";
    name = json['name']  ?? "";
    price = double.parse(json['price'] ?? "0");
    language = json['language'] ?? "";
    coverType = json['cover_type'] ?? "";
    pictureThumb = json['picture_thumb'] ?? "";
    picture = json['picture'] ?? "";
    salesCount = json['sales_count'] ?? "";
    isBanner = json['is_banner'] ?? "";
    categoryId = json['category_id'] ?? "";
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

class FreshsBooks {
  FreshsBooks({
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
  late final double voteCount;
  late final String writer;
  late final String description;
  late final String name;
  late final double price;
  late final String language;
  late final String coverType;
  late final String pictureThumb;
  late final String picture;
  late final String salesCount;
  late final String isBanner;
  late final String categoryId;

  FreshsBooks.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cover = json['cover'] ?? "";
    pagesCount = json['pages_count'] ?? "";
    voteCount = double.parse(json['vote_count'] ?? "0");
    writer = json['writer'] ?? "";
    description = json['description'] ?? "";
    name = json['name']  ?? "";
    price = double.parse(json['price'] ?? "0");
    language = json['language'] ?? "";
    coverType = json['cover_type'] ?? "";
    pictureThumb = json['picture_thumb'] ?? "";
    picture = json['picture'] ?? "";
    salesCount = json['sales_count'] ?? "";
    isBanner = json['is_banner'] ?? "";
    categoryId = json['category_id'] ?? "";
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

class Poster {
  Poster({
    required this.id,
    required this.picture,
    required this.name,
  });

  late final String id;
  late final String picture;
  late final String name;

  Poster.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    picture = json['picture'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};

    _data['id'] = id;
    _data['picture'] = picture;
    _data['name'] = name;
    return _data;
  }
}
