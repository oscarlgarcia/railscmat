# Class for instance a User
class User
 
  attr_reader :id, :email, :access_right
   
  def initialize (id, email, access_right)
    @id = id
	@email = email
	@access_right = access_right
  end
   
  def to_s
      "#{@id} #{@email} #{@access_right}"
  end  
end