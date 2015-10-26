# Class for instance a Transaction
class Transaction
 
   attr_accessor :id, :account_number,:transaction_type, :subject, :amount, :currency, :booking_date, :value_date,
     :return_transaction_id, :created_at, :updated_at, :transaction_type_details
  
  def to_s
      "#{@id} #{@account_number} #{@transaction_type} #{@subject} #{@amount}"
  end
  
  def self.to_csv(myArray)
    
	 CSV.generate do |csv|
	   csv << [I18n.t('views.transactions.show.page_table_transaction_id'),
	           I18n.t('views.transactions.show.page_table_transaction_type'),
			   I18n.t('views.transactions.show.page_table_subject'),
			   I18n.t('views.transactions.show.page_table_amount'),
			   I18n.t('views.transactions.show.page_table_booking_date')
			  ]
       myArray.each do |transaction|
	     csv << [transaction.id, transaction.transaction_type,
                 transaction.subject, transaction.amount, 
				 transaction.booking_date
				]
	   end
    end
	 
  end
  
end