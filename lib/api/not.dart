// var postUrl = "fcm.googleapis.com/fcm/send";

// static Future<void> sendNotification(receiver,msg)async{

// var token = await getToken(receiver);
// print('token : $token');

// final data = {
//   "notification": {"body": "Accept Ride Request", "title": "This is Ride Request"},
//   "priority": "high",
//   "data": {
//     "click_action": "FLUTTER_NOTIFICATION_CLICK",
//     "id": "1",
//     "status": "done"
//   },
//   "to": "$token"
// };

// final headers = {
//   'content-type': 'application/json',
//   'Authorization': 'key=<Your firebase Messaging Api Key Get it from firebase project settings under cloud messaging section>'
// };


// BaseOptions options = new BaseOptions(
//   connectTimeout: 5000,
//   receiveTimeout: 3000,
//   headers: headers,
// );


// try {
// final response = await Dio(options).post(postUrl,
// data: data);

// if (response.statusCode == 200) {
// Fluttertoast.showToast(msg: 'Request Sent To Driver');
// } else {
// print('notification sending failed');
// // on failure do sth
// }
// }
// catch(e){
// print('exception $e');
// }




// }

// static Future<String> getToken(userId)async{

// final Firestore _db = Firestore.instance;

// var token;
// await _db.collection('users')
// .document(userId)
// .collection('tokens').getDocuments().then((snapshot){
// snapshot.documents.forEach((doc){
// token = doc.documentID;
// });
// });

// return token;


// }


// //Now Receiving End

// class _LoginPageState extends State<LoginPage>
//     with SingleTickerProviderStateMixin {

//   final Firestore _db = Firestore.instance;
//   final FirebaseMessaging _fcm = FirebaseMessaging();

//   StreamSubscription iosSubscription;



//   //this code will go inside intiState function

//   if (Platform.isIOS) {
//   iosSubscription = _fcm.onIosSettingsRegistered.listen((data) {
//   // save the token  OR subscribe to a topic here
//   });

//   _fcm.requestNotificationPermissions(IosNotificationSettings());
//   }
//   _fcm.configure(
//   onMessage: (Map<String, dynamic> message) async {
//   print("onMessage: $message");
//   showDialog(
//   context: context,
//   builder: (context) => AlertDialog(
//   content: ListTile(
//   title: Text(message['notification']['title']),
//   subtitle: Text(message['notification']['body']),
//   ),
//   actions: <Widget>[
//   FlatButton(
//   child: Text('Ok'),
//   onPressed: () => Navigator.of(context).pop(),
//   ),
//   ],
//   ),
//   );
// },
// onLaunch: (Map<String, dynamic> message) async {
// print("onLaunch: $message");
// // TODO optional
// },
// onResume: (Map<String, dynamic> message) async {
// print("onResume: $message");
// // TODO optional
// },
// );

// //saving token while signing in or signing up
// _saveDeviceToken(uid) async {
//   FirebaseUser user = await _auth.currentUser();

//   // Get the token for this device
//   String fcmToken = await _fcm.getToken();

//   // Save it to Firestore
//   if (fcmToken != null) {
//     var tokens = _db
//         .collection('users')
//         .document(uid)
//         .collection('tokens')
//         .document(fcmToken);

//     await tokens.setData({
//       'token': fcmToken,
//       'createdAt': FieldValue.serverTimestamp(), // optional
//       'platform': Platform.operatingSystem // optional
//     });
//   }
// }
