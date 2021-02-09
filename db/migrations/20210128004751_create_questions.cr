class CreateQuestions::V20210128004751 < Avram::Migrator::Migration::V1
  def migrate
    # Learn about migrations at: https://luckyframework.org/guides/database/migrations
    create table_for(Question) do
      primary_key id : Int64
      add_timestamps
      add title : String
      add body : String
      add parsed_body : String
      add answered : Bool
      add_belongs_to author : User, on_delete: :cascade
    end
  end

  def rollback
    drop table_for(Question)
  end
end
