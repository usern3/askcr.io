class ChangeToUUID::V20210301230108 < Avram::Migrator::Migration::V1
  def migrate
    alter table_for(User) do
      change_type id : Int32
    end
  end

  def rollback
    alter table_for(User) do
      primary_key id : Int64
    end
  end
end
