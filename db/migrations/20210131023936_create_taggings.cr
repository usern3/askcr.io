class CreateTaggings::V20210131023936 < Avram::Migrator::Migration::V1
  def migrate
    # Learn about migrations at: https://luckyframework.org/guides/database/migrations
    create table_for(Tagging) do
      primary_key id : Int64
      add_timestamps
      add_belongs_to tag : Tag, on_delete: :cascade
      add_belongs_to question : Question, on_delete: :cascade
    end
  end

  def rollback
    drop table_for(Tagging)
  end
end
