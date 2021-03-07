class Vote < BaseModel
  table do
    column vote : Bool?

    has_many vote_managers : VoteManager
    has_many questions : Question, through: [:vote_managers, :question]
    has_many answers : Answer, through: [:vote_managers, :answer]
  end
end
