import 'dart:io';
import 'package:book_wallert/controllers/signup_controller.dart';
import 'package:book_wallert/controllers/image_controller.dart';
import 'package:book_wallert/textbox/custom_textbox1.dart';
import 'package:flutter/material.dart';
import 'package:book_wallert/screens/login_screens/login_screen.dart';
import 'package:book_wallert/widgets/buttons/custom_button1.dart';
import 'package:book_wallert/colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

// StatefulWidget for SignupScreen to manage state
class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

// State class for SignupScreen
class _SignupScreenState extends State<SignupScreen> {
  final SignupController _signupController = SignupController();
  File? _imageFile;
  final picker = ImagePicker();
  final ImageController _imageController = ImageController();
  late String _imageName;
  bool _isCaptchaVerified = false; // Flag to check if captcha is verified

  @override
  void initState() {
    super.initState();
    // Generate a unique ID for the image name during initialization
    _imageName = 'userprofileimage${generateUniqueId()}';
  }

  // Generate a unique ID for each image file (based on the current timestamp)
  String generateUniqueId() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _uploadImage() async {
    if (_imageFile == null) return;
    await _imageController.uploadImageController(_imageFile!, _imageName);
  }

  Future<void> _onVerify(String token) async {
    print('Token in _onVerify: $token');
    _signupController.recaptchaToken = token;
    setState(() {
      _isCaptchaVerified = true;
    });
  }

  Future<void> _handleSignUp(BuildContext context) async {
    if (!_isCaptchaVerified) {
      // Show WebView for reCAPTCHA verification
      String? token = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CaptchaVerificationScreen(onVerify: _onVerify),
        ),
      );
      print('Received token from CaptchaVerificationScreen: $token');

      if (token != null) {
        _signupController.recaptchaToken = token;
        setState(() {
          _isCaptchaVerified = true;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text("Please verify the CAPTCHA to proceed.")),
        );
        return;
      }
    }

    // If CAPTCHA is verified, upload the image and sign up
    await _uploadImage();
    _signupController.signUp(context, _imageName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.bgColor, // Background color for the screen
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center, // Center the content vertically
            children: <Widget>[
              const SizedBox(height: 80),
              const Text(
                "WELCOME TO BOOKWALLET",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0,
                  color: MyColors.textColor,
                ),
              ),
              const SizedBox(height: 10), // Add some space between widgets
              Stack(
                children: [
                  CircleAvatar(
                    backgroundImage: _imageFile != null
                        ? FileImage(_imageFile!)
                        : const AssetImage('assets/images/placeholder.png'),
                    foregroundColor: MyColors.textColor,
                    radius: 60,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () async {
                        await _pickImage();
                      },
                      child: CircleAvatar(
                        radius: 15,
                        backgroundColor: MyColors.selectedItemColor,
                        child: Icon(Icons.edit, color: MyColors.textColor),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10), // Add some space between widgets
              CustomTextBox1(
                lableText: "UserName",
                type: TextInputType.name,
                controller: _signupController.usernameController,
              ),
              const SizedBox(height: 10), // Add some space between widgets
              CustomTextBox1(
                lableText: "Email",
                type: TextInputType.emailAddress,
                controller: _signupController.emailController,
              ),
              const SizedBox(height: 10), // Add some space between widgets
              CustomTextBox1(
                lableText: "Password",
                type: TextInputType.visiblePassword,
                isPassword: true,
                controller: _signupController.passwordController,
              ),
              const SizedBox(height: 10), // Add some space between widgets
              CustomTextBox1(
                lableText: "Confirm Password",
                type: TextInputType.visiblePassword,
                isPassword: true,
                controller: _signupController.confirmPasswordController,
              ),
              const SizedBox(height: 10), // Add some space between widgets
              CustomTextBox1(
                lableText: "description",
                type: TextInputType.name,
                isPassword: false,
                controller: _signupController.descriptionController,
              ),
              const SizedBox(height: 10), // Add some space between widgets
              CustomButton1(
                text: "Sign up",
                press: () => _handleSignUp(context),
              ),
              const SizedBox(height: 10), // Add some space between widgets
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                child: RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: "Already have an account? ",
                        style:
                            TextStyle(color: MyColors.textColor, fontSize: 12),
                      ),
                      TextSpan(
                        text: "LOG IN",
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// New screen for CAPTCHA verification
class CaptchaVerificationScreen extends StatelessWidget {
  final Future<void> Function(String) onVerify; // Add the onVerify callback
  const CaptchaVerificationScreen({super.key, required this.onVerify});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CAPTCHA Verification"),
      ),
      body: WebViewPlus(
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (controller) {
          controller.loadUrl("assets/webpages/index.html");
        },
        javascriptChannels: Set.from([
          JavascriptChannel(
            name: 'Captcha',
            onMessageReceived: (JavascriptMessage message) async {
              String token = message.message;
              print('Received token: $token'); // Debug: Log token
              await onVerify(token); // Call the onVerify method with the token
              Navigator.pop(
                  context, token); // Close the WebView after verification
            },
          ),
        ]),
      ),
    );
  }
}
