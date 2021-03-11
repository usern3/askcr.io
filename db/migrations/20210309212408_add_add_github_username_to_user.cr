class AddAddGithubUsernameToUser::V20210309212408 < Avram::Migrator::Migration::V1
  def migrate
    alter table_for(User) do
      add github_username : String?
    end
  end

  def rollback
    alter table_for(User) do
      remove :github_username
    end
  end
end
