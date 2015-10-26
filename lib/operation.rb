# Class for instance an API Operation
# This class will keep results and pagination values from paginated API response
class Operation
 
  attr_reader :result, :pagination
   
  def initialize (result, pagination)
    @result = result
	@pagination = pagination
  end
  
  
end