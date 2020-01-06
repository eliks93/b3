const express = require('express');
const app = express();

app.use('/', express.static(__dirname));

app.get('/', (req, res) => {
  res.sendFile(__dirname + "/b3.html");
});

app.listen(4234);