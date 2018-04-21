class HomeController < ApplicationController
	def index
		@forums = Forum.all
	end
end