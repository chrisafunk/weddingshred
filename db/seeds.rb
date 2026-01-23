
# db/seeds.rb
# Fresh loader:
# - Purges Exercise
# - Resets PK sequence (when supported)
# - Loads the exercises seed file

puts "[seeds] Purging exercises…"
Exercise.delete_all

if ActiveRecord::Base.connection.respond_to?(:reset_pk_sequence!)
  ActiveRecord::Base.connection.reset_pk_sequence!("exercises")
elsif ApplicationRecord.connection.respond_to?(:reset_pk_sequence!)
  ApplicationRecord.connection.reset_pk_sequence!("exercises")
end

puts "[seeds] Loading exercise seeds…"
require_relative "seeds/exercises.seeds"

puts "[seeds] Done."
