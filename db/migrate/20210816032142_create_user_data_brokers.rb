class CreateUserDataBrokers < ActiveRecord::Migration[6.1]
  def change
    create_table :user_data_brokers do |t|
      t.belongs_to :user
      t.belongs_to :data_broker

      t.text :status
      t.datetime :opted_out_on

      t.timestamps
    end
  end
end
