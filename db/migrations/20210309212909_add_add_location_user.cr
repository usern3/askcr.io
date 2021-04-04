class AddAddLocationUser::V20210309212909 < Avram::Migrator::Migration::V1
  def migrate
    alter table_for(User) do
      add location : String?
    end
  end

  def rollback
    alter table_for(User) do
      remove :location
    end
  end
end
