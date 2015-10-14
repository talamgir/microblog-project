require 'sinatra'
require 'active_record'
require 'sinatra/activerecord'
require 'sinatra/flash'


require './models.rb'

set :bind, "0.0.0.0"
set :database, "sqlite3:db/database.sqlite3"
enable :session

def a_user
	if session[:user_id]
		User.find session[:user_id]

	end
end

get "/" do 
	if a_user
		erb :index
	else
		redirect to('/signup')
	end
end

get "/signup" do
	erb :signup
end

post "/signup" do
	if a_user
		redirect "/profile"

	elsif params[:username].empty? ||
		params[:handle].empty? ||
		params[:email].empty? ||
		params[:password].empty? ||
		params[:security_question].empty? ||
		params[:security_answer].empty? 
		redirect to("/user_create_error")
	else
		User.create({
			:name => params[:username],
			:handle => params[:handle],
			:email => params[:email],
			:password => params[:password],
			:security_question => params[:security_question],
			:security_answer => params[:security_answer]

		})
		redirect to("/user_create_success")
	end
end

get "/user_create_success" do
	@users = User.all
	erb :user_create_success

end

get "/user_create_error" do
	erb :error
end

get "/login" do 
	erb :signup
end

post "/user_login_attempt" do

	matches = User.all.where({
		:name => params[:username],
		:password => params[:password]
		})
	if matches.first
		session[:user_id] = matches.first.user_id
		redirect to ("/profile")
	else
		redirect to ("/login_error")
	end
end

get "/login_error" do 
	erb :error
end 

get "/profile" do
	@user = User.find(session[:user_id])
	erb :profile
end

get "/logout" do 
	session[:user_id] = nil
	redirect to("/")
end


post "/tweet" do
	
	Post.create({
		:content => params[:content],
		:posted_at => params[:posted_at]
		})
	redirect to ("/profile")
end





