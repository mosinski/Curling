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

end
