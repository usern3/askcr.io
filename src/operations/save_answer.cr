class SaveAnswer < Answer::SaveOperation
  include Markdown
  # To save user provided params to the database, you must permit them
  # https://luckyframework.org/guides/database/validating-saving#perma-permitting-columns
  #
  permit_columns body, parsed_body, solution, author_id, question_id

  before_save do
    generate_parsed_body
  end

  private def generate_parsed_body
    self.parsed_body.value = Markdown.parse(self.body.value.not_nil!)
  end
end
