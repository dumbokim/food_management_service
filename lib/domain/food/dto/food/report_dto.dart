class ReportDto {
  ReportDto({
    required this.targetId,
    required this.type,
    required this.reason,
    this.detail = '',
  });

  final int targetId;
  final String type;
  final String reason;
  final String detail;
}
