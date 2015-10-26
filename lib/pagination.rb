# Class to keep pagination values from API
class Pagination
 
  attr_reader :per_page, :current_page, :current_entries, :total_entries, :total_pages
   
  def initialize (per_page, current_page, current_entries, total_entries, total_pages)
    @per_page = per_page
	@current_page = current_page
	@current_entries = current_entries
	@total_entries = total_entries
	@total_pages = total_pages
  end
  
  def to_s
      "#{@per_page} #{@current_entries} #{@total_entries} #{@total_pages}"
  end
  
end