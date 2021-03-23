class Shared::HeaderNav < BaseComponent
  include TextHelpers
  needs current_user : User

  def render_links
    a "About", class: "mx-2 mt-2 md:mt-0 px-2 py-1 text-sm text-gray-700 dark:text-gray-200 font-medium rounded-md hover:bg-gray-300 dark:hover:bg-gray-700", href: "#"
    link "Questions", to: Questions::Index, class: "mx-2 mt-2 md:mt-0 px-2 py-1 text-sm text-gray-700 dark:text-gray-200 font-medium rounded-md hover:bg-gray-300 dark:hover:bg-gray-700"
    link "Tags", to: Tags::Index, class: "mx-2 mt-2 md:mt-0 px-2 py-1 text-sm text-gray-700 dark:text-gray-200 font-medium rounded-md hover:bg-gray-300 dark:hover:bg-gray-700"
    a "Contact", class: "mx-2 mt-2 md:mt-0 px-2 py-1 text-sm text-gray-700 dark:text-gray-200 font-medium rounded-md hover:bg-gray-300 dark:hover:bg-gray-700", href: "#"
    a "Crystal Lang", href: "https://crystal-lang.org/", target: "_blank", class: "mx-2 mt-2 md:mt-0 px-2 py-1 text-sm text-gray-700 dark:text-gray-200 font-medium rounded-md hover:bg-gray-300 dark:hover:bg-gray-700"
  end

  def render
    nav class: "bg-white dark:bg-gray-800 shadow" do
      div class: "container mx-auto px-6 py-3" do
        div class: "md:flex md:items-center md:justify-between" do
          div class: "flex justify-between items-center" do
            div class: "text-xl font-semibold text-gray-700" do
              link "Askcr.io", to: Dashboard::Show, class: "text-gray-800 dark:text-white text-xl font-bold md:text-2xl hover:text-gray-700 dark:hover:text-gray-300"
            end
            div class: "flex md:hidden" do
              button aria_label: "toggle menu", class: "text-gray-500 dark:text-gray-200 hover:text-gray-600 dark:hover:text-gray-400 focus:outline-none focus:text-gray-600 dark:focus:text-gray-400", type: "button" do
                tag "svg", class: "h-6 w-6 fill-current", viewBox: "0 0 24 24" do
                  tag "path", d: "M4 5h16a1 1 0 0 1 0 2H4a1 1 0 1 1 0-2zm0 6h16a1 1 0 0 1 0 2H4a1 1 0 0 1 0-2zm0 6h16a1 1 0 0 1 0 2H4a1 1 0 0 1 0-2z", fill_rule: "evenodd"
                end
              end
            end
          end
          div class: "hidden md:flex md:items-center md:justify-between flex-1" do
            div class: "flex flex-col -mx-4 md:flex-row md:items-center md:mx-8" do
              render_links
            end
            div class: "flex items-center mt-4 md:mt-0" do
              button aria_label: "show notifications", class: "mx-4 hidden md:block text-gray-600 dark:text-gray-200 hover:text-gray-700 dark:hover:text-gray-400 focus:text-gray-700 dark:focus:text-gray-400 focus:outline-none" do
                tag "svg", class: "h-6 w-6", fill: "none", viewBox: "0 0 24 24", xmlns: "http://www.w3.org/2000/svg" do
                  tag "path", d: "M15 17H20L18.5951 15.5951C18.2141 15.2141 18 14.6973 18 14.1585V11C18 8.38757 16.3304 6.16509 14 5.34142V5C14 3.89543 13.1046 3 12 3C10.8954 3 10 3.89543 10 5V5.34142C7.66962 6.16509 6 8.38757 6 11V14.1585C6 14.6973 5.78595 15.2141 5.40493 15.5951L4 17H9M15 17V18C15 19.6569 13.6569 21 12 21C10.3431 21 9 19.6569 9 18V17M15 17H9", stroke: "currentColor", stroke_linecap: "round", stroke_linejoin: "round", stroke_width: "2"
                end
              end
              button aria_label: "toggle profile dropdown", class: "dropdown inline-block text-left relative flex items-center focus:outline-none", type: "button" do
                div class: "h-8 w-8 overflow-hidden rounded-full border-2 border-gray-400", id: "options-menu", aria_haspopup: "true", aria_expanded: "false" do
                  if image_path = user_profile_image_link(current_user)
                    img alt: current_user.username, class: "h-12 w-12 rounded-full", src: image_path
                  else
                    img alt: "avatar", class: "h-full w-full object-cover", src: "https://lh3.googleusercontent.com/a-/AOh14Gi0DgItGDTATTFV6lPiVrqtja6RZ_qrY91zg42o-g"
                  end
                  h3 "Khatab wedaa", class: "mx-2 text-sm text-gray-700 dark:text-gray-200 font-medium md:hidden"
                  div aria_labelledby: "options-menu", aria_hidden: "true", aria_orientation: "vertical", class: "dropdown-menu absolute ml-8 hidden text-gray-700 pt-1 mt-0 w-56 rounded-md shadow-lg bg-white ring-1 ring-black ring-opacity-5 divide-y divide-gray-100", role: "menu" do
                    div class: "py-1" do
                      para class: "block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100 hover:text-gray-900", role: "menuitem" do
                        text "Signed in as: "
                        span current_user.email, class: "font-medium "
                      end
                    end
                    if current_user.role.admin? || current_user.role.superadmin?
                      div class: "py-1" do
                        link to: Admin::Index, class: "block px-4 py-2 text-sm text-red-700 hover:bg-gray-100 hover:text-gray-900" do
                          tag "svg", class: "inline h-5 w-5 mr-2", fill: "none", stroke: "currentColor", viewBox: "0 0 24 24", xmlns: "http://www.w3.org/2000/svg" do
                            tag "path", d: "M8 9l3 3-3 3m5 0h3M5 20h14a2 2 0 002-2V6a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z", stroke_linecap: "round", stroke_linejoin: "round", stroke_width: "2"
                          end
                          text "Admin Panel"
                        end
                      end
                    end
                    if current_user.role.moderator?
                      div class: "py-1" do
                        link to: Admin::Index, class: "block px-4 py-2 text-sm text-red-700 hover:bg-gray-100 hover:text-gray-900" do
                          tag "svg", class: "inline h-5 w-5 mr-2", fill: "none", stroke: "currentColor", viewBox: "0 0 24 24", xmlns: "http://www.w3.org/2000/svg" do
                            tag "path", d: "M15.232 5.232l3.536 3.536m-2.036-5.036a2.5 2.5 0 113.536 3.536L6.5 21.036H3v-3.572L16.732 3.732z", stroke_linecap: "round", stroke_linejoin: "round", stroke_width: "2"
                          end
                          text "Moderator Panel"
                        end
                      end
                    end
                    div class: "py-1" do
                      link to: Users::Edit.with(current_user.id), class: "block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100 hover:text-gray-900", role: "menuitem" do
                        tag "svg", class: "inline h-5 w-5 mr-2", fill: "none", stroke: "currentColor", viewBox: "0 0 24 24", xmlns: "http://www.w3.org/2000/svg" do
                          tag "path", d: "M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z", stroke_linecap: "round", stroke_linejoin: "round", stroke_width: "2"
                        end
                        text "Edit Profile"
                      end
                      link to: Users::Show.with(current_user.id), class: "block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100 hover:text-gray-900", role: "menuitem" do
                        tag "svg", class: "inline h-5 w-5 mr-2", fill: "none", stroke: "currentColor", viewBox: "0 0 24 24", xmlns: "http://www.w3.org/2000/svg" do
                          tag "path", d: "M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z", stroke_linecap: "round", stroke_linejoin: "round", stroke_width: "2"
                        end
                        text "View Profile"
                      end
                    end
                    div class: "py-1" do
                      a class: "block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100 hover:text-gray-900", href: "", role: "menuitem" do
                        tag "svg", class: "inline h-5 w-5 mr-2", fill: "none", stroke: "currentColor", viewBox: "0 0 24 24", xmlns: "http://www.w3.org/2000/svg" do
                          tag "path", d: "M12 6V4m0 2a2 2 0 100 4m0-4a2 2 0 110 4m-6 8a2 2 0 100-4m0 4a2 2 0 110-4m0 4v2m0-6V4m6 6v10m6-2a2 2 0 100-4m0 4a2 2 0 110-4m0 4v2m0-6V4", stroke_linecap: "round", stroke_linejoin: "round", stroke_width: "2"
                        end
                        text "Settings"
                      end
                      link to: SignIns::Delete, class: "block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100 hover:text-gray-900", flow_id: "sign-out-button", role: "menuitem" do
                        tag "svg", class: "inline h-5 w-5 mr-2", fill: "none", stroke: "currentColor", viewBox: "0 0 24 24", xmlns: "http://www.w3.org/2000/svg" do
                          tag "path", d: "M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1", stroke_linecap: "round", stroke_linejoin: "round", stroke_width: "2"
                        end
                        text "Logout"
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end
