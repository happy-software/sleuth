namespace :users do
  task create: :environment do
    brokers = DataBroker.all

    # Assign every data broker to this test user
    user_data_brokers = brokers.map { |broker| UserDataBroker.new(data_broker: broker) }

    User.create(
      first_name: "Test",
      last_name: "User",
      email: "test.user@gmail.com",
      state: "WI",
      age: 39,
      user_data_brokers: user_data_brokers,
    )
  end
end
