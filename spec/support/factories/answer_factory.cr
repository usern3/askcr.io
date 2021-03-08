class AnswerFactory < Avram::Factory
  def initialize
    body sequence("Random text")
    question_id 1
    author_id 1
    solution false
  end
end
