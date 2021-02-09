class Tagging < BaseModel
  table do
    belongs_to tag : Tag
    belongs_to question : Question
  end
end
