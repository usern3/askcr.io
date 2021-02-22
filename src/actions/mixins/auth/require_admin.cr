module Auth::RequireAdmin
  macro included
    before require_admin_role
  end

  private def require_admin_role
    if current_user.role.admin? || current_user.role.superadmin?
      continue
    else
      Authentic.remember_requested_path(self)
      flash.keep
      flash.failure = "Sorry, you are not authorized to view that!"
      redirect_back fallback: Dashboard::Show
    end
  end

  # Tells the compiler that the current_user is not nil since we have checked
  # that the user is signed in
  private def current_user : User
    current_user?.not_nil!
  end
end
