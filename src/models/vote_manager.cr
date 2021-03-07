class VoteManager < BaseModel
  table do
    belongs_to vote : Vote
    belongs_to question : Question?
    belongs_to answer : Answer?
    belongs_to user : User
  end
end
