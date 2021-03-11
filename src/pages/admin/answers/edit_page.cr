class Admin::Answers::EditPage < MainLayout
  needs operation : SaveAnswer
  needs answer : Answer
  quick_def page_title, "Edit Answer"

  def content
    div do
      text "Test"
    end
  end
end
