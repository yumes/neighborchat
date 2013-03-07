mongoose = require 'mongoose'
Schema = mongoose.Schema

commentSchema = new Schema
  text: type: String, required: true
  userId: type: Schema.Types.ObjectId, ref: 'User', required: true
  created: type: String

module.exports = mongoose.model "Comment", commentSchema
