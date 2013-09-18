# encoding: UTF-8
class ImagesController < ApplicationController
require 'net/ftp'

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
		if file.size < 200.kilobytes
		file.original_filename = file.original_filename.gsub(/\s+/, "")
		@zdjecia = Image.find_all_by_nazwa(file.original_filename).count
		if @zdjecia == 0
    		  ftp = Net::FTP.new('FTP.gdanskcurlingclub.pl')
        	  ftp.passive = true
    		  ftp.login(user = "images@gdanskcurlingclub.pl", passwd = ENV['ftp_images_password'])
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
        		format.html { redirect_to @przydzial, notice: 'Gratulacje! Dodano zdjęcie do aktualności' }
        		format.json { render json: @image, status: :created, location: @image }
      		    else
        		format.html { redirect_to @przydzial, notice: 'Uwaga! Niepowodznie dodania zdjęcia' }
        		format.json { render json: @image.errors, status: :unprocessable_entity }
      		    end
    		  end
		else
		  redirect_to @przydzial, :notice => 'Uwaga! Zdjęcie o takiej nazwie już jest w bazie!'
		end
		else
    		  redirect_to @user, :notice => 'Informacja!<br>Zdjęcie jest za duże max 200KB !'
    		end
		else
		  redirect_to @przydzial, :notice => 'Uwaga! Nie wybrano zdjęcia z komputera lub rozszerzenie jest nieprawidłowe!'
		end
	else
  	redirect_to root_url, :notice => t('errors.messages.permissions')
  	end
    else
        redirect_to :login, :notice => t('errors.messages.login_to_see')
    end
  end

  def destroy
    if current_user
       if current_user.role=="admin"
    	@image = Image.find(params[:id])
    	@image.destroy

    	respond_to do |format|
      		format.html { redirect_to "/galeria", notice: 'Gratulacje! Zdjęcie zostało usunięte!' }
      		format.json { head :no_content }
    	end
	else
  	redirect_to root_url, :notice => t('errors.messages.permissions')
  	end
    else
        redirect_to :login, :notice => t('errors.messages.login_to_see')
    end
  end
end
