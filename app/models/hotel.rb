class Hotel < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  has_many :rates
  attr_accessible :address, :breakfast, :photo, :price_for_room, :room_description, :star_rating, :title

  validates :title, presence: true, uniqueness:{ message:'Hotel with this name are created' }
  validates :price_for_room, allow_nil: true, numericality: { message: "this field can only contain numeric", greater_than: 0}

  before_save :prepare_address

  mount_uploader :photo, PhotoUploader

  scope :chronology, lambda { |param = nil| order("created_at #{param ? 'ASC' : 'DESC'}") }

  def prepare_address
    self.address = self.address.to_hash.values.join(", ") unless self.address.nil?
  end
end