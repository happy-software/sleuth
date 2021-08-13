class CreateDataBrokers < ActiveRecord::Migration[6.1]
  def change
    create_table :data_brokers do |t|
      t.text :name
      t.text :url
      t.text :opt_out_url
      t.text :opt_out_type
      t.text :notes

      t.timestamps
    end
  end
end
