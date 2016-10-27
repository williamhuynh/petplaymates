class Profile < ApplicationRecord
  belongs_to :user

  extend FriendlyId
  friendly_id :first_name, use: :slugged

  geocoded_by :full_street_address
  after_validation :geocode

  def full_street_address
  	[street, suburb, state, country].compact.join(',')
  end

  validates :first_name, :last_name, :street, :suburb, :postcode, :state, :country, :phone, presence: true
  validates :phone, numericality: {only_integer: true}
 

end
