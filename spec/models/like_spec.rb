require 'rails_helper'

RSpec.describe Like, type: :model do
  user = User.create(name: 'Lilly', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'A beautiful beach',
                     post_counter: 0)
  post = Post.create(user_id: user.id, title: 'Hello', text: 'This is my first post', likes_counter: 0,
                     comments_counter: 0)

  like = Like.new(post_id: post.id, user_id: user.id)
  like.save

  it 'When user like a post, it should return a total number of 1 like for that post' do
    expect(user.likes.length).to eq 1
  end

  it 'post like count should be 0' do
    expect(post.likes_counter).to eq 0
  end

  it 'update_posts_likes_counter should increment the total likes by 1' do
    like.update_posts_likes_counter
    expect(like.post.likes_counter).to eq 1
  end
end
