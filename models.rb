require 'active_record'

ActiveRecord::Base.establish_connection(
	:adapter => "postgresql",
	:host => "localhost",
	:database => "transaction_db"
)

class CreateTransaction < ActiveRecord::Migration
	def initialize
		create_table :transacts do |column|
			column.string :payee
			column.float :amount
			column.string :date
			column.string :category
		end	
end
end
class Transact < ActiveRecord::Base
		belongs_to :account
			validates :payee, presence: true
			validates :amount, presence: true
			validates :date, presence: true
end