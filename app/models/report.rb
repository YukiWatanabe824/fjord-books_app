# frozen_string_literal: true

class Report < ApplicationRecord
  belongs_to :user
  validates :content, presence: true
  validates :title, presence: true
  has_many :comments, as: :commentable, dependent: :destroy
end
