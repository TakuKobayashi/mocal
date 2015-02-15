module ApplicationHelper
  def json_set_all_column(json, ar_class, model)
    enums = model.defined_enums
    column_names = ar_class.column_names
    column_names-= ["created_at", "updated_at"]
    column_names.each do |name|
      value = model.send(name)
      json.set! name, enums[name] ? enums[name][value] : value
    end
  end
end
