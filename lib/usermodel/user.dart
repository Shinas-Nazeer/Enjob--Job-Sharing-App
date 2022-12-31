

class UserCurrent {
  // ignore: non_constant_identifier_names
 final String ApplicantEmail;
  // ignore: non_constant_identifier_names
  final String ApplicantId;
   // ignore: non_constant_identifier_names
  final  String     ApplicantImage;
    // ignore: non_constant_identifier_names
  final  String    Applicantname;

  UserCurrent(this.ApplicantEmail, this.ApplicantId, this.ApplicantImage, this.Applicantname);

  Map<String, dynamic> toJson() => {
              'ApplicantEmail': ApplicantEmail,
        'ApplicantId': ApplicantId,
        'ApplicantImage':ApplicantImage,
        'Applicantname': Applicantname,
      };
}