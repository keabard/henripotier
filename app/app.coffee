bodyParser       = require 'body-parser'
express 		 = require 'express'
ECT              = require 'ect'
favicon          = require 'serve-favicon'

app = module.exports = express()

ectRenderer     = ECT
    root: __dirname + '/views'
    ext : '.ect'

app.set 'views', "#{__dirname}/views"
app.set 'view engine', 'ect'
app.engine 'ect', ectRenderer.render
# app.use favicon "#{__dirname}/../public/favicon.ico"
app.use bodyParser.urlencoded({extended: true})
app.use express.static "#{__dirname}/../public"
app.use '/js', express.static "#{__dirname}/../webapp/bin"
app.use '/partials', express.static "#{__dirname}/../webapp/partials"

# Load controllers
app.use require('./controllers')

app.listen 80, () ->
    console.log "Express server listening on port 80"
