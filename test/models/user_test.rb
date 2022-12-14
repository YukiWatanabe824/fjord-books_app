# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @user1 = users(:alice)
    @user2 = users(:bob)
    @user1_report = reports(:one)
  end

  test '#name_or_email' do
    assert_equal 'alice@test.com', @user1.name_or_email
    @user1.name = 'alice'
    assert_equal 'alice', @user1.name_or_email
  end

  test '#follow' do
    assert_not @user1.following?(@user2)
    @user1.follow(@user2)
    assert @user1.following?(@user2)
  end

  test '#unfollow' do
    @user1.follow(@user2)
    assert @user1.following?(@user2)
    @user1.unfollow(@user2)
    assert_not @user1.following?(@user2)
  end

  test '#following?' do
    assert_not @user1.following?(@user2)
    @user1.follow(@user2)
    assert @user1.following?(@user2)
  end

  test '#followed_by?' do
    assert_not @user2.followed_by?(@user1)
    @user1.follow(@user2)
    assert @user2.followed_by?(@user1)
  end
end
