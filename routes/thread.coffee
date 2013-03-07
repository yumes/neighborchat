express = require 'express'
router = new express.Router()

mongoose = require 'mongoose'
Thread = mongoose.model 'Thread'

router.get '/new', (req, res) ->
  res.render 'newThread', title: 'New Thread'

router.post '/new', (req, res) ->
  { title, text } = req.body

  thread = new Thread { title, text }
  thread.save()
  res.redirect 201, "/thread/#{thread._id}"

router.get '/:id', (req, res) ->
  Thread.findById req.params.id, (err, thread) ->
    return next() if err || !thread
    console.log thread
    res.render 'thread',
      { title: thread.title, thread }

router.post '/:id/comment', (req, res) ->
  res.json []


module.exports = router
