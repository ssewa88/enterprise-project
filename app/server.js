const express = require("express");

const app = express();
const PORT = process.env.PORT || 3000;

app.get("/", (req, res) => {
  res.json({
    message: "Hello from the Enterprise EKS Platform!",
    environment: process.env.APP_ENV || "dev",
    version: process.env.APP_VERSION || "v1",
    status: "running"
  });
});

app.get("/health", (req, res) => {
  res.status(200).json({
    status: "healthy"
  });
});

app.listen(PORT, () => {
  console.log(`App running on port ${PORT}`);
});
