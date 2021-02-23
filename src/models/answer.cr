class Answer < BaseModel
  table do
    column body : String
    column parsed_body : String
    column solution : Bool
    column soft_deleted_at : Time?

    belongs_to question : Question
    belongs_to author : User
  end
end
