class AddAdditionalUserFields::V20210307224331 < Avram::Migrator::Migration::V1
  def migrate
    alter table_for(User) do
      add first_name : String?
      add last_name : String? 
      add location : String?
      add github_username : String?
      add email_confirmed_at : Time?
    end
  end

  def rollback
    alter table_for(User) do
      change_type id : Int64
      remove :first_name 
      remove :last_name
      remove :location
      remove :github_username
      remove :email_confirmed_at
    end
  end
end
