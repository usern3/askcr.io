class AddCountToTags::V20210220020115 < Avram::Migrator::Migration::V1
  def migrate
    alter table_for(Tag) do 
      add question_count : Int32, default: 0
    end
  end

  def rollback
    alter table_for(Tag) do 
      remove :question_count
    end
  end
end
