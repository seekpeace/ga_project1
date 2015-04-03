require 'active_record'
require 'pry'
require_relative 'modelsv2'

def babys_bottom
	ActiveRecord::Base.connection.tables.each do |table|
	ActiveRecord::Base.connection.drop_table(table)
	end
end
#CreateTransaction.new
 ebalance = 100000
 while true
 	puts "MENU"
 	puts "1 - Current Balance"
 	puts "2 - View ALL Transactinos"
 	puts "3 - Add A Transaction"
 	puts "4 - Delete A Transaction"
 	puts "5 - Edit A Transaction"
 	puts "6 - View By Category"
 	puts "7 - Quit"
 	puts "Enter a number for the menu option"
 	choice = gets.chomp.to_i

	case choice
	when 1 #Current Balance 
		puts "Your balance as of now"
		ebalance = ebalance + Transact.sum(:amount)
		puts "$#{ebalance}"
	when 2 #View ALL Transactinos
		# if Transact.all.empty?
		# 	puts "There are no transactions"
		# else
			puts "Your Transaction History:"
			Transact.all.each do |x|
			puts "#ID: #{x.id} Payee: #{x.payee} $#{x.amount} Date:#{x.date} Category:#{x.category} balance:$#{ebalance}"
			end
#		end

	when 3 #Add A Transaction
		print "Enter payee: "
		payee_holder = gets.chomp.to_s
		print "Enter amount $:"
		amount_holder = gets.chomp.to_f.round(2)
		while true
			puts "Will this be a credit or debit? Enter c or d"
			add_subtract = gets.chomp.to_s
			if add_subtract == "c"
				amount_holder = amount_holder*-1
				break
			elsif !(amount_holder == "c" || amount_holder == "d")
				puts "Please type in c or d for credit or debit"
			else
				break
			end
		end	
		puts "Enter date: "
		print "Month: "
		month_holder = gets.chomp.to_i
		print "Day: "
		day_holder = gets.chomp.to_i
		print "Year: "
		year_holder = gets.chomp.to_i
		date_holder = 	{
						month: month_holder,
						day: day_holder,
						year: year_holder
						}	

		puts "Pick a Category"
		puts "1 - Entertainment"
		puts "2 - Contracts"
		puts "3 - Food"
		puts "4 - Extortion"
		puts "5 - Bribes"
		puts "6 - Poisons"
		puts "7 - Weapons"
		cat_option = gets.chomp.to_i		
		
		Transact.create(payee: payee_holder, amount: amount_holder, date: date_holder, category: cat_option)

	when 4 #Delete A Transaction
		puts "Choose a transaction to delete:"
		Transact.all.each do |x|
		puts "#ID: #{x.id} Payee: #{x.payee} Amount:$#{x.amount} Date:#{x.date} Category:#{x.category} balance:$#{ebalance}"
		end	
		print "Enter Transaction ID: "
		delete_transaction = gets.chomp.to_i
		Transact.delete(delete_transaction)

	when 5 #Edit A Transaction
		puts "Choose a transaction to edit:"
		Transact.all.each do |x|
		puts "#ID: #{x.id} Payee: #{x.payee} Amount:$#{x.amount} Date:#{x.date} Category:#{x.category} balance:$#{ebalance}"
		end	
		puts "Enter Transaction ID to overwrite: "
		edit_transactionid = gets.chomp.to_i
		print "Enter new payee: "
		payee_holder = gets.chomp.to_s
		print "Enter new amount $:"
		amount_holder = gets.chomp.to_f.round(2)
		
		puts "Enter new date: "
		print "Month: "
		month_holder = gets.chomp.to_i
		print "Day: "
		day_holder = gets.chomp.to_i
		print "Year: "
		year_holder = gets.chomp.to_i
		date_holder = 	{
						month: month_holder,
						day: day_holder,
						year: year_holder
						}	

		puts "Pick a new category"
		puts "1 - Entertainment"
		puts "2 - Contracts"
		puts "3 - Food"
		puts "4 - Extortion"
		puts "5 - Bribes"
		puts "6 - Poisons"
		puts "7 - Weapons"
		cat_option = gets.chomp.to_i		

		Transact.update(edit_transactionid, payee: payee_holder, amount: amount_holder, date: date_holder, category: cat_option)
		#	Drink.find_by(id: sip_drink).update(size: drink_left)
		
	when 6 #View by Category
		puts "Choose your view: "
		puts "1 - Entertainment"
		puts "2 - Contracts"
		puts "3 - Food"
		puts "4 - Extortion"
		puts "5 - Bribes"
		puts "6 - Poisons"
		puts "7 - Weapons"
		puts "8 - All"
		view_choice = gets.chomp.to_i
		category_total = 0
		category_total.to_f.round(2)
		if view_choice < 8
			Transact.where(category: view_choice).each do |x|
			puts "#ID: #{x.id} To: #{x.payee} $#{x.amount} Date:#{x.date} Category:#{x.category}"
			category_total = category_total + x.amount
			end
			print "Total for this category is: $#{category_total}"
		elsif view_choice == 8
			firstone = Transact.order(:category).first
			same = firstone.category
			Transact.order(:category).each do |x|
			if same == x.category
			category_total = category_total + x.amount
			puts "#ID: #{x.id} To: #{x.payee} $#{x.amount} Date:#{x.date} Category:#{x.category}"
			else
				puts "Total for this categories is: $#{category_total}"
				puts "================================================"
				puts "#ID: #{x.id} To: #{x.payee} $#{x.amount} Date:#{x.date} Category:#{x.category}"
			  	same = x.category
			  	category_total = 0
			  	category_total = x.amount
			end
			end
			puts "Total for this categories is: $#{category_total}"	
		else
			puts ""
		end	

	when 7
		break
	else
		puts "Enter a number 1 through 7 please"
	end
 end

binding.pry

