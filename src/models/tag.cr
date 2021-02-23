class Tag < BaseModel
  table do
    column name : String
    column slug : String
    column description : String?
    column question_count : Int32
    column text_color : String?
    column background_color : String?
    column soft_deleted_at : Time?

    has_many taggings : Tagging
    has_many questions : Question, through: [:taggings, :question]
  end
end
