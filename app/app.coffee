bodyParser       = require 'body-parser'
express 		 = require 'express'
expressValidator = require 'express-validator'
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
app.use bodyParser.json()
app.use expressValidator()
app.use express.static "#{__dirname}/../public"
app.use '/js', express.static "#{__dirname}/../webapp/bin"
app.use '/js/lib', express.static "#{__dirname}/../bower_components"
app.use '/partials', express.static "#{__dirname}/../webapp/partials"

# Load controllers
app.use require('./controllers')

app.listen 80, () ->
    console.log "Express server listening on port 80"
