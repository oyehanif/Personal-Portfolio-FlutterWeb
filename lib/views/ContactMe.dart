import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:oyehanif/globles/AppColor.dart';
import 'package:oyehanif/globles/app_button.dart';
import 'package:oyehanif/helper_class/helper_class.dart';
import 'package:oyehanif/views/thank_you.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../globles/app_text_style.dart';
import '../helper_class/WidgetNotification.dart';
import 'package:emailjs/emailjs.dart' as emailjs;

class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  final _formKey = GlobalKey<FormState>();
  var isLoading = false;

  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobileNumberController = TextEditingController();
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _mobileNumberController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  String? _validateField(String? value, String fieldName,
      {ValidationType? type}) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }

    if (type == ValidationType.email) {
      final emailRegex =
          RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
      if (!emailRegex.hasMatch(value)) {
        return 'Invalid email address';
      }
    }

    if (type == ValidationType.phoneNumber) {
      final phoneRegex = RegExp(r'^\d+$');
      if (!phoneRegex.hasMatch(value)) {
        return 'Phone number must contain only digits';
      }
    }

    if (type == ValidationType.phoneNumber) {
      final phoneRegex = RegExp(r'^\d{10}$'); // Exactly 10 digits
      if (!phoneRegex.hasMatch(value)) {
        return 'Phone number must contain exactly 10 digits';
      }
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return VisibilityDetector(
      key: const Key('contact-key'),
      onVisibilityChanged: (VisibilityInfo info) {
        if (info.visibleFraction > 0.50) {
          WidgetNotification(4).dispatch(context);
        }
      },
      child: HelperClass(
        mobile: _buildForm(size, isTabletOrDesktop: false),
        tablet: _buildForm(size, isTabletOrDesktop: true),
        desktop: _buildForm(size, isTabletOrDesktop: true),
        paddingWidth: size.width * 0.2,
        bgColor: AppColor.bgColor,
      ),
    );
  }

  void _sendEmail({
    required String name,
    required String email,
    required String subject,
    required String message,
    required String phone,
  }) async {
    try {
      setState(() {
        isLoading = true;
      });
      await emailjs.send(
        'service_z91o83j',
        'template_h6e6lss',
        {
          'user_name': name,
          'user_email': email,
          'user_subject': subject,
          'user_message': message,
        },
        const emailjs.Options(
            publicKey: '7pg8VC8_4-xfKwtSM',
            privateKey: 'geQtGHbwCB5M__f_wWLg8',
            limitRate: const emailjs.LimitRate(
              id: 'app',
              throttle: 10000,
            )),
      );
      print('SUCCESS!');
      setState(() {
        isLoading = false;
      });
      clearAllText();
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ThankYouPage(),
          ));
    } catch (error) {
      if (error is emailjs.EmailJSResponseStatus) {
        print('ERROR... $error');
        isLoading = false;
      }
      print(error.toString());
      setState(() {
        isLoading = false;

      });
    }
  }

  void clearAllText(){
    _fullNameController.clear();
    _emailController.clear();
    _mobileNumberController.clear();
    _subjectController.clear();
    _messageController.clear();
  }

  Widget _buildForm(Size size, {required bool isTabletOrDesktop}) {
    final textFields = [
      _buildTextField(_fullNameController, 'Full Name'),
      _buildTextField(_emailController, 'Email Address',
          type: ValidationType.email),
      _buildTextField(_mobileNumberController, 'Mobile Number',
          type: ValidationType.phoneNumber),
      _buildTextField(_subjectController, 'Email Subject'),
      _buildTextField(_messageController, 'Your Message', maxLines: 15),
    ];

    final fieldsInRow = [
      if (isTabletOrDesktop)
        Row(
          children: [
            Expanded(child: textFields[0]),
            const SizedBox(width: 20),
            Expanded(child: textFields[1]),
          ],
        )
      else
        textFields[0],
      const SizedBox(height: 20),
      if (isTabletOrDesktop)
        Row(
          children: [
            Expanded(child: textFields[2]),
            const SizedBox(width: 20),
            Expanded(child: textFields[3]),
          ],
        )
      else ...[
        textFields[1],
        const SizedBox(height: 20),
        textFields[2],
      ],
      const SizedBox(height: 20),
      textFields[4],
    ];

    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _buildContactText(),
          const SizedBox(height: 40),
          ...fieldsInRow,
          const SizedBox(height: 40),
          isLoading ? Column(
                  children: [
                    const CircularProgressIndicator(color: Colors.white,),
                    const SizedBox(height: 10,),
                    Text(
                      "Please wait we are sending data.",
                      style: AppTextStyles.headerTextStyle(fontSize: 16),
                    )
                  ],
                )
              : AppButton.buildMaterialButton(
                  buttonName: "Send Message",
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      _sendEmail(
                          name: _fullNameController.text,
                          email: _emailController.text,
                          subject: _subjectController.text,
                          message: _messageController.text,
                          phone: _messageController.text);
                    }
                  },
                ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hintText,
      {int maxLines = 1, ValidationType? type}) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      color: Colors.transparent,
      elevation: 8,
      child: TextFormField(
        controller: controller,
        cursorColor: AppColor.white,
        style: AppTextStyles.normalStyle(),
        decoration: _buildInputDecoration(hintText),
        maxLines: maxLines,
        validator: (value) => _validateField(value, hintText, type: type),
      ),
    );
  }

  FadeInDown _buildContactText() {
    return FadeInDown(
      child: RichText(
        text: TextSpan(
          text: 'Contact',
          style: AppTextStyles.headerTextStyle(fontSize: 30),
          children: [
            TextSpan(
              text: ' Me',
              style: AppTextStyles.headerTextStyle(
                  fontSize: 30, color: AppColor.robinEdgeBlue),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration(String hintText) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: AppTextStyles.comfortaaStyle(),
      errorStyle: const TextStyle(color: Colors.white),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
      filled: true,
      fillColor: AppColor.bgColor2,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    );
  }
}

enum ValidationType {
  email,
  phoneNumber,
}
