express 	= require 'express'
router 		= express.Router()

router.use '/', require('./shop')
router.use '/cart', require('./cart')

module.exports = router