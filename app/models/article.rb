class Article < ApplicationRecord
  belongs_to :user
  validates_presence_of :title, length: {minimum: 3, maximum: 50}
  validates :description, presence: true , length: {minimum: 10, maximum: 300}
  validates :user_id, presence: true
end