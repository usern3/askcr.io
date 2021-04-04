class SaveTagging < Tagging::SaveOperation
  # To save user provided params to the database, you must permit them
  # https://luckyframework.org/guides/database/validating-saving#perma-permitting-columns
  #
  # permit_columns column_1, column_2
  permit_columns question_id, tag_id
  before_save validate_only_relationship

  private def validate_only_relationship
    exists = TaggingQuery.new.question_id(question_id.value.not_nil!).tag_id(tag_id.value.not_nil!).first?
    !exists
  end

  def self.find_or_create(*, question_id, tag_id)
    query = TaggingQuery.new
    if query.question_id(question_id.not_nil!).tag_id(tag_id.not_nil!).first?
      query.question_id(question_id.not_nil!).tag_id(tag_id.not_nil!).first
    else
      self.create!(question_id: question_id.not_nil!, tag_id: tag_id.not_nil!)
    end
  end
end
