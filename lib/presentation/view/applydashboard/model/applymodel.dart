

class AccountDetails {
   int? id;
   String? headname;
   String? shortDetails;
   String? details;
   String? requirement;
   String? eligibility;
   String? subhead;
   String? flag;

  AccountDetails({
     this.id,
     this.headname,
     this.shortDetails,
     this.details,
     this.requirement,
     this.eligibility,
     this.subhead,
     this.flag,
  });

  factory AccountDetails.fromJson(Map<String, dynamic> json) {
    return AccountDetails(
      id: json['accdetails_kid'] as int,
      headname: json['headname'] as String,
      shortDetails: json['shortDetails'] as String,
      details: json['details'] as String,
      requirement: json['requirement'] as String,
      eligibility: json['eligibility'] as String,
      subhead: json['subhead'] as String,
      flag: json['flag'] as String,
    );
  }
}


class AccountDetailsSub {
   int? id;
   String? headname;
   String? shortDetails;
   String? details;
   String? requirement;
   String? eligibility;
   String? subhead;
   String? flag;

  AccountDetailsSub({
     this.id,
     this.headname,
     this.shortDetails,
     this.details,
     this.requirement,
     this.eligibility,
     this.subhead,
     this.flag,
  });

  factory AccountDetailsSub.fromJson(Map<String, dynamic> json) {
    return AccountDetailsSub(
      id: json['accdetails_kid'] as int,
      headname: json['headname'] as String,
      shortDetails: json['shortDetails'] as String,
      details: json['details'] as String,
      requirement: json['requirement'] as String,
      eligibility: json['eligibility'] as String,
      subhead: json['subhead'] as String,
      flag: json['flag'] as String,
    );
  }
}



class AccountDetailsFirst {
   int? mbacctypekid;
   String? mbacctypename;
   String? mbdetail;

  AccountDetailsFirst({
     this.mbacctypekid,
     this.mbacctypename,
     this.mbdetail,

  });

  factory AccountDetailsFirst.fromJson(Map<String, dynamic> json) {
    return AccountDetailsFirst(
      mbacctypekid: json['mbacctypekid'] as int,
      mbacctypename: json['mbacctypename'] as String,
      mbdetail: json['mbdetail'] as String,

    );
  }
}
