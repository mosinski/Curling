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

              @udane += 1
            else
              @nieudane += 1
            end
          end
          ftp.quit()

          respond_to do |format|
            if @udane > 0
              format.html { redirect_to @przydzial, flash: {success: "Gratulacje!<br>Dodano: #{@udane} zdjęć<br>Niepowodznie dodania: #{@nieudane} zdjęć"}}
            else
              format.html { redirect_to @przydzial,
                            flash: {error: "Uwaga!<br>Rozmiar pliku lub jego rozszerzenie jest niewłaściwe<br>
                            Zjdęcie powinno być nie większe niż 200kb, dopuszczalne rozszerzenia pliku: jpg png gif.<br>
                            Niepowodznie dodania zdjęć<br>Nieudanych: #{@nieudane}"}}
            end
          end

        else
          redirect_to @przydzial, flash: {error: 'Uwaga! Nie wybrano zdjęcia z komputera!'}
        end
      else
        redirect_to root_url, flash: {error: t('errors.messages.permissions')}
      end
    else
      redirect_to :login, flash: {notice: t('errors.messages.login_to_see')}
    end
  end

  def destroy
    if current_user
      if current_user.role=="admin"
        @image = Image.find(params[:id])
        @image.destroy

        respond_to do |format|
          format.html { redirect_to "/galeria", flash: {success: 'Gratulacje! Zdjęcie zostało usunięte!'}}
          format.json { head :no_content }
        end
      else
        redirect_to root_url, flash: {error: t('errors.messages.permissions')}
      end
    else
      redirect_to :login, flash: {notice: t('errors.messages.login_to_see')}
    end
  end

  def destroy_multiple
    if current_user
      if current_user.role=="admin"

        Image.destroy(params[:images])

        respond_to do |format|
          format.html { redirect_to "/galeria", flash: {success: 'Gratulacje! Zdjęcia zostały usunięte!'}}
          format.json { head :no_content }
        end

      else
        redirect_to root_url, flash: {error: t('errors.messages.permissions')}
      end
    else
      redirect_to :login, flash: {notice: t('errors.messages.login_to_see')}
    end
  end
end
