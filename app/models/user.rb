# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :avatar

  # あるユーザーがあるユーザーをフォローした際の関係性への関連付け
  has_many :active_relationships, class_name: "FollowingAndFollower",
                                  foreign_key: "follower_id",
                                  dependent: :destroy

  # あるユーザーがあるユーザーにフォローされた際の関係性への関連付け
  has_many :passive_relationships, class_name: "FollowingAndFollower",
                                   foreign_key: "followed_id",
                                   dependent: :destroy


  # あるユーザーが能動的にフォローしたユーザーとの関連付け
  has_many :following, through: :active_relationships, source: :followed

  # あるユーザーをフォローしているユーザーとの関連付け
  has_many :followers, through: :passive_relationships

  # ユーザーをフォローする
  def follow(other_user)
    following << other_user
  end

  # ユーザーフォローを解除する
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  # フォロー済みの場合にtrueを返す
  def following?(other_user)
    following.include?(other_user)
  end

end
