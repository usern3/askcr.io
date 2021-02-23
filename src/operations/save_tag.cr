class SaveTag < Tag::SaveOperation
  # To save user provided params to the database, you must permit them
  # https://luckyframework.org/guides/database/validating-saving#perma-permitting-columns
  permit_columns name, slug, description, text_color, background_color

  before_save do
    set_tag_slug
    validate_uniqueness_of name
  end

  private def set_tag_slug
    self.name.value.try do |n|
      slug.value = n.downcase.strip.gsub(" ", "-")
    end
  end

  def self.find_or_create(*, name)
    query = TagQuery.new
    if query.name(name.capitalize.not_nil!).first?
      tag = query.name(name.capitalize.not_nil!).first
      SaveTag.update!(tag, question_count: tag.question_count + 1)
    else
      SaveTag.create!(name: name.capitalize.not_nil!, question_count: 1)
    end
  end
end
