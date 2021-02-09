class Tag < BaseModel
  table do
    column name : String
    column slug : String
    column description : String?

    has_many taggings : Tagging
    has_many questions : Question, through: [:taggings, :question]
  end
end
