class Question < BaseModel
  include Avram::SoftDelete::Model
  
  table do
    column title : String
    column body : String
    column parsed_body : String
    column solved : Bool
    column solution_id : Int64?
    column soft_deleted_at : Time?

    belongs_to author : User
    has_many taggings : Tagging
    has_many tags : Tag, through: [:taggings, :tag]
    has_many vote_managers : VoteManager
    has_many votes : Vote, through: [:vote_managers, :question]
    has_many answers : Answer
    has_one solution : Answer, foreign_key: solution_id
  end

  def solved?
    true unless self.solution_id.nil?
  end
end
