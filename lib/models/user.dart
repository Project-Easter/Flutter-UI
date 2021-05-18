//User is defined in FireBase and user.model showing error
class MyAppUser {
  String uid;
  MyAppUser({this.uid});
}

//Example of User from firebase Object
//User(displayName: null, email: null, emailVerified: false, isAnonymous: true, metadata: UserMetadata(creationTime: 2021-03-17 11:07:16.592, lastSignInTime: 2021-03-17 11:07:16.592), phoneNumber: null, photoURL: null, providerData, [], refreshToken: , tenantId: null, uid: OS17XNHPeOdC33SOU4nh8tZ9PfD3)

class UserData {
  String uid;
  String displayName;
  String email;
  bool emailVerified;
  String refreshToken;
  //this is not required.Just for test purpose
  bool isAnonymous;
  String phoneNumber;
  String photoURL;
  //**Add additional information on User preferences,favBook,author,location etc here
  String city;
  String state;
  // Map<String, dynamic> location;
  // Region:MH,City:Nagpur,lat:68.68778,lon:68.977
  double latitude;
  double longitude;
  double locationRange;
  //Preferences
  Map<String, dynamic> preferences;
  UserData(
      {this.uid,
      this.displayName,
      this.email,
      this.emailVerified,
      this.isAnonymous,
      this.phoneNumber,
      this.photoURL,
      this.city,
      this.state,
      this.refreshToken,
      this.latitude = 0.0,
      this.longitude = 0.0,
      this.preferences,
      this.locationRange});
//Add Refresh Token Later
}
