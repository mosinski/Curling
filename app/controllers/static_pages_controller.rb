class StaticPagesController < ApplicationController

 def start

    respond_to do |format|
      format.html # start.html.erb
      format.json { render json: @static_page }
    end
  end

 def galeria
   
    respond_to do |format|
      format.html # galeria.html.erb
      format.json { render json: @static_page }
    end
  end

 def about

    respond_to do |format|
      format.html # about.html.erb
      format.json { render json: @static_page }
    end
  end

 def admin_panel
    if current_user
    	if current_user.role == "admin"
    	@users = User.find_all_by_potwierdzenie(1)
    	@users_waiting = User.find_all_by_potwierdzenie(0)

    	respond_to do |format|
      		format.html # about.html.erb
      		format.json { render json: @static_page }
    	end
	else
  	  redirect_to root_url, :notice => 'Uwaga! Nie masz uprawnie&#324;!'
  	end
    else
        redirect_to :login, :notice => 'Informacja! Zaloguj si&#281; aby obejrze&#263;!'
    end
  end

  def contact
	@name = params[:contact_name]
	@email = params[:contact_email]
	@message = params[:contact_message]

	if @name != "" && @email != "" && @message != ""
		ContactMailer.message_sender(@name,@email,@message).deliver
		redirect_to root_url, :notice => 'Informacja! Wiadomo&#347;&#263; wys&#322;ana pomy&#347;lnie dzi&#281;kujemy!'
	else
          redirect_to root_url, :notice => 'Uwaga! Podane dane s&#261; niekompletne!'
	end

  end

  def reset_pass
	@user = User.find_by_username(params[:user_name])
        @form_born = convert_date(params[:user], :born)
	@form_pesel = params[:user_pesel]

	if @user != nil
		if (@user.pesel == @form_pesel) && (@user.born == @form_born)
		  @nowehaslo = SecureRandom.base64(8).tr('+/=lIO0', 'pqrsxyz')
        	  redirect_to "/resethasla", :notice => "Gratulacje! Nowe has&#322;o zosta&#322;o wys&#322;ane na maila!"
		else
        	  redirect_to "/resethasla", :notice => 'Uwaga! Podane dane s&#261; nieprawid&#322;owe!'
		end
        
	else
          redirect_to "/resethasla", :notice => 'Informacja! Nie znaleziono Konta lub podane dane s&#261; niekompletne!'
	end
  end

  private
 
  def convert_date(hash, date_symbol_or_string)
    attribute = date_symbol_or_string.to_s
    return Date.new(hash[attribute + '(1i)'].to_i, hash[attribute + '(2i)'].to_i, hash[attribute + '(3i)'].to_i)   
  end


end
