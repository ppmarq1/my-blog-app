require 'rails_helper'

RSpec.describe Comment, type: :model do
  it 'adds a comment' do
    author = User.new(name: 'Lilly', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'A beautiful beach',
                      postsCounter: 0)
    post = Post.new(title: 'Hello', text: 'his is my first post', author:, likesCounter: 0, commentsCounter: 0)
    post.save

    comment_creator = User.new(name: 'Pedro', photo: 'picture.jpeg', bio: 'Bio for user', postsCounter: 0)
    comment_creator.save!

    post.comments.create!(text: 'Hello', author: comment_creator)
    post.comments.create!(text: 'second post', author: comment_creator)
    expect(post.comments.length).to eql(2)
  end
end
