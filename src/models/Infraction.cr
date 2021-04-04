class Infraction < BaseModel
  include Avram::SoftDelete::Model

  table do
    column title : String
    column description : String
    column severity : Infraction::Severity
    column expires_on : Time?
    column soft_deleted_at : Time?

    belongs_to user : User
  end

  avram_enum Severity do
    # Assign custom values
    Low     = 0
    Medium  = 1
    High    = 2
    Extreme = 3
  end
end
