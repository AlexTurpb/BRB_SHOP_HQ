#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, "sqlite3:brbshop.db"

class Client < ActiveRecord::Base
	validates :name, presence: true
	validates :phone, presence: true
	validates :datestamp, presence: true
	validates :barber, presence: true
	validates :color, presence: true
end

class Barber < ActiveRecord::Base
end

class Contact < ActiveRecord::Base
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
	# hash
	hh = {:username => 'Enter name',
			:user_phone => 'Enter phone',
			:user_date => 'Enter date'
		}
	
	@error = hh.select {|key,_| params[key] == ""}.values.join(", ")

	if @error != ""
		return erb :visit
	else
		cl = Client.new params[:client]
		cl.save	
		@info = "#{cl.name} Greetings!!! Registration succesfull!"
		return erb :visit		
	end		
end	

get '/contacts' do
	erb :contacts			
end

post '/contacts' do
	con = Contact.new do |to_db|
			to_db.name = params[:user].capitalize
			to_db.mail = params[:user_mail]
			to_db.post = params[:post]
		end
	@info = "#{con.name} Subscribed"
	con.save
	erb :contacts			
end