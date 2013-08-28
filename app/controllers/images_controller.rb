class ImagesController < ApplicationController
require 'net/ftp'
  # GET /images
  # GET /images.json
  def index
    @images = Image.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @images }
    end
  end

  # GET /images/1
  # GET /images/1.json
  def show
    @image = Image.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @image }
    end
  end

  # GET /images/new
  # GET /images/new.json
  def new
    @image = Image.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @image }
    end
  end

  # GET /images/1/edit
  def edit
    @image = Image.find(params[:id])
  end

  # POST /images
  # POST /images.json
  def create
    if current_user
       if current_user.role=="admin"
    		file = params[:file]
    		@albumy_przydzialu = Album.find_all_by_przydzial(params[:przydzial])
		if params[:przydzial] == "news"
		@przydzial = News.find(params[:przydzial_id])
		elsif params[:przydzial] == "album"
		@przydzial = Album.find(params[:przydzial_id])
		end
		@album = @albumy_przydzialu.detect{|w| w.przydzial_id == @przydzial.id}
		
		if file != nil && file.original_filename.end_with?('.jpg','.JPG','.png','.PNG','.gif','.GIF')
		file.original_filename = file.original_filename.gsub(/\s+/, "")
		@zdjecia = Image.find_all_by_nazwa(file.original_filename).count
		if @zdjecia == 0
    		  ftp = Net::FTP.new('FTP.gdanskcurlingclub.pl')
        	  ftp.passive = true
    		  ftp.login(user = "images@gdanskcurlingclub.pl", passwd = ENV['ftp_images_password')
    		  ftp.storbinary("STOR " + file.original_filename, StringIO.new(file.read), Net::FTP::DEFAULT_BLOCKSIZE)
    		  ftp.quit()
    		  
   		  if @album == nil
		  @album = Album.new
		  @album.tytul = @przydzial.tytul
		  @album.przydzial = params[:przydzial]
	          @album.przydzial_id = @przydzial.id
	          @album.termin = @przydzial.termin
		  @album.save
		  end 	
		  	  
		  @image = Image.new
		  @image.nazwa = file.original_filename
        	  @image.opis = params[:opis]
		  @image.nr_albumu = @album.id


    		  respond_to do |format|
      		    if @image.save
        		format.html { redirect_to @przydzial, notice: 'Gratulacje! Dodano zdj&#281;cie do aktualno&#347;ci' }
        		format.json { render json: @image, status: :created, location: @image }
      		    else
        		format.html { redirect_to @przydzial, notice: 'Uwaga! Niepowodznie dodania zdjecia' }
        		format.json { render json: @image.errors, status: :unprocessable_entity }
      		    end
    		  end
		else
		  redirect_to @przydzial, :notice => 'Uwaga! Zdj&#281;cie o takiej nazwie ju&#380; jest w bazie!'
		end
		else
		  redirect_to @przydzial, :notice => 'Uwaga! Nie wybrano zdj&#281cia z komputera lub rozszerzenie jest nieprawid&#322owe!'
		end
	else
  	redirect_to root_url, :notice => 'Uwaga! Nie masz uprawnie&#324;!'
  	end
    else
        redirect_to :login, :notice => 'Informacja! Zaloguj si&#281; aby obejrze&#263;!'
    end
  end

  # PUT /images/1
  # PUT /images/1.json
  def update
    @image = Image.find(params[:id])

    respond_to do |format|
      if @image.update_attributes(params[:image])
        format.html { redirect_to @image, notice: 'Image was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /images/1
  # DELETE /images/1.json
  def destroy
    @image = Image.find(params[:id])
    @image.destroy

    respond_to do |format|
      format.html { redirect_to images_url }
      format.json { head :no_content }
    end
  end
end
