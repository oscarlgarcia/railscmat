class Status < ActiveRecord::Base

validates_presence_of :name

  def is_denied?
    return (self.name == Constants::PAYMENT_2MC_DENIED_STATUS)
  end

end
