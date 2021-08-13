class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.text :first_name_ciphertext
      t.text :last_name_ciphertext
      t.text :email_ciphertext
      t.text :state_ciphertext
      t.text :age_ciphertext

      t.text :first_name_bidx, index: true
      t.text :last_name_bidx, index: true
      t.text :email_bidx, index: { unique: true }

      t.timestamps
    end
  end
end
