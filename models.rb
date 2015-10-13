class User < ActiveRecord::Base
	def isSecurePassword
		!self.password.nil? &&
		self.password.length > 5 &&
		!self.password.match("[0-9]").nil
	end
end

class Post < ActiveRecord::Base
	def aTweet
		!self.content.nil? &&
		self.content.length < 150
	end
end