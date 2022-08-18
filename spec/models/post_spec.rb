require 'rails_helper'

RSpec.describe Post, type: :model do
  User.create(name: 'Lilly', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'A beautiful beach',
              post_counter: 0)
  subject { Post.new(user_id: user.id, title: 'Hello', text: 'This is my first post') }
  before { subject.save }

  it 'title should be present' do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it 'title should be invalid if it has more than 250 characters' do
    subject.title = 'My text, my text, my text, my text, my text,
    my text, my text, my text, my text, my text, my text,
    my text, my text, my text, my text, my text, my text,
     my text, my text, my text, my text, my text, my text,
    my text, my text, my text, my text, my text, my text,
    my text, my text, my text, my text, my text, my text,
    my text, my text'
    expect(subject).to_not be_valid
  end

  it 'comments_counter should be numeric' do
    subject.comments_counter = ''
    expect(subject).to_not be_valid
  end

  it 'comments_counter should be greater than or equal to 0' do
    subject.comments_counter = -1
    expect(subject).to_not be_valid
  end

  it 'likes_counter should be numeric' do
    subject.likes_counter = ''
    expect(subject).to_not be_valid
  end

  it 'likes_counter should be greater than or equal to 0' do
    subject.likes_counter = -1
    expect(subject).to_not be_valid
  end

  it 'most_recent_comments should return 0 comment' do
    expect(subject.most_recent_comments.length).to eq 0
  end

  it 'most_recent_comments should always return a total number of 5 comments' do
    expect(subject.most_recent_comments).to eq(subject.comments.last(5))
  end

  it 'user post count should be 0' do
    expect(user.post_counter).to eq 0
  end

  it 'update_users_posts_counter should increment the total posts by 1' do
    subject.update_users_posts_counter
    expect(subject.user.post_counter).to eq 1
  end
end
