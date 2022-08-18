require 'rails_helper'

RSpec.describe Comment, type: :model do
  User.create(name: 'Lilly', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'A beautiful beach',
              post_counter: 0)
  post = Post.create(user_id: user.id, title: 'Hello', text: 'This is my first post', likes_counter: 0,
                     comments_counter: 0)

  comment = Comment.new(post_id: post.id, user_id: user.id, text: 'Hi Tom!')
  comment.save

  it 'When user add a comment or a post, it should return a total number of 1 comment for that post' do
    expect(user.comments.length).to eq 1
  end

  it 'post comment count should be 0' do
    expect(post.comments_counter).to eq 0
  end

  it 'update_comments_posts_counter should increment the total comments by 1' do
    comment.update_comments_posts_counter
    expect(comment.post.comments_counter).to eq 1
  end
end
