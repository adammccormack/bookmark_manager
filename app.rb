require 'sinatra/base'
require 'sinatra/reloader'
require './lib/bookmark'
require './database_connection_setup'
require 'uri'
require 'sinatra/flash'


class BookmarkManager < Sinatra::Base
  enable :sessions, :method_override
  register Sinatra::Flash

  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
      'Bookmark Manager'
    erb :index
  end

  get '/bookmarks' do
    @bookmarks = Bookmark.all
    erb :bookmarks
  end

  get '/bookmarks/new' do
    erb :new
  end

  post '/bookmarks' do
    if params['url'] =~ /\A#{URI::regexp(['http', 'https'])}\z/
      Bookmark.create(url: params[:url], title: params[:title])
    else
      flash[:notice] = "You must submit a valid URL."
      redirect '/bookmarks/new'
    end

    redirect '/bookmarks'
  end

  delete '/bookmarks/:id' do
    Bookmark.delete(id: params[:id])
    redirect '/bookmarks'
  end

  get '/bookmarks/:id/edit' do
    @bookmark = Bookmark.get(id: params[:id])
    erb :edit
  end

  patch '/bookmarks/:id' do
    if params['url'] =~ /\A#{URI::regexp(['http', 'https'])}\z/
      Bookmark.update(id: params[:id], title: params[:title], url: params[:url])
      redirect '/bookmarks'
    else
      flash[:notice] = "You must submit a valid URL."
      redirect '/bookmarks'
    end
  end

  post '/bookmarks/:id/comments/new' do
    @bookmark = params[:id]
    erb :comments
  end


  post '/bookmarks/:id/comments' do
    connection = PG.connect(dbname: 'bookmark_manager_test')
    connection.exec("INSERT INTO comments (text, bookmark_id) VALUES('#{params[:comment]}', '#{params[:id]}');")
    redirect '/bookmarks'
  end

  run! if app_file == $0
end
