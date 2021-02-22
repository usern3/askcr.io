class TagQuery < Tag::BaseQuery
  def initialize
    defaults &.preload_questions
  end
end
