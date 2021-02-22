module FormattingHelpers
  def minify_title(title : String, max_size : Int32)
    title.size > max_size ? "#{title[0..max_size]}..." : title
  end

  def pluralize(word, count)
    if count == 0 || count >= 2
      "#{count} #{word}s"
    else
      "#{count} #{word}"
    end
  end 
end
