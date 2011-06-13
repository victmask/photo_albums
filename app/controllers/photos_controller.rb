class PhotosController < ApplicationController

  # GET /photos
  # GET /photos.xml
  def index
    @photos = Photo.all.paginate(:per_page => 18, :page => params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @photos }
    end
  end

  # GET /photos/1
  # GET /photos/1.xml
  def show
    @photo = Photo.find(params[:id])
    @album = Album.find(@photo.album_id)
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @photo }
    end
  end


end
