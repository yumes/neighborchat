mongoose = require("mongoose")
Schema = mongoose.Schema

userSchema = new Schema
  ip: type: String, required: true
  comments: [type: Schema.Types.ObjectId, ref: 'Comment']
  threads: [type: Schema.Types.ObjectId, ref: 'Thread']


# Set Mongoose Model
module.exports = mongoose.model "User", userSchema
