class Admin::Questions::Answers::EditPage < AdminLayout
  include FormattingHelpers
  needs operation : SaveAnswer
  needs answer : Answer
  needs question_id : String
  quick_def page_title, "Edit Answer"

  def content

  end
end
