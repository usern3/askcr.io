module FormattingHelpers
  def minify_title(title : String, max_size : Int32)
    title.size > max_size ? "#{title[0..max_size]}..." : title
  end

  def pluralize(count, word)
    if count == 0 || count >= 2
      "#{count} #{word}s"
    else
      "#{count} #{word}"
    end
  end

  def pluralize_reply(size)
    if size > 1 || size == 0
      "#{size} replies"
    else
      "1 reply"
    end
  end
end
