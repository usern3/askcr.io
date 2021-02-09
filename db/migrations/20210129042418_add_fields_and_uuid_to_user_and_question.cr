class AddFieldsAndUUIDToUserAndQuestion::V20210129042418 < Avram::Migrator::Migration::V1
  def migrate
    alter table_for(User) do
      add username : String, index: true, unique: true, fill_existing_with: "changeme"
      add role : Int32, index: true, default: 0
      add website_url : String?
    end
  end

  def rollback
    alter table_for(User) do
      remove :username
      remove :role
      remove :website_url
    end
  end
end
