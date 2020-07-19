import 'dart:async';

import 'package:event_registration_using_spreedsheet/form.dart';
import 'package:event_registration_using_spreedsheet/networking.dart';
import 'package:flutter/material.dart';
import 'Constants/constant.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Event Registration",
      theme: ThemeData(primarySwatch: Colors.red),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  // TextField Controllers
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  final RoundedLoadingButtonController _btnController =
      new RoundedLoadingButtonController();

  void _submitForm() {
    if (_formKey.currentState.validate()) {
      FeedbackForm feedbackForm = FeedbackForm(nameController.text,
          emailController.text, mobileNoController.text, genderController.text);

      FormController formController = FormController((String response) {
        print("Response: $response");
        if (response == FormController.STATUS_SUCCESS) {
          //
          _showSnackbar("Submitted");
        } else {
          _showSnackbar("Error Occurred!");
        }
      });

      _showSnackbar("Sucessfuly Registered");

      // Submit 'info' and save it in Google Sheet

      formController.submitForm(feedbackForm);
    }
    Timer(Duration(seconds: 3), () {
      _btnController.reset();
    });

    nameController.clear();
    emailController.clear();
    mobileNoController.clear();
    genderController.clear();
  }

  // Method to show snackbar with 'message'.
  _showSnackbar(String message) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Color(0xffd009fd),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/imgdone.jpg"), fit: BoxFit.cover)),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          key: _scaffoldKey,
          body: SingleChildScrollView(
            child: Center(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 50, horizontal: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 180,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [BoxShadow(color: Colors.black)],
                          image: DecorationImage(
                              image: AssetImage("images/techno.jpg"),
                              fit: BoxFit.fitWidth)),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Registration Form",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30.0,
                              color: Colors.white),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          TextFormField(
                            controller: nameController,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Enter Valid Name";
                              }
                              return null;
                            },
                            textCapitalization: TextCapitalization.words,
                            keyboardType: TextInputType.text,
                            style: TextStyle(color: kwhiteColor, fontSize: 20),
                            decoration: InputDecoration(
                              enabledBorder: kenabledBorder,
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(
                                Icons.person,
                                color: kwhiteColor,
                              ),
                              labelStyle: kTextStyle,
                              labelText: "Name",
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            controller: emailController,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Enter Valid Email";
                              }
                              return null;
                            },
                            keyboardType: TextInputType.emailAddress,
                            style: TextStyle(color: kwhiteColor, fontSize: 20),
                            decoration: InputDecoration(
                                enabledBorder: kenabledBorder,
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(
                                  Icons.email,
                                  color: kwhiteColor,
                                ),
                                labelStyle: kTextStyle,
                                labelText: "Email"),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            controller: mobileNoController,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Enter Valid Phone Number";
                              }
                              return null;
                            },
                            keyboardType: TextInputType.number,
                            style: TextStyle(color: kwhiteColor, fontSize: 20),
                            decoration: InputDecoration(
                                enabledBorder: kenabledBorder,
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(
                                  Icons.phone_android,
                                  color: kwhiteColor,
                                ),
                                labelStyle: kTextStyle,
                                labelText: "Phone Number"),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            controller: genderController,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Enter Gender";
                              }
                              return null;
                            },
                            textCapitalization: TextCapitalization.words,
                            keyboardType: TextInputType.text,
                            style: TextStyle(color: kwhiteColor, fontSize: 20),
                            decoration: InputDecoration(
                                enabledBorder: kenabledBorder,
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(
                                  Icons.accessibility,
                                  color: kwhiteColor,
                                ),
                                labelStyle: kTextStyle,
                                labelText: "Gender"),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              RoundedLoadingButton(
                                duration: Duration(seconds: 3),
                                controller: _btnController,
                                color: Color(0xff4004d5),
                                animateOnTap: true,
                                child: Text('Submit',
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white)),
                                onPressed: _submitForm,
                                width: 200,
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
