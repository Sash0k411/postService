class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: %i[show edit update destroy approve reject send_for_review]
  after_action :verify_authorized, except: :index
  after_action :verify_policy_scoped, only: :index

  def index
    @posts = policy_scope(Post)
    filter_posts_for_user
    apply_filters
  end

  def show
    authorize @post
  end

  def new
    @post = Post.new
    authorize @post
  end

  def create
    @post = current_user.posts.build(post_params)
    @post.status = current_user.admin? ? :approved : :draft
    authorize @post

    if @post.save
      redirect_to posts_path, notice: "Post created successfully."
    else
      render :new
    end
  end

  def edit
    authorize @post
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
    ApprovePostJob.perform_later(@post.id)
    redirect_to posts_path, notice: "Post approval initiated."
  end

  def reject
    authorize @post
    RejectPostJob.perform_later(@post.id)
    redirect_to posts_path, alert: "Post rejection initiated."
  end

  def send_for_review
    authorize @post
    SendForReviewJob.perform_later(@post.id)
    redirect_to posts_path, notice: "Post sent for review."
  end

  def export
    authorize Post
    @posts = Post.by_region(params[:region_id])
                 .by_author(params[:author_id])
                 .by_date_range(params[:start_date], params[:end_date])

    respond_to do |format|
      format.xlsx do
        response.headers["Content-Disposition"] = "attachment; filename=Posts_Report_#{Date.today}.xlsx"
      end
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:content, :region_id, images: [], files: [])
  end

  def filter_posts_for_user
    @posts = if current_user.admin?
               @posts.pending_review
    else
               @posts.where(user: current_user)
    end
  end

  def apply_filters
    @posts = @posts.by_region(params[:region_id])
                   .by_author(params[:author_id])
                   .by_date_range(params[:start_date], params[:end_date])
  end
end
