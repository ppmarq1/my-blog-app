require 'rails_helper'

RSpec.describe Comment, type: :model do
  it 'adds a comment' do
    author = User.new(name: 'Lilly', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'A beautiful beach',
                      post_counter: 0)
    author.save
    post = Post.new(title: 'Hello', text: 'his is my first post', user_id: author.id, likes_counter: 0, comments_counter: 0)
    post.save
    comment_creator = User.new(name: 'Pedro', photo: 'picture.jpeg', bio: 'Bio for user', post_counter: 0)
    comment_creator.save!
    post.comments.create!(text: 'Hello', user_id: comment_creator.id)
    post.comments.create!(text: 'second post', user_id: comment_creator.id)
    expect(post.comments.length).to eql(2)
  end
end
