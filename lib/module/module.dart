class Default {
  String? url;
  int? width;
  int? height;

  Default({this.url, this.width, this.height});

  Default.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    width = json['width'];
    height = json['height'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['url'] = url;
    data['width'] = width;
    data['height'] = height;
    return data;
  }
}

class High {
  String? url;
  int? width;
  int? height;

  High({this.url, this.width, this.height});

  High.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    width = json['width'];
    height = json['height'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['url'] = url;
    data['width'] = width;
    data['height'] = height;
    return data;
  }
}

class Item {
  String? kind;
  String? etag;
  String? id;
  Snippet? snippet;

  Item({this.kind, this.etag, this.id, this.snippet});

  Item.fromJson(Map<String, dynamic> json) {
    kind = json['kind'];
    etag = json['etag'];
    id = json['id'];
    snippet =
        json['snippet'] != null ? Snippet?.fromJson(json['snippet']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['kind'] = kind;
    data['etag'] = etag;
    data['id'] = id;
    data['snippet'] = snippet!.toJson();
    return data;
  }
}

class Maxres {
  String? url;
  int? width;
  int? height;

  Maxres({this.url, this.width, this.height});

  Maxres.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    width = json['width'];
    height = json['height'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['url'] = url;
    data['width'] = width;
    data['height'] = height;
    return data;
  }
}

class Medium {
  String? url;
  int? width;
  int? height;

  Medium({this.url, this.width, this.height});

  Medium.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    width = json['width'];
    height = json['height'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['url'] = url;
    data['width'] = width;
    data['height'] = height;
    return data;
  }
}

class PageInfo {
  int? totalResults;
  int? resultsPerPage;

  PageInfo({this.totalResults, this.resultsPerPage});

  PageInfo.fromJson(Map<String, dynamic> json) {
    totalResults = json['totalResults'];
    resultsPerPage = json['resultsPerPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['totalResults'] = totalResults;
    data['resultsPerPage'] = resultsPerPage;
    return data;
  }
}

class ResourceId {
  String? kind;
  String? videoId;

  ResourceId({this.kind, this.videoId});

  ResourceId.fromJson(Map<String, dynamic> json) {
    kind = json['kind'];
    videoId = json['videoId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['kind'] = kind;
    data['videoId'] = videoId;
    return data;
  }
}

class Root {
  String? kind;
  String? etag;
  List<Item?>? items;
  PageInfo? pageInfo;

  Root({this.kind, this.etag, this.items, this.pageInfo});

  Root.fromJson(Map<String, dynamic> json) {
    kind = json['kind'];
    etag = json['etag'];
    if (json['items'] != null) {
      items = <Item>[];
      json['items'].forEach((v) {
        items!.add(Item.fromJson(v));
      });
    }
    pageInfo =
        json['pageInfo'] != null ? PageInfo?.fromJson(json['pageInfo']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['kind'] = kind;
    data['etag'] = etag;
    data['items'] =
        items != null ? items!.map((v) => v?.toJson()).toList() : null;
    data['pageInfo'] = pageInfo!.toJson();
    return data;
  }
}

class Snippet {
  DateTime? publishedAt;
  String? channelId;
  String? title;
  String? description;
  Thumbnails? thumbnails;
  String? channelTitle;
  String? playlistId;
  int? position;
  ResourceId? resourceId;
  String? videoOwnerChannelTitle;
  String? videoOwnerChannelId;

  Snippet(
      {this.publishedAt,
      this.channelId,
      this.title,
      this.description,
      this.thumbnails,
      this.channelTitle,
      this.playlistId,
      this.position,
      this.resourceId,
      this.videoOwnerChannelTitle,
      this.videoOwnerChannelId});

  Snippet.fromJson(Map<String, dynamic> json) {
    publishedAt = json['publishedAt'];
    channelId = json['channelId'];
    title = json['title'];
    description = json['description'];
    thumbnails = json['thumbnails'] != null
        ? Thumbnails?.fromJson(json['thumbnails'])
        : null;
    channelTitle = json['channelTitle'];
    playlistId = json['playlistId'];
    position = json['position'];
    resourceId = json['resourceId'] != null
        ? ResourceId?.fromJson(json['resourceId'])
        : null;
    videoOwnerChannelTitle = json['videoOwnerChannelTitle'];
    videoOwnerChannelId = json['videoOwnerChannelId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['publishedAt'] = publishedAt;
    data['channelId'] = channelId;
    data['title'] = title;
    data['description'] = description;
    data['thumbnails'] = thumbnails!.toJson();
    data['channelTitle'] = channelTitle;
    data['playlistId'] = playlistId;
    data['position'] = position;
    data['resourceId'] = resourceId!.toJson();
    data['videoOwnerChannelTitle'] = videoOwnerChannelTitle;
    data['videoOwnerChannelId'] = videoOwnerChannelId;
    return data;
  }
}

class Standard {
  String? url;
  int? width;
  int? height;

  Standard({this.url, this.width, this.height});

  Standard.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    width = json['width'];
    height = json['height'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['url'] = url;
    data['width'] = width;
    data['height'] = height;
    return data;
  }
}

class Thumbnails {
  Default? def;
  Medium? medium;
  High? high;
  Standard? standard;
  Maxres? maxres;

  Thumbnails({this.def, this.medium, this.high, this.standard, this.maxres});

  Thumbnails.fromJson(Map<String, dynamic> json) {
    def = json['default'] != null ? Default?.fromJson(json['default']) : null;
    medium = json['medium'] != null ? Medium?.fromJson(json['medium']) : null;
    high = json['high'] != null ? High?.fromJson(json['high']) : null;
    standard =
        json['standard'] != null ? Standard?.fromJson(json['standard']) : null;
    maxres = json['maxres'] != null ? Maxres?.fromJson(json['maxres']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['default'] = def!.toJson();
    data['medium'] = medium!.toJson();
    data['high'] = high!.toJson();
    data['standard'] = standard!.toJson();
    data['maxres'] = maxres!.toJson();
    return data;
  }
}
