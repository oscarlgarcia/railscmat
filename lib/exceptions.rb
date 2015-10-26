module Exceptions    
  class OAuthConnError < StandardError
    
	attr_reader :errors, :code, :message
	
	def initialize (code, msg, errors) 
	 @code=code
	 @message=msg
	 @errors=errors
	end
  end
  
  
  
  class OAuthHTTPStatusError < StandardError
   
   attr_reader :errors, :code, :message
	
	def initialize (code, msg, errors) 
	 @code=code
	 @message=msg
	 @errors=errors
	end

  end
  
  
  class OAuthProcessStatusError < StandardError

    attr_reader :errors, :code, :message
	
	def initialize(code, msg, errors) 
	 @code=code
	 @message=msg
	 @errors=errors
	end
	

  end 
end