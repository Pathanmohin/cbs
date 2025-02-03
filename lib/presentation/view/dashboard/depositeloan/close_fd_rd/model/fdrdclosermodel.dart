class FatchFDCluserDetails {
  String? fdiint;
  String? fdistrsrno;
  String? fdidate;
  String? fdimdate;
  String? fdinumber;
  String? fdiseries;
  String? fdisrsrno;

  FatchFDCluserDetails({
    this.fdiint,
    this.fdistrsrno,
    this.fdidate,
    this.fdimdate,
    this.fdinumber,
    this.fdiseries,
    this.fdisrsrno,
  });

  // Factory constructor to create an instance from JSON
  factory FatchFDCluserDetails.fromJson(Map<String, dynamic> json) {
    return FatchFDCluserDetails(
      fdiint: json['fdiint'],
      fdistrsrno: json['fdistrsrno'],
      fdidate: json['fdidate'],
      fdimdate: json['fdimdate'],
      fdinumber: json['fdinumber'],
      fdiseries: json['fdiseries'],
      fdisrsrno: json['fdisrsrno'],
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'fdiint': fdiint,
      'fdistrsrno': fdistrsrno,
      'fdidate': fdidate,
      'fdimdate': fdimdate,
      'fdinumber': fdinumber,
      'fdiseries': fdiseries,
      'fdisrsrno': fdisrsrno,
    };
  }
}

class FatchFDDeatlsforClouser {
  String? roii;
  String? principalAmountt;
  String? originalMaurityValuee;
  String? totalIntAmtt;
  String? intAlreadyPaidd;
  String? restIntPayablee;
  String? tdsForPreFyy;
  String? tdsForThisFyy;
  String? intOnTdsRecovv;
  String? parkedTdsAmountt;
  String? intonParkedTdsamtt;
  String? netAmtPayablee;
  String? fdisrsrno;
  String? parkedDSAmounttt;
  String? intOnParkedTdsAmttt;
  String? intToBePaidForHolidayyy;
  String? totalIntAmttt;

  FatchFDDeatlsforClouser({
    this.roii,
    this.principalAmountt,
    this.originalMaurityValuee,
    this.totalIntAmtt,
    this.intAlreadyPaidd,
    this.restIntPayablee,
    this.tdsForPreFyy,
    this.tdsForThisFyy,
    this.intOnTdsRecovv,
    this.parkedTdsAmountt,
    this.intonParkedTdsamtt,
    this.netAmtPayablee,
    this.fdisrsrno,
    this.parkedDSAmounttt,
    this.intOnParkedTdsAmttt,
    this.intToBePaidForHolidayyy,
    this.totalIntAmttt,
  });

  // Factory constructor to create an instance from JSON
  factory FatchFDDeatlsforClouser.fromJson(Map<String, dynamic> json) {
    return FatchFDDeatlsforClouser(
      roii: json['ROIi'].toString(),
      principalAmountt: json['PrincipalAmountt'].toString(),
      originalMaurityValuee: json['OriginalMaurityValuee'].toString(),
      totalIntAmtt: json['TotalIntAmtt'].toString(),
      intAlreadyPaidd: json['IntAlreadyPaidd'].toString(),
      restIntPayablee: json['RestIntPayablee'].toString(),
      tdsForPreFyy: json['TDSForPreFYy'].toString(),
      tdsForThisFyy: json['TDSforThisFYy'].toString(),
      intOnTdsRecovv: json['IntOnTDSRecovv'].toString(),
      parkedTdsAmountt: json['ParkedTdsAmountt'].toString(),
      intonParkedTdsamtt: json['IntonParkedTDSamtt'].toString(),
      netAmtPayablee: json['NetAmtPayablee'].toString(),
      fdisrsrno: json['fdisrsrno'].toString(),
      parkedDSAmounttt: json['parkedDSAmounttt'].toString(),
      intOnParkedTdsAmttt: json['IntOnParkedTdsAmttt'].toString(),
      intToBePaidForHolidayyy: json['IntToBEPaidForHolidayyy'].toString(),
      totalIntAmttt: json['TotalIntAmttt'].toString(),
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'ROIi': roii,
      'PrincipalAmountt': principalAmountt,
      'OriginalMaurityValuee': originalMaurityValuee,
      'TotalIntAmtt': totalIntAmtt,
      'IntAlreadyPaidd': intAlreadyPaidd,
      'RestIntPayablee': restIntPayablee,
      'TDSForPreFYy': tdsForPreFyy,
      'TDSforThisFYy': tdsForThisFyy,
      'IntOnTDSRecovv': intOnTdsRecovv,
      'ParkedTdsAmountt': parkedTdsAmountt,
      'IntonParkedTDSamtt': intonParkedTdsamtt,
      'NetAmtPayablee': netAmtPayablee,
      'fdisrsrno': fdisrsrno,
      'parkedDSAmounttt': parkedDSAmounttt,
      'IntOnParkedTdsAmttt': intOnParkedTdsAmttt,
      'IntToBEPaidForHolidayyy': intToBePaidForHolidayyy,
      'TotalIntAmttt': totalIntAmttt,
    };
  }
}
