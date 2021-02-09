class AddProfilePicturePath::V20210205233530 < Avram::Migrator::Migration::V1
  def migrate
    alter table_for(User) do
      add profile_picture_path : String?
    end
  end

  def rollback
    # drop table_for(Thing)
    alter table_for(User) do
      remove :profile_picture_path
    end
  end
end
