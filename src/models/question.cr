class Question < BaseModel
  table do
    column title : String
    column body : String
    column parsed_body : String
    column solved : Bool
    column solution_id : Int64?

    belongs_to author : User
    has_many taggings : Tagging
    has_many tags : Tag, through: [:taggings, :tag]
    has_many answers : Answer
    has_one solution : Answer, foreign_key: solution_id
  end
end
