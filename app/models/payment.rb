class Payment < ActiveRecord::Base

validates_presence_of :account_id , :transaction_number , :amount , :currency , :iban , :bic , :status_id, :uuid
belongs_to :account
belongs_to :status
after_initialize :init

  def init
    self.transaction_number  ||= "-"
    self.currency ||= "euro"  #TODO load from DB
  end
  
  def pretty_created_at
    self.created_at.strftime("%FT%T") 
  end

  def can_approve?(user_id)
    return (user_id == self.account.approver_id)? true : false
  end

  def is_denied?
  	return (self.status.name == Constants::PAYMENT_2MC_DENIED_STATUS)? true : false
  end

  def is_modified?
    return (self.status.name == Constants::PAYMENT_MODIFIED_STATUS)? true : false
  end

  def can_complete?
   
    if (self.status.name == Constants::PAYMENT_MODIFIED_STATUS || self.status.name == Constants::PAYMENT_CREATED_STATUS)
      self.status = Status.where(:name=>Constants::PAYMENT_MTANCONFIRMED_STATUS).first
      return true unless self.account.is_tmr?
    end

    if (self.status.name == Constants::PAYMENT_2MC_CHECKED_STATUS)
      self.status = Status.where(:name=>Constants::PAYMENT_2MC_MTANCONFIRMED_STATUS).first 
      return true
    end

    return false
  
  end

end
