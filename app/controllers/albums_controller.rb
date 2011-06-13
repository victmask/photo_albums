class AlbumsController < ApplicationController
  # GET /albums
  # GET /albums.xml


  def index
    @albums = Album.all
    @photos = Photo.all.paginate(:per_page => 18, :page => params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @albums }
    end
  end

  # GET /albums/1
  # GET /albums/1.xml
  def show
    @album = Album.find(params[:id])
    @photos = Photo.where("album_id = #{@album.id}").paginate(:per_page => 18, :page => params[:page])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @album }
    end
  end


end
