const express = require("express");
const router = express.Router();
const { firestore } = require("../firebase/config");
const moment = require("moment");
const { v4: uuidv4, NIL } = require("uuid");
// const cloudinary = require("../utils/cloudinary");
const multer = require("multer");
const path = require("path");
// const { search, image } = require("../utils/cloudinary");

let storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, path.join(__dirname, "../../client/assets/pictureUploads"));
  },
  filename: (req, file, cb) => {
    cb(
      null,
      file.originalname +
        "-" +
        Date.now() +
        "-" +
        path.extname(file.originalname)
    );
  },
});

// let fileFilter = (req, file, cb) => {
//   if (
//     file.mimetype === "image/jpeg" ||
//     file.mimetype === "image/png" ||
//     file.mimetype === "image/jpg"
//   ) {
//     cb(null, true);
//   } else {
//     return cb(new Error("** ต้องเป็นไฟล์ png หรือ jpeg เท่านั้น **"));
//   }
// };

// let upload = multer({
//   storage: storage,
//   fileFilter: fileFilter,
//   limits: {
//     fileSize: 1 * 1024 * 1024,
//   },
// });

// const uploadFile = (req, res, next) => {
//   const upload2 = upload.fields([
//     { name: "photo", maxCount: 1 },
//     { name: "eiei", maxCount: 20 },
//   ]);
//   upload2(req, res, function (err) {
//     if (err instanceof multer.MulterError) {
//       return res
//         .status(400)
//         .json({ msg: "** ไฟล์รูปรวมกันต้องมีขนาดไม่เกิน 1 MB **" });
//     } else if (err) {
//       return res.status(400).json({ msg: err.message });
//     }
//     next();
//   });
// };

// const uploadphotocomment = (req, res, next) => {
//   const upload2 = upload.fields([{ name: "photocomment", maxCount: 20 }]);
//   upload2(req, res, function (err) {
//     if (err instanceof multer.MulterError) {
//       return res
//         .status(400)
//         .json({ msg: "** ไฟล์รูปรวมกันต้องมีขนาดไม่เกิน 1 MB **" });
//     } else if (err) {
//       return res.status(400).json({ msg: err.message });
//     }
//     next();
//   });
// };

router.post("/createFood/:userId", (req, res) => {
  const userId = req.params;
  const { nameFood, timeCook, categoryFood, ingredient, howCook, linkYoutube } =
    req.body;

  res.json({ success: true });
});

module.exports = router;
