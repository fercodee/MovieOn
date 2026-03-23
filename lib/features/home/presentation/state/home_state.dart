import 'package:equatable/equatable.dart';

import 'package:move_on/features/shared/domain/media_item.dart';
import 'package:move_on/features/shared/domain/media_type.dart';

class HomeState extends Equatable {
  const HomeState({
    required this.selectedType,
    required this.query,
    required this.items,
  });

  final MediaType selectedType;
  final String query;
  final List<MediaItem> items;

  bool get isSearching => query.trim().isNotEmpty;

  HomeState copyWith({
    MediaType? selectedType,
    String? query,
    List<MediaItem>? items,
  }) {
    return HomeState(
      selectedType: selectedType ?? this.selectedType,
      query: query ?? this.query,
      items: items ?? this.items,
    );
  }

  @override
  List<Object?> get props => [selectedType, query, items];
}
