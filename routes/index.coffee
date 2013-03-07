express = require 'express'
router = new express.Router()

mongoose = require 'mongoose'
Thread = mongoose.model 'Thread'

router.get '/', (req, res) ->
  Thread.find (err, threads) ->
    res.render 'index',
      { title: 'Neighbor Chat', threads }

module.exports = router
