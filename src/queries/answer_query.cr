class AnswerQuery < Answer::BaseQuery
  include Avram::SoftDelete::Query

  def initialize
    defaults &.preload_question.preload_author
  end
end
