module Configurable
  def configure(yml_filename)
    config.merge!(load_config(yml_filename))

    config.each do |key, value|
      define_singleton_method(key) { value }
    end
  end

  private

  def config
    @config ||= {}
  end

  def load_config(name)
    filename = "#{name}.yml"
    content = File.read(Rails.root.join("config", filename))
    template = ERB.new(content)

    result = template.result(binding)
    YAML.load(result).fetch(Rails.env, {}).with_indifferent_access
  end
end
