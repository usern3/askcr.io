class AddSolutionIdToQuestion::V20210221015902 < Avram::Migrator::Migration::V1
  def migrate
    alter table_for(Question) do 
      add solution_id : Int64?
    end
  end

  def rollback
    alter table_for(Question) do 
      remove :solution_id
    end
  end
end
