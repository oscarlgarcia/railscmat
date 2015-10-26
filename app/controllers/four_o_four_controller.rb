class FourOFourController < ApplicationController

def index
  respond_to do |format|
    flash[:status] = request.path
    format.html { render :index }
    format.all  { render :nothing => true,:status => "404 Not Found" }
  end
end


end
