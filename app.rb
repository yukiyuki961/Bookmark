require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?
require 'open-uri'
require "sinatra/json"

require './models/bookmark.rb'

get '/' do
    @bookmarks = Bookmark.all
    erb :index
end

post "/create" do
    Bookmark.create(title: params[:title], url: params[:url])
    redirect '/'
end

get '/api/site' do
    html = Nokogiri::HTML.parse(open(params[:url]))
    title = html = html.css('title').text
    data = {title: title}
    json data
end