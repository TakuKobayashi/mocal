# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

def bench(title = "")
  benchmark_start = Time.now
  puts "== Seeding #{title} Data ".ljust(79, "=")
  context = yield
  elapsed = (Time.now - benchmark_start).to_d.floor(4).to_s
  puts " -> #{elapsed}s"
  context
end

bench("api_info") do
  book = ::Roo::Excel.new("db/mst_data/mst_api_config.xls")
  import_sheet(book.sheet("mst_api_configs"), Mst::ApiConfig)
  import_sheet(book.sheet("api_feature_configs"), Mst::ApiFeatureConfig)
end