const express = require("express");
const router = express.Router();
const { auth, firestore } = require("../firebase/config");
const moment = require("moment");
const { v4: uuidv4, NIL } = require("uuid");
// const cloudinary = require("../utils/cloudinary");
const multer = require("multer");
const path = require("path");

router.post("/login", (req, res) => {
    const { email, password } = req.body;
    console.log(email, password)
    const userLogin = 
    auth
    .signInWithEmailAndPassword(email, password)
    .then((result) => {
        res.json({ user: result });
      })
      .catch((err) => {
        res.status(400).json({ error: err });
      });
});

router.post("/register", async(req, res) => {
    var usernameExist = false;
  var item = [];
  const {
    username,
    email,
    password
  } = req.body;
  console.log(
    username,
    email,
    password
  );
  await firestore
    .collection("User")
    .where("email", "==", email)
    .get()
    .then((querySnapshot) => {
      querySnapshot.forEach((doc) => {
        item.push(doc.data());
      });
      if (item[0] === undefined) {
        auth
          .createUserWithEmailAndPassword(email, password)
          .then((result) => {
            console.log(result);
            if (result) {
              const userRef = firestore.collection("User").doc(result.user.uid);
              userRef.set({
                uid: result.user.uid,
                username: username,
                email: result.user.email,
                password : password
              });
              return res.json({ user: result, usernameExist: usernameExist });
            }
          })
          .catch((err) => {
            res.status(400).json({ error: err });
          });
      } else if (item[0] !== undefined) {
        usernameExist = true;
        return res.json({ usernameExist: usernameExist });
      }
    })
    .catch((err) => {
      console.log(err);
    });
});


router.post("/logout", (req, res) => {
    auth
    .signOut()
    .then(() => {
      console.log("Signout");
    })
    .catch((err) => {
      console.log(err);
    });
});

router.post("/editProfile", (req, res) => {
   
});

router.get("/profile", (req, res) => {
   
});


router.get("/historyFollow", (req, res) => {
   
});

router.get("/historyFollower", (req, res) => {
   
});

router.get("/historyPost", (req, res) => {
   
});

router.post("/followUser", (req, res) => {
   
});

router.post("/unFollowUser", (req, res) => {
   
});





module.exports = router;
