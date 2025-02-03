class LoanDetails {
  String? loanname;
  String? act_code;

  String? act_atptype;

  String? ltype_remark;

  LoanDetails({
    this.loanname,
    this.act_code,
    this.act_atptype,
    this.ltype_remark,

  });

  // Factory constructor to create an instance from JSON
  factory LoanDetails.fromJson(Map<String, dynamic> json) {
    return LoanDetails(
      loanname: json['loanname'],
      act_code: json['act_code'],
      act_atptype: json['act_atptype'],
      ltype_remark: json['ltype_remark'],
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'loanname': loanname,
      'act_code': act_code,
      'act_atptype': act_atptype,
      'ltype_remark': ltype_remark,
    };
  }
}