class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :hotel
  attr_accessible :text

  validates :text, presence: true, length: {maximum: 300}

  protected
    def self.create_hotel_comment_by_user user, hotel, comment_text
      c = user.comments.new(comment_text) unless user.nil?
      c.hotel_id = hotel
      if c.save
        "comment added"
      else
        "comment not added"
      end
    end
end
