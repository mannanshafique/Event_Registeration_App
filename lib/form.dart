class FeedbackForm {
  String _name;
  String _email;
  String _mobileNo;
  String _gender;

  FeedbackForm(this._name, this._email, this._mobileNo, this._gender);

  // Method to make GET parameters.
  String toParams() =>
      "?name=$_name&email=$_email&mobileno=$_mobileNo&gender=$_gender";
}
