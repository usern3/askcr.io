module ErrorFormatters
  def join_error_messages(errors : Hash(Symbol, Array(String))) : String
    output = [] of String
    errors.each do |k, v|
      output << "#{k.to_s.gsub("_", " ").capitalize} #{v[0]}"
    end
    output.join(" ")
  end
end
