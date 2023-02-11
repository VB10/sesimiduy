import 'package:json_annotation/json_annotation.dart';

part 'want_help_migrate.g.dart';

@JsonSerializable()
class WantHelpMigrate {
  WantHelpMigrate({
    this.itemId,
    this.wantHelpId,
  });
  final int count = 1;
  final String? itemId;
  final String? wantHelpId;

  Map<String, dynamic> tojson() => _$WantHelpMigrateToJson(this);
}
