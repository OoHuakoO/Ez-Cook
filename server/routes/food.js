const express = require("express");
const router = express.Router();
const { firestore } = require("../firebase/config");
const { v4: uuidv4} = require("uuid");
const multer = require("multer");
const path = require("path");
// const { search, image } = require("../utils/cloudinary");
let storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, path.join(__dirname, "../../client/assets/pictureUploads"));
  },
  filename: (req, file, cb) => {
    cb(null, file.originalname);
  },
});

let fileFilter = (req, file, cb) => {
  if (
    file.mimetype === "image/jpeg" ||
    file.mimetype === "image/png" ||
    file.mimetype === "image/jpg"
  ) {
    cb(null, true);
  } else {
    return cb(new Error("** ต้องเป็นไฟล์ png หรือ jpeg เท่านั้น **"));
  }
};

let upload = multer({
  storage: storage,
  fileFilter: fileFilter,
  limits: {
    fileSize: 1 * 1024 * 1024,
  },
});

const uploadFile = (req, res, next) => {
  const upload2 = upload.fields([{ name: "imageFood", maxCount: 1 }]);
  upload2(req, res, function (err) {
    if (err instanceof multer.MulterError) {
      return res
        .status(400)
        .json({ msg: "** ไฟล์รูปรวมกันต้องมีขนาดไม่เกิน 1 MB **" });
    } else if (err) {
      return res.status(400).json({ msg: err.message });
    }
    next();
  });
};

// สร้างสูตรอาหาร
router.post("/createFood/:userId", uploadFile, async (req, res) => {
  const userId = req.params.userId;
  const uid = uuidv4();
  var { nameFood, timeCook, categoryFood, ingredient, howCook, linkYoutube } =
    req.body;
  const imageFood = req.files.imageFood;
  const date = Date.now();
  const imageFoodConvertToPath = `assets/pictureUploads/${imageFood[0].filename}`;
  console.log(
    imageFood[0].filename,
    nameFood,
    date,
    timeCook,
    categoryFood,
    ingredient,
    howCook,
    linkYoutube
  );
  await firestore
    .collection("Food")
    .doc(uid)
    .set({
      uid,
      nameFood,
      timeCook,
      categoryFood,
      ingredient,
      howCook,
      linkYoutube,
      date,
      imageFood: imageFoodConvertToPath,
      userId,
      like: 0,
    })
    .then(async () => {
      res.json({ success: true });
    })
    .catch((err) => {
      console.log(err);
    });
});

router.post("/detailFood/:foodId", async (req, res) => {
  const foodId = req.params.foodId;
  const data = [];
  await firestore
    .collection("Food")
    .where("uid", "==", foodId)
    .get()
    .then((querySnapshot) => {
      querySnapshot.forEach((element) => {
        data.push(element.data());
      });
      res.json({ data });
    })
    .catch((err) => {
      console.log(err);
    });
});

router.get("/allFood", async (req, res) => {
  const data = [];
  await firestore
    .collection("Food")
    .orderBy("date", "desc")
    .get()
    .then((querySnapshot) => {
      querySnapshot.forEach((element) => {
        data.push(element.data());
      });
      res.json({ data });
    })
    .catch((err) => {
      console.log(err);
    });
});

router.post("/otherFoodInDetailFood/:userId", async (req, res) => {
  const userId = req.params.userId;
  const data = [];
  await firestore
    .collection("Food")
    .where("userId", "==", userId)
    .orderBy("date", "desc")
    .get()
    .then((querySnapshot) => {
      querySnapshot.forEach((element) => {
        data.push(element.data());
      });
      res.json({ data });
    })
    .catch((err) => {
      console.log(err);
    });
});

router.post("/likeFood/:foodId", async (req, res) => {
  const foodId = req.params.foodId;
  let countLike = 0;
  await firestore
    .collection("Food")
    .where("uid", "==", foodId)
    .get()
    .then((querySnapshot) => {
      querySnapshot.forEach((element) => {
        countLike = element.get("like");
      });
    })
    .then(async () => {
      await firestore
        .collection("Food")
        .doc(foodId)
        .update({ like: countLike + 1 })
        .then(() => {
          res.json({ success: true });
        });
    })
    .catch((err) => {
      console.log(err);
    })
    .catch((err) => {
      console.log(err);
    });
});
router.post("/unlikeFood/:foodId", async (req, res) => {
  const foodId = req.params.foodId;
  let countLike = 0;
  await firestore
    .collection("Food")
    .where("uid", "==", foodId)
    .get()
    .then((querySnapshot) => {
      querySnapshot.forEach((element) => {
        countLike = element.get("like");
      });
    })
    .then(async () => {
      await firestore
        .collection("Food")
        .doc(foodId)
        .update({ like: countLike - 1 })
        .then(() => {
          res.json({ success: true });
        });
    })
    .catch((err) => {
      console.log(err);
    })
    .catch((err) => {
      console.log(err);
    });
});


router.post("/editFood/:foodId", uploadFile, async (req, res) => {
  const foodId = req.params.foodId;
  var { nameFood, timeCook, categoryFood, ingredient, howCook, linkYoutube } =
    req.body;
  const imageFood = req.files.imageFood;
  const date = Date.now();
  if (imageFood == undefined) {
    await firestore
      .collection("Food")
      .doc(foodId)
      .update({
        nameFood,
        timeCook,
        categoryFood,
        ingredient,
        howCook,
        linkYoutube,
        date,
      })
      .then(async () => {
        res.json({ success: true });
      })
      .catch((err) => {
        console.log(err);
      });
  } else if (imageFood != undefined) {
    const imageFoodConvertToPath = `assets/pictureUploads/${imageFood[0].filename}`;
    await firestore
      .collection("Food")
      .doc(foodId)
      .update({
        nameFood,
        timeCook,
        categoryFood,
        ingredient,
        howCook,
        linkYoutube,
        date,
        imageFood: imageFoodConvertToPath,
      })
      .then(async () => {
        res.json({ success: true });
      })
      .catch((err) => {
        console.log(err);
      });
  }
});

router.get("/rankFood", async (req, res) => {
  const data = [];
  await firestore
    .collection("Food")
    .orderBy("like", "desc")
    .get()
    .then((querySnapshot) => {
      querySnapshot.forEach((element) => {
        data.push(element.data());
      });
      res.json({ data });
    })
    .catch((err) => {
      console.log(err);
    });
});

router.post("/createComment/:foodId/:userId", async (req, res) => {
  const userId = req.params.userId;
  const foodId = req.params.foodId;
  let userCommentData = undefined;
  const uid = uuidv4();
  const date = Date.now();
  const { text } = req.body;
  await firestore
    .collection("User")
    .where("uid", "==", userId)
    .get()
    .then((querySnapshot) => {
      querySnapshot.forEach((element) => {
        userCommentData = {
          username: element.get("username"),
          imageProfile: element.get("imageProfile"),
        };
      });
    })
    .then(async () => {
      await firestore
        .collection("Comment")
        .doc(uid)
        .set({ text, date, userCommentData, foodId });
      res.json({ success: true });
    })
    .catch((err) => {
      console.log(err);
    })
    .catch((err) => {
      console.log(err);
    });
});

router.post("/getComment/:foodId", async (req, res) => {
  const foodId = req.params.foodId;
  const data = [];
  await firestore
    .collection("Comment")
    .where("foodId", "==", foodId)
    .orderBy("date", "desc")
    .get()
    .then((querySnapshot) => {
      querySnapshot.forEach((element) => {
        data.push(element.data());
      });
      res.json({ data });
    })
    .catch((err) => {
      console.log(err);
    });
});

module.exports = router;
