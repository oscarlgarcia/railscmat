# Class for instance an AccountInfo
class AccountDetail
 
   attr_reader :id, :account_number,:balance, :balance_available, :iban

  def initialize (id,account_number,balance, balance_available, iban) 
    @id = id
	@account_number = account_number
    @balance = balance
    @balance_available = balance_available
    @iban = iban
  end	

  def can_transfer? ( amount = 1)
    return self.balance_available.to_i >= amount.to_i
  end
  
  def to_s
      "#{@id} #{@account_number} #{@balance} #{@balance_available} #{@iban}"
  end
  
end