require 'rails_helper'

RSpec.describe FourOFourController, :type => :controller do

  describe "index" do
	it "renders the page_not_found template" do  
	  get :index , {:path => '/nonexistent'}
	  expect(response).to render_template :index
    end
  end

end
