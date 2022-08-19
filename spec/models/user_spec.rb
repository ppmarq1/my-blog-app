require 'rails_helper'

RSpec.describe User, type: :model do
  User.create(name: 'Lilly', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'A beautiful beach',

              post_counter: 0)

  before { subject.save }

  it 'name should be present' do
    subject.name = nil

    expect(subject).to_not be_valid
  end

  it 'post_counter should be numeric' do
    subject.post_counter = ''

    expect(subject).to_not be_valid
  end

  it 'post_counter should be greater than or equal to 0' do
    subject.post_counter = -1

    expect(subject).to_not be_valid
  end

  it 'most_recent_posts should return 0 post' do
    expect(subject.most_recent_posts.length).to eq 0
  end

  it 'most_recent_posts should always return a total number of 3 comments' do
    expect(subject.most_recent_posts).to eq(subject.posts.last(3))
  end
end
