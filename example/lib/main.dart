import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_to_pdf/flutter_to_pdf.dart';

void main() => runApp(const Demo());

class Demo extends StatefulWidget {
  const Demo({super.key});

  @override
  State<Demo> createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  static const pageInset = 2.5;

  static const double inch = 72.0;
  static const double cm = inch / 2.54;

  final ExportDelegate exportDelegate = ExportDelegate(
    ttfFonts: {
      'Poppins': 'fonts/Poppins/Poppins-Regular.ttf',
      'PoppinsBold': 'fonts/Poppins/Poppins-Bold.ttf',
      'PoppinsMedium': 'fonts/Poppins/Poppins-Medium.ttf',
      'PoppinsSemiBold': 'fonts/Poppins/Poppins-SemiBold.ttf',
      // 'Helvetica': 'fonts/Helvetica/Helvetica.ttf',
      // 'Roboto': 'fonts/Roboto/Roboto-VariableFont_wdth,wght.ttf',
    },
    options: ExportOptions(
      pageFormatOptions: const PageFormatOptions(
        pageFormat: PageFormat.custom,
        width: 595,
        height: 842,
        marginTop: pageInset * cm,
        marginBottom: pageInset * cm,
        marginLeft: pageInset * cm,
        marginRight: pageInset * cm,
      ),
      textFieldOptions: const TextFieldOptions.individual(
        interactive: false,
      ),
      checkboxOptions: CheckboxOptions.uniform(
        interactive: false,
      ),
    ),
  );

  final headerTextPoppins = const TextStyle(
    fontFamily: 'PoppinsBold',
    fontSize: 24,
    color: Colors.black,
    height: 1.4,
    letterSpacing: 0.0,
    wordSpacing: 1.16,
  );

  final subheaderTextPoppins = const TextStyle(
    fontFamily: 'PoppinsMedium',
    fontSize: 14,
    color: Color(0xff9ce5d0),
    height: 1.4,
    letterSpacing: 0.5,
    wordSpacing: 1.16,
  );

  final bodyTextPoppins = const TextStyle(
    fontFamily: 'Poppins',
    fontSize: 10,
    color: Colors.black,
    height: 1.4,
    letterSpacing: 0.0,
    wordSpacing: 1.1,
  );

  final bodyTextPoppinsGray = const TextStyle(
    fontFamily: 'Poppins',
    fontSize: 10,
    color: Color.fromARGB(255, 151, 151, 151),
    height: 1.4,
    letterSpacing: 0.0,
    wordSpacing: 1.1,
  );

  final badgeTextPoppins = const TextStyle(
    fontFamily: 'PoppinsBold',
    fontSize: 10,
    color: Colors.black,
    height: 1.4,
    letterSpacing: 0.0,
    wordSpacing: 1.1,
  );

  final bodyText20Poppins = const TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.normal,
    fontSize: 20,
    color: Colors.black,
    height: 1.4,
    letterSpacing: 0.0,
    wordSpacing: 1.16,
  );

  final bodyText16Poppins = const TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.normal,
    fontSize: 16,
    color: Colors.black,
    height: 1.4,
    letterSpacing: 0.0,
    wordSpacing: 1.3,
  );

  @override
  Widget build(BuildContext context) => MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          tabBarTheme: const TabBarTheme(
            labelColor: Colors.black87,
          ),
        ),
        home: DefaultTabController(
          length: 2,
          child: Scaffold(
              body: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(onPressed: save, child: Text('Save')),
                ],
              ),
              Expanded(
                child: InteractiveViewer(
                  constrained: false,
                  child: Container(
                    color: Colors.white,
                    margin: const EdgeInsets.all(0),
                    padding: const EdgeInsets.all(pageInset * cm),
                    child: ExportFrame(
                      exportDelegate: exportDelegate,
                      frameId: 'someFrameId', // identifies the frame
                      child: Container(
                        width: 595 - 2 * pageInset * cm,
                        height: 842 - 2 * pageInset * cm,
                        child: Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.all(50),
                              decoration: const BoxDecoration(
                                  border: Border(
                                left: BorderSide(color: Colors.black, width: 2),
                                right:
                                    BorderSide(color: Colors.black, width: 2),
                                top: BorderSide(color: Colors.black, width: 2),
                                bottom:
                                    BorderSide(color: Colors.black, width: 2),
                              )),
                              child: Text(
                                "Mario Meyer",
                                style: headerTextPoppins,
                                textScaler: TextScaler.noScaling,
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
          )),
        ),
      );

  save() async {
    final pdf = await exportDelegate.exportToPdfDocument('someFrameId');
    saveFile(pdf, 'output');
  }

  Future<void> saveFile(document, String name) async {
    final Directory dir = await getApplicationDocumentsDirectory();
    final File file = File('${dir.path}/$name.pdf');

    await file.writeAsBytes(await document.save());
    debugPrint('Saved exported PDF at: ${file.path}');
  }
}
