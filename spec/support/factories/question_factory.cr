class QuestionFactory < Avram::Factory
  def initialize
    title sequence("Question Title")
    body "Random text"
    solved false
  end
end
