class LienData {
  String? schcode;
  String? accountnumber;
  String? fdnumber;
  String? fddate;
  String? fdamount;
  String? fdmddate;
  String? fdmaturityamount;
  String? lienlastdate;
  String? lienenterydate;
  String? schemename;
  String? fdistrnumber;
  String? accountname;
  String? accounholdername;
  String? actname;
  String? schemeholdername;
  String? loanholdername;
  String? loanhead;
  String? fdinterestrate;
  String? acthname;
  String? loanaccountnumber;
  String? lienmark;

  LienData({
    this.schcode,
    this.accountnumber,
    this.fdnumber,
    this.fddate,
    this.fdamount,
    this.fdmddate,
    this.fdmaturityamount,
    this.lienlastdate,
    this.lienenterydate,
    this.schemename,
    this.fdistrnumber,
    this.accountname,
    this.accounholdername,
    this.actname,
    this.schemeholdername,
    this.loanholdername,
    this.loanhead,
    this.fdinterestrate,
    this.acthname,
    this.loanaccountnumber,
    this.lienmark,
  });

  // You can add methods like fromJson, toJson, etc. if needed
}


class FdReceipt {
  String? schcode;
  String?fdistrsrno;
  String? fdiseries;
  String? fdidate;
  String? fdiamount;
  String? fdiintpaid;
  String? fditdsamt;
  String? fdimdate;
  String? fdiint;
  String? fdimamount;
  String? prism;

  FdReceipt({
     this.schcode,
     this.fdistrsrno,
     this.fdiseries,
     this.fdidate,
     this.fdiamount,
     this.fdiintpaid,
     this.fditdsamt,
     this.fdimdate,
     this.fdiint,
     this.fdimamount,
     this.prism,
  });

  // Optionally, you can add a method to create an FdReceipt object from a JSON object
  factory FdReceipt.fromJson(Map<String, dynamic> json) {
    return FdReceipt(
      schcode: json['schcode'],
      fdistrsrno: json['fdistrsrno'],
      fdiseries: json['fdiseries'],
      fdidate: json['fdidate'],
      fdiamount: json['fdiamount'],
      fdiintpaid: json['fdiintpaid'],
      fditdsamt: json['fditdsamt'],
      fdimdate: json['fdimdate'],
      fdiint: json['fdiint'],
      fdimamount: json['fdimamount'],
      prism: json['prism'],
    );
  }

  // Optionally, you can add a method to convert an FdReceipt object to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'schcode': schcode,
      'fdistrsrno': fdistrsrno,
      'fdiseries': fdiseries,
      'fdidate': fdidate,
      'fdiamount': fdiamount,
      'fdiintpaid': fdiintpaid,
      'fditdsamt': fditdsamt,
      'fdimdate': fdimdate,
      'fdiint': fdiint,
      'fdimamount': fdimamount,
      'prism': prism,
    };
  }
}

