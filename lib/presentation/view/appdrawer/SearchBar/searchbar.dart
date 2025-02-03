// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:hpscb/presentation/view/BBPS/bbps.dart';
import 'package:hpscb/presentation/view/appdrawer/faq/faq.dart';
import 'package:hpscb/presentation/view/appdrawer/profileview/profileview.dart';
import 'package:hpscb/presentation/view/appdrawer/profileview/safty_tips.dart';
import 'package:hpscb/presentation/view/dashboard/depositeloan/close_fd_rd/closefdrd.dart';
import 'package:hpscb/presentation/view/dashboard/depositeloan/create_fd_rd/createfdrd.dart';
import 'package:hpscb/presentation/view/dashboard/depositeloan/create_fd_rd/fdintrate/fdintrestrate.dart';
import 'package:hpscb/presentation/view/dashboard/depositeloan/loan_against/loanagainstfd.dart';
import 'package:hpscb/presentation/view/dashboard/instapayment/bbps/Boardband/Boardbandbill.dart';
import 'package:hpscb/presentation/view/dashboard/instapayment/bbps/CableTv/cabletv.dart';
import 'package:hpscb/presentation/view/dashboard/instapayment/bbps/EducationBill/Education.dart';
import 'package:hpscb/presentation/view/dashboard/instapayment/bbps/ElectricityRecharge/Electricity.dart';
import 'package:hpscb/presentation/view/dashboard/instapayment/bbps/FastTagRecharge/fasttage.dart';
import 'package:hpscb/presentation/view/dashboard/instapayment/bbps/LPG_Booking/LPG.dart';
import 'package:hpscb/presentation/view/dashboard/instapayment/bbps/MobilePospaidRecharge/mobilepostpaid.dart';
import 'package:hpscb/presentation/view/dashboard/instapayment/bbps/MobileRecharge/mobilerecharge.dart';
import 'package:hpscb/presentation/view/dashboard/instapayment/bbps/PIPED_Gas/PipedGas.dart';
import 'package:hpscb/presentation/view/dashboard/instapayment/bbps/Water/WaterRecharge.dart';
import 'package:hpscb/presentation/view/dashboard/instapayment/bbps/creditcard/CreditCard.dart';
import 'package:hpscb/presentation/view/dashboard/instapayment/myaccount/accountsummary/accsummary.dart';
import 'package:hpscb/presentation/view/dashboard/instapayment/myaccount/myaccount.dart';
import 'package:hpscb/presentation/view/dashboard/instapayment/quicktransfer/banktransfer/ToOtherBank/toothertransfer.dart';
import 'package:hpscb/presentation/view/dashboard/instapayment/quicktransfer/quicktransfer.dart';
import 'package:hpscb/presentation/view/dashboard/payments/manage_beneficiary/addPayee/addpayee.dart';
import 'package:hpscb/presentation/view/dashboard/payments/manage_beneficiary/manage_beneficiary.dart';
import 'package:hpscb/presentation/view/dashboard/payments/tootherbank/tootherbank.dart';
import 'package:hpscb/presentation/view/dashboard/payments/withinbank/withinbank.dart';
import 'package:hpscb/presentation/view/dashboard/security/blockcard/blockcard.dart';
import 'package:hpscb/presentation/view/dashboard/security/changepassword/changepassword.dart';
import 'package:hpscb/presentation/view/dashboard/security/generatempin/Generatempin.dart';
import 'package:hpscb/presentation/view/home/dashboard.dart';
import 'package:hpscb/presentation/view/more/15H/g_15_h.dart';
import 'package:hpscb/presentation/view/more/AddNominee/Addnominee.dart';
import 'package:hpscb/presentation/view/more/ChequeService/Chequemenu.dart';
import 'package:hpscb/presentation/view/more/certificates/certificates.dart';
import 'package:hpscb/presentation/view/more/fdliendata/fdliendata.dart';
import 'package:hpscb/presentation/view/more/fdrdreciptprint/fdrfview.dart';
import 'package:hpscb/presentation/view/more/moreoptions.dart';
import 'package:hpscb/presentation/view/more/positivepay/positivepay.dart';



class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<String> allItems = [
    'Mobile Recharge',
    'Mobile Postpaid',
    'Fast Tag Recharge',
    'Pay Credit Card Bill',
    'Water Bill',
    'Electricity Bill',
    'BBPS',
    'Boradband Bill',
    'Cable TV',
    'Education',
    'LPG Booking',
    'Piped Gas',
    'My Accounts',
    'Accounts Summary',
    'Mini Statement',
    'Quick Transfer',
    'Within Bank',
    'To Other Bank',
    'IMPS Transfer',
    'NEFT RGTS transfer',
    'Manage Beneficiary',
    'Create FD RD',
    'Loan Against FD',
    'Close FD RD',
    'Generate MPIN',
    'Change Password',
    'Block Card',
    'More Services',
    'Interest Certificates',
    'Cheque Book Request',
    'Cheque Inquiry',
    'Stop Cheque',
    'Add Nominee',
    '15G 15H',
    'Positive Pay',
    'FD Lien',
    'View FD RD Receipt',
    'FD Interest rate',
    'Profile View',
    'FAQ',
    'Saftey Tips',
  ];

  List<String> trendingSearches = [
    'Generate MPIN',
    'Change Password',
    'Create FD RD',
    'BBPS',
    'Fast Tag Recharge',
    'IMPS Transfer',
  ];

  List<String> recommendedForYou = [
    'Electricity Bill',
    'Mobile Recharge',
    'Water Bill',
    'More Services'
  ];

  List<String> recentSearches = [];
  List<String> filteredItems = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    searchController.addListener(() {
      filterItems();
    });
  }

  void filterItems() {
    String query = searchController.text.toLowerCase();
    setState(() {
      if (query.isNotEmpty) {
        // Filter items based on search query
        filteredItems = allItems
            .where((item) => item.toLowerCase().contains(query))
            .toList();
      } else {
        // Show recent searches when the search bar is empty
        filteredItems = recentSearches;
      }
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  // Function to navigate to respective pages
  void navigateToPage(String item) {
    if (item == 'Mobile Recharge') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Recharge(),
        ),
      );
    } else if (item == 'Mobile Postpaid') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const PostPaid(),
        ),
      );
    } else if (item == 'Fast Tag Recharge') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const FastTag(),
        ),
      );
    } else if (item == 'Pay Credit Card Bill') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const CreditCard(),
        ),
      );
    } else if (item == 'Water Bill') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const WaterRecharge(),
        ),
      );
    } else if (item == 'Electricity Bill') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Electricity(),
        ),
      );
    } else if (item == 'BBPS') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const BBPSConnect(),
        ),
      );
    } else if (item == 'Boradband Bill') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Boradbandbill(),
        ),
      );
    } else if (item == 'Cable TV') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const CABLETV(),
        ),
      );
    } else if (item == 'Education') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Education(),
        ),
      );
    } else if (item == 'LPG Booking') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const LPG(),
        ),
      );
    } else if (item == 'Piped Gas') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const pipedGass(),
        ),
      );
    } else if (item == 'My Accounts') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const MyAccounts(),
        ),
      );
    } else if (item == 'Accounts Summary') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const AccSummary(),
        ),
      );
    } else if (item == 'Mini Statement') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const MyAccounts(),
        ),
      );
    } else if (item == 'Quick Transfer') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const QuickTransfer(),
        ),
      );
    } else if (item == 'Within Bank') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const WithIn(),
        ),
      );
    } else if (item == 'To Other Bank') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ToOtherBank(),
        ),
      );
    } else if (item == 'IMPS Transfer') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ToOtherBankIMPS(),
        ),
      );
    } else if (item == 'NEFT RGTS Transfer') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ToOtherBankIMPS(),
        ),
      );
    } else if (item == 'Manage Beneficiary') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Manage(),
        ),
      );
    } else if (item == 'Add Payee') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const AddPayee(),
        ),
      );
    } else if (item == 'Create FD RD') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const CreateFDRD(),
        ),
      );
    } else if (item == 'Close FD RD') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const CloserFDRD(),
        ),
      );
    } else if (item == 'Loan Against FD') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const LoanAgainstFD(),
        ),
      );
    } else if (item == 'Generate MPIN') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const MpinGenerate(),
        ),
      );
    } else if (item == 'Change Password') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ChangePassword(),
        ),
      );
    } else if (item == 'Block Card') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const AtmDeactivation(),
        ),
      );
    } else if (item == 'More Services') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const MoreOptions(),
        ),
      );
    } else if (item == 'Interest Certificates') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Certificates(),
        ),
      );
    } else if (item == 'Cheque Book Request') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Chequemenu(),
        ),
      );
    } else if (item == 'Cheque Inquiry') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Chequemenu(),
        ),
      );
    } else if (item == 'Stop Cheque') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Chequemenu(),
        ),
      );
    } else if (item == 'Add Nominee') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const AddNominee(),
        ),
      );
    } else if (item == '15G 15H') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const G15H15(),
        ),
      );
    } else if (item == 'Positive Pay') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const PositivePay(),
        ),
      );
    } else if (item == 'FD Lien') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const FdLienData(),
        ),
      );
    } else if (item == 'View FD RD Receipt') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const FDRDView(),
        ),
      );
    } else if (item == 'FD Interest rate') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const FDInterestRate(),
        ),
      );
    } else if (item == 'Profile View') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ProfileView(),
        ),
      );
    } else if (item == 'Saftey Tips') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SafetyTipsScreenView(),
        ),
      );
    } else if (item == 'FAQ') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const FAQ(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Dashboard()),
            );
          },
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
        ),
        backgroundColor: const Color(0xFF0057C2),
        title: TextField(
          controller: searchController,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            hintText: 'Type to search',
            hintStyle:
                TextStyle(color: Colors.white), // Set hint text color to white
            iconColor: Colors.white,
            labelStyle: TextStyle(color: Color(0xFF0057C2)),
            prefixIcon: Icon(Icons.search,
                color: Colors.white), // Set icon color to white
            border: InputBorder.none,
          ),
        ),
      ),
      body: SingleChildScrollView(
        // Added scroll view
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Recent Searches Section
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Recent Searches',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          recentSearches.clear();
                          filteredItems.clear();
                        });
                      },
                      child: const Text(
                        'Clear all',
                        style: TextStyle(
                          color: Color(0xFF0057C2),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          
              if (filteredItems
                  .isNotEmpty) // Show recent search list if available
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: filteredItems.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: const Icon(Icons.history, color: Colors.orangeAccent),
                      title: Text(filteredItems[index]),
                      onTap: () {
                        navigateToPage(filteredItems[index]);
                      },
                    );
                  },
                ),
          
              // Trending Searches Section
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Trending searches',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Wrap(
                spacing: 8.0,
                children: trendingSearches.map((item) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade100,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        recentSearches.add(item);
                        navigateToPage(item);
                      });
                    },
                    child: Text(item),
                  );
                }).toList(),
              ),
          
              // Recommended for You Section
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Recommended for you',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Wrap(
                spacing: 8.0,
                children: recommendedForYou.map((item) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade100,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        recentSearches.add(item);
                        navigateToPage(item);
                      });
                    },
                    child: Text(item),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
