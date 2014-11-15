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

def import_sheet(sheet, base_class, options = {})
  datas = []
  headers = sheet.row(1)
  rindex = 1
  sheet.each do |row| # Arrayのeachではない。
    if rindex > 1
      datas << headers.each_with_index.each_with_object({}) do |(col, cindex), o|
        if col.blank?
          # do nothing
        else
          o[col] = sheet.cell(rindex, cindex + 1)
        end
      end
    end
    break if options[:limit] && (rindex + 1) == options[:limit]
    rindex += 1
  end
  mod_datas = datas.compact.map do |data|
    data = data.with_indifferent_access
    data = yield(data) if block_given?
    case true
    when data.is_a?(Hash) then base_class.create!(data)
    when data.is_a?(Array) then data.map {|d| base_class.create!(d)}
    end
  end.compact.flatten

  #base_class.import(mod_datas)
end

bench("mst_api_config") do
  book = ::Roo::Excelx.new("db/mst_data/mst_api_config.xlsx")
  import_sheet(book.sheet("mst_api_configs"), Mst::ApiConfig)
  import_sheet(book.sheet("mst_api_feature_configs"), Mst::ApiFeatureConfig)
end

bench("mst_company") do
  book = ::Roo::Excelx.new("db/mst_data/mst_comany.xlsx")
  import_sheet(book.sheet("mst_companies"), Mst::Company)
end