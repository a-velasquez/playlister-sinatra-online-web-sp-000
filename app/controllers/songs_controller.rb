class SongsController < ApplicationController

 get '/songs' do
   @songs = Song.all
   erb :'/songs/index'
 end

 get '/songs/new' do
    @genres = Genre.all
    erb :"songs/new"
  end

  get '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    erb :'songs/show'
  end

  post '/songs' do

    @song = Song.create(:name => params["Name"])
    @song.artist = Artist.find_or_create_by(:name => params["Artist Name"])
    @song.genre_ids = params[:genres]
    @song.save

    erb :"songs/show"
  end


 # post '/songs' do
 #
 #   artist_entry = params[:song][:artist]
 #   if Artist.find_by(:name => artist_entry)
 #     artist = Artist.find_by(:name => artist_entry)
 #   else
 #     @song = Song.create(:name => params[:song][:name])
 #     artist = Artist.create(:name => artist_entry)
 #   end
 #   @song.artist = artist
 #
 #   genre_selections = params[:song][:genres]
 #   @song.genre_id = genre_selections
 #
 #   @song.save
 #
 #   redirect to '/songs/#{@song.slug}'
 #
 # end


 patch '/songs/:slug' do #edit action
    @song = Song.find_by_slug(params[:slug])
    @song.update(params[:song])
    @song.artist = Artist.find_or_create_by(name: params[:artist][:name])
    @song.save

    redirect '/songs/#{@song.slug}'
  end

  get '/songs/:slug/edit' do
    slug = params[:slug]
    @song = Song.find_by_slug(slug)
    erb :"songs/edit"
  end

end
