const express = require("express");
const router = express.Router();
const { firestore } = require("../firebase/config");
const { v4: uuidv4 } = require("uuid");
const multer = require("multer");
const path = require("path");
// const { search, image } = require("../utils/cloudinary");
// let storage = multer.diskStorage({
//   destination: (req, file, cb) => {
//     cb(null, path.join(__dirname, "../../client/assets/pictureUploads"));
//   },
//   filename: (req, file, cb) => {
//     cb(null, file.originalname);
//   },
// });

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
router.get("/", async (req, res) => {
  const category = req.query.category;
  let food = [];
  let count = 0;

  //filter by category เช่น ต้ม ผัด ...
  if (category !== "all") {
    const FoodDB = await firestore
      .collection("Food")
      .where("categoryFood", "==", category)
      .orderBy("date", "desc")
      .get();

    await FoodDB.forEach(async (element) => {
      await firestore
        .collection("User")
        .where("uid", "==", element.get("userId"))
        .get()
        .then(async (querySnapshot) => {
          await querySnapshot.forEach(async (user) => {
            await food.push({
              howCook: element.get("howCook"),
              ingredient: element.get("ingredient"),
              like: element.get("like"),
              timeCook: element.get("timeCook"),
              nameFood: element.get("nameFood"),
              linkYoutube: element.get("linkYoutube"),
              date: element.get("date"),
              userId: element.get("userId"),
              imageFood: element.get("imageFood"),
              categoryFood: element.get("categoryFood"),
              username: user.get("username"),
              imageProfile: user.get("imageProfile"),
            });

            count++;

            if (count == FoodDB.size) {
              await res.status(200).send(food);
            }
          });
        });
    });
  }
  //get all category
  else {
    const FoodDB = await firestore
      .collection("Food")
      .orderBy("date", "desc")
      .get();

    await FoodDB.forEach(async (element) => {
      await firestore
        .collection("User")
        .where("uid", "==", element.get("userId"))
        .get()
        .then(async (querySnapshot) => {
          await querySnapshot.forEach(async (user) => {
            // const data = ;
            await food.push({
              howCook: element.get("howCook"),
              ingredient: element.get("ingredient"),
              like: element.get("like"),
              timeCook: element.get("timeCook"),
              nameFood: element.get("nameFood"),
              linkYoutube: element.get("linkYoutube"),
              date: element.get("date"),
              userId: element.get("userId"),
              imageFood: element.get("imageFood"),
              categoryFood: element.get("categoryFood"),
              username: user.get("username"),
              imageProfile: user.get("imageProfile"),
            });
            count++;
            if (count == FoodDB.size) {
              await res.status(200).send(food);
            }
          });
        });
    });
  }
});
router.post("/createFood/:userId", async (req, res) => {
  const userId = req.params.userId;
  const foodId = [];
  let food = undefined;
  let user = undefined;
  let data = [];
  const uid = uuidv4();
  var {
    nameFood,
    timeCook,
    categoryFood,
    ingredient,
    howCook,
    linkYoutube,
    imageFood,
  } = req.body;
  const date = Date.now();
  // const imageFoodConvertToPath = `assets/pictureUploads/${imageFood[0].filename}`;
  console.log(
    imageFood,
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
      imageFood,
      userId,
      like: 0,
    })
    .then(async () => {
      await firestore
        .collection("Food")
        .where("userId", "==", userId)
        .get()
        .then((querySnapshot) => {
          querySnapshot.forEach((element) => {
            foodId.push(element.get("uid"));
          });
        })
        .then(async () => {
          if (foodId == undefined) {
            await firestore
              .collection("User")
              .doc(userId)
              .update({ foodId: uid })
              .then(async () => {
                await firestore
                  .collection("Food")
                  .where("uid", "==", uid)
                  .get()
                  .then((querySnapshot) => {
                    querySnapshot.forEach((element) => {
                      food = element.data();
                    });
                  })
                  .then(async () => {
                    await firestore
                      .collection("User")
                      .where("uid", "==", userId)
                      .get()
                      .then(async (querySnapshot) => {
                        await querySnapshot.forEach((element) => {
                          user = {
                            username: element.get("username"),
                            imageProfile: element.get("imageProfile"),
                          };
                        });

                        data.push({ food, user });
                        res.json({ data });
                      })
                      .catch((err) => {
                        console.log(err);
                      });
                  })
                  .catch((err) => {
                    console.log(err);
                  })
                  .catch((err) => {
                    console.log(err);
                  });
              })
              .catch((err) => {
                console.log(err);
              });
          } else if (foodId != undefined) {
            await firestore
              .collection("User")
              .doc(userId)
              .update({ foodId: foodId })
              .then(async () => {
                await firestore
                  .collection("Food")
                  .where("uid", "==", uid)
                  .get()
                  .then(async (querySnapshot) => {
                    await querySnapshot.forEach((element) => {
                      food = element.data();
                    });
                  })
                  .then(async () => {
                    await firestore
                      .collection("User")
                      .where("uid", "==", userId)
                      .get()
                      .then(async (querySnapshot) => {
                        await querySnapshot.forEach((element) => {
                          user = {
                            username: element.get("username"),
                            imageProfile: element.get("imageProfile"),
                          };
                        });
                        data.push({ food, user });
                        res.json({ data });
                      })
                      .catch((err) => {
                        console.log(err);
                      });
                  })
                  .catch((err) => {
                    console.log(err);
                  })
                  .catch((err) => {
                    console.log(err);
                  });
              })
              .catch((err) => {
                console.log(err);
              });
          }
        })
        .catch((err) => {
          console.log(err);
        })
        .catch((err) => {
          console.log(err);
        });
    })
    .catch((err) => {
      console.log(err);
    });
});

router.post("/detailFood/:foodId", async (req, res) => {
  const foodId = req.params.foodId;
  const food = [];
  let user = undefined;
  let userId = undefined;
  await firestore
    .collection("Food")
    .where("uid", "==", foodId)
    .get()
    .then((querySnapshot) => {
      querySnapshot.forEach((element) => {
        food.push(element.data());
        userId = element.get("userId");
      });
    })
    .then(async () => {
      await firestore
        .collection("User")
        .where("uid", "==", userId)
        .get()
        .then(async (querySnapshot) => {
          querySnapshot.forEach((element) => {
            user = {
              username: element.get("username"),
              imageProfile: element.get("imageProfile"),
            };
          });
          res.json({ user, food });
        })
        .catch((err) => {
          console.log(err);
        });
    })
    .catch((err) => {
      console.log(err);
    });
});

router.post("/deleteFood/:foodId", async (req, res) => {
  const foodId = req.params.foodId;

  await firestore
    .collection("Food")
    .doc(foodId)
    .delete()
    .then(() => {
      res.json({ sucess: true });
    })
    .catch((err) => {
      console.log(err);
    });
});

router.get("/", async (req, res) => {
  const category = req.query.category;
  let food = [];
  let count = 0;

  //filter by category เช่น ต้ม ผัด ...
  if (category !== "all") {
    const FoodDB = await firestore
      .collection("Food")
      .where("categoryFood", "==", category)
      .orderBy("date", "desc")
      .get();

    await FoodDB.forEach(async (element) => {
      await firestore
        .collection("User")
        .where("uid", "==", element.get("userId"))
        .get()
        .then(async (querySnapshot) => {
          await querySnapshot.forEach(async (user) => {
            await food.push({
              howCook: element.get("howCook"),
              ingredient: element.get("ingredient"),
              like: element.get("like"),
              timeCook: element.get("timeCook"),
              nameFood: element.get("nameFood"),
              linkYoutube: element.get("linkYoutube"),
              date: element.get("date"),
              userId: element.get("userId"),
              imageFood: element.get("imageFood"),
              categoryFood: element.get("categoryFood"),
              username: user.get("username"),
              imageProfile: user.get("imageProfile"),
            });

            count++;

            if (count == FoodDB.size) {
              await res.status(200).send(food);
            }
          });
        });
    });
  }
  //get all category
  else {
    const FoodDB = await firestore
      .collection("Food")
      .orderBy("date", "desc")
      .get();

    await FoodDB.forEach(async (element) => {
      await firestore
        .collection("User")
        .where("uid", "==", element.get("userId"))
        .get()
        .then(async (querySnapshot) => {
          await querySnapshot.forEach(async (user) => {
            // const data = ;
            await food.push({
              howCook: element.get("howCook"),
              ingredient: element.get("ingredient"),
              like: element.get("like"),
              timeCook: element.get("timeCook"),
              nameFood: element.get("nameFood"),
              linkYoutube: element.get("linkYoutube"),
              date: element.get("date"),
              userId: element.get("userId"),
              imageFood: element.get("imageFood"),
              categoryFood: element.get("categoryFood"),
              username: user.get("username"),
              imageProfile: user.get("imageProfile"),
            });
            count++;
            if (count == FoodDB.size) {
              await res.status(200).send(food);
            }
          });
        });
    });
  }
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
  const data = [];
  var {
    nameFood,
    timeCook,
    categoryFood,
    ingredient,
    howCook,
    linkYoutube,
    imageFood,
  } = req.body;
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
      })
      .catch((err) => {
        console.log(err);
      });
  } else if (imageFood != undefined) {
    // const imageFoodConvertToPath = `assets/pictureUploads/${imageFood[0].filename}`;
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
        imageFood,
      })
      .then(async () => {
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
      })
      .catch((err) => {
        console.log(err);
      });
  }
});

router.get("/rankFood", async (req, res) => {
  const food = [];
  const user = [];
  await firestore
    .collection("Food")
    .orderBy("like", "desc")
    .limit(10)
    .get()
    .then(async (querySnapshotFirst) => {
      await querySnapshotFirst.forEach(async (element) => {
        food.push(element.data());
        await firestore
          .collection("User")
          .where("uid", "==", element.get("userId"))
          .get()
          .then(async (querySnapshot) => {
            await querySnapshot.forEach(async (element) => {
              user.push({
                username: element.get("username"),
                imageProfile: element.get("imageProfile"),
              });
              if (user.length == querySnapshotFirst.size) {
                res.json({ food, user });
              }
            });
          })
          .catch((err) => {
            console.log(err);
          });
      });
    })
    .catch((err) => {
      console.log(err);
    });
});

module.exports = router;
