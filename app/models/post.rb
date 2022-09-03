class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def update_users_posts_counter
    user.increment!(:post_counter)
  end

  def most_recent_comments
    comments.order(created_at: :desc).limit(5)
  end

  def as_json(_options = {})
    { id:, title:, text: }
  end
end
