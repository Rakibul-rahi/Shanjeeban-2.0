import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class signUpInfo extends StatefulWidget {
  @override
  State<signUpInfo> createState() => _signUpInfo();
}

class _signUpInfo extends State<signUpInfo> {
  var fullNameInput = TextEditingController();
  var passwordInput = TextEditingController();
  var phoneNumberInput = TextEditingController();
  var handleInput = TextEditingController();
  var emailInput = TextEditingController();
  DateTime? selectedDate;
  var districtInput;
  var thanaInput;
  bool _obscurePassword = true;

  int flagCreateAcc = 1;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Premium palette — kept consistent with the rest of the app
  static const Color background = Color(0xFF2C1B36);
  static const Color backgroundDeep = Color(0xFF1B0F22);
  static const Color gold = Color(0xFFD9A659);
  static const Color goldDeep = Color(0xFFC4894A);
  static const Color blush = Color(0xFFF3D9D0);
  static const Color cardColor = Color(0xFF3A2545);
  static const Color fieldFill = Color(0xFF241530);

  /////////////////////////////////////////////  VALIDATOR   ///////////////////////////////////////////////
  String? _validateName(value) {
    if (value!.isEmpty)
      return 'Enter a valid name';
    RegExp nameReg = RegExp(r'^[a-zA-Z ]+$');
    if (!nameReg.hasMatch(value)) {
      return 'Enter a valid name';
    }
    return null;
  }

  String? _validateEmail(value) {
    if (value!.isEmpty) return 'Enter a proper email address';

    RegExp emailReg = RegExp(r'^[\w.+-]+@(([\w-]+\.)+[\w-]{2,4}|(google\.com|outlook\.com|yahoo\.com|aust\.edu|protonmail\.com))$');

    if (!emailReg.hasMatch(value)) {
      return 'Enter a proper email address';
    }
    return null;
  }

  String? _validatePhone(value) {
    if (value!.isEmpty) return 'Phone number must contain 11 digits';
    RegExp phoneReg = RegExp(r'^[0-9]');
    if (!phoneReg.hasMatch(value)) {
      return 'Enter proper number';
    }
    if (value.length != 11) return 'Phone Number must contain 11 digits';
    return null;
  }

  String? _validatePassword(value) {
    if (value!.isEmpty) return 'Password must be 8 characters or longer';
    if (value.length <= 7) return 'Password must be 8 characters or longer';
    return null;
  }

  String? _validateHandle(value) {
    if (value!.isEmpty) return 'Must provide handle';
    return null;
  }
  ////////////////////////////////////////////////  VALIDATOR   ///////////////////////////////////////////////////

  ////////////////////////////////////////////////  SHARED FIELD STYLE   ///////////////////////////////////////////////////
  InputDecoration _fieldDecoration({
    required String label,
    required IconData icon,
  }) {
    return InputDecoration(
      prefixIcon: Icon(icon, color: gold.withValues(alpha: 0.85), size: 21),
      labelText: label,
      labelStyle: TextStyle(
        color: blush.withValues(alpha: 0.55),
        fontSize: 15,
        fontWeight: FontWeight.w500,
      ),
      filled: true,
      fillColor: fieldFill,
      contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 4),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: gold, width: 1.4),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.08), width: 1),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xFFE08B8B), width: 1.2),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xFFE08B8B), width: 1.4),
      ),
      errorStyle: const TextStyle(color: Color(0xFFE08B8B)),
    );
  }

  Widget _dropdownShell({required Widget child}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      height: 62,
      decoration: BoxDecoration(
        color: fieldFill,
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
        borderRadius: BorderRadius.circular(14),
      ),
      child: child,
    );
  }
  ////////////////////////////////////////////////  SHARED FIELD STYLE   ///////////////////////////////////////////////////

  ////////////////////////////////////////////////  DATE OF BIRTH INPUT   ///////////////////////////////////////////////////
  Widget datePicker() {
    return GestureDetector(
      onTap: () {
        _selectDate(context);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        height: 62,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: fieldFill,
          border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
        ),
        child: Row(
          children: [
            Icon(
              Icons.calendar_today_rounded,
              size: 19,
              color: gold.withValues(alpha: 0.85),
            ),
            const SizedBox(width: 12),
            Text(
              selectedDate == null
                  ? 'Insert Date of Birth'
                  : '${selectedDate!.day}-${selectedDate!.month}-${selectedDate!.year}',
              style: TextStyle(
                color: selectedDate == null
                    ? blush.withValues(alpha: 0.55)
                    : Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: gold,
              onPrimary: Colors.white,
              surface: cardColor,
              onSurface: Colors.white,
            ),
            dialogTheme: DialogThemeData(backgroundColor: background),
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

  String formatDate(DateTime date) {
    return '${date.day}-${date.month}-${date.year}';
  }

  String dateDise() {
    String date = "";
    date = selectedDate != null ? formatDate(selectedDate!) : '';
    return date;
  }
  ////////////////////////////////////////////////  DATE OF BIRTH INPUT   ///////////////////////////////////////////////////

  ////////////////////////////////////////////////  LESGO TO SUMIT's PAGE   ///////////////////////////////////////////////////
  void saveUserInfo() {
    String userFullName = fullNameInput.text.toString().trim();
    String userPassword = passwordInput.text.toString().trim();
    String userPhoneNumber = phoneNumberInput.text.toString().trim();
    String userEmail = emailInput.text.toString().trim();
    String userHandle = handleInput.text.toString().trim();
    String userDateOfBirth = selectedDate != null ? formatDate(selectedDate!).trim() : '';

    int etaki244 = int.parse(userPhoneNumber);

    Map<String, dynamic> userData = {
      "number": etaki244,
      "email": userEmail,
    };

    FirebaseFirestore.instance.collection("experiment").add(userData);
  }

  void snackBarMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: backgroundDeep,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        content: Text(
          message,
          style: const TextStyle(color: blush),
        ),
      ),
    );
  }

  void _proceed() async {
    if (_formKey.currentState!.validate()) {
      // form er 5ta thik ase
      if ((dateDise().isEmpty) && (districtInput == null || districtInput.isEmpty) && (thanaInput == null || thanaInput.isEmpty)) {
        snackBarMessage('Date of Birth, District and Thana fields are mandatory.');
        return;
      }
      if ((districtInput == null || districtInput.isEmpty) && (thanaInput == null || thanaInput.isEmpty)) {
        snackBarMessage('Please input District and Thana.');
        return;
      }
      if ((dateDise().isEmpty) && (thanaInput == null || thanaInput.isEmpty)) {
        snackBarMessage('Please input Date of Birth and Thana.');
        return;
      }
      if ((dateDise().isEmpty) && (districtInput == null || districtInput.isEmpty)) {
        snackBarMessage('Please input Date of Birth and District.');
        return;
      }
      if (districtInput == null || districtInput.isEmpty) {
        snackBarMessage('Provide your district info');
        return;
      }
      if (thanaInput == null || thanaInput.isEmpty) {
        snackBarMessage('Provide your thana info');
        return;
      }
      if (dateDise().isEmpty) {
        snackBarMessage('Provide Date of Birth');
        return;
      }

      String userEmail = emailInput.text.toString().trim();
      String userPassword = passwordInput.text.toString().trim();

      setState(() {
        flagCreateAcc = 0;
      });
      print("1st call: $flagCreateAcc");

      String cha = "chaKhabo";
      String userFullName = fullNameInput.text.toString().trim();
      String userPhoneNumber = phoneNumberInput.text.toString().trim();
      String userHandle = handleInput.text.toString().trim();
      String userDateOfBirth = selectedDate != null ? formatDate(selectedDate!).trim() : '';
      String district = districtInput;
      String thana = thanaInput;

      showDialog(
        context: context,
        barrierColor: Colors.black.withValues(alpha: 0.55),
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(gold),
            ),
          );
        },
      );
      Future.delayed(Duration(seconds: 1), () {
        if (!mounted) return;
        Navigator.of(context).pop(); // close the loading dialog
        Navigator.pushNamed(
          context,
          '/physical',
          arguments: {
            'cha': cha,
            'name': userFullName,
            'pass': userPassword,
            'number': userPhoneNumber,
            'email': userEmail,
            'handle': userHandle,
            'dateOfBirth': userDateOfBirth,
            'district': district,
            'thana': thana,
          },
        );
      });
    } else if (!_formKey.currentState!.validate()) {
      //form validate hoy nai
      if ((dateDise().isEmpty) && (districtInput == null || districtInput.isEmpty) && (thanaInput == null || thanaInput.isEmpty)) {
        snackBarMessage('Date of Birth, District and Thana fields are mandatory.');
        return;
      }
      if ((districtInput == null || districtInput.isEmpty) && (thanaInput == null || thanaInput.isEmpty)) {
        snackBarMessage('Please input District and Thana.');
        return;
      }
      if ((dateDise().isEmpty) && (thanaInput == null || thanaInput.isEmpty)) {
        snackBarMessage('Please input Date of Birth and Thana.');
        return;
      }
      if ((dateDise().isEmpty) && (districtInput == null || districtInput.isEmpty)) {
        snackBarMessage('Please input Date of Birth and District.');
        return;
      }
      if (districtInput == null || districtInput.isEmpty) {
        snackBarMessage('Provide your district info');
        return;
      }
      if (thanaInput == null || thanaInput.isEmpty) {
        snackBarMessage('Provide your thana info');
        return;
      }
      if (dateDise().isEmpty) {
        snackBarMessage('Provide Date of Birth');
        return;
      }
    }
  }
  ////////////////////////////////////////////////  LESGO TO SUMIT's PAGE   ///////////////////////////////////////////////////

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundDeep,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
          color: gold,
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Sign Up Info',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            letterSpacing: 1,
            color: blush.withValues(alpha: 0.92),
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(0, -0.5),
            radius: 1.3,
            colors: [background, backgroundDeep],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 8, 24, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'TELL US ABOUT YOU',
                        style: TextStyle(
                          color: blush.withValues(alpha: 0.55),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 2.5,
                        ),
                      ),
                      const SizedBox(height: 8),
                      ShaderMask(
                        shaderCallback: (bounds) =>
                            LinearGradient(colors: [blush, gold]).createShader(bounds),
                        child: const Text(
                          'Create your profile',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.25),
                          blurRadius: 30,
                          offset: const Offset(0, 14),
                        ),
                      ],
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: fullNameInput,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            cursorColor: gold,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                            decoration: _fieldDecoration(
                              label: 'Full Name',
                              icon: Icons.person_outline_rounded,
                            ),
                            validator: _validateName,
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: handleInput,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            cursorColor: gold,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                            decoration: _fieldDecoration(
                              label: 'Handle',
                              icon: Icons.alternate_email_rounded,
                            ),
                            validator: _validateHandle,
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: phoneNumberInput,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            cursorColor: gold,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                            keyboardType: TextInputType.number,
                            decoration: _fieldDecoration(
                              label: 'Phone Number',
                              icon: Icons.phone_outlined,
                            ),
                            validator: _validatePhone,
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: emailInput,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            cursorColor: gold,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                            decoration: _fieldDecoration(
                              label: 'Email',
                              icon: Icons.email_outlined,
                            ),
                            validator: _validateEmail,
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: passwordInput,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            obscureText: _obscurePassword,
                            obscuringCharacter: '•',
                            cursorColor: gold,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                            decoration: _fieldDecoration(
                              label: 'Password',
                              icon: Icons.lock_outline_rounded,
                            ).copyWith(
                              suffixIcon: IconButton(
                                splashRadius: 18,
                                icon: Icon(
                                  _obscurePassword
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                  color: blush.withValues(alpha: 0.45),
                                  size: 20,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscurePassword = !_obscurePassword;
                                  });
                                },
                              ),
                            ),
                            validator: _validatePassword,
                          ),
                          const SizedBox(height: 16),
                          datePicker(),
                          const SizedBox(height: 16),
                          _dropdownShell(
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                hint: Row(
                                  children: [
                                    Icon(Icons.location_on_outlined,
                                        color: gold.withValues(alpha: 0.85), size: 20),
                                    const SizedBox(width: 10),
                                    Text(
                                      "District",
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: blush.withValues(alpha: 0.55),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                value: districtInput,
                                dropdownColor: cardColor,
                                icon: Icon(Icons.keyboard_arrow_down_rounded,
                                    color: gold.withValues(alpha: 0.85)),
                                iconSize: 24,
                                isExpanded: true,
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                                items: [
                                  'Dhaka',
                                ].map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (String? value) {
                                  setState(() {
                                    districtInput = value;
                                  });
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          _dropdownShell(
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                hint: Row(
                                  children: [
                                    Icon(Icons.add_location_alt_outlined,
                                        color: gold.withValues(alpha: 0.85), size: 20),
                                    const SizedBox(width: 10),
                                    Text(
                                      "Thana",
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: blush.withValues(alpha: 0.55),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                value: thanaInput,
                                dropdownColor: cardColor,
                                icon: Icon(Icons.keyboard_arrow_down_rounded,
                                    color: gold.withValues(alpha: 0.85)),
                                iconSize: 24,
                                isExpanded: true,
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                                items: [
                                  'Adabar',
                                  'Badda',
                                  'Bangsal',
                                  'Bimanbandar',
                                  'Cantonment',
                                  'Chowkbazar',
                                  'Darus Salam',
                                  'Demra',
                                  'Dhakshinkhan',
                                  'Dhanmondi',
                                  'Gendaria',
                                  'Gulshan',
                                  'Hazaribagh',
                                  'Jatrabari',
                                  'Kadamtali',
                                  'Kafrul',
                                  'Kalabagan',
                                  'Kamrangirchar',
                                  'Khilgaon',
                                  'Khilkhet',
                                  'Kotwali',
                                  'Lalbagh',
                                  'Mirpur Model',
                                  'Mohammadpur',
                                  'New Market',
                                  'Pallabi',
                                  'Paltan',
                                  'Panthapath',
                                  'Ramna',
                                  'Rampura',
                                  'Sabujbagh',
                                  'Shah Ali',
                                  'Shahba',
                                  'Sher-e-Bangla Nagar',
                                  'Shyampur',
                                  'Sutrapur',
                                  'Tejgaon Industrial Area',
                                  'Tejgaon',
                                  'Turag',
                                  'Uttar Khan',
                                  'Vatara',
                                  'Wari',
                                ].map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (String? value) {
                                  setState(() {
                                    thanaInput = value;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 28),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: GestureDetector(
                      onTap: () {
                        _proceed();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(28),
                          gradient: const LinearGradient(colors: [gold, goldDeep]),
                          boxShadow: [
                            BoxShadow(
                              color: gold.withValues(alpha: 0.35),
                              blurRadius: 18,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          'PROCEED TO PHYSICAL INFO',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                            letterSpacing: 1.6,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 36),
              ],
            ),
          ),
        ),
      ),
    );
  }
}