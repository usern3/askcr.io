class Questions::Delete < BrowserAction
  route do
    QuestionQuery.find(question_id).delete
    flash.success = "Deleted the record"
    redirect Index
  end
end
