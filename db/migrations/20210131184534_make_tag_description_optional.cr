class MakeTagDescriptionOptional::V20210131184534 < Avram::Migrator::Migration::V1
  def migrate
    make_optional :tags, :description
  end

  def rollback
    # drop table_for(Thing)
  end
end
