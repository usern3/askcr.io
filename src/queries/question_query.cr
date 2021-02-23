class QuestionQuery < Question::BaseQuery
  include Avram::SoftDelete::Query
  
  def initialize
    defaults &.preload_author.preload_tags
  end
end
