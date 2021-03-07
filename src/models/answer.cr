class Answer < BaseModel
  include Avram::SoftDelete::Model
  
  table do
    column body : String
    column parsed_body : String
    column solution : Bool
    column soft_deleted_at : Time?

    belongs_to question : Question
    belongs_to author : User
    has_many vote_managers : VoteManager
    has_many votes : Vote, through: [:vote_managers, :answer]
  end
end
