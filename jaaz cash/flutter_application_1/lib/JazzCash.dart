import "package:flutter/material.dart";
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';

class JazzCash extends StatelessWidget {
  static Future<void> makePayment(BuildContext context) async {
    String dateAndTime = DateFormat("yyyyMMddHHmmss").format(DateTime.now());
    String dExpireDate = DateFormat("yyyyMMddHHmmss")
        .format(DateTime.now().add(Duration(days: 1)));
    String tre = "T$dateAndTime";
    String ppAmount = "5000";
    String ppBillReference = "billref";
    String ppCNIC = "345678";
    String ppDescription = "Description Of Transaction";
    String ppLanguage = "EN";
    String ppMerchantID = "MC57049";
    String ppMobileNumber = "03123456789";
    String ppPassword = "3c1y31zwuu";
    String ppReturnURL = "https://www.qistbazaar.pk/?wc-api=jazzcashresponse";
    String ppTxnCurrency = "PKR";
    String ppTxnDateTime = dateAndTime.toString();
    String ppTxnExpiryDateTime = dExpireDate.toString();
    String ppTxnRefNo = tre.toString();
    String integritySalt = "239w9h0t52";
    String and = '&';

    String superdata = integritySalt +
        and +
        ppAmount +
        and +
        ppBillReference +
        and +
        ppCNIC +
        and +
        ppDescription +
        and +
        ppLanguage +
        and +
        ppMerchantID +
        and +
        ppMobileNumber +
        and +
        ppPassword +
        and +
        ppTxnCurrency +
        and +
        ppTxnDateTime +
        and +
        ppTxnExpiryDateTime +
        and +
        ppTxnRefNo;

    var key = utf8.encode(integritySalt);
    var bytes = utf8.encode(superdata);
    var hmacSha256 = Hmac(sha256, key);
    Digest sha256Result = hmacSha256.convert(bytes);

    var url =
        'https://sandbox.jazzcash.com.pk/SandboxDocumentation/v4.2/';

    var response = await Dio().post(
      url,
      data: {
        "pp_Amount": ppAmount,
        "pp_BillReference": ppBillReference,
        "pp_Description": ppDescription,
        "pp_CNIC": ppCNIC,
        "pp_MobileNumber": ppMobileNumber,
        "pp_Language": ppLanguage,
        "pp_MerchantID": ppMerchantID,
        "pp_Password": ppPassword,
        "pp_TxnRefNo": ppTxnRefNo,
        "pp_TxnCurrency": ppTxnCurrency,
        "pp_TxnDateTime": dateAndTime,
        "pp_TxnExpiryDateTime": ppTxnExpiryDateTime,
        "pp_ReturnURL": ppReturnURL,
        "pp_SecureHash": sha256Result.toString().toUpperCase(),
        "ppmpf_1": "",
        "ppmpf_2": "",
        "ppmpf_3": "",
        "ppmpf_4": "",
        "ppmpf_5": "",

        // "pp_Version": "4.2",
        // "pp_TxnType": "MWALLET",
        // "pp_Language": "EN",
        // "pp_MerchantID": ppMerchantID,
        // "pp_SubMerchantID": "",
        // "pp_Password": ppPassword,
        // "pp_BankID": "",
        // "pp_ProductID": "",
        // "pp_TxnRefNo": "T20230526170436",
        // "pp_Amount": "700",
        // "pp_TxnCurrency": "PKR",
        // "pp_TxnDateTime": "20230526170436",
        // "pp_BillReference": "billref",
        // "pp_Description": "Description of transaction",
        // "pp_TxnExpiryDateTime": "20230526170436",
        // "pp_ReturnURL": "https://www.qistbazaar.pk/?wc-api=jazzcashresponse",
        // "pp_SecureHash": "F15FB9ADC8B7C46CEA342F9B1AF5DD517FDA059CA65680F095478395A3CBE870",
        // "ppmpf_1": "03181072294",
        // "ppmpf_2": "",
        // "ppmpf_3": "",
        // "ppmpf_4": "",
        // "ppmpf_5": ""
      },
    );

    print("response=>");
    print(response.data);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: ElevatedButton(
        onPressed: () {
          try {
            makePayment(context);
          } catch (e) {
            print('No Transactions');
          }
        },
        child: Text('Jazz'),
      )),
    );
  }
}
