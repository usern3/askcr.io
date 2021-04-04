class ConfirmEmail::NewPage < AuthLayout
  def content
    div do
      para "Before continuing to use the website, please confirm your account by clicking the link sent to your email."
    end

    div do
      para "If you did not receive an email, please contact support by filing a bug report."
    end
  end
end
