require 'sinatra'
require 'active_record'
require 'sinatra/activerecord'


require './models.rb'

set :bind, "0.0.0.0"
enable :session

get "/" do 
	@users = User.all
	erb :index
end

get "/signup" do
	erb :signup
end

get "/signup_nametaken" do
	erb :nametaken
end

get "/login" do 
	erb :login
end

get "/logout" do 
	session.clear
	redirect to("/logout_successful")
end

post "/user_login_attempt" do

	matches = User.all.where({
		:name => params[:username]
		})
	if matches.first
		session[:user_id] = matches.first.user_id
		redirect to ("/profile")
	else
		redirect to ("/login_error")
	end
end

get "/profile" do
	@user = User.find(session[:user_id])
	erb :profile
end

get "/login_error" do 
	erb :error
end 

get "/logout_successful" do
	erb :logout_success 
end

post "/user_create" do
	if params[:username].empty? ||
		params[:email].empty? ||
		params[:password].empty?
		redirect to("/user_create_error")
	else
		User.create({
			:name => params[:username],
			:email => params[:email],
			:password => params[:password]
		})
		redirect to("/user_create_success")
	end
end

get "/user_create_success" do
	@users = User.all
	erb :user_create_success

	redirect to("/")
end

get "/user_create_error" do
	erb :error
end

post "/tweet" do
end




