#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, "sqlite3:brbshop.db"

class Client < ActiveRecord::Base
end

class Barber < ActiveRecord::Base
end

before do
	@barbers = Barber.all
end


get '/' do
	erb :index			
end

get '/visit' do
	erb :visit
end

post '/visit' do
	@username = params[:username].capitalize
	@user_phone = params[:user_phone]
	@user_date = params[:user_date]
	@prefered_barber = params[:prefered_barber]
	@color = params[:color]

	# hash
	hh = {:username => 'Enter name',
			:user_phone => 'Enter phone',
			:user_date => 'Enter date'
		}
	
	@error = hh.select {|key,_| params[key] == ""}.values.join(", ")

	if @error != ""
		return erb :visit
	else
		cl = Client.new do |to_db|
			to_db.name = params[:username].capitalize
			to_db.phone = params[:user_phone]
			to_db.datestamp = params[:user_date]
			to_db.barber = params[:prefered_barber]
			to_db.color = params[:color]
		end
		@info = "#{cl.name} Greetings!!! Registration succesfull!"
		cl.save
		return erb :visit		
	end		
end	
