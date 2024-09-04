import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '/exports/exports.dart';

void showMessage(
    {String type = 'info',
    String? msg,
    bool float = false,
    required BuildContext context,
    double opacity = 1,
    int duration = 5,
    Animation<double>? animation}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: float ? SnackBarBehavior.floating : SnackBarBehavior.fixed,
      content: Text(
        msg ?? '',
        style: const TextStyle(fontSize: 17),
      ),
      backgroundColor: type == 'info'
          ? Colors.lightBlue
          : type == 'warning'
              ? Colors.orange[400]!.withOpacity(opacity)
              : type == 'danger'
                  ? Colors.red[400]!.withOpacity(opacity)
                  : type == 'success'
                      ? const Color.fromARGB(255, 2, 104, 7)
                          .withOpacity(opacity)
                      : Colors.grey[500]!.withOpacity(opacity),
      duration: Duration(seconds: duration),
    ),
  );
}

/// alert dialog
showAlertMsg(BuildContext context, {String content = "", String title = ""}) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            title,
            style: TextStyles(context).getRegularStyle(),
          ),
          content: Text(
            content,
            style: TextStyles(context).getRegularStyle(),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "OK",
                style: TextStyles(context).getRegularStyle(),
              ),
            )
          ],
        );
      });
}

/// show progress widget
void showProgress(BuildContext context, {String? text = 'Task'}) {
  showDialog(
    context: context,
    builder: (context) => Dialog(
      backgroundColor: Colors.transparent,
      child: Card(
        child: SizedBox(
          height: 90,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: SpinKitDualRing(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Theme.of(context).primaryColor),
              ),
              const SizedBox(
                width: 40,
              ),
              Text(
                "$text..",
                textAlign: TextAlign.center,
                style: TextStyles(context).getRegularStyle(),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

String formatNumberWithCommas(int number) {
  final formatter = NumberFormat('#,###');
  return formatter.format(number);
}

Future<void> requestPermissions() async {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  if (Platform.isAndroid) {
    final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
        flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();

    await androidImplementation?.requestNotificationsPermission();
    // setState(() {
    //   _notificationsEnabled = granted ?? false;
    // });
  }
}

// function to detect the start of a new month
bool isStartOfMonth(DateTime date) {
  return date.day == 1;
}

// glpat-sdq-jg75dypZuicMKCQp
// function to handle date
String formatDate(DateTime date) {
  return DateFormat('dd-MM-yyyy').format(date);
}

// fuction to handle time
String formatTime(DateTime date) {
  return DateFormat('hh:mm a').format(date);
}

// function to handle date
String formatDateTime(DateTime date) {
  return DateFormat('dd-MM-yyyy hh:mm a').format(date);
}

// function to handle image upload in form of base64
Future<File> uploadImage() async {
  final ImagePicker picker = ImagePicker();
  var file = await picker.pickImage(source: ImageSource.camera);
  return (File(file!.path));
}

// function to handle image upload in form of base64
Future<File> captureImage() async {
  final ImagePicker picker = ImagePicker();
  var file = await picker.pickImage(source: ImageSource.gallery);
  return (File(file!.path));
}

// function to determine the tenant's end of month
String getEndOfMonth(DateTime date) {
  DateTime registrationDate =
      DateTime(2023, 6, 15); // Replace with the tenant's registration date
  DateTime nextMonth =
      DateTime(registrationDate.year, registrationDate.month + 1, 1);
  DateTime endOfMonth = nextMonth.subtract(const Duration(days: 1));
  return DateFormat('dd-MM-yyyy').format(endOfMonth);
}

String getTimeAgo(DateTime dateTime) {
  final now = DateTime.now();
  final difference = now.difference(dateTime);

  if (difference.inSeconds < 5) {
    return 'just now';
  } else if (difference.inSeconds < 60) {
    return '${difference.inSeconds} seconds ago';
  } else if (difference.inMinutes < 60) {
    return '${difference.inMinutes} minutes ago';
  } else if (difference.inHours < 24) {
    return '${difference.inHours} hours ago';
  } else if (difference.inDays < 7) {
    return '${difference.inDays} days ago';
  } else {
    final formatter = DateFormat('dd MMM yyyy');
    return formatter.format(dateTime);
  }
}

String separateZerosWithCommas(String zeros) {
  final formatter = NumberFormat("#,###");
  int value = int.parse(zeros);
  return formatter.format(value);
}

void showProgressLoader(BuildContext context) {
  showDialog(
    barrierDismissible: true,
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        child: Card(
          child: SizedBox(
            height: 90,
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 18.0),
                  child: CircularProgressIndicator(),
                ),
                const SizedBox(
                  width: 50,
                ),
                Text(
                  "Payment in progress ",
                  style: TextStyles(context).getRegularStyle(),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

// function used to generate receipt
Future<Uint8List> pdfFile(
    PdfPageFormat format, Map<String, dynamic> paymentData) async {
  final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
  List<pw.Text> heads = [
    pw.Text("Tenant's Name",
        style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
    pw.Text("Date of payment",
        style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
    pw.Text("Payment Gateway",
        style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
    pw.Text("Amount Paid",
        style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
    pw.Text("Balance",
        style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
    pw.Text("Payment status",
        style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
  ];

  //
  List<pw.Widget> body = [
    pw.Text(paymentData['tenantName'], style: const pw.TextStyle(fontSize: 16)),
    pw.Text(paymentData['date'], style: const pw.TextStyle(fontSize: 16)),
    pw.Text(paymentData['paymentMode'],
        style: const pw.TextStyle(fontSize: 16)),
    pw.Text(paymentData['amountPaid'], style: const pw.TextStyle(fontSize: 16)),
    pw.Text(paymentData['balance'], style: const pw.TextStyle(fontSize: 16)),
    pw.Text(paymentData['paymentStatus'],
        style: const pw.TextStyle(fontSize: 16)),
  ];
  pdf.addPage(
    pw.Page(
      pageFormat: format,
      build: (pw.Context context) => pw.Center(
          child: pw.Padding(
        padding: const pw.EdgeInsets.all(10),
        child: pw.Column(
          children: [
            pw.Center(
                child: pw.Text((paymentData['property']),
                    style: pw.TextStyle(
                        fontSize: 20, fontWeight: pw.FontWeight.bold))),
            pw.Padding(
              padding: const pw.EdgeInsets.all(15),
              child: pw.PdfLogo(),
            ),
            pw.SizedBox(height: 50),
            pw.Signature(
              name: "NyumbaYo Tenant",
            ),
            pw.Center(
                child: pw.Text("Payment receipt",
                    style: pw.TextStyle(
                        fontSize: 20, fontWeight: pw.FontWeight.bold))),
            pw.SizedBox(height: 20),
            pw.Divider(),
            pw.Padding(
              padding: const pw.EdgeInsets.all(15),
              child: pw.Table(
                children: List.generate(
                  body.length,
                  (index) => pw.TableRow(children: [
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(15),
                      child: heads[index],
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(15),
                      child: body[index],
                    ),
                  ]),
                ),
              ),
            ),
            pw.Divider()
          ],
        ),
      )),
    ),
  );

  return pdf.save();
}
