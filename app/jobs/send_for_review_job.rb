class SendForReviewJob < ApplicationJob
  queue_as :default

  def perform(post_id)
    post = Post.find(post_id)
    post.update(status: :pending_review)
  end
end
