const express = require("express"),
  cors = require("cors");
// (userRoutes = require("./routes/user")),
  (foodRoutes = require("./routes/food")),
  (moment = require("moment"));
moment.locale("th");
// set up express
app = express();
app.use(express.json({ limit: "50mb" }));
app.use(express.urlencoded({ limit: "50mb", extended: true }));
app.use(cors());

// app
// Set Route
// app.use("/user", userRoutes);
app.use("/food", foodRoutes);
const PORT = process.env.PORT || 7000;

app.listen(PORT, () => {
  console.log("server start on port 7000");
});
