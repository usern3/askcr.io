class Admin::IndexPage < AuthLayout
  needs current_user : User

  def content
    render_sign_in_form
  end

  private def render_sign_in_form
    div class: "container mt-20" do
      div class: "bg-white dark:bg-gray-800 w-full max-w-sm rounded-lg shadow-md overflow-hidden mx-auto" do
        div class: "py-4 px-6" do
          h2 "Ask.cr", class: "text-center font-bold text-gray-700 dark:text-white text-3xl"
          h3 "Welcome Back", class: "mt-1 text-center font-medium text-gray-600 dark:text-gray-200 text-xl"
          para "Login or create account", class: "mt-1 text-center text-gray-500 dark:text-gray-400"
            div class: "mt-4 w-full" do
            end
            div class: "mt-4 w-full" do
            end
            div class: "flex justify-between items-center mt-4" do
              link "Forgot password?", to: PasswordResetRequests::New, class: "text-gray-600 dark:text-gray-200 text-sm hover:text-gray-500"
              submit "Login", flow_id: "sign-in-button", class: "py-2 px-4 bg-gray-700 text-white rounded hover:bg-gray-600 focus:outline-none"
            end
          end
        
        div class: "flex items-center justify-center py-4 bg-gray-100 dark:bg-gray-700 text-center" do
          span "Don't have an account? ", class: "text-gray-600 dark:text-gray-200 text-sm"
          link "Register", to: SignUps::New, class: "text-blue-600 dark:text-blue-400 font-bold mx-2 text-sm hover:text-blue-500"
        end
      end
    end
  end
end
