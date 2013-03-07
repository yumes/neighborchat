mongoose = require 'mongoose'
Schema = mongoose.Schema

commentSchema = new Schema
  text: type: String, required: true
  thread: type: Schema.Types.ObjectId, ref: 'Thread', required: true
  user: type: String
  created: type: String

module.exports = mongoose.model "Comment", commentSchema
