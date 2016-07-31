class SessionsController < ApplicationController

	def new
	end

	def create
		user = User.find_by(username: params[:session][:username])
		if user && user.authenticate(params[:session][:password])
			if user.activated?
				log_in user
				redirect_back_or user
				flash[:success] = "Successfully Logged In"
			else 
				flash[:warning] = "Account Not Activated, Check Your Emails"
			end
		else
			flash.now[:danger] = 'Invalid email/password combination'
      		render 'new'	
		end
	end

	def destroy
		log_out if logged_in?
		redirect_to root_url
	end

end
