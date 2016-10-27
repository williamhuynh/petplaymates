class Pet < ApplicationRecord
  belongs_to :user
  extend FriendlyId
  friendly_id :name, use: :slugged
  mount_uploader :photo, PetPictureUploader

  validates :name, :photo, :breed, :age, :size, presence: true
  validates :age, numericality: {only_integer: true, greater_than: 0}
end
