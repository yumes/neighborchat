mongoose = require 'mongoose'
Schema = mongoose.Schema

threadSchema = new Schema
  title: type: String, required: true
  text: type: String
  user: type: String
  created: type: Date, default: Date.now
  longitude: type: Number
  latitude: type: Number
  comments: [type: Schema.Types.ObjectId, ref: 'Comment']

threadSchema.virtual("coords").get ->
  [@longitude, @latitude]

# Set Mongoose Model
module.exports = mongoose.model "Thread", threadSchema
