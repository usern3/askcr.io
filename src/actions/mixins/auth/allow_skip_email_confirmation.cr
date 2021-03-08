module Auth::AllowSkipEmailConfirmation
  macro included
    skip require_email_confirmation
  end
end