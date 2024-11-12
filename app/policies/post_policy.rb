class PostPolicy < ApplicationPolicy
  # Only admins can view posts that are pending review
  def index?
    user.admin?
  end

  def create?
    user.present?
  end

  def show?
    is_owner? || user.admin?
  end

  # Only admins can approve or reject posts
  def approve?
    user.admin?
  end

  def reject?
    user.admin?
  end

  # Only admins and owners can update posts
  def update?
    user.admin? || is_owner?
  end

  # Only users can delete drafts
  def destroy?
    record.draft? && is_owner?
  end

  def export?
    user.admin?
  end

  def send_for_review?
    is_owner?
  end

  private

  def is_owner?
    user == record.user
  end

  # Set policy scope based on role
  class Scope < Scope
    def resolve
      if user.admin?
        scope.where(status: :pending_review)
      else
        scope.where(user: user)
      end
    end
  end
end
