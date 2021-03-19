class Admin::UpdateUserRole < User::SaveOperation
  needs user : User
  permit_columns username, email, role

  after_save log_changes

  def log_changes(user : User)
    # Get changed attributes and log each of them
    attributes.select(&.changed?).each do |attribute|
      Log.dexter.info do
        {
          user_id: user.id,
          changed_attribute: attribute.name.to_s,
          from: attribute.original_value.to_s,
          to: attribute.value.to_s
        }
      end
    end
  end

end
