express = require 'express'
router = new express.Router()

mongoose = require 'mongoose'
Thread = mongoose.model 'Thread'
Comment = mongoose.model 'Comment'

router.get '/new', (req, res) ->
  res.render 'newThread', title: 'New Thread'

router.post '/new', (req, res) ->
  { title, text } = req.body

  thread = new Thread { title, text }
  thread.save()
  res.redirect "/thread/#{thread._id}"

router.get '/:id', (req, res) ->
  Thread.findById(req.params.id)
    .populate('comments')
    .exec (err, thread) ->
      return next() if err || !thread

      res.render 'thread',
        { title: thread.title, thread }

router.post '/:id/comment', (req, res) ->
  Thread.findById req.params.id, (err, thread) ->
    { text } = req.body

    comment = new Comment { text, thread: req.params.id }

    thread.comments.push comment._id

    comment.save()
    thread.save()

    res.redirect "/thread/#{thread._id}"

module.exports = router
