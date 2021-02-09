class RenameAnsweredToSolved::V20210131184955 < Avram::Migrator::Migration::V1
  def migrate
    alter table_for(Question) do
      rename :answered, :solved
    end
  end

  def rollback
    # drop table_for(Thing)
  end
end
