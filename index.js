const express = require('express')
const mysql = require("mysql2");
const jwt = require("jsonwebtoken");
const connection = mysql.createConnection({ host: "localhost", user: "root", password: "", database: "test" });
const app = express();
const bcrypt = require("bcryptjs");
const cookie = require("cookie-parser");

app.use(cookie());

async function checkAuth(req, res, next) {
    if (req.cookies.token != undefined) {
        connection.query("SELECT * FROM `users` WHERE token = ?", [req.cookies.token], async function(err, results) {
            if (results != 0) {
                next()
            } else {
                res.redirect("/register");
            }
        });
    } else {
        res.redirect("/register");
    }
}

const urlencodedParser = express.urlencoded({ extended: false });

app.get("/post:id", function(req, res) {
    connection.query("SELECT * FROM `posts` WHERE id = ?", [req.params.id], async function(err, results) {
        if (results != 0) {
            res.send(`
            <h2>Title: ${results[0]['title']}</h2><br>
            <p>Desc: ${results[0]['description']}</p>
            `);
        } else {
            res.send("Post not found!");
        }
    });
});

app.post("/newpost", urlencodedParser, async function(req, res) {
    if (req.body.token != undefined) {
        connection.query("SELECT * FROM `users` WHERE token = ?", [req.body.token], async function(err, results) {
            if (results != 0) {
                connection.query("INSERT INTO `posts` SET title = ?, description = ?", [req.body.title, req.body.description]);
                res.send("create");
            }
        });
    }
});

app.get("/post/new", checkAuth, function(req, res) {
    res.sendFile(__dirname + "/public/post/new.html");
});

app.get("/post/delete/:id", checkAuth, function(req, res) {
    connection.query("DELETE FROM `posts` WHERE id = ?", [req.params.id]);
});

app.get("/register", function(req, res) {
    res.sendFile(__dirname + "/public/reg/index.html")
});

app.post("/reg", urlencodedParser, async function(req, res) {
    console.log(req.body);
    connection.query("SELECT * FROM `users` WHERE login = ?", [req.body.login], async function(err, results) {
        if (results == 0) {
            const salt = bcrypt.genSaltSync(10);
            const password = req.body.password;
            connection.query("INSERT INTO `users` SET login = ?, password = ?, token = ?", [req.body.login, bcrypt.hashSync(password, salt), bcrypt.hashSync(password, salt)]);
            connection.commit();
            connection.query("SELECT * FROM `users` WHERE login = ?", [req.body.login], async function(err, results) {
                if (results != 0) {
                    const token = jwt.sign({
                        login: req.body.login,
                        userId: results[0]['id']
                    }, 'dev-jwt', { expiresIn: 86400 });
                    connection.query("UPDATE `users` SET token = ? WHERE login = ?", [token, req.body.login]);
                    res.send(token);
                }
            });
        } else {
            res.send("user");
        }
    });
});

app.get("/post/:id", (req, res) => {

});

app.get("/postsAll", (req, res) => {

});

app.post("/auth", urlencodedParser, async function(req, res) {
    const salt = bcrypt.genSaltSync(10);
    connection.query("SELECT * FROM `users` WHERE login = ?", [req.body.login], async function(err, results) {
        if (results != 0) {
            const password = bcrypt.compareSync(req.body.password, results[0]['password']);
            if (password) {
                const token = jwt.sign({
                    login: req.body.login,
                    userId: results[0]['id']
                }, 'dev-jwt', { expiresIn: 86400 });
                connection.query("UPDATE `users` SET token = ? WHERE login = ?", [token, req.body.login]);
                res.send(token);
            } else {
                res.send("user");
            }
        } else {
            res.send("user");
        }
    });
});

app.get("/log", (req, res) => {
    res.send(`
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.3/jquery.min.js" integrity="sha512-STof4xm1wgkfm7heWqFJVn58Hm3EtS31XFaagaa8VMReCXAkQnJZ+jEy8PCC/iT18dFy95WcExNHFTqLyp72eQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-cookie/1.4.1/jquery.cookie.min.js" integrity="sha512-3j3VU6WC5rPQB4Ld1jnLV7Kd5xr+cq9avvhwqzbH/taCRNURoeEpoPBK9pDyeukwSxwRPJ8fDgvYXd6SkaZ2TA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>

    <script>
        $.removeCookie('token');
    </script>
    `)
});

app.get("/login", (req, res) => {
    if (req.cookies.token != undefined) {
        connection.query("SELECT * FROM `users` WHERE token = ?", [req.cookies.token], async function(err, results) {
            if (results != 0) {
                res.sendFile(__dirname + "/public/main/index.html")
            } else {
                res.sendFile(__dirname + "/public/login/index.html")
            }
        });
    } else {
        res.sendFile(__dirname + "/public/login/index.html")
    }
});

app.listen(3000);