FileUtils.mkdir_p('log')
require 'logger'
DB.loggers << Logger.new('log/seguel.log')

RSpec.configure do |c|
  c.before(:suite) do
    Sequel.extension :migration
    Sequel::Migrator.run(DB, 'db/migrations')
    DB[:expenses].truncate
  end
  c.around(:example, :db) do |example|
    DB.transaction(rollback: :always) do
      DB.log_info("Starting example: #{example.metadata[:description]}")
      example.run
      DB.log_info("Ending example: #{example.metadata[:description]}")
    end
  end
end
