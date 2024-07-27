import express from "express"
import path from "path"
import controller from "./controller";


const app = express()

// Middleware to parse JSON bodies
app.use(express.json());

// Middleware to parse URL-encoded bodies
app.use(express.urlencoded({ extended: true }));

app.use('/food',express.static(path.join(__dirname,'../public/food')))


app.get("/restaurants",controller.getRestaurants)
app.get("/restaurants/:restaurant_id/foods",controller.getFoodList)
app.get("/", (req, res) => {
    res.send("Hello World")
})


// app.get("/restaurants",)

app.listen(3456, ()=> console.log("Listening on port 3456"))