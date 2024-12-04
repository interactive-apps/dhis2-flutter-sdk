class LatestVersionResponse {
  LatestVersionResponse({
    required this.status,
    required this.validationReport,
    required this.stats,
    required this.bundleReport,
  });

  final String? status;
  final ValidationReport? validationReport;
  final Stats? stats;
  final BundleReport? bundleReport;

  factory LatestVersionResponse.fromJson(Map<String, dynamic> json) {
    return LatestVersionResponse(
      status: json["status"],
      validationReport: json["validationReport"] == null
          ? null
          : ValidationReport.fromJson(json["validationReport"]),
      stats: json["stats"] == null ? null : Stats.fromJson(json["stats"]),
      bundleReport: json["bundleReport"] == null
          ? null
          : BundleReport.fromJson(json["bundleReport"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "validationReport": validationReport?.toJson(),
        "stats": stats?.toJson(),
        "bundleReport": bundleReport?.toJson(),
      };
}

class BundleReport {
  BundleReport({
    required this.status,
    required this.typeReportMap,
    required this.stats,
  });

  final String? status;
  final TypeReportMap? typeReportMap;
  final Stats? stats;

  factory BundleReport.fromJson(Map<String, dynamic> json) {
    return BundleReport(
      status: json["status"],
      typeReportMap: json["typeReportMap"] == null
          ? null
          : TypeReportMap.fromJson(json["typeReportMap"]),
      stats: json["stats"] == null ? null : Stats.fromJson(json["stats"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "typeReportMap": typeReportMap?.toJson(),
        "stats": stats?.toJson(),
      };
}

class Stats {
  Stats({
    required this.created,
    required this.updated,
    required this.deleted,
    required this.ignored,
    required this.total,
  });

  final int? created;
  final int? updated;
  final int? deleted;
  final int? ignored;
  final int? total;

  factory Stats.fromJson(Map<String, dynamic> json) {
    return Stats(
      created: json["created"],
      updated: json["updated"],
      deleted: json["deleted"],
      ignored: json["ignored"],
      total: json["total"],
    );
  }

  Map<String, dynamic> toJson() => {
        "created": created,
        "updated": updated,
        "deleted": deleted,
        "ignored": ignored,
        "total": total,
      };
}

class TypeReportMap {
  TypeReportMap({
    required this.relationship,
    required this.trackedEntity,
    required this.enrollment,
    required this.event,
  });

  final Enrollment? relationship;
  final Enrollment? trackedEntity;
  final Enrollment? enrollment;
  final Enrollment? event;

  factory TypeReportMap.fromJson(Map<String, dynamic> json) {
    return TypeReportMap(
      relationship: json["RELATIONSHIP"] == null
          ? null
          : Enrollment.fromJson(json["RELATIONSHIP"]),
      trackedEntity: json["TRACKED_ENTITY"] == null
          ? null
          : Enrollment.fromJson(json["TRACKED_ENTITY"]),
      enrollment: json["ENROLLMENT"] == null
          ? null
          : Enrollment.fromJson(json["ENROLLMENT"]),
      event: json["EVENT"] == null ? null : Enrollment.fromJson(json["EVENT"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "RELATIONSHIP": relationship?.toJson(),
        "TRACKED_ENTITY": trackedEntity?.toJson(),
        "ENROLLMENT": enrollment?.toJson(),
        "EVENT": event?.toJson(),
      };
}

class Enrollment {
  Enrollment({
    required this.trackerType,
    required this.stats,
    required this.objectReports,
  });

  final String? trackerType;
  final Stats? stats;
  final List<ObjectReport> objectReports;

  factory Enrollment.fromJson(Map<String, dynamic> json) {
    return Enrollment(
      trackerType: json["trackerType"],
      stats: json["stats"] == null ? null : Stats.fromJson(json["stats"]),
      objectReports: json["objectReports"] == null
          ? []
          : List<ObjectReport>.from(
              json["objectReports"]!.map((x) => ObjectReport.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "trackerType": trackerType,
        "stats": stats?.toJson(),
        "objectReports": objectReports.map((x) => x.toJson()).toList(),
      };
}

class ObjectReport {
  ObjectReport({
    required this.trackerType,
    required this.uid,
    required this.index,
    required this.errorReports,
  });

  final String? trackerType;
  final String? uid;
  final int? index;
  final List<dynamic> errorReports;

  factory ObjectReport.fromJson(Map<String, dynamic> json) {
    return ObjectReport(
      trackerType: json["trackerType"],
      uid: json["uid"],
      index: json["index"],
      errorReports: json["errorReports"] == null
          ? []
          : List<dynamic>.from(json["errorReports"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
        "trackerType": trackerType,
        "uid": uid,
        "index": index,
        "errorReports": errorReports.map((x) => x).toList(),
      };
}

class ValidationReport {
  ValidationReport({
    required this.errorReports,
    required this.warningReports,
  });

  final List<dynamic> errorReports;
  final List<dynamic> warningReports;

  factory ValidationReport.fromJson(Map<String, dynamic> json) {
    return ValidationReport(
      errorReports: json["errorReports"] == null
          ? []
          : List<dynamic>.from(json["errorReports"]!.map((x) => x)),
      warningReports: json["warningReports"] == null
          ? []
          : List<dynamic>.from(json["warningReports"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
        "errorReports": errorReports.map((x) => x).toList(),
        "warningReports": warningReports.map((x) => x).toList(),
      };
}
