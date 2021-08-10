class User < ApplicationRecord
  encrypts :first_name, :last_name, :email
  blind_index :email, slow: true
end
