namespace :data_brokers do
  task populate: :environment do |_|
    App::Application.config_for(:data_brokers).brokers.each do |broker_name, config|
      Rails.logger.info("Creating/Updating DataBroker##{config[:id]} (#{broker_name})")

      opt_out_type = config[:opt_out_type].strip
      raise "Invalid opt-out type for #{broker_name}" unless DataBroker::OptOutTypes.include?(opt_out_type)

      broker = DataBroker.find_or_initialize_by(id: config[:id])

      broker.update(
        name: broker_name,
        url: config[:url].strip,
        opt_out_url: config[:opt_out_url].strip,
        opt_out_type: opt_out_type,
        notes: config[:notes]&.strip,
      )
    end
  end
end
