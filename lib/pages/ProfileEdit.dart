import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login/Smj/add_data.dart';
import 'package:login/Smj/utils.dart';

class editProfile extends StatefulWidget {
  const editProfile({super.key});

  @override
  State<editProfile> createState() => _editProfileState();
}

class _editProfileState extends State<editProfile> {

  // final formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  /////////////////////////////////////////////  TEXT CONTROLLERS   ///////////////////////////////////////////////
  var fullNameInput = TextEditingController();
  var passwordInput = TextEditingController();
  var phoneNumberInput = TextEditingController();
  var handleInput = TextEditingController();
  var emailInput = TextEditingController();
  DateTime? selectedDate;
  var districtInput;
  var thanaInput;
  var   genderInput;
  var   ageInput = TextEditingController();
  var   heightInput = TextEditingController();
  var   weightInput = TextEditingController();
  var   bloodGroupInput ;
  var   lastDonationInput ;
  DateTime? selectedDonationDate;
  String imageURL = "";
  String docID = "";
  int flagCreateAcc = 1;

  /////////////////////////////////////////////  TEXT CONTROLLERS   ///////////////////////////////////////////////


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
    if (value!.isEmpty) return 'Enter an proper email address';
    RegExp emailReg = RegExp(r'^[\w-]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailReg.hasMatch(value)) {
      return 'Enter an proper email address';
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
  String? _validateAge(value) {
    if (value!.isEmpty) return 'This field is mandatory';
    RegExp phoneReg = RegExp(r'^[0-9]');
    if (!phoneReg.hasMatch(value)) {
      return 'Enter proper age.';
    }
    return null;
  }
  String? _validateWeight(value) {
    if (value!.isEmpty) return 'This field is mandatory';
    RegExp phoneReg = RegExp(r'^[0-9]');
    if (!phoneReg.hasMatch(value)) {
      return 'Enter proper weight.';
    }
    return null;
  }
  String? _validateHeight(value) {
    if (value!.isEmpty) return 'This field is mandatory';
    RegExp phoneReg = RegExp(r'^[0-9]');
    if (!phoneReg.hasMatch(value)) {
      return 'Enter proper height.';
    }
    return null;
  }
  ////////////////////////////////////////////////  VALIDATOR   ///////////////////////////////////////////////////


  ////////////////////////////////////////////////  DATE INPUT   ///////////////////////////////////////////////////
  Widget datePicker() {
    return GestureDetector(
      onTap: () {
        _selectDate(context);
      },
      child: Container(
        padding: EdgeInsets.all(11.6),
        height: 62,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13),
          color: Colors.white,
          border: Border.all(
            color: Colors.amber,
            width: 4,
          ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.calendar_today,
              size: 20,
              color: Colors.black,
            ),
            SizedBox(width: 8),
            Text(
              selectedDate == null
                  ? ' Insert Date of Birth'
                  : '${selectedDate!.day}-${selectedDate!.month}-${selectedDate!.year}',
              style: TextStyle(
                color: Colors.black,
                fontSize: 17,
                fontWeight: FontWeight.bold,
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
  String dateDise(){
    String date = "";
    date = selectedDate != null ? formatDate(selectedDate!) : '';
    return date;
  }


  Widget  LastDonationDate() {
    return GestureDetector(
      onTap: () {
        _selectDate(context);
      },
      child: Container(
        padding: EdgeInsets.all(15),
        height: 60,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(13.0),
            border: Border.all(
              color: Colors.amber ,
              width: 4,
            )
        ),
        child: Row(

          children: [
            Icon(
              Icons.calendar_today,
              size: 21,
              color: Colors.black,
            ),
            SizedBox(width: 8),
            Text(
              selectedDonationDate == null
                  ? '   Last Donation Date'
                  : '${selectedDonationDate!.day}-${selectedDonationDate!.month}-${selectedDonationDate!.year}',
              style: TextStyle(
                fontSize: 17,
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins-Medium',
              ),
            ),

            SizedBox(width: 83),


          ],
        ),
      ),
    );
  }
  Future<void> _selectDonationDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != selectedDonationDate) {
      setState(() {
        selectedDonationDate = picked;
      });
    }
  }
  String formatDonationDate(DateTime date) {
    return '${date.day}-${date.month}-${date.year}';
  }
  String dateDonationDise(){
    String date = "";
    date = selectedDonationDate != null ? formatDate(selectedDonationDate!) : '';
    return date;
  }
  ////////////////////////////////////////////////  DATE INPUT   ///////////////////////////////////////////////////


  ////////////////////////////////////////////////  SELECT IMAGE   ///////////////////////////////////////////////////
  Uint8List? _image;

  void selectImage() async{
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  void saveProfile() async{

    String resp = await StoreData().saveData(
      file: _image!,
      docId: docID,
    );

    setState(() {
      imageURL = resp;
    });

  }
  bool isLoading = false;
  ////////////////////////////////////////////////  SELECT IMAGE  ///////////////////////////////////////////////////


  @override
  Widget build(BuildContext context) {

    final Map<String, dynamic> formData = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    fullNameInput.text = formData['name'];
    passwordInput.text = formData['pass'];
    phoneNumberInput.text = formData['number'];
    emailInput.text = formData['email'];
    handleInput.text = formData['handle'];
    selectedDate = formData['dateOfBirth'];
    districtInput.text = formData['district'];
    thanaInput.text = formData['thana'];
    ageInput.text = formData['age'];
    heightInput.text = formData['height'];
    weightInput.text = formData['weight'];
    selectedDonationDate = formData['lastDonation'];
    bloodGroupInput.text = formData['bloodGroup'];
    genderInput.text = formData['gender'];


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff2a2a2b),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.red,
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Update Profile Info',
          style: TextStyle(
            fontSize: 22,
            color: Colors.white,
          ),
        ),
      ),
      backgroundColor: Colors.blueGrey,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(height: 15,),
                      Stack(
                        children: [
                          _image != null ?
                          CircleAvatar(
                            radius: 70,
                            backgroundImage: MemoryImage(_image!),
                          ):

                          const CircleAvatar(
                            radius: 70,
                            backgroundImage: AssetImage('assetsSadik/Profile.jpg'),
                          ),
                          Positioned(
                            child: IconButton(
                              onPressed: selectImage,
                              icon: const Icon(Icons.add_a_photo),
                              color: Colors.amber,
                            ),
                            bottom: -10,
                            left: 80,
                          )
                        ],
                      ),
                      SizedBox(height: 22,),
                      TextFormField(
                        controller: fullNameInput,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        cursorColor: Colors.black,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.account_box,
                            color: Colors.black,
                          ),
                          labelText: 'Full Name',
                          labelStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(13),
                            borderSide: BorderSide(
                              color: Colors.green,
                              width: 4,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(13),
                            borderSide: BorderSide(
                              color: Colors.amber,
                              width: 4,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(13),
                            borderSide: BorderSide(
                              color: Color(0xffc22333),
                              width: 4,
                            ),
                          ),
                          errorStyle: TextStyle(color: Colors.red),
                        ),
                        validator: _validateName,
                      ),
                      SizedBox(height: 15,),
                      TextFormField(
                        controller: handleInput,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        cursorColor: Colors.black,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.supervisor_account,
                            color: Colors.black,
                          ),
                          labelText: 'Handle',
                          labelStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(13),
                            borderSide: BorderSide(
                              color: Colors.green,
                              width: 4,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(13),
                            borderSide: BorderSide(
                              color: Colors.amber,
                              width: 4,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(13),
                            borderSide: BorderSide(
                              color: Color(0xffc22333),
                              width: 4,
                            ),
                          ),
                          errorStyle: TextStyle(color: Colors.red),
                        ),
                        validator: _validateHandle,
                      ),
                      SizedBox(height: 15,),
                      TextFormField(
                        controller: phoneNumberInput,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        cursorColor: Colors.black,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.phone,
                            color: Colors.black,
                          ),
                          labelText: 'Phone Number',
                          labelStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(13),
                            borderSide: BorderSide(
                              color: Colors.green,
                              width: 4,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(13),
                            borderSide: BorderSide(
                              color: Colors.amber,
                              width: 4,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(13),
                            borderSide: BorderSide(
                              color: Color(0xffc22333),
                              width: 4,
                            ),
                          ),
                          errorStyle: TextStyle(color: Colors.red),
                        ),
                        validator: _validatePhone,
                      ),
                      SizedBox(height: 15,),
                      TextFormField(
                        controller: emailInput,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        cursorColor: Colors.black,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.email,
                            color: Colors.black,
                          ),
                          labelText: 'Email',
                          labelStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(13),
                            borderSide: BorderSide(
                              color: Colors.green,
                              width: 4,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(13),
                            borderSide: BorderSide(
                              color: Colors.amber,
                              width: 4,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(13),
                            borderSide: BorderSide(
                              color: Color(0xffc22333),
                              width: 4,
                            ),
                          ),
                          errorStyle: TextStyle(color: Colors.red),
                        ),
                        validator: _validateEmail,
                      ),
                      SizedBox(height: 15,),
                      TextFormField(
                        controller: passwordInput,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        obscureText: true,
                        obscuringCharacter: '*',
                        cursorColor: Colors.black,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.key,
                            color: Colors.black,
                          ),
                          labelText: 'Password',
                          labelStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(13),
                            borderSide: BorderSide(
                              color: Colors.green,
                              width: 4,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(13),
                            borderSide: BorderSide(
                              color: Colors.amber,
                              width: 4,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(13),
                            borderSide: BorderSide(
                              color: Color(0xffc22333),
                              width: 4,
                            ),
                          ),
                          errorStyle: TextStyle(color: Colors.red),
                        ),
                        validator: _validatePassword,
                      ),
                      SizedBox(height: 15,),
                      datePicker(),
                      SizedBox(height: 15,),
                      Container(
                        padding: EdgeInsets.all(15.0),
                        height: 62,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.amber,
                            width: 4,
                          ),
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        child: DropdownButton<String>(
                          hint: Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: Colors.black,
                              ),
                              Text(
                                " District",
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          value: districtInput,
                          dropdownColor: Colors.white,
                          icon: Icon(
                            Icons.arrow_drop_down_circle,
                            color: Colors.black,
                          ),
                          iconSize: 22, // Adjusted icon size
                          iconEnabledColor: Colors.black,
                          isExpanded: true,
                          focusColor: Colors.red,
                          underline: SizedBox(),
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          items: [
                            'Dhaka',
                          ].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(
                                  color: districtInput == value ? Colors.black : Colors.black,
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            setState(() {
                              districtInput = value;
                            });
                          },
                        ),
                      ),
                      SizedBox(height: 15,),
                      Container(
                        padding: EdgeInsets.all(15.0),
                        height: 62,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.amber,
                            width: 4,
                          ),
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        child: DropdownButton<String>(
                          hint: Row(
                            children: [
                              Icon(
                                Icons.add_location,
                                color: Colors.black,
                              ),
                              Text(
                                " Thana",
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          value: thanaInput,
                          dropdownColor: Colors.white,
                          icon: Icon(
                            Icons.arrow_drop_down_circle,
                            color: Colors.black,
                          ),
                          iconSize: 22,
                          iconEnabledColor: Colors.black,
                          isExpanded: true,
                          focusColor: Colors.red,
                          underline: SizedBox(),
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
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
                              child: Text(
                                value,
                                style: TextStyle(
                                  fontSize: 17,
                                  color: thanaInput == value ? Colors.black : Colors.black,
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            setState(() {
                              thanaInput = value;
                            });
                          },
                        ),
                      ),
                      SizedBox(height: 20,),
                      TextFormField(
                        controller: ageInput,
                        keyboardType: TextInputType.number,

                        style: TextStyle(
                            fontSize: 17,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins-Medium'),
                        decoration: InputDecoration(filled: true, fillColor: Colors.white,
                          contentPadding: EdgeInsets.all(17),
                          prefixIcon: Icon(
                            Icons.person_add,
                            color: Colors.black,
                          ),
                          labelText: " Age",
                          labelStyle: TextStyle(
                              fontSize: 17,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins-Medium'),
                          border:
                          OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.amber),
                            borderRadius: BorderRadius.circular(13.0),
                          ),
                          enabledBorder:  OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.amber, width: 4.0),
                            borderRadius: BorderRadius.circular(13.0),
                          ),
                          focusedBorder:  OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green, width: 4.0),
                            borderRadius: BorderRadius.circular(13.0),
                          ),
                        ),
                        validator: _validateAge,
                      ),
                      SizedBox(height: 19.0),
                      TextFormField(
                        controller: heightInput,
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                            fontSize: 17,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins-Medium'),
                        decoration: InputDecoration(filled: true, fillColor: Colors.white,
                          contentPadding: EdgeInsets.all(17),
                          prefixIcon: Icon(
                            Icons.height,
                            color: Colors.black,
                          ),
                          labelText: " Height (in cm)",
                          labelStyle: TextStyle(
                            fontSize: 17,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins-Medium',
                          ),
                          border:
                          OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.amber),
                            borderRadius: BorderRadius.circular(13.0),
                          ),
                          enabledBorder:  OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.amber, width: 4.0),
                            borderRadius: BorderRadius.circular(13.0),
                          ),
                          focusedBorder:  OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green, width: 4.0),
                            borderRadius: BorderRadius.circular(13.0),
                          ),
                        ),
                        validator: _validateHeight,
                      ),
                      SizedBox(height: 19.0),
                      TextFormField(
                        controller: weightInput,
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                            fontSize: 17,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins-Medium'),
                        decoration: InputDecoration(filled: true, fillColor: Colors.white,
                          contentPadding: EdgeInsets.all(17),
                          prefixIcon: Icon(
                            Icons.line_weight,
                            color: Colors.black,
                          ),
                          labelText: " Weight (in kg)",
                          labelStyle: TextStyle(
                              fontSize: 17,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins-Medium'),

                          border:
                          OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.amber),
                            borderRadius: BorderRadius.circular(13.0),
                          ),
                          enabledBorder:  OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.amber, width: 4.0),
                            borderRadius: BorderRadius.circular(13.0),
                          ),
                          focusedBorder:  OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green, width: 4.0),
                            borderRadius: BorderRadius.circular(13.0),
                          ),
                        ),
                        validator: _validateWeight,
                      ),
                      SizedBox(height: 19.0),
                      Container(
                        padding: EdgeInsets.all(15.0),
                        height: 63,

                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.amber,width: 4),
                          borderRadius: BorderRadius.circular(13.0),
                        ),
                        child: DropdownButton<String>(
                          hint: Row(
                            children: [
                              Icon(
                                Icons.bloodtype,
                                color: Colors.black,
                              ),
                              Text("   Blood Group",
                                style: TextStyle(
                                    fontSize:17 ,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins-Medium'),
                              ),
                            ],
                          ),


                          value:  bloodGroupInput,
                          dropdownColor: Colors.white,
                          icon: Icon(Icons.add),
                          iconSize: 26,
                          iconEnabledColor: Colors.black,
                          isExpanded: true,
                          underline: SizedBox(),
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins-Medium'),

                          items: [
                            'A+',
                            'A-',
                            'B+',
                            'B-',
                            'AB+',
                            'AB-',
                            'O+',
                            'O-',
                            'None of These'
                          ].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            setState(() {
                              bloodGroupInput = value;
                            });
                          },
                        ),
                      ),
                      SizedBox(height: 19.0),
                      Container(
                        padding: EdgeInsets.all(15.0),
                        height: 62,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.amber,width: 4),
                          borderRadius: BorderRadius.circular(13.0),
                        ),
                        child: DropdownButton<String>(
                          hint: Row(
                            children: [
                              Icon(
                                Icons.perm_identity_sharp,
                                color: Colors.black,
                              ),

                              Text("    Gender",
                                style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins-Medium'),
                              ),
                            ],
                          ),
                          value:genderInput ,
                          dropdownColor: Colors.white,
                          icon: Icon(Icons.add),
                          iconSize: 25,
                          iconEnabledColor: Colors.black,
                          isExpanded: true,
                          underline: SizedBox(),
                          style: TextStyle(
                              fontSize: 17,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins-Medium'),

                          items: [
                            'Male',
                            'Female',
                            'None of These'
                          ].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            setState(() {
                              genderInput = value;
                            });
                          },
                        ),
                      ),
                      SizedBox(height: 19.0),
                      LastDonationDate (),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 10,),
              ElevatedButton(
                onPressed: () {

                  /*showDialog(
                    context: context,
                    builder: (context){
                      return Center(child: CircularProgressIndicator());
                    }
                  );*/

                  //_proceed();
                  // Navigator.of(context).pop();
                },

                style: ButtonStyle(
                  elevation: WidgetStateProperty.all<double>(10.0),
                  backgroundColor: WidgetStateProperty.all<Color>(Colors.red),
                  foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
                  padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                    EdgeInsets.symmetric(vertical: 12, horizontal: 30),
                  ),

                ),

                child: Text(
                  'Save changes',
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
              ),
              //SizedBox(height: 30,),
            ],
          ),
        ),
      ),
    );
  }
}


// class _PhysicalInformationPageState extends State<PhysicalInformationPage> {
//
//
//   void snackBarMessage(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//       ),
//     );
//   }
//   void proceed ({required String cha, required String name, required String pass, required String number, required String email, required String handle, required String dateOfBirth, required String district, required String thana}) async {
//     if (formKey.currentState!.validate()) {
//       if ((dateDise().isEmpty) && (BloodGroupInput == null || BloodGroupInput.isEmpty) && (GenderInput == null || GenderInput.isEmpty)) {
//         snackBarMessage('Date of Birth, Blood Group and Gender fields are mandatory.');
//         return;
//       }
//       if ((BloodGroupInput == null || BloodGroupInput.isEmpty) && (GenderInput == null || GenderInput.isEmpty)) {
//         snackBarMessage('Please input Blood Group and Gender.');
//         return ;
//       }
//       if ((dateDise().isEmpty) && (GenderInput == null || GenderInput.isEmpty)) {
//         snackBarMessage('Please input Date of Birth and Gender.');
//         return ;
//       }
//       if ((dateDise().isEmpty) && (BloodGroupInput == null || BloodGroupInput.isEmpty)) {
//         snackBarMessage('Please input Date of Birth and Blood Group.');
//         return ;
//       }
//       if (BloodGroupInput == null || BloodGroupInput.isEmpty) {
//         snackBarMessage('Blood Group field is empty');
//         return ;
//       }
//       if (GenderInput == null || GenderInput.isEmpty) {
//         snackBarMessage('Gender field is empty');
//         return ;
//       }
//       if (dateDise().isEmpty) {
//         snackBarMessage('Please input your date of birth');
//         return ;
//       }
//
//       String age = AgeInput.text.toString().trim();
//       String height = HeightInput.text.toString().trim();
//       String weight = WeightInput.text.toString().trim();
//       String gender = GenderInput.toString().trim();
//       String lastDonation = dateDise();
//       String bloodGroup = BloodGroupInput.toString().trim();
//       String ID = "";
//       String docID = "";
//
//
//       try {
//         UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: pass);
//         if(userCredential.user != null){
//           print("user created successfully.");
//
//           ID = userCredential.user!.uid;
//           print(ID);
//
//           int etaki244 = int.parse(number);
//           int boyosh = int.parse(age);
//           int ucchota = int.parse(height);
//           int vor = int.parse(weight);
//
//           /* Map <String, dynamic> userData = {
//             "name" : name,
//             "pass" : pass,
//             "number" : etaki244,
//             "name" : name,
//             "email" : email,
//             "handle" : handle,
//             "dateOfBirth" : dateOfBirth,
//             "district" : district,
//             "thana" : thana,
//             "age" : boyosh,
//             "height" : ucchota,
//             "weight" : vor,
//             "bloodGroup" : bloodGroup,
//             "gender" : gender,
//             "lastDonation" : lastDonation,
//           };
//
//           FirebaseFirestore.instance.collection("userCredentials").add(userData);
//           Navigator.pushNamed(context, '/physical');
//
//           DocumentReference documentReference1 = await FirebaseFirestore.instance.collection("userCredentials").doc(email);
//           await documentReference1.set(userData)
//               .then((value) {
//             print("Document added successfully!");
//             // docID = email;
//             print("Document ID: $docID");
//           })
//               .catchError((error) {
//             print("Error adding document: $error");
//           });
//
//
//
//           Map<String, dynamic> uData = {
//             "email": email,
//             "docID": email,
//             "name" : name,
//             "pass" : pass,
//             "number" : etaki244,
//             "name" : name,
//             "handle" : handle,
//             "dateOfBirth" : dateOfBirth,
//             "district" : district,
//             "thana" : thana,
//             "age" : boyosh,
//             "height" : ucchota,
//             "weight" : vor,
//             "bloodGroup" : bloodGroup,
//             "gender" : gender,
//             "lastDonation" : lastDonation,
//           };
//
//           DocumentReference docRef = await FirebaseFirestore.instance.collection("userIdHolder").doc(ID);
//           await docRef.set(uData)
//               .then((value) {
//             print("Document added successfully!");
//             // docID = email;
//             print("Document ID: $docID");
//           })
//               .catchError((error) {
//             print("Error adding document: $error");
//           });*/
//
//
//
//           Map <String, dynamic> newUserData = {
//             "name" : name,
//             "pass" : pass,
//             "number" : etaki244,
//             "email" : email,
//             "handle" : handle,
//             "dateOfBirth" : dateOfBirth,
//             "district" : district,
//             "thana" : thana,
//             "age" : boyosh,
//             "height" : ucchota,
//             "weight" : vor,
//             "bloodGroup" : bloodGroup,
//             "gender" : gender,
//             "lastDonation" : lastDonation,
//             "uid" : ID,
//           };
//
//           DocumentReference documentReference4 = await FirebaseFirestore.instance.collection("newUserCredentials").doc(ID);
//           await documentReference4.set(newUserData)
//               .then((value) {
//             print("Document added successfully!");
//             docID = ID;
//             print("Document ID: $ID");
//           })
//               .catchError((error) {
//             print("Error adding document: $error");
//           });
//
//
//
//           Map <String, dynamic> newUserData6 = {
//             "name" : name,
//             "pass" : pass,
//             "number" : etaki244,
//             "email" : email,
//             "handle" : handle,
//             "dateOfBirth" : dateOfBirth,
//             "district" : district,
//             "thana" : thana,
//             "age" : boyosh,
//             "height" : ucchota,
//             "weight" : vor,
//             "bloodGroup" : bloodGroup,
//             "gender" : gender,
//             "lastDonation" : lastDonation,
//             "uid" : ID,
//             "imageURL" : imageURL,
//           };
//
//           DocumentReference documentReference6 = await FirebaseFirestore.instance.collection("newrrrrrUserCredentials").doc(ID);
//           await documentReference6.set(newUserData6)
//               .then((value) {
//             print("Document added successfully!");
//             docID = ID;
//             print("Document ID: $ID");
//           })
//               .catchError((error) {
//             print("Error adding document: $error");
//           });
//
//         }
//       } on FirebaseAuthException catch (ex) {
//         print(ex.code.toString());
//         snackBarMessage('error occured.');
//         // if(ex.code.toString() == "weak-password"){}  eivabe specific error dhora jabe
//       }
//
//       print("form filled up");
//       print("to login");
//       print(cha);
//       print(name);
//       print(pass);
//       print(number);
//       print(handle);
//       print(dateOfBirth);
//       print(email);
//       print(age);
//       print(height);
//       print(weight);
//       print(gender);
//       print(lastDonation);
//       print(bloodGroup);
//       print(cha);
//       print("storing info in database");
//
//       showDialog(
//           context: context,
//           builder: (context){
//             return Center(child: CircularProgressIndicator());
//           }
//       );
//
//       Future.delayed(Duration(seconds: 2), () {
//         Navigator.pushNamed(context, '/onBoarding'
//         ).then((_) {
//           Navigator.of(context).pop();
//         });
//       });
//     }
//
//     else if (!formKey.currentState!.validate()) {
//       if ((dateDise().isEmpty) && (BloodGroupInput == null || BloodGroupInput.isEmpty) && (GenderInput == null || GenderInput.isEmpty)) {
//         snackBarMessage('Date of Birth, Blood Group and Gender fields are mandatory.');
//         return ;
//       }
//       if ((BloodGroupInput == null || BloodGroupInput.isEmpty) && (GenderInput == null || GenderInput.isEmpty)) {
//         snackBarMessage('Please input Blood Group and Gender.');
//         return ;
//       }
//       if ((dateDise().isEmpty) && (GenderInput == null || GenderInput.isEmpty)) {
//         snackBarMessage('Please input Date of Birth and Gender.');
//         return ;
//       }
//       if ((dateDise().isEmpty) && (BloodGroupInput == null || BloodGroupInput.isEmpty)) {
//         snackBarMessage('Please input Date of Birth and Blood Group.');
//         return ;
//       }
//       if (BloodGroupInput == null || BloodGroupInput.isEmpty) {
//         snackBarMessage('Blood Group field is empty');
//         return ;
//       }
//       if (GenderInput == null || GenderInput.isEmpty) {
//         snackBarMessage('Gender field is empty');
//         return ;
//       }
//       if (dateDise().isEmpty) {
//         snackBarMessage('Please input your date of birth');
//         return ;
//       }
//     }
//
//   }
//
//
//
//
// }
