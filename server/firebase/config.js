const firebase = require("firebase/app");
require("firebase/firestore");
require("firebase/auth");

const firebaseConfig = {
    apiKey: "AIzaSyDor8J_DeL4tPl6LnIUDU0blBNJWQL7asM",
    authDomain: "ezcook-11658.firebaseapp.com",
    projectId: "ezcook-11658",
    storageBucket: "ezcook-11658.appspot.com",
    messagingSenderId: "949651405885",
    appId: "1:949651405885:web:aeb5fe557c1160413e3e54"
};

if (!firebase.apps.length) {
  firebase.initializeApp(firebaseConfig);
}

const auth = firebase.auth();
const firestore = firebase.firestore();

module.exports = {
  auth,
  firestore,
};