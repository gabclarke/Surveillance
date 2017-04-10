module.exports = function(app,express){
  app.set("port", 8080); //Server's port number
  app.use(express.static(__dirname + "/public")); //Specify where the static content is
}
