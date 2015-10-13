class User < ActiveRecord::Base
	def isSecurePassword
		!self.password.nil? &&
		self.password.length > 5 &&
		!self.password.match("[0-9]").nil

end

class Tweet < ActiveRecord::Base
end