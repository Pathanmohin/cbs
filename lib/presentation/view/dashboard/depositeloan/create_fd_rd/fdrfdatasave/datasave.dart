import 'package:hpscb/presentation/view/dashboard/depositeloan/create_fd_rd/fdrdmodel/model.dart';

class FDList {
  static List<FDOpening> fdlistS = <FDOpening>[];

  static List<FDOpening> rdListS = <FDOpening>[];
}

class RelationList {
  static List<NomineeListName> nomineeEname = <NomineeListName>[];
}

class SelectedDataUser {
// Add scheme

  static String mStateNameGet = "";
  static String fdkid = "";
  static String sglcode = "";

  static String accNumberBank = "";
  static String day = "";
  static String month = "";
  static String year = "";
  static String mIntrest = "";
  static String mAmount = "";
  static String mDate = "";
  static String amountEntered = "";
  static String switchButton = "";

  // Nomainee Details page

  static String nomineeName = "";
  static String relationName = "";
  static String gender = "";
  static String DateOFBirth = "";
  static String Minor = "";

  // Rd Day Select for payment

  static String dayofMonth = "";
}

class CityData {
  static List<StateObjectList> city = <StateObjectList>[];
}

class IntRateList {
  static List<InterestRate> intListShow = <InterestRate>[];
}

class FDLoanSave {
  static String? accNo;
  static String? kid;
  static String? maxamt;
  static String? exdate;
}

class FDGetData {
  static String nomineeName = "";
  static String nomineeRealtionship = "";
  static String nomineeage = "";
  static String nomineeAddress1 = "";
  static String nomineeAddress2 = "";
  static String nomineeCity = "";
  static String nomineeState = "";
}

class RDGetData {
  static String nomineeNameRD = "";
  static String nomineeRealtionshipRD = "";
  static String nomineeageRD = "";
  static String nomineeAddress1RD = "";
  static String nomineeAddress2RD = "";
  static String nomineeCityRD = "";
  static String nomineeStateRD = "";
}
