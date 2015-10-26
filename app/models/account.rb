class Account < ActiveRecord::Base

validates_presence_of :account_number, :account_fidor_id, :two_man_rule, :customer_id, :approver_id ,:is_active
has_many :payments

  def is_tmr?
    return self.two_man_rule 
  end 
  
  
end
