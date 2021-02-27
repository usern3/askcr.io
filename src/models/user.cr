class User < BaseModel
  include Carbon::Emailable
  include Authentic::PasswordAuthenticatable

  ROLES = [{"Member", 0}, {"Moderator", 1}, {"Admin", 2}, {"Superadmin", 3}, {"Banned", 4}]

  table do
    column email : String
    column username : String
    column website_url : String?
    column encrypted_password : String
    column role : User::Role
    column profile_picture_path : String?
    column soft_deleted_at : Time?

    has_many questions : Question, foreign_key: "author_id"
    has_many answers : Answer, foreign_key: "author_id"
  end

  avram_enum Role do
    # Assign custom values
    Member     = 0
    Moderator  = 1
    Admin      = 2
    Superadmin = 3
    Banned     = 4
  end

  def emailable : Carbon::Address
    Carbon::Address.new(email)
  end
end
