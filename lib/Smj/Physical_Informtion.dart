
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import 'package:login/Smj/add_data.dart';
import 'package:login/Smj/utils.dart';

class PhysicalInformationPage extends StatefulWidget {
  const PhysicalInformationPage({super.key});

  @override
  State<PhysicalInformationPage> createState() =>
      _PhysicalInformationPageState();
}

class _PhysicalInformationPageState extends State<PhysicalInformationPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController ageInput = TextEditingController();
  final TextEditingController heightInput = TextEditingController();
  final TextEditingController weightInput = TextEditingController();

  String? genderInput;
  String? bloodGroupInput;
  DateTime? selectedDate;

  Uint8List? _image;
  String imageURL = "";
  String docID = "";

  bool isLoading = false;

  static const Color background = Color(0xFF2C1B36);
  static const Color backgroundDeep = Color(0xFF1B0F22);
  static const Color gold = Color(0xFFD9A659);
  static const Color goldDeep = Color(0xFFC4894A);
  static const Color blush = Color(0xFFF3D9D0);
  static const Color cardColor = Color(0xFF3A2545);

  final List<String> bloodGroups = const [
    'A+',
    'A-',
    'B+',
    'B-',
    'AB+',
    'AB-',
    'O+',
    'O-',
    'None of These',
  ];

  final List<String> genders = const [
    'Male',
    'Female',
    'None of These',
  ];

  @override
  void dispose() {
    ageInput.dispose();
    heightInput.dispose();
    weightInput.dispose();
    super.dispose();
  }

  String? _validateAge(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'This field is mandatory';
    }

    final age = int.tryParse(value.trim());
    if (age == null) {
      return 'Enter proper age.';
    }

    if (age < 1 || age > 120) {
      return 'Enter a realistic age.';
    }

    return null;
  }

  String? _validateHeight(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'This field is mandatory';
    }

    final height = int.tryParse(value.trim());
    if (height == null) {
      return 'Enter proper height.';
    }

    if (height < 50 || height > 250) {
      return 'Enter height in cm.';
    }

    return null;
  }

  String? _validateWeight(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'This field is mandatory';
    }

    final weight = int.tryParse(value.trim());
    if (weight == null) {
      return 'Enter proper weight.';
    }

    if (weight < 10 || weight > 300) {
      return 'Enter weight in kg.';
    }

    return null;
  }

  String formatDate(DateTime date) {
    return '${date.day}-${date.month}-${date.year}';
  }

  String dateDise() {
    return selectedDate != null ? formatDate(selectedDate!) : '';
  }

  void snackBarMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: backgroundDeep,
        content: Text(
          message,
          style: const TextStyle(
            color: blush,
            fontWeight: FontWeight.w600,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: gold,
              onPrimary: Colors.white,
              onSurface: backgroundDeep,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> selectImage() async {
    try {
      final Uint8List img = await pickImage(ImageSource.gallery);
      setState(() {
        _image = img;
      });
    } catch (e) {
      snackBarMessage('Could not select image.');
    }
  }

  Future<String> uploadProfileImage(String uid) async {
    if (_image == null) return "";

    try {
      final String uploadedUrl = await StoreData().saveData(
        file: _image!,
        docId: uid,
      );

      return uploadedUrl;
    } catch (e) {
      print("Image upload failed: $e");
      return "";
    }
  }

  Future<void> proceed({
    required String cha,
    required String name,
    required String pass,
    required String number,
    required String email,
    required String handle,
    required String dateOfBirth,
    required String district,
    required String thana,
  }) async {
    if (!formKey.currentState!.validate()) {
      snackBarMessage('Please fill up all required fields correctly.');
      return;
    }

    if (bloodGroupInput == null || bloodGroupInput!.isEmpty) {
      snackBarMessage('Blood Group field is empty');
      return;
    }

    if (genderInput == null || genderInput!.isEmpty) {
      snackBarMessage('Gender field is empty');
      return;
    }

    if (dateDise().isEmpty) {
      snackBarMessage('Please input your last donation date');
      return;
    }

    setState(() {
      isLoading = true;
    });

    final String age = ageInput.text.trim();
    final String height = heightInput.text.trim();
    final String weight = weightInput.text.trim();
    final String gender = genderInput!.trim();
    final String lastDonation = dateDise();
    final String bloodGroup = bloodGroupInput!.trim();

    try {
      final UserCredential userCredential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: pass,
      );

      final User? user = userCredential.user;

      if (user == null) {
        snackBarMessage('Account creation failed.');
        setState(() {
          isLoading = false;
        });
        return;
      }

      final String id = user.uid;
      docID = id;

      final String uploadedImageURL = await uploadProfileImage(id);
      imageURL = uploadedImageURL;

      final int phoneNumber = int.parse(number);
      final int userAge = int.parse(age);
      final int userHeight = int.parse(height);
      final int userWeight = int.parse(weight);

      final Map<String, dynamic> newUserData = {
        "name": name,
        "number": phoneNumber,
        "email": email,
        "handle": handle,
        "district": district,
        "thana": thana,
        "age": userAge,
        "height": userHeight,
        "weight": userWeight,
        "bloodGroup": bloodGroup,
        "gender": gender,
        "lastDonation": lastDonation,
        "imageURL": imageURL,
        "uid": id,
      };

      await FirebaseFirestore.instance
          .collection("newUserCredentials")
          .doc(id)
          .set(newUserData);

      // Date of birth lives in an owner-only document (see firestore.rules).
      await FirebaseFirestore.instance
          .collection("users")
          .doc(id)
          .collection("private")
          .doc("info")
          .set({"dateOfBirth": dateOfBirth});

      if (!mounted) return;

      setState(() {
        isLoading = false;
      });

      Navigator.pushNamedAndRemoveUntil(
        context,
        '/onBoarding',
            (route) => route.isFirst, // keep the root route so the stack is never empty
      );
    } on FirebaseAuthException catch (ex) {
      setState(() {
        isLoading = false;
      });

      if (ex.code == 'email-already-in-use') {
        snackBarMessage('This email is already in use.');
      } else if (ex.code == 'weak-password') {
        snackBarMessage('Password is too weak.');
      } else {
        snackBarMessage('Account creation failed.');
      }

      print(ex.code.toString());
    } catch (e) {
      setState(() {
        isLoading = false;
      });

      snackBarMessage('Something went wrong. Please try again.');
      print("Signup error: $e");
    }
  }

  InputDecoration _premiumInputDecoration({
    required String hint,
    required IconData icon,
    Widget? suffix,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(
        color: blush.withValues(alpha: 0.38),
        fontSize: 14,
      ),
      prefixIcon: Icon(
        icon,
        color: gold.withValues(alpha: 0.85),
        size: 21,
      ),
      suffixIcon: suffix,
      filled: true,
      fillColor: Colors.white.withValues(alpha: 0.04),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(
          color: Colors.white.withValues(alpha: 0.08),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(
          color: Colors.white.withValues(alpha: 0.08),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(
          color: gold.withValues(alpha: 0.65),
          width: 1.4,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(
          color: Colors.redAccent.withValues(alpha: 0.8),
          width: 1.2,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(
          color: Colors.redAccent.withValues(alpha: 0.9),
          width: 1.4,
        ),
      ),
      errorStyle: TextStyle(
        color: Colors.redAccent.shade100,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _premiumTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    required String? Function(String?) validator,
    String? suffixText,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      style: const TextStyle(
        color: Colors.white,
        fontSize: 15,
        fontWeight: FontWeight.w600,
      ),
      cursorColor: gold,
      decoration: _premiumInputDecoration(
        hint: hint,
        icon: icon,
        suffix: suffixText == null
            ? null
            : Padding(
          padding: const EdgeInsets.only(right: 16),
          child: Center(
            widthFactor: 1,
            child: Text(
              suffixText,
              style: TextStyle(
                color: blush.withValues(alpha: 0.45),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _premiumDropdown({
    required String hint,
    required IconData icon,
    required String? value,
    required List<String> items,
    required void Function(String?) onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: value == null
              ? Colors.white.withValues(alpha: 0.08)
              : gold.withValues(alpha: 0.55),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          dropdownColor: cardColor,
          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: blush.withValues(alpha: 0.55),
          ),
          hint: Row(
            children: [
              Icon(
                icon,
                color: gold.withValues(alpha: 0.85),
                size: 21,
              ),
              const SizedBox(width: 12),
              Text(
                hint,
                style: TextStyle(
                  color: blush.withValues(alpha: 0.38),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _lastDonationField() {
    return GestureDetector(
      onTap: () => _selectDate(context),
      child: Container(
        height: 58,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: selectedDate == null
                ? Colors.white.withValues(alpha: 0.08)
                : gold.withValues(alpha: 0.55),
          ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.calendar_month_rounded,
              color: gold.withValues(alpha: 0.85),
              size: 21,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                selectedDate == null
                    ? 'Last Donation Date'
                    : formatDate(selectedDate!),
                style: TextStyle(
                  color: selectedDate == null
                      ? blush.withValues(alpha: 0.38)
                      : Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Icon(
              Icons.keyboard_arrow_down_rounded,
              color: blush.withValues(alpha: 0.55),
            ),
          ],
        ),
      ),
    );
  }

  Widget _profileImagePicker() {
    return Center(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: gold.withValues(alpha: 0.55),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: gold.withValues(alpha: 0.15),
                  blurRadius: 26,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: CircleAvatar(
              radius: 56,
              backgroundColor: Colors.white.withValues(alpha: 0.08),
              backgroundImage: _image != null
                  ? MemoryImage(_image!)
                  : const AssetImage('assetsSadik/Profile.jpg')
              as ImageProvider,
            ),
          ),
          Positioned(
            right: 0,
            bottom: 2,
            child: GestureDetector(
              onTap: selectImage,
              child: Container(
                height: 38,
                width: 38,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [gold, goldDeep],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: gold.withValues(alpha: 0.35),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.add_a_photo_rounded,
                  color: Colors.white,
                  size: 19,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _header() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(28, 36, 28, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'FINAL STEP',
                  style: TextStyle(
                    color: blush.withValues(alpha: 0.7),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 3,
                  ),
                ),
                const SizedBox(height: 10),
                ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [blush, gold],
                  ).createShader(bounds),
                  child: const Text(
                    'Physical Info',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 31,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Complete your profile to help us create a safer donor record.',
                  style: TextStyle(
                    color: blush.withValues(alpha: 0.58),
                    fontSize: 14,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: gold.withValues(alpha: 0.35),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: gold.withValues(alpha: 0.12),
                  blurRadius: 24,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: const Icon(
              Icons.monitor_heart_rounded,
              color: gold,
              size: 27,
            ),
          ),
        ],
      ),
    );
  }

  Widget _formCard({
    required String line,
    required String name,
    required String pass,
    required String number,
    required String email,
    required String handle,
    required String dateOfBirth,
    required String district,
    required String thana,
  }) {
    return Container(
      padding: const EdgeInsets.fromLTRB(22, 26, 22, 26),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.06),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 30,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            _profileImagePicker(),
            const SizedBox(height: 22),

            _premiumTextField(
              controller: ageInput,
              hint: 'Age',
              icon: Icons.person_add_alt_1_rounded,
              validator: _validateAge,
            ),
            const SizedBox(height: 15),

            _premiumTextField(
              controller: heightInput,
              hint: 'Height',
              icon: Icons.height_rounded,
              suffixText: 'cm',
              validator: _validateHeight,
            ),
            const SizedBox(height: 15),

            _premiumTextField(
              controller: weightInput,
              hint: 'Weight',
              icon: Icons.monitor_weight_outlined,
              suffixText: 'kg',
              validator: _validateWeight,
            ),
            const SizedBox(height: 15),

            _premiumDropdown(
              hint: 'Blood Group',
              icon: Icons.bloodtype_rounded,
              value: bloodGroupInput,
              items: bloodGroups,
              onChanged: (String? value) {
                setState(() {
                  bloodGroupInput = value;
                });
              },
            ),
            const SizedBox(height: 15),

            _premiumDropdown(
              hint: 'Gender',
              icon: Icons.person_outline_rounded,
              value: genderInput,
              items: genders,
              onChanged: (String? value) {
                setState(() {
                  genderInput = value;
                });
              },
            ),
            const SizedBox(height: 15),

            _lastDonationField(),
            const SizedBox(height: 28),

            SizedBox(
              width: double.infinity,
              height: 52,
              child: GestureDetector(
                onTap: isLoading
                    ? null
                    : () {
                  proceed(
                    cha: line,
                    name: name,
                    pass: pass,
                    number: number,
                    email: email,
                    handle: handle,
                    dateOfBirth: dateOfBirth,
                    district: district,
                    thana: thana,
                  );
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    gradient: const LinearGradient(
                      colors: [gold, goldDeep],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: gold.withValues(alpha: 0.35),
                        blurRadius: 18,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: isLoading
                      ? const SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.4,
                      valueColor:
                      AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                      : const Text(
                    'SUBMIT',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      letterSpacing: 2.5,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> formData =
    ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    final String line = formData['cha'];
    final String name = formData['name'];
    final String pass = formData['pass'];
    final String number = formData['number'];
    final String email = formData['email'];
    final String handle = formData['handle'];
    final String dateOfBirth = formData['dateOfBirth'];
    final String district = formData['district'];
    final String thana = formData['thana'];

    return Scaffold(
      backgroundColor: backgroundDeep,
      appBar: AppBar(
        backgroundColor: backgroundDeep,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          color: gold,
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Physical Information',
          style: TextStyle(
            fontSize: 19,
            color: blush,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(0, -0.4),
            radius: 1.3,
            colors: [background, backgroundDeep],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              Positioned(
                top: -70,
                right: -50,
                child: _GlowCircle(
                  color: gold.withValues(alpha: 0.07),
                  size: 220,
                ),
              ),
              Positioned(
                bottom: -90,
                left: -70,
                child: _GlowCircle(
                  color: blush.withValues(alpha: 0.05),
                  size: 260,
                ),
              ),
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _header(),
                    const SizedBox(height: 28),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: _formCard(
                        line: line,
                        name: name,
                        pass: pass,
                        number: number,
                        email: email,
                        handle: handle,
                        dateOfBirth: dateOfBirth,
                        district: district,
                        thana: thana,
                      ),
                    ),
                    const SizedBox(height: 28),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GlowCircle extends StatelessWidget {
  final Color color;
  final double size;

  const _GlowCircle({
    required this.color,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            color,
            color.withValues(alpha: 0),
          ],
        ),
      ),
    );
  }
}