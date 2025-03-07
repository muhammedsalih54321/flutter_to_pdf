import 'dart:io';
import 'dart:typed_data';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:screenshot/screenshot.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:intl/intl.dart';

class PDFGeneratorPage extends StatefulWidget {
  @override
  _PDFGeneratorPageState createState() => _PDFGeneratorPageState();
}

class _PDFGeneratorPageState extends State<PDFGeneratorPage> {
  int? selectedCheckbox;
  ScreenshotController screenshotController = ScreenshotController();

  Future<void> _generatePDF() async {
    try {
      Uint8List? image = await screenshotController.capture();
      if (image == null) return;

      final pdf = pw.Document();
      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.Center(
              child: pw.Image(pw.MemoryImage(image)),
            );
          },
        ),
      );

      // Generate unique file name using timestamp
      String timestamp = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());
      String fileName = "generated_$timestamp.pdf";

      final directory = await getApplicationDocumentsDirectory();
      final filePath = "${directory.path}/$fileName";
      final file = File(filePath);
      await file.writeAsBytes(await pdf.save());

      // Open the PDF file
      await OpenFile.open(filePath);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("PDF saved at: $filePath")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error generating PDF: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Generate PDF")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Screenshot(
            controller: screenshotController,
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black)),
                height: 280.h,
                width: double.infinity,
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 20.w,
                        ),
                        Image.asset(
                          'asset/images/Ash logo.jpg',
                          height: 80.h,
                          width: 80.w,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Container(
                            height: 40.h,
                            width: 150.w,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      BootstrapIcons.geo_alt_fill,
                                      color: Colors.black,
                                      size: 6.sp,
                                    ),
                                    SizedBox(
                                      width: 2.w,
                                    ),
                                    Text(
                                      '2nd Floor,OPS MALL vailathur,Tirur',
                                      style: TextStyle(
                                          fontSize: 6.5.sp,
                                          fontWeight: FontWeight.w500),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      BootstrapIcons.envelope,
                                      color: Colors.black,
                                      size: 6.sp,
                                    ),
                                    SizedBox(
                                      width: 2.w,
                                    ),
                                    Text(
                                      'connect@ashcorptechnologies.com',
                                      style: TextStyle(
                                          fontSize: 6.5.sp,
                                          fontWeight: FontWeight.w500),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      BootstrapIcons.globe,
                                      color: Colors.black,
                                      size: 6.sp,
                                    ),
                                    SizedBox(
                                      width: 2.w,
                                    ),
                                    Text(
                                      'www.ashcoroptechnologies.com',
                                      style: TextStyle(
                                          fontSize: 6.5.sp,
                                          fontWeight: FontWeight.w500),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      BootstrapIcons.telephone_fill,
                                      color: Colors.black,
                                      size: 6.sp,
                                    ),
                                    SizedBox(
                                      width: 2.w,
                                    ),
                                    Text(
                                      '+91 8921 365 750',
                                      style: TextStyle(
                                          fontSize: 6.5.sp,
                                          fontWeight: FontWeight.w500),
                                    )
                                  ],
                                ),
                              ],
                            )),
                        SizedBox(
                          width: 15.w,
                        ),
                        Container(
                          height: 40.h,
                          width: 100.w,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 20.h,
                                width: 100.w,
                                child: Row(
                                  children: [
                                    Text(
                                      'Date',
                                      style: TextStyle(
                                          fontSize: 8.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(
                                      width: 7.w,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Stack(
                                        clipBehavior: Clip.none,
                                        children: [
                                          Container(
                                            height: .5.h,
                                            width: 60.w,
                                            color: Colors.black,
                                          ),
                                          Positioned(
                                            left: 5.w,
                                            bottom: 2.h,
                                            child: Text(
                                              '12/22/2025',
                                              style: TextStyle(
                                                  fontSize: 8.sp,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                height: 20.h,
                                width: 100.w,
                                child: Row(
                                  children: [
                                    Text(
                                      'Bill No',
                                      style: TextStyle(
                                          fontSize: 8.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 11),
                                      child: Stack(
                                        clipBehavior: Clip.none,
                                        children: [
                                          Container(
                                            height: .5.h,
                                            width: 60.w,
                                            color: Colors.black,
                                          ),
                                          Positioned(
                                            left: 5.w,
                                            bottom: 2.h,
                                            child: Text(
                                              '12222025',
                                              style: TextStyle(
                                                  fontSize: 8.sp,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    Container(
                      height: 2.h,
                      width: double.infinity.w,
                      color: const Color.fromARGB(255, 93, 11, 107),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Container(
                      height: 80.h,
                      width: 350.w,
                      child: Column(
                        children: [
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Text(
                                'Received from Mr/Ms...............................................................................',
                                style: TextStyle(
                                    height: 2.5.h,
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                              Positioned(
                                left: 110,
                                bottom: 9.h,
                                child: SizedBox(
                                  width: 200.w,
                                  child: Text(
                                    'Contrary to popular belief, Lorem Ipsum is not ',
                                    style: TextStyle(
                                        fontSize: 8.sp,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Text(
                                'for the course............................................................................................',
                                style: TextStyle(
                                    height: 2.5.h,
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                              Positioned(
                                left: 80,
                                bottom: 9.h,
                                child: SizedBox(
                                  width: 200.w,
                                  child: Text(
                                    'Contrary to popular belief, Lorem Ipsum is not ',
                                    style: TextStyle(
                                        fontSize: 8.sp,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                      height: 60.h,
                      width: 350.w,
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    height: 20.h, // Adjust the spacing
                                    width: 20.w, // Control checkbox size
                                    child: Transform.scale(
                                      scale: 0.7,
                                      child: Checkbox(
                                        checkColor:
                                            Colors.black, // Tick mark color
                                        fillColor: WidgetStateProperty
                                            .resolveWith<Color>(
                                          (states) => Colors
                                              .transparent, // Keep background always transparent
                                        ),
                                        side: WidgetStateBorderSide.resolveWith(
                                          (states) => const BorderSide(
                                              color: Colors.black,
                                              width: 2), // Always show border
                                        ),
                                        visualDensity: VisualDensity.compact,
                                        materialTapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        value: selectedCheckbox == 1,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            selectedCheckbox =
                                                value! ? 1 : null;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                  // Reduce space between checkboxes

                                  SizedBox(
                                    width: 3.w,
                                  ),
                                  Text(
                                    'Cash',
                                    style: TextStyle(
                                      fontSize: 8.5.sp,
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    height: 20.h,
                                    width: 20.w,
                                    child: Transform.scale(
                                      scale: 0.7,
                                      child: Checkbox(
                                        checkColor:
                                            Colors.black, // Tick mark color
                                        fillColor: WidgetStateProperty
                                            .resolveWith<Color>(
                                          (states) => Colors
                                              .transparent, // Keep background always transparent
                                        ),
                                        side: WidgetStateBorderSide.resolveWith(
                                          (states) => const BorderSide(
                                              color: Colors.black,
                                              width: 2), // Always show border
                                        ),
                                        visualDensity: VisualDensity.compact,
                                        materialTapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        value: selectedCheckbox == 2,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            selectedCheckbox =
                                                value! ? 2 : null;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 3.w,
                                  ),
                                  Text(
                                    'Net Banking',
                                    style: TextStyle(
                                      fontSize: 8.5.sp,
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            width: 30.w,
                          ),
                          Image.asset(
                            'asset/images/seal.png',
                            height: 100.h,
                            width: 100.w,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          Text(
                            'Amount',
                            style: TextStyle(
                                fontSize: 9.sp, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Container(
                            height: 20.h,
                            width: 90.w,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)),
                            child: Padding(
                              padding: EdgeInsets.only(left: 3.w),
                              child: Row(
                                children: [
                                  Text('₹'),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Text(
                                    '5000',
                                    style: TextStyle(
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _generatePDF,
            child: Text("Generate PDF"),
          ),
        ],
      ),
    );
  }
}
