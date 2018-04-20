class User < ApplicationRecord
	validates :userName, 
          :presence => {:message => "Username can't be blank." },
          :uniqueness => {:message => "Username already exists."}
	# validates :password, presence: true
end
