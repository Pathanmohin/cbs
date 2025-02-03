import 'dart:core';

class AppVer {
  static String versionName = "26";
  static String appversion = "3.5";
}

class ServerDetails {
  // serverIP -----------------------------------------------------------------------------------------------

  static String serverIP = "192.168.1.113"; // for testing server url
  // //static String serverIP =
  //     "netbanking.hpscb.com"; // live server url - for upload
  // String serverIP = "dev.nscspl.in"; // live server url
  //static String serverIP = "183.83.177.224"; // Public ip boos
  //String serverIP = "netbanking.hpscb.com"; // for testing server url
  //String serverIP = "115.243.80.217"; // for hpscb server url by suresh sir UAT SHIMLA
  // String serverIP = "115.243.80.221"; // for hpscb server url by suresh sir Live SHIMLA
  // String serverIP = "122.160.11.12"; // for testing server url
  //      String serverIP = "117.239.0.73"; // UAT_MB_Internet_IP
  // String serverIP = "10.1.13.251"; // _Internet_IP
  // static String serverIP = "136.233.47.196"; //-- S.Test
  //String serverIP = '183.83.177.224'; //New S.Test (Live run test)
  // String serverIP = '183.83.177.224'; //New S.Test (Live run test)

//---------------------------------------------------------------------------------------------------------------

// protocol ----------------------------------------------------------------------------------------------------------

  // static String protocol = "https://"; //apk create karu tab
  //  String protocol = "https://"; // testing server -- upload

  static String protocol = "http://"; // testing server

//----------------------------------------------------------------------------------------------------------------------------
//120133017502
// port -------------------------------------------------------------------------------------------------------------------------
//  static String port = ""; //  -- upload
  // String port = ":8086"; //for public
  //   String port = ":9090"; // for testing
  static String port = ":7086"; // for public boss -- S.Test -- new port also

  //  String port = ":7080"; // for hpscb
  //static String port = ":8080"; // for adarshhh
  // String port = ":9443"; // dev.nscspl
  //    String port = ":8080"; //  UAT_MB_Internet_IP
  //   String port = ":8080"; //  Internet_IP

// --------------------------------------------------------------------------------------------------------------------------------------
}
