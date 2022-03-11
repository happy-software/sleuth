require "rake"

shared_context "when a rake task is tested" do
  subject(:task) { rake_task }

  let(:task_name) { self.class.top_level_description }
  let(:rake_task) { Rake::Task.tasks.find { |task| task.name == task_name } }

  # this is a custom task path relative to Rails root -- useful for rake tasks defined in the spec directory
  let(:task_path) { "" }

  before do
    Rails.application.load_tasks if Rake::Task.tasks.none?

    if task_path.present? && Rake::Task.tasks.none? { |task| task.name == task_name }
      Rake.application.rake_require(task_path, [Rails.root.to_s])
    end

    if rake_task.nil?
      error_message = <<~MSG.strip
        Attempted to run rake task #{task_name.inspect}, but could not find a matching rake task.
        Verify that the rake task is accessible by running:
          bundle exec rails -T
        You can also inspect the available tasks in code by running:
          Rake::Task.tasks
      MSG

      raise error_message
    end

    rake_task.reenable
  end
end
