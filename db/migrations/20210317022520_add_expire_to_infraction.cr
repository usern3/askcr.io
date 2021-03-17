class AddExpireToInfraction::V20210317022520 < Avram::Migrator::Migration::V1
  def migrate
    alter table_for(Infraction) do 
      add expires_on : Time?
    end
  end

  def rollback
    alter table_for(Infraction) do 
      remove :expires_on
    end
  end
end
