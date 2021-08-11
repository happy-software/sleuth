class User < ApplicationRecord
  encrypts :first_name, :last_name, :state, :email
  encrypts :age, type: :integer

  blind_index :first_name, slow: true
  blind_index :last_name, slow: true
  blind_index :email, slow: true
end
