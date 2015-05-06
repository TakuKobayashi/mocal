class JsonConverter
  SPREADSHEET_ORIGINALFILE_DIRECTORY_PATH = "/tmp/spreadsheet/"

  def initialize(file)
    pref_file_name = Rails.root.to_s + SPREADSHEET_ORIGINALFILE_DIRECTORY_PATH + SecureRandom.hex.to_s + "_"
    ext = File.extname(file.original_filename).downcase
    filename = file.original_filename.underscore
    @file_path = pref_file_name + filename
    File.open(@file_path, 'wb') { |f| f.write(file.read)}
    @file_ext = ext[1..ext.size]
  end

  def convert
    case(@file_ext)
    when "csv"
      json = convert_from_csv
    when "xls"
      json = convert_from_except_csv
    when "xlsx"
      json = convert_from_except_csv
    else
      raise "input file is not support"
    end
    return json
  end

  private
  def adjust_cell(hash)
    h = {}
    hash.each do |key, value|
      if value.nil?
        hash[key] = nil
        next
      end
      begin
        v = Integer(value)
      rescue ArgumentError => e
        begin
          v = Float(value)
        rescue ArgumentError => e
          v = value
        end
      end
      h[key] = v
    end
    h
  end

  def convert_from_csv
    result = []
    CSV.foreach(@file_path, headers: true) do |row|
      result << adjust_cell(row.to_hash)
    end
    return result.to_json
  end

  def convert_from_except_csv
    if @file_ext == "xls"
      book = ::Roo::Excel.new(@file_path)
    else
      book = ::Roo::Excelx.new(@file_path)
    end
    sheets = book.sheets
    result = {}
    sheets.each do |s|
      arr = []
      sheet = book.sheet(s)
      headers = sheet.row(1)
      sheet.each_with_index do |row, index|
        next if index == 0
        arr << adjust_cell(Hash[[headers,row].transpose])
      end
      if sheets.size <= 1
        result = arr
      else
        result[s] = arr
      end
    end
    return result.to_json
  end
end