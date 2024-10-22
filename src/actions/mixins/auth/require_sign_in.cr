module Auth::RequireSignIn
  macro included
    before require_sign_in
  end

  private def require_sign_in
    if current_user?
      if current_user.role.banned?
        flash.failure = "This account has been banned."
        redirect to: Static::Banned.with(current_user)
      else
        continue
      end
    else
      Authentic.remember_requested_path(self)
      flash.info = "Please sign in first"
      redirect to: SignIns::New
    end
  end

  # Tells the compiler that the current_user is not nil since we have checked
  # that the user is signed in
  private def current_user : User
    current_user?.not_nil!
  end
end
