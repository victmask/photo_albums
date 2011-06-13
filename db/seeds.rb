# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

# Modify this to reflect your ENV
#    s_dir = '/Users/victmask/RoR/photo_album/public/images/'
    s_dir = Dir.pwd + '/public/images/'
    # Get the names of all files in the source directory
    albums = Dir.entries(s_dir)

    # Truncate the database
    Album.delete_all

    albums.each do |a|
        next if a == '.' # current directory
        next if a == '..'# the parent

        # We're only interested in directories
        if File.directory?(s_dir + a)
          # Create a new entry in the albums table
          album = Album.new(:title => a.split('_').each{|word| word.capitalize!}.join(' '),:directory => a)
          album.save
        end
    end

    #Add the images to the albums
    albums = Album.find(:all)

    # Truncate the photos table
    Photo.delete_all

    # Find the photos for each album (directory)
    albums.each do |a|
      # Add a file only if there's a thumbnail image for it.
      next unless File.directory?(s_dir + a.directory + "/thumbs/")

      # Move into the image directory and read the file names
      Dir.chdir(s_dir + a.directory + "/thumbs/")
      images = Dir.entries('.')

      images.each do |im|
        next if File.directory?(im)
        # We're only interested in regular files that end with jpg, png, or gif.
        next if im !~ /.(jpg|png|gif)$/i

        # Make sure there's a full-sized counterpart to the thumbnail
        if File.exist?(s_dir + a.directory + "/" + im)
          # Create a new record in the photos table. Note the album_id
          # sets this as belongs_to relationship.
          p = Photo.new(:title => im,:description =>  im + ": needs descriptions",
                        :image_path =>  a.directory,  :album_id => a.id, :image_name => im)
          p.save
        end
      end
    end



