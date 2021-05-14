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
    cb(null, file.originalname + "-" + Date.now());
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

// สร้างสูตรอาหาร
router.post("/createFood/:userId", (req, res) => {
  const userId = req.params.userId;
  const { nameFood, timeCook, categoryFood, ingredient, howCook, linkYoutube } =
    req.body;

  res.json({ success: true });
});
// ดูรายละเอียดโพสต์สูตรอาหาร
router.post("/detailFood/:foodId", (req, res) => {
  const foodId = req.params.foodId;
  res.json({ success: true });
});
// ดูสูตรอาหารทั้งหมด
router.get("/allpost", (req, res) => {
  res.json({ success: true });
});
// ดูสูตรอาหารของคนๆนั้น
router.post("/otherFoodInDetailFood/:userId", (req, res) => {
  const userId = req.params.userId;

  res.json({ success: true });
});
// บันทึกสูตรอาหารที่ชอบ
router.post("/saveFood/:foodId/:userId", (req, res) => {
  const foodId = req.params.foodId;
  const userId = req.params.userId;

  res.json({ success: true });
});
// ยกเลิกบันทึกสูตรอาหารที่ชอบ
router.post("/unSaveFood/:foodId/:userId", (req, res) => {
  const foodId = req.params.foodId;
  const userId = req.params.userId;

  res.json({ success: true });
});
// แก้ไขสูตรอาหาร
router.post("/editFood/:foodId", (req, res) => {
  const foodId = req.params;
  const { nameFood, timeCook, categoryFood, ingredient, howCook, linkYoutube } =
    req.body;

  res.json({ success: true });
});
// จัดอันดับเมนูอาหารยอดนิยม
router.post("/rankFood/", (req, res) => {
  res.json({ success: true });
});
// เขียนคอมเมนต์ในสูตรอาหารคนอื่น
router.post("/createComment/:foodId/:userId", (req, res) => {
  const foodId = req.params;
  const userId = req.params.userId;
  const { text } = req.body;

  res.json({ success: true });
});
// ดึงคอมเมนต์ในสูตรอาหารคนอื่น
router.post("/getComment/:foodId", (req, res) => {
  const foodId = req.params;

  res.json({ success: true });
});
router.get("/getComment", (req, res) => {
  const foodId = req.params;

  res.json({ success: true });
});

module.exports = router;
