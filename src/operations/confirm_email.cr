class ConfirmEmail < User::SaveOperation
  before_save do
    email_confirmed_at.value = Time.utc
  end
end
