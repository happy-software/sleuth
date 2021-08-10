class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      # t.text :first_name
      # t.text :last_name
      # t.text :email
      t.text :state

      # We don't encrypt state because :shurg:
      t.text :first_name_ciphertext
      t.text :last_name_ciphertext
      t.text :email_ciphertext
      t.text :email_bidx, index: { unique: true }

      t.timestamps
    end
  end
end
