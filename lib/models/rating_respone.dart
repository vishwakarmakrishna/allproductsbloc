// This file is "main.dart"
import 'package:freezed_annotation/freezed_annotation.dart';

part 'rating_respone.freezed.dart';
part 'rating_respone.g.dart';

@freezed
class Rating with _$Rating {
  const factory Rating({
    required int count,
    required double rate,
  }) = _Rating;

  factory Rating.fromJson(Map<String, Object?> json) => _$RatingFromJson(json);
}
