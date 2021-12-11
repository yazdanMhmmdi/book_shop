class BasketModel {
  BasketModel({
    required this.basket,
    required this.data,
  });
  late final List<Basket> basket;
  late final Data data;

  BasketModel.fromJson(Map<String, dynamic> json) {
    basket = List.from(json['basket']).map((e) => Basket.fromJson(e)).toList();
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['basket'] = basket.map((e) => e.toJson()).toList();
    _data['data'] = data.toJson();
    return _data;
  }
}

class Basket {
  Basket({
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

  Basket.fromJson(Map<String, dynamic> json) {
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

class Data {
  Data({
    required this.totalPages,
    required this.currentPage,
    required this.offsetPage,
    required this.taxPercent,
    required this.tax,
    required this.deliveryCost,
    required this.fullCost,
  });
  late final int totalPages;
  late final String currentPage;
  late final int offsetPage;
  late final String taxPercent;
  late final int tax;
  late final int deliveryCost;
  late final int fullCost;

  Data.fromJson(Map<String, dynamic> json) {
    totalPages = json['total_pages'] ?? 0;
    currentPage = json['current_page'] ?? "0";
    offsetPage = json['offset_page'] ?? 0;
    taxPercent = json['tax_percent'] ?? "0";
    tax = json['tax'] ?? 0;
    deliveryCost = json['delivery_cost'] ?? 0;
    fullCost = json['full_cost'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['total_pages'] = totalPages;
    _data['current_page'] = currentPage;
    _data['offset_page'] = offsetPage;
    _data['tax_percent'] = taxPercent;
    _data['tax'] = tax;
    _data['delivery_cost'] = deliveryCost;
    _data['full_cost'] = fullCost;
    return _data;
  }
}
