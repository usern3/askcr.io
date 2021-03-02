class TagQuery < Tag::BaseQuery
  include Avram::SoftDelete::Query
  
  def initialize
    defaults &.preload_questions
  end
end
