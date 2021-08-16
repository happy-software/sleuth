class User < ApplicationRecord
  encrypts :first_name, :last_name, :state, :email
  encrypts :age, type: :integer

  blind_index :first_name, slow: true
  blind_index :last_name, slow: true
  blind_index :email, slow: true

  has_many :user_data_brokers, dependent: :destroy
  has_many :data_brokers, through: :user_data_brokers
end
