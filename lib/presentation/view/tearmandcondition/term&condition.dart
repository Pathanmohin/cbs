import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hpscb/main.dart';
import 'package:hpscb/utility/theme/colors.dart';

class TermsConditionPage extends StatelessWidget {
  const TermsConditionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return MediaQuery(
        data: MediaQuery.of(context)
            .copyWith(textScaler: const TextScaler.linear(1.1)),
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: AppColors.appBlueC,
            title:  Text(
              "Terms and Conditions",
              style: TextStyle(color: AppColors.onPrimary, fontSize: 16.sp),
            ),
                        iconTheme: const IconThemeData(
              color: Colors.white,
              //change your color here
            ),
          ),
          body: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Center(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'HIMPESA Terms and Conditions',
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            const Text(
                              'This Mobile Banking App, now referred to as HIMPESA is provided by the HP State Cooperative Bank Ltd. By downloading, installing, or using Himpesa, you agree to be bound by the following terms and conditions:',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF002E5B),
                              ),
                            ),
                            const SizedBox(height: 10),
                            buildSectionTitle('1. Acceptance of Terms'),
                            buildSectionContent(
                              'Your use of Himpesa constitutes your acceptance of these terms and conditions. If you do not agree to these terms, please refrain from using Himpesa.',
                            ),
                            buildSectionTitle('2. User Registration'),
                            buildSectionContent(
                              'To use certain features of Himpesa, you may be required to register and provide accurate information. You are responsible for maintaining the confidentiality of your account information.',
                            ),
                            buildSectionTitle('3. Account Access'),
                            buildSectionContent(
                              'You are responsible for all activities that occur under your account. You shall be responsible for reporting any unauthorized access or suspicious activities immediately to your branch, nearest branch or to customer support.',
                            ),
                            buildSectionTitle('4. Services Offered'),
                            buildSectionContent(
                              'Himpesa provides access to various banking services. The bank reserves the right to modify, suspend, or discontinue any service at its discretion.',
                            ),
                            buildSectionTitle('5. Security Measures'),
                            buildSectionContent(
                              'You agree to take reasonable precautions to prevent unauthorized access to your account. The bank implements security measures, and you acknowledge that no system is completely secure.',
                            ),
                            buildSectionTitle('6. Confidentiality'),
                            buildSectionContent(
                              'You shall exercise reasonable care and diligence, and shall be solely responsible for the confidentiality of the account/mobile banking details, OTP, MPIN, user name and password and such other items relevant or pertaining to your Account. The Bank shall not be held liable in any manner whatsoever if details referred hereinabove are compromised/shared by the customer and the customer shall keep the Bank indemnified from any loss/damage/cost/harm/penalty/liability in this regard. The customer shall be solely responsible in case the details are compromised shared by him/her.',
                            ),
                            buildSectionTitle('7. Transactions'),
                            buildSectionContent(
                              'The bank is not liable for errors in transactions if instructions provided are inaccurate.',
                            ),
                            buildSectionTitle('8. Communication'),
                            buildSectionContent(
                              'The bank may communicate with you through Himpesa or other means. You agree to receive notifications, alerts, and updates.',
                            ),
                            buildSectionTitle(
                                '9. Liability and Indemnification'),
                            buildSectionContent(
                              'The bank is not liable for any unauthorized transactions if you fail to report them promptly. You agree to indemnify the bank from any claims arising from your use of Himpesa.',
                            ),
                            buildSectionTitle('10. Termination of Services'),
                            buildSectionContent(
                              'The bank may terminate or suspend services for any reason on Himpesa. Upon termination, you may lose access to certain features without notice.',
                            ),
                            buildSectionTitle(
                                '11. Savings / Current Accounts:'),
                            buildSectionContent(
                              'a) Account Maintenance: - The bank shall charge fees for non-maintenance of minimum balance, as outlined in the service charges schedule available on the bank\'s website www.hpscb.com.',
                            ),
                            buildSectionTitle('12. Fixed Deposits (FD):'),
                            buildSectionContent(
                              'a) Minimum Deposit amount: - A minimum of Rs. 500/- can be placed as a fixed deposit for a minimum period of 1 year through Himpesa. b) Interest Payments: - Interest on Fixed Deposits will be paid at every quarter end. c) Premature Withdrawal: - No interest will be paid if the term deposit has remained with the bank for a period less than 7 days. For FDs which have remained for seven days and above, on premature withdrawal of such FDs interest will be paid at the rate applicable for the period for which the deposit remained with the bank or the contracted rate whichever is lower less penalty of 1% or as applicable. d) Renewal Option: - Customer may choose to automatically renew the fixed deposit or credit the maturity proceeds to their savings account.',
                            ),
                            buildSectionTitle('13. Recurring Deposits (RD)'),
                            buildSectionContent(
                              'a) Minimum Deposit amount: - A minimum of Rs. 10/- (in the multiples of Rs. 5/-) can be placed as a Recurring Deposit for a minimum period of 1 year through the Himpesa. b) Interest Payments: - Interest on RDs will be paid at every quarter end. c) Premature Withdrawal: - No interest will be paid if the recurring deposit (RD) has remained with the bank for a period less than 7 days. For RDs which have remained for seven days and above, on premature withdrawal of such RDs interest will be paid at the rate applicable for the period for which the deposit remained with the bank or the contracted rate whichever is lower less penalty of 1% or as applicable. d) Penalty for delayed installment: A penalty of Rs. 2 + GST (per Rs. 100 per month) shall be charged for any delay in depositing the installments in Recurring Deposit Accounts.',
                            ),
                            buildSectionTitle('14. Loan against FD:'),
                            buildSectionContent(
                              'If a loan against FD remains unpaid as of the maturity date of the fixed deposit, the outstanding loan amount, including any accrued interest, shall automatically be adjusted from the maturity proceeds of the fixed deposit. The adjusted amount will be utilized to settle the outstanding loan balance. Upon the automatic adjustment of the loan amount, any remaining balance, if applicable, shall be credited to the deposit account of the account holder.',
                            ),
                            buildSectionTitle('15. Dispute resolution'),
                            buildSectionContent(
                              'Any dispute or differences arising out of or in connection with Himpesa shall be referred for Arbitration under Section 72, 73 of the HP State Cooperative Societies Act, 1968 (Act No.3 of 1969) to Registrar Cooperative Societies HP for decision and his decision shall be final. The mere fact that Himpesa can be accessed by a Customer in any state other than Himachal Pradesh does not imply that the laws of the said state govern these terms and conditions and / or the operations in the accounts of the Customer and / or the use Himpesa.',
                            ),
                            buildSectionTitle('16. Amendments to Terms'),
                            buildSectionContent(
                              'The bank reserves the right to amend these terms and conditions. Changes will be communicated to users through Himpesa.',
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF0057C2),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(vertical: 15.0),
                                child: Center(
                                  child: Text(
                                    'OK',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      fontFamily: 'Montserrat',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 5),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget buildSectionContent(String content) {
    return Text(
      content,
      style: const TextStyle(
        fontSize: 13,
        color: Colors.black,
      ),
    );
  }
}
