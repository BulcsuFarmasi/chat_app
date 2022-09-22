const functions = require("firebase-functions");
const admin = require('firebase-admin');
exports.myFunction = functions.firestore
    .document("chat/{message}")
    .onCreate((snap, context) => {
      return admin
        .messaging()
        .sendToTopic('chat', {
            notification: {
                title: snap.data().username,
                body: snapshot.data().text
                clickAction: 'FLUTTER_NOTIFICATION_CLICK'
              }
            }
         )

      return;
    });
