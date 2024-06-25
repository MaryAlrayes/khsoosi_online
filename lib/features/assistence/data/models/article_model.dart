// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:khosousi_online/core/utils/enums/enums.dart';
import 'package:khosousi_online/features/assistence/domain/entities/article_entity.dart';

class ArticleModel extends ArticleEntity {

  ArticleModel({
    required super.id,
    required super.type,
    required super.title,
    required super.details,
  });
  factory ArticleModel.fromJson(Map<String, dynamic> map) {
    return ArticleModel(
      id: map['Id'] as String,
      type: map['Type']=='0'?FAQUserType.student:map['Type']=='1'?FAQUserType.teacher:FAQUserType.both,
      title: map['Title'] as String,
      details: map['Details'] as String,
    );
  }
}
