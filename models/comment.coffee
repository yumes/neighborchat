mongoose = require 'mongoose'
Schema = mongoose.Schema

commentSchema = new Schema
  text: type: String, required: true
  threadId: type: Schema.Types.ObjectId, ref: 'Thread', required: true
  userId: type: Schema.Types.ObjectId, ref: 'User'
  created: type: String

module.exports = mongoose.model "Comment", commentSchema
