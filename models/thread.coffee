mongoose = require("mongoose")
Schema = mongoose.Schema

commentSchema = new Schema
  text: type: String, required: true
  userId: type: Schema.Types.ObjectId, ref: 'User', required: true
  created: type: String

threadSchema = new Schema
  title: type: String, required: true
  userId: type: Schema.Types.ObjectId, ref: 'User', required: true
  created: type: Date, default: Date.now
  longitude: type: Number
  latitude: type: Number
  comments: [commentSchema]

threadSchema.virtual("coords").get ->
  [@longitude, @latitude]

# Set Mongoose Model
module.exports = mongoose.model "Thread", threadSchema
