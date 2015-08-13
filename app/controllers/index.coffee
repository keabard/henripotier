express 	= require 'express'
router 		= express.Router()

router.use '/shop', require('./shop')
router.use '/cart', require('./cart')
router.use '/', (req, res) ->
	return res.redirect '/shop'

module.exports = router