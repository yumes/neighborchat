mongoose = require("mongoose")
Schema = mongoose.Schema

userSchema = new Schema
  ip: type: String, required: true
  commentIds: type: [Schema.Types.ObjectId], ref: 'Comment'
  threadIds: type: [Schema.Types.ObjectId], ref: 'Thread'


# Set Mongoose Model
module.exports = mongoose.model "User", userSchema
