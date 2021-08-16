class UserDataBroker < ApplicationRecord
  belongs_to :user
  belongs_to :data_broker

  scope :spokeo, -> { joins(:data_broker).where(data_brokers: { name: DataBroker::Spokeo }) }
end
