class HomeModel {
  List<MostSalesBooks> mostSalesBooks;
  List<FreshBooks> freshsBooks;
  List<Poster> poster;

  HomeModel({this.mostSalesBooks, this.freshsBooks});

  HomeModel.fromJson(Map<String, dynamic> json) {
    if (json['mostSalesBooks'] != null) {
      mostSalesBooks = new List<MostSalesBooks>();
      json['mostSalesBooks'].forEach((v) {
        mostSalesBooks.add(new MostSalesBooks.fromJson(v));
      });
    }
    if (json['freshsBooks'] != null) {
      freshsBooks = new List<FreshBooks>();
      json['freshsBooks'].forEach((v) {
        freshsBooks.add(new FreshBooks.fromJson(v));
      });
    }
    if (json['poster'] != null) {
      poster = new List<Poster>();
      json['poster'].forEach((v) {
        poster.add(new Poster.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.mostSalesBooks != null) {
      data['mostSalesBooks'] =
          this.mostSalesBooks.map((v) => v.toJson()).toList();
    }
    if (this.freshsBooks != null) {
      data['freshsBooks'] = this.freshsBooks.map((v) => v.toJson()).toList();
    }

    if (this.poster != null) {
      data['poster'] = this.poster.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MostSalesBooks {
  String s0;
  String s1;
  String s2;
  String s3;
  String id;
  String pictureThumb;
  String name;
  String writer;
  double voteCount;
  String description;
  String language;
  String pagesCount;
  String coverType;
  String price;

  MostSalesBooks(
      {this.price,
      this.id,
      this.pictureThumb,
      this.name,
      this.writer,
      this.description,
      this.language,
      this.pagesCount,
      this.coverType,
      this.voteCount});

  MostSalesBooks.fromJson(Map<String, dynamic> json) {

    id = json['id'];
    pictureThumb = json['picture_thumb'];
    name = json['name'];
    writer = json['writer'];
    description = json['description'];
    language = json['language'];
    voteCount = double.tryParse(json['vote_count']);
    pagesCount = json['pages_count'];
    coverType = json['cover_type'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['id'] = this.id;
    data['picture_thumb'] = this.pictureThumb;
    data['name'] = this.name;
    data['writer'] = this.writer;
    data['vote_count'] = this.voteCount;
    data['price'] = this.price;
    return data;
  }
}

class FreshBooks {
  String id;
  String pictureThumb;
  String name;
  String writer;
  double voteCount;
  String description;
  String language;
  String pagesCount;
  String coverType;
  String price;

  FreshBooks(
      {this.id,
      this.pictureThumb,
      this.name,
      this.writer,
      this.voteCount,
      this.language,
      this.description,
      this.coverType,
      this.pagesCount,
      this.price
      });

  FreshBooks.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pictureThumb = json['picture_thumb'];
    name = json['name'];
    writer = json['writer'];
    description = json['description'];
    language = json['language'];
    pagesCount = json['pages_count'];
    coverType = json['cover_type'];
    voteCount = double.tryParse(json['vote_count']);
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['id'] = this.id;
    data['picture_thumb'] = this.pictureThumb;
    data['name'] = this.name;
    data['writer'] = this.writer;
    data['vote_count'] = this.voteCount;
    data['price'] = this.price;
    return data;
  }
}

class Poster {
  String id;
  String picture;
  String name;

  Poster({this.id, this.picture, this.name});

  Poster.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    picture = json['picture'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['id'] = this.id;
    data['picture_thumb'] = this.picture;
    data['name'] = this.name;
    return data;
  }
}
