class Questions::Delete < BrowserAction
  route do
    question = QuestionQuery.new.preload_tags.find(question_id)
    question.tags.each do |tag|
      SaveTag.update!(tag, question_count: tag.question_count - 1)
    end
    question.soft_delete
    flash.success = "Question removed successfully."
    redirect Index
  end
end
