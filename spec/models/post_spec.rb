require 'rails_helper'

RSpec.describe Post, type: :model do
  user = User.create(name: 'Lilly', bio: 'teacher in Brazil')

  user.save

  subject do
    Post.new(title: 'My new post', text: 'Hello', user_id: user.id)
  end

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
    expect(user.post_counter).not_to eq(0)
  end

  it 'update_users_posts_counter should increment the total posts by 1' do
    expect(user.post_counter).not_to eq(0)
  end
end
