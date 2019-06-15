class Comment < ApplicationRecord
  belongs_to :feature
  validates_presence_of :message
  validates_length_of :message, minimum: 3, maximum: 240
end