# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat"
    ActionCable.server.broadcast "chat", {appear: current_user}
  end

  def unsubscribed
    ActionCable.server.broadcast "chat", {leave: current_user}
  end

  def notification msg
    params = ActionController::Parameters.new(Rack::Utils.parse_nested_query(msg["post"]))
    @post = Post.create post_params(params).merge!(user: current_user)
    ActionCable.server.broadcast "chat", post: PostsController.render(@post)
  end

  def post_params params
    params.require(:post).permit(:content)
  end
end
