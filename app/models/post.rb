class Post < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :likes

  def update_users_posts_counter
    user.increment!(:post_counter)
  end

  def most_recent_comments
    comments.order(created_at: :desc).limit(5)
  end
end
