class Static::BannedUser < MainLayout
  needs user : User

  def content
    render_ban_message
  end

  private def render_ban_message
    div class: "container mt-20" do
      div class: "bg-white dark:bg-gray-800 w-full max-w-sm rounded-lg shadow-md overflow-hidden mx-auto" do
        div class: "py-4 px-6" do
          h2 "Ask.cr", class: "text-center font-bold text-gray-700 dark:text-white text-3xl"
          h3 "Welcome Back", class: "mt-1 text-center font-medium text-gray-600 dark:text-gray-200 text-xl"
          para "This account (#{user.email}) has been banned.", class: "mt-1 text-center text-red-500 dark:text-gray-400"
        end
      end
    end
  end
end
