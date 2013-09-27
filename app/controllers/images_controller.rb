# encoding: UTF-8
class ImagesController < ApplicationController
require 'net/ftp'

  def create
    if current_user
       if current_user.role=="admin"
       		@udane = 0
       		@nieudane = 0
       		
    		@file = params[:file]
    		@albumy_przydzialu = Album.find_all_by_przydzial(params[:przydzial])
    		
		if params[:przydzial] == "news"
		   @przydzial = News.find(params[:przydzial_id])
		elsif params[:przydzial] == "album"
		   @przydzial = Album.find(params[:przydzial_id])
		end
		
		@album = @albumy_przydzialu.detect{|w| w.przydzial_id == @przydzial.id}

   		if @album == nil
		   @album = Album.new
		   @album.tytul = @przydzial.tytul
		   @album.przydzial = params[:przydzial]
	           @album.przydzial_id = @przydzial.id
	           @album.termin = @przydzial.termin
		   @album.save
		end 
		  
		if @file != nil 
		   ftp = Net::FTP.new('FTP.gdanskcurlingclub.pl')
        	   ftp.passive = true
    		   ftp.login(user = "images@gdanskcurlingclub.pl", passwd = ENV['ftp_images_password'])
    		   
		@file.each do |zdjecie|
		   if (zdjecie.size < 200.kilobytes) && (zdjecie.original_filename.end_with?('.jpg','.JPG','.png','.PNG','.gif','.GIF'))
		      zdjecie.original_filename = zdjecie.original_filename.gsub(/\s+/, "")
    		      ftp.storbinary("STOR " + zdjecie.original_filename, StringIO.new(zdjecie.read), Net::FTP::DEFAULT_BLOCKSIZE)

		      @image = Image.new
		      @image.nazwa = zdjecie.original_filename
        	      @image.opis = params[:opis]
		      @image.nr_albumu = @album.id
		      @image.save
		
		      @udane.increment!
		   else
		      @nieudane.increment!
		   end
		end
		   ftp.quit()

    		  respond_to do |format|
    		    if @udane > 0
        		format.html { redirect_to @przydzial, notice: 'Gratulacje!<br>Dodano: #{@udane} zdjęć<br>Niepowodznie dodania: #{@nieudane} zdjęć' }
        	    else
        		format.html { redirect_to @przydzial, notice: 'Uwaga!<br> Niepowodznie dodania zdjęć<br>Nieudanych: #{@nieudane}' }
        	    end
    		  end

		else
		  redirect_to @przydzial, :notice => 'Uwaga! Nie wybrano zdjęcia z komputera!'
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
