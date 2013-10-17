module HotelsHelper
	def count_rate common_rate, votes
		common_rate.sum(:rate).fdiv(votes)
	end

	def check_breakfast_include breakfast_param = nil
		breakfast_param ? 'Yes' : 'No'
	end

	def toprates
		Rate.top_rate
	end

	def preview text
		text.truncate(100, separator: ' ', omission: '...') unless text.nil?
	end
end
