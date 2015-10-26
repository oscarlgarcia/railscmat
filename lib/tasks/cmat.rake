namespace :cmat do
  desc "Exports Payments information from database"
  task export_payments: :environment do
    Payment.order(:id).all.each do |payment|
      puts "Payment.create(#{payment.serializable_hash.delete_if {|key, value| ['created_at','updated_at','id'].include?(key)}.to_s.gsub(/[{}]/,'')})"
    end
  end
end
