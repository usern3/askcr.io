class SaveTag < Tag::SaveOperation
  # To save user provided params to the database, you must permit them
  # https://luckyframework.org/guides/database/validating-saving#perma-permitting-columns
  permit_columns name, slug, description

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
      query.name(name.capitalize.not_nil!).first
    else
      self.create!(name: name.capitalize.not_nil!)
    end
  end
end
