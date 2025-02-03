class InterestModel {
  String? accnoo;
  String? tdsdetdatee;
  String? tdsdeducted;
  String? interestpaid;

  InterestModel({
     this.accnoo,
     this.tdsdetdatee,
     this.tdsdeducted,
     this.interestpaid,
  });

  factory InterestModel.fromJson(Map<String, dynamic> json) {
    return InterestModel(
      accnoo: json['accnoo'],
      tdsdetdatee: json['tdsdetdatee'],
      tdsdeducted: json['tdsdeducted'],
      interestpaid: json['interestpaid'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accnoo': accnoo,
      'tdsdetdatee': tdsdetdatee,
      'tdsdeducted': tdsdeducted,
      'interestpaid': interestpaid,
    };
  }
}

class TdssetModel {
  String? accno;
  String? trddrcrr;
  String? trdamtt;
  String? trddatee;

  TdssetModel({this.accno, this.trddrcrr, this.trdamtt, this.trddatee});

  // Method to convert JSON to TdssetModel
  factory TdssetModel.fromJson(Map<String, dynamic> json) {
    return TdssetModel(
      accno: json['accno'],
      trddrcrr: json['trddrcrr'],
      trdamtt: json['trdamtt'],
      trddatee: json['trddatee'],
    );
  }

  // Method to convert TdssetModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'accno': accno,
      'trddrcrr': trddrcrr,
      'trdamtt': trdamtt,
      'trddatee': trddatee,
    };
  }
}
