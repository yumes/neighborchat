express = require 'express'
router = new express.Router()

router.post '/', (req, res) ->
  res.render 'post', req.body

module.exports = router
