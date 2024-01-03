class BaseResponse {
  BaseResponse({
    this.status,
    this.code,
    this.data,
    this.message,
    this.error,
  });

  int? status;
  int? code;
  dynamic data;
  String? message;
  String? error;

  ///This is to verify whether the response is success or failure.
  bool get success => status == 0 ? false : true;

  factory BaseResponse.fromJson(Map<String, dynamic> json) => BaseResponse(
        status: json["status"],
        code: json["code"],
        data: json["data"],
        message: json["message"],
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "data": data.toJson(),
        "message": message,
        "error": error,
      };
}

class ArticleBaseResponse {
  ArticleBaseResponse({this.status, this.totalResults, this.articles});

  String? status;
  int? totalResults;
  List? articles;

  ///This is to verify whether the response is success or failure.
  bool get success => status == 'ok' ? false : true;

  factory ArticleBaseResponse.fromJson(Map<String, dynamic> json) =>
      ArticleBaseResponse(
          status: json["status"],
          totalResults: json["totalResults"],
          articles: json["articles"]);

  Map<String, dynamic> toJson() => {
        "status": status,
        "totalResults": totalResults,
        "articles": articles!
      };
}

// META RESPONSE ACCORDING TO LEVERAGE APPLICATION

// import 'package:leverage_ielts/models/community_model.dart';

//RESPONSE TYPE 1 [META, TOKEN AND DATA]--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

// ignore: slash_for_doc_comments
/** 
class BaseResponse {
  Meta? meta;
  dynamic data;

  String? token;

  ///This is to verify whether the response is success or failure.
  bool get success => meta?.status == true;

  BaseResponse({this.meta, this.data, this.token});

  BaseResponse.fromJson(Map<String, dynamic> json) {
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
    data = json['Data'] ?? json['data'];
    token = json['Token'] != null ? json['Token'].toString() : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    data['Data'] = this.data;
    if (token != null) {
      data['Token'] = token!;
    }
    return data;
  }
}
*/

//RESPONSE TYPE 2 [META AND DATA--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
class BaseResponseCommunity {
  Meta? meta;
  dynamic data;

  bool get success => meta?.status == true;

  BaseResponseCommunity({
    this.meta,
    this.data,
  });

  BaseResponseCommunity.fromJson(Map<String, dynamic> json) {
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    data['data'] = this.data;
    return data;
  }
}

//RESPONSE TYPE 3 [META AND DATA OF CommunityModel TYPE--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

// ignore: slash_for_doc_comments
/** 
class CommunityResponse {
  Meta? meta;
  CommunityModel? data;

  CommunityResponse({this.meta, this.data});

  bool get success => meta?.status == true;

  CommunityResponse.fromJson(Map<String, dynamic> json) {
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
    if (meta!.code == 200) {
      data =
          json['data'] != null ? CommunityModel.fromJson(json['data']) : null;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (meta != null) {
      data['meta'] = meta?.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data?.toJson();
    }
    return data;
  }
}
*/

//RESPONSE TYPE 3 -------------------------------------------------------------------------------------------]-------------------------------------------------------------------------------------------

class Meta {
  bool? status;
  String? message;
  int? code;
  int? totalPages;
  int? postStatus;

  Meta({this.status, this.message, this.code});

  Meta.fromJson(Map<String, dynamic> json) {
    status = json['Status'] ?? json['status'];
    message = json['Message'] ?? json['message'];
    code = json['code'];
    totalPages = json['totalPages'] ?? 0;
    postStatus = json['post_status'] ?? 1;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Status'] = status;
    data['Message'] = message;
    data['code'] = code;
    data['totalPages'] = totalPages ?? 0;
    data['post_status'] = postStatus ?? 1;
    return data;
  }
}


//Model is defined in model class , these lines of code is here just for the explanation

// class CommunityModel {
//   int? communityId;
//   String? communityName;
//   String? communityDescription;
//   int? parentCommunity;
//   String? createdAt;
//   String? updatedAt;
//   int? status;
//   int? member_count;
//   String? members_string;
//   String? createdBy;
//   String? updatedBy;
//   List<Post>? communityPosts;

//   CommunityModel(
//       {this.communityId,
//       this.communityName,
//       this.communityDescription,
//       this.parentCommunity,
//       this.createdAt,
//       this.updatedAt,
//       this.status,
//       this.member_count,
//       this.members_string,
//       this.createdBy,
//       this.updatedBy,
//       this.communityPosts});

//   List<Post>? get getPosts {
//     return communityPosts;
//   }

//   CommunityModel.fromJson(Map<String, dynamic> json) {
//     communityId = json['community_id'];
//     communityName = json['community_name'];
//     communityDescription = json['community_description'];
//     parentCommunity = json['parent_community'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     status = json['status'];
//     if (json['community_posts'] != null) {
//       communityPosts = <Post>[];
//       json['community_posts'].forEach((v) {
//         communityPosts?.add(Post.fromJson(v));
//       });
//     }
//   }

//   fromJson(Map<String, dynamic> json) {
//     communityId = json['community_id'];
//     communityName = json['community_name'];
//     communityDescription = json['community_description'];
//     parentCommunity = json['parent_community'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     status = json['status'];
//     if (json['community_posts'] != null) {
//       communityPosts = <Post>[];
//       json['community_posts'].forEach((v) {
//         communityPosts?.add(Post.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     data['community_id'] = this.communityId;
//     data['community_name'] = this.communityName;
//     data['community_description'] = this.communityDescription;
//     data['parent_community'] = this.parentCommunity;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     data['status'] = this.status;
//     if (this.communityPosts != null) {
//       data['community_posts'] =
//           this.communityPosts?.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
