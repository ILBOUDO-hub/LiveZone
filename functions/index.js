const functions = require("firebase-functions");
// The Firebase Admin SDK to access Firestore.
const admin = require("firebase-admin");
const firebaseConfig = {
  apiKey: "AIzaSyBCLEAIjFVaMxuy7HGwU-9qvIfdW5rxcBs",
  authDomain: "fourevent-ea1dc.firebaseapp.com",
  databaseURL: "https://fourevent-ea1dc-default-rtdb.europe-west1.firebasedatabase.app",
  projectId: "fourevent-ea1dc",
  storageBucket: "fourevent-ea1dc.appspot.com",
  messagingSenderId: "1094287475458",
  appId: "1:1094287475458:web:230ed3d774b8fa92b5381b",
};
admin.initializeApp(firebaseConfig);
const auth = admin.auth();
// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
exports.signoutdevice = functions.https.onCall((data, context) => {
  auth.revokeRefreshTokens(context.auth.uid).then((e)=>{
    console.log(e);
  })
      .catch((err)=>{
        console.log(err);
      });
});
