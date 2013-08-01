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

end
