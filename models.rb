class User < ActiveRecord::Base
	has_many :posts
	has_one :profile

	def isSecurePassword
		!self.password.nil? &&
		self.password.length > 5 &&
		!self.password.match("[0-9]").nil?
	end

	def isGoodUsername
		!self.username.nil? &&
		self.username.length > 5
end

class Post < ActiveRecord::Base
	belongs_to :user

	def aTweet
		!self.content.nil? &&
		self.content.length < 150
	end
end
end