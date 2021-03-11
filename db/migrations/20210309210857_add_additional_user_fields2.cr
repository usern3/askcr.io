class AddAdditionalUserFields2::V20210309210857 < Avram::Migrator::Migration::V1
  def migrate
    alter table_for(User) do
      add bio : String?
      add btc_address : String?
      add eth_address : String?
      add bch_address : String?
      add doge_address : String?
      add nim_address : String?
      add oxen_address : String?
      add xmr_address : String?
    end
  end

  def rollback
    alter table_for(User) do
      remove :bio
      remove :btc_address
      remove :eth_address
      remove :bch_address
      remove :doge_address
      remove :nim_address
      remove :oxen_address
    end
  end
end
