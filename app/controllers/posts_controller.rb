class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: %i[show edit update destroy approve reject send_for_review]
  after_action :verify_authorized, except: :index
  after_action :verify_policy_scoped, only: :index

  def index
    if current_user.admin?
      @posts = policy_scope(Post).pending_review
    else
      @posts = policy_scope(Post).where(user: current_user)
    end
  end

  def edit
    authorize @post
  end

  def show
    @post = Post.find(params[:id])
    authorize @post
  end

  def new
    @post = Post.new
    authorize @post
  end

  def create
    @post = current_user.posts.build(post_params)
    @post.status = :draft
    authorize @post
    if @post.save
      redirect_to posts_path, notice: "Post created successfully."
    else
      render :new
    end
  end


  def update
    authorize @post
    if @post.update(post_params)
      redirect_to posts_path, notice: "Post updated successfully."
    else
      Rails.logger.debug @post.errors.full_messages
      render :edit
    end
  end


  def destroy
    authorize @post
    @post.destroy
    redirect_to posts_path, notice: "Post deleted successfully."
  end

  def approve
    authorize @post
    @post.update(status: :approved)
    redirect_to posts_path, notice: "Post approved."
  end

  def reject
    authorize @post
    @post.update(status: :rejected)
    redirect_to posts_path, alert: "Post rejected."
  end

  def send_for_review
    authorize @post
    if @post.update(status: :pending_review)
      redirect_to posts_path, notice: "Post sent for review."
    else
      redirect_to posts_path, alert: "Failed to send post for review."
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:content, :region_id, attachments: [])
  end
end
