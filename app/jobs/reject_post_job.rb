class RejectPostJob < ApplicationJob
  queue_as :default

  def perform(post_id)
    post = Post.find(post_id)
    post.update(status: :rejected)
  end
end
