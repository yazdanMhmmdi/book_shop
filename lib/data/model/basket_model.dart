class BasketModel {
  List<Basket> basket;
  Data data;

  BasketModel({this.basket, this.data});

  BasketModel.fromJson(Map<String, dynamic> json) {
    if (json['basket'] != null) {
      basket = new List<Basket>();
      json['basket'].forEach((v) {
        basket.add(new Basket.fromJson(v));
      });
    }
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.basket != null) {
      data['basket'] = this.basket.map((v) => v.toJson()).toList();
    }
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Basket {
 
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
  String categoryId;

  Basket(
      {
      this.id,
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
      this.isBanner,
      this.categoryId});

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
    data['category_id'] = this.categoryId;
    return data;
  }
}

class Data {
  int totalPages;
  String currentPage;
  int offsetPage;
  String taxPercent;
  int tax;
  int deliveryCost;
  int fullCost;

  Data(
      {this.totalPages,
      this.currentPage,
      this.offsetPage,
      this.taxPercent,
      this.tax,
      this.deliveryCost,
      this.fullCost});

  Data.fromJson(Map<String, dynamic> json) {
    totalPages = json['total_pages'];
    currentPage = json['current_page'];
    offsetPage = json['offset_page'];
    taxPercent = json['tax_percent'];
    tax = json['tax'];
    deliveryCost = json['delivery_cost'];
    fullCost = json['full_cost'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_pages'] = this.totalPages;
    data['current_page'] = this.currentPage;
    data['offset_page'] = this.offsetPage;
    data['tax_percent'] = this.taxPercent;
    data['tax'] = this.tax;
    data['delivery_cost'] = this.deliveryCost;
    data['full_cost'] = this.fullCost;
    return data;
  }
}
