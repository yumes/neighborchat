express = require 'express'
router = new express.Router()

router.get '/', (req, res) ->
  res.render 'index', title: 'Neighbor Chat'

module.exports = router
