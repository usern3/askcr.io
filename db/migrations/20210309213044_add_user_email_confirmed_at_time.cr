class AddUserEmailConfirmedAtTime::V20210309213044 < Avram::Migrator::Migration::V1
  def migrate
    alter table_for(User) do
      add email_confirmed_at : Time?
    end
  end

  def rollback
    alter table_for(User) do
      remove :email_confirmed_at
    end
  end
end
