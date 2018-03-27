class CreateContacts < ActiveRecord::Migration[5.1]
  def change
  	create_table :contacts do |t|
  		t.text :name
  		t.text :mail
  		t.text :post
  		
  		t.timestamps
  	end
  end
end
