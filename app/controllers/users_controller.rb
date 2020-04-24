class UsersController < ApplicationController
	before_action :authenticate_user!, except: [:show]
	def show		
		@user = User.find(current_user.id)
	end

	
end
