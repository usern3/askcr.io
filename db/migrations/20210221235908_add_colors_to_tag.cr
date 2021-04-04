class AddColorsToTag::V20210221235908 < Avram::Migrator::Migration::V1
  def migrate
    alter table_for(Tag) do
      add background_color : String?
      add text_color : String?
    end
  end

  def rollback
    alter table_for(Tag) do
      remove :background_color
      remove :text_color
    end
  end
end
