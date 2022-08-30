require 'rails_helper'

RSpec.describe 'Post pages test', type: :feature do
  describe 'index page' do
    before :each do
      @user_first = User.create(name: 'Clara', photo: 'mybaby.png', bio: 'A cute baby', post_counter: 0)

      @post_first = @user_first.posts.new(title: 'Love must lead', text: 'This is my first post')
      @post_first.likes_counter = 0
      @post_first.comments_counter = 0
      @post_first.update_users_posts_counter
      @post_first.save

      @comment = @user_first.comments.new(post_id: @post_first.id, user_id: @user_first.id, text: 'My first comment')
      @comment.post_id = @post_first.id
      @comment.update_comments_posts_counter
      @comment.save

      @like = Like.new(user_id: @user_first.id, post_id: @post_first.id)
      @like.user = @user_first
      @like.post = @post_first
      @like.save
      @like.update_posts_likes_counter
    end

    it 'check posts#index path' do
      visit user_posts_path(@user_first.id)
      expect(current_path).to eq(user_posts_path(@user_first.id))
      expect(page).to have_text('My Blog App')
    end

    it 'Should set the link of the picture to the img src' do
      visit user_posts_path(@user_first.id)
      all('img').each do |i|
        expect(i[:src]).to eq('/assets/mybaby.png')
      end
    end

    it 'Should display the user name' do
      visit user_posts_path(@user_first.id)
      expect(page).to have_content('Clara')
    end

    it 'Should display the total post number of 1' do
      visit user_posts_path(@user_first.id)
      expect(page).to have_content('Number of posts: 1')
    end

    it 'Should display the post title' do
      visit user_posts_path(@user_first.id)
      expect(page).to have_content('Love must lead')
    end

    it 'Should display the post body' do
      visit user_posts_path(@user_first.id)
      expect(page).to have_content('This is my first post')
    end

    it 'Should display the post comment' do
      visit user_posts_path(@user_first.id)
      expect(page).to have_content('My first comment')
    end

    it 'Should display the total post comment number of 1' do
      visit user_posts_path(@user_first.id)
      expect(page).to have_content('Comment 1')
    end

    it 'Should display the total post likes number of 1' do
      visit user_posts_path(@user_first.id)
      expect(page).to have_content('Likes 1')
    end

    it 'Should display a button with "Pagination" text' do
      visit user_posts_path(@user_first.id)
      expect(page).to have_link('Pagination')
    end

    it 'Should redirect to post show page after clicking on a post' do
      visit user_posts_path(@user_first.id)
      click_link 'Love must lead'
      expect(current_path).to eq(user_post_path(@user_first.id, @post_first.id))
    end
  end

  describe 'show page' do
    before :each do
      @user_first = User.create(name: 'Clara', photo: 'mybaby.png', bio: 'A cute baby', post_counter: 0)

      @post_first = @user_first.posts.new(title: 'Love must lead', text: 'This is my first post')
      @post_first.likes_counter = 0
      @post_first.comments_counter = 0
      @post_first.update_users_posts_counter
      @post_first.save

      @comment = @user_first.comments.new(post_id: @post_first.id, user_id: @user_first.id, text: 'My first comment')
      @comment.post_id = @post_first.id
      @comment.update_comments_posts_counter
      @comment.save

      @like = Like.new(user_id: @user_first.id, post_id: @post_first.id)
      @like.user = @user_first
      @like.post = @post_first
      @like.save
      @like.update_posts_likes_counter
    end

    it 'check posts#show path' do
      visit user_post_path(@user_first.id, @post_first.id)
      expect(current_path).to eq(user_post_path(@user_first.id, @post_first.id))
      expect(page).to have_text('My Blog App')
    end

    it 'Should display the post title' do
      visit user_post_path(@user_first.id, @post_first.id)
      expect(page).to have_content('Love must lead')
    end

    it 'Should display who wrote the post' do
      visit user_post_path(@user_first.id, @post_first.id)
      expect(page).to have_content('Clara')
    end

    it 'Should display the total post comment number of 1' do
      visit user_post_path(@user_first.id, @post_first.id)
      expect(page).to have_content('Comment 1')
    end

    it 'Should display the total post likes number of 1' do
      visit user_post_path(@user_first.id, @post_first.id)
      expect(page).to have_content('Likes 1')
    end

    it 'Should display the post body' do
      visit user_post_path(@user_first.id, @post_first.id)
      expect(page).to have_content('This is my first post')
    end

    it 'Should display the name of the user who posted a comment' do
      visit user_post_path(@user_first.id, @post_first.id)
      expect(page).to have_content('Clara:')
    end

    it 'Should display the post comment text of a user' do
      visit user_post_path(@user_first.id, @post_first.id)
      expect(page).to have_content('My first comment')
    end
  end
end
