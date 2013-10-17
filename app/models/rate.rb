class Rate < ActiveRecord::Base
  belongs_to :hotel
  belongs_to :user
  attr_accessible :rate

  scope :top_rate, select("sum(rate) / count(rate) as rating, hotel_id").group("hotel_id").order("rating DESC").limit(5)

  protected
    def self.current_user_vote? user
      Rate.find_by_user_id(user).blank? ? false : true
    end
  
  	def self.add_vote user, hotel, rate
  		add_rate = user.rates.new(rate)
  		add_rate[:hotel_id] = hotel
  		if add_rate.save
  			"Your vote added"
  		else
  			"Vote not added"
  		end
  	end
end
