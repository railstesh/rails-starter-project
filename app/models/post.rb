class Post < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  # validates :title#, presence: true
  validates :description, presence: true
  belongs_to :user
  has_many :answers, class_name: 'Post'
  has_many :tags
  accepts_nested_attributes_for :tags, :allow_destroy => true

  scope :only_posts, ->{ where(post_id: nil) }
end
