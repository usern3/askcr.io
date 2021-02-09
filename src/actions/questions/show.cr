class Questions::Show < BrowserAction
  route do
    question = QuestionQuery.new.preload_tags.preload_author.find(question_id)
    pages, answers = paginate(AnswerQuery.new.question_id(question.id).preload_author, per_page: 5)
    op = SaveAnswer.new
    html ShowPage, question: question, operation: op, answers: answers, pages: pages
  end
end
