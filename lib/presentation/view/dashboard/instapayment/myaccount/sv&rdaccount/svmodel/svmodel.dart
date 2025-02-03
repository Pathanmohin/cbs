import 'dart:ui';

class SVModel{
    static String accNumber = "";
    static String accBalance = "";
    static String title = "";
}

class MiniStatementData {
  String? curbalance;
  String? narration;
  String? trAccID;
  String? trdAmt;
  String? trdDate;
  String? trdDrCr;
  String? textcolour;
  String? INR;
  String? PaidBy;
  String? dClosingBalace;
  String? trddate;
  String? drCr;
  String? tdsdetdate;
  String? interestPaid;
  String? fdAmt;
  String? tdsdetroi;
  String? description;
  String? drcr;
  String? trdamt;
  String? sename;
  String? dtdate;
  String? seact;
  String? interest;
  String? scCharge;
  String? scAmount;
  String? faqQue;
  bool? isExpand;
  String? faqAns;
  Color? color;
  MiniStatementData({
    this.curbalance,
    this.narration,
    this.trAccID,
    this.trdAmt,
    this.trdDate,
    this.trdDrCr,
    this.textcolour,
    this.INR,
    this.PaidBy,
    this.dClosingBalace,
    this.trddate,
    this.drCr,
    this.tdsdetdate,
    this.interestPaid,
    this.fdAmt,
    this.tdsdetroi,
    this.description,
    this.drcr,
    this.trdamt,
    this.sename,
    this.dtdate,
    this.seact,
    this.interest,
    this.scCharge,
    this.scAmount,
    this.faqQue,
    this.isExpand,
    this.faqAns,
    this.color
  });

  factory MiniStatementData.fromJson(Map<String, dynamic> json) {
    return MiniStatementData(
      curbalance: json['curbalance'],
      narration: json['narration'],
      trAccID: json['trAccID'],
      trdAmt: json['trdAmt'],
      trdDate: json['trdDate'],
      trdDrCr: json['trdDrCr'],
      textcolour: json['textcolour'],
      INR: json['INR'],
      PaidBy: json['PaidBy'],
      dClosingBalace: json['dClosingBalace'],
      trddate: json['trddate'],
      drCr: json['drCr'],
      tdsdetdate: json['tdsdetdate'],
      interestPaid: json['interestPaid'],
      fdAmt: json['fdAmt'],
      tdsdetroi: json['tdsdetroi'],
      description: json['description'],
      drcr: json['drcr'],
      trdamt: json['trdamt'],
      sename: json['sename'],
      dtdate: json['dtdate'],
      seact: json['seact'],
      interest: json['interest'],
      scCharge: json['scCharge'],
      scAmount: json['scAmount'],
      faqQue: json['faqQue'],
      isExpand: json['isExpand'],
      faqAns: json['faqAns'],
      color:json['color']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'curbalance': curbalance,
      'narration': narration,
      'trAccID': trAccID,
      'trdAmt': trdAmt,
      'trdDate': trdDate,
      'trdDrCr': trdDrCr,
      'textcolour': textcolour,
      'INR': INR,
      'PaidBy': PaidBy,
      'dClosingBalace': dClosingBalace,
      'trddate': trddate,
      'drCr': drCr,
      'tdsdetdate': tdsdetdate,
      'interestPaid': interestPaid,
      'fdAmt': fdAmt,
      'tdsdetroi': tdsdetroi,
      'description': description,
      'drcr': drcr,
      'trdamt': trdamt,
      'sename': sename,
      'dtdate': dtdate,
      'seact': seact,
      'interest': interest,
      'scCharge': scCharge,
      'scAmount': scAmount,
      'faqQue': faqQue,
      'isExpand': isExpand,
      'faqAns': faqAns,
      'color':color,
    };
  }
}


class MiniDataList {

  static  List<MiniStatementData> dataShowList = <MiniStatementData>[];

}


class FinalDetailsStatement {
  String? curbalance;
  String? narration;
  String? trAccID;
  String? trdAmt;
  String? trdDate;
  String? trdDrCr;
  String? textcolour;
  String? INR;
  String? PaidBy;
  String? dClosingBalace;
  String? trddate;
  String? drCr;
  String? tdsdetdate;
  String? interestPaid;
  String? fdAmt;
  String? tdsdetroi;
  String? description;
  String? drcr;
  String? trdamt;
  String? sename;
  String? dtdate;
  String? seact;
  String? interest;
  String? scCharge;
  String? scAmount;
  String? faqQue;
  bool? isExpand;
  String? faqAns;
  Color? color;
  FinalDetailsStatement({
    this.curbalance,
    this.narration,
    this.trAccID,
    this.trdAmt,
    this.trdDate,
    this.trdDrCr,
    this.textcolour,
    this.INR,
    this.PaidBy,
    this.dClosingBalace,
    this.trddate,
    this.drCr,
    this.tdsdetdate,
    this.interestPaid,
    this.fdAmt,
    this.tdsdetroi,
    this.description,
    this.drcr,
    this.trdamt,
    this.sename,
    this.dtdate,
    this.seact,
    this.interest,
    this.scCharge,
    this.scAmount,
    this.faqQue,
    this.isExpand,
    this.faqAns,
    this.color
  });

  factory FinalDetailsStatement.fromJson(Map<String, dynamic> json) {
    return FinalDetailsStatement(
      curbalance: json['curbalance'],
      narration: json['narration'],
      trAccID: json['trAccID'],
      trdAmt: json['trdAmt'],
      trdDate: json['trdDate'],
      trdDrCr: json['trdDrCr'],
      textcolour: json['textcolour'],
      INR: json['INR'],
      PaidBy: json['PaidBy'],
      dClosingBalace: json['dClosingBalace'],
      trddate: json['trddate'],
      drCr: json['drCr'],
      tdsdetdate: json['tdsdetdate'],
      interestPaid: json['interestPaid'],
      fdAmt: json['fdAmt'],
      tdsdetroi: json['tdsdetroi'],
      description: json['description'],
      drcr: json['drcr'],
      trdamt: json['trdamt'],
      sename: json['sename'],
      dtdate: json['dtdate'],
      seact: json['seact'],
      interest: json['interest'],
      scCharge: json['scCharge'],
      scAmount: json['scAmount'],
      faqQue: json['faqQue'],
      isExpand: json['isExpand'],
      faqAns: json['faqAns'],
      color:json['color']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'curbalance': curbalance,
      'narration': narration,
      'trAccID': trAccID,
      'trdAmt': trdAmt,
      'trdDate': trdDate,
      'trdDrCr': trdDrCr,
      'textcolour': textcolour,
      'INR': INR,
      'PaidBy': PaidBy,
      'dClosingBalace': dClosingBalace,
      'trddate': trddate,
      'drCr': drCr,
      'tdsdetdate': tdsdetdate,
      'interestPaid': interestPaid,
      'fdAmt': fdAmt,
      'tdsdetroi': tdsdetroi,
      'description': description,
      'drcr': drcr,
      'trdamt': trdamt,
      'sename': sename,
      'dtdate': dtdate,
      'seact': seact,
      'interest': interest,
      'scCharge': scCharge,
      'scAmount': scAmount,
      'faqQue': faqQue,
      'isExpand': isExpand,
      'faqAns': faqAns,
      'color':color,
    };
  }
}
