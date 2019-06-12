class Comment < ApplicationRecord
  belongs_to :feature
  validates_presence_of :message
end