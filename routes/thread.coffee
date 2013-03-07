express = require 'express'
router = new express.Router()

uuid = require 'node-uuid'
mongoose = require 'mongoose'
ObjectId = mongoose.Schema.ObjectId
Thread = mongoose.model 'Thread'
Comment = mongoose.model 'Comment'

router.get '/new', (req, res) ->
  res.render 'newThread', title: 'New Thread'

router.post '/new', (req, res) ->
  { title, text } = req.body

  unless req.session.userId
    req.session.userId = uuid.v4()

  thread = new Thread { title, text, user: req.session.userId }
  thread.save()
  res.redirect "/thread/#{thread._id}"

router.get '/:id', (req, res, next) ->
  Thread.findById(req.params.id)
    .populate('comments')
    .exec (err, thread) ->
      return next() if err || !thread

      res.render 'thread',
        { title: thread.title, thread }

router.post '/:id/comment', (req, res) ->
  Thread.findById req.params.id, (err, thread) ->
    { text } = req.body

    unless req.session.userId
      req.session.userId = uuid.v4()

    comment = new Comment { text, thread: req.params.id, user: req.session.userId }

    thread.comments.push comment._id

    comment.save()
    thread.save()

    res.redirect "/thread/#{thread._id}"

module.exports = router
