const functions = require("firebase-functions");
const admin = require('firebase-admin');
exports.myFunction = functions.firestore
    .document("chat/{message}")
    .onCreate((snap, context) => {
      console.log(snap.data());

      return;
    });
