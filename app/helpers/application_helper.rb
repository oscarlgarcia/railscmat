module ApplicationHelper

  def language_selector
    if I18n.locale == :en
      link_to "Deutsch", url_for(:locale => 'de')
    else
      link_to "English", url_for(:locale => 'en')
    end
  end


end
