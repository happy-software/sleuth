class DataBroker < ApplicationRecord
  OptOutTypes = [
    Form = "form".freeze
  ].freeze

  Providers = [
    Spokeo = "spokeo".freeze,
    PeekYou = "peekyou".freeze,
    Pipl = "pipl".freeze,
    WhitePages = "whitepages".freeze,
    Epsilon = "epsilon_data_management".freeze
  ].freeze

  has_many :user_data_brokers, dependent: :destroy
  has_many :users, through: :user_data_brokers
end
