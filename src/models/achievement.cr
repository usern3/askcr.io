class Achievement < BaseModel
  include Avram::SoftDelete::Model

  table do
    column title : String
    column description : String
    column soft_deleted_at : Time?

    belongs_to user : User
  end
end
