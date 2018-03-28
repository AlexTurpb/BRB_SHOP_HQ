#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, "sqlite3:brbshop.db"

class Client < ActiveRecord::Base
	validates :name, presence: true, length: { in: 4..20 }
	validates :phone, presence: true
	validates :datestamp, presence: true
	validates :barber, presence: true
	validates :color, presence: true
end

class Barber < ActiveRecord::Base
end

class Contact < ActiveRecord::Base
	validates :name, presence: true, length: { in: 4..20 }
	validates :mail, presence: true
	validates :post, presence: true, length: { minimum: 10 }
end

before do
	@barbers = Barber.all
end


get '/' do
	erb :index			
end

get '/visit' do
	@cl = Client.new
	erb :visit
end

post '/visit' do
	@cl = Client.new params[:client]
	if @cl.save	
		@info = "#{@cl.name} Greetings!!! Registration succesfull!"
		erb :visit
	else
		@error = @cl.errors.full_messages.first
		erb :visit			
	end		
end	

get '/contacts' do
	@con = Contact.new
	erb :contacts			
end

post '/contacts' do
	@con = Contact.new params[:contact]
	if @con.save
		@info = "#{@con.name} Subscribed"
		erb :contacts
	else
		@error = @con.errors.full_messages.first
		erb :contacts
	end			
end

get '/barber/:id' do
	@barber = Barber.find(params[:id])
	erb :barber			
end

get '/client/:id' do
	@client = Client.find(params[:id])
	erb :client
end

get '/registered' do
	@clients = Client.order('created_at DESC')
	erb :registered
end

