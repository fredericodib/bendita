class Lyric < ApplicationRecord
  belongs_to :user
  validates :name, :message, presence: true
end
