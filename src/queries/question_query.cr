class QuestionQuery < Question::BaseQuery
  def initialize
    defaults &.preload_author.preload_tags
  end
end
