# This component is used to make it easier to render the same fields styles
# throughout your app.
#
# Extensive documentation at: https://luckyframework.org/guides/frontend/html-forms#shared-components
#
# ## Basic usage:
#
#    # Renders a text input by default and will guess the label name "Name"
#    mount Shared::Field, op.name
#    # Call any of the input methods on the block
#    mount Shared::Field, op.email, &.email_input
#    # Add other HTML attributes
#    mount Shared::Field, op.email, &.email_input(autofocus: "true")
#    # Pass an explicit label name
#    mount Shared::Field, attribute: op.username, label_text: "Your username"
#
# ## Customization
#
# You can customize this component so that fields render like you expect.
# For example, you might wrap it in a div with a "field-wrapper" class.
#
#    div class: "field-wrapper"
#      label_for field
#      yield field
#      mount Shared::FieldErrors, field
#    end
#
# You may also want to have more components if your fields look
# different in different parts of your app, e.g. `CompactField` or
# `InlineTextField`
class Shared::Field(T) < BaseComponent
  # Raises a helpful error if component receives an unpermitted attribute
  include Lucky::CatchUnpermittedAttribute

  needs attribute : Avram::PermittedAttribute(T)
  needs label_text : String?
  needs prefix : String | Proc(Nil) | Nil

  def render
    label_for attribute, label_text, class: "mb-3 block text-lg font-bold leading-5 text-gray-700"

    # You can add more default options here. For example:
    #
    #    tag_defaults field: attribute, class: "input"
    #
    # Will add the class "input" to the generated HTML.
    div class: "mt-1 mb-3 flex relative rounded-md shadow-sm" do
      if prefix
        span class: "inline-flex items-center px-3 rounded-l-md border border-r-0 border-gray-300 bg-gray-50 text-gray-500 sm:text-sm #{prefix_validation_styles}" do
          render_prefix prefix
        end
      end
      tag_defaults field: attribute, class: "#{base_input_styles} #{input_validation_styles}" do |input_builder|
        yield input_builder
      end
      render_error_icon
    end

    mount Shared::FieldErrors, attribute
  end

  # Applies styles to the input based on the existence of a prefix
  def base_input_styles
    if prefix
      "form-input flex-1 block w-full px-3 py-2 rounded-none rounded-r-md sm:text-sm sm:leading-5"
    else
      "appearance-none block w-full px-3 py-2 border rounded-md focus:outline-none transition duration-150 ease-in-out sm:text-sm sm:leading-5"
    end
  end

  def render_prefix(prefix : String)
    text prefix
  end

  def render_prefix(prefix : Proc(Nil))
    prefix.call
  end

  def render_prefix(prefix : Nil)
  end

  def prefix_validation_styles
    if attribute.valid?
      "border-gray-300 bg-gray-50 text-gray-500"
    else
      "border-red-300 bg-red-50 text-red-500"
    end
  end

  def input_validation_styles
    if attribute.valid?
      "border-gray-300 placeholder-gray-400 focus:shadow-outline-blue focus:border-blue-300"
    else
      "border-red-300 text-red-900 placeholder-red-300 focus:border-red-300 focus:shadow-outline-red"
    end
  end

  def render_error_icon
    unless attribute.valid?
      div class: "absolute inset-y-0 right-0 pr-3 flex items-center pointer-events-none" do
        tag "svg", class: "h-5 w-5 text-red-500", fill: "currentColor", viewBox: "0 0 20 20" do
          tag "path", clip_rule: "evenodd", d: "M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7 4a1 1 0 11-2 0 1 1 0 012 0zm-1-9a1 1 0 00-1 1v4a1 1 0 102 0V6a1 1 0 00-1-1z", fill_rule: "evenodd"
        end
      end
    end
  end

  # Use a text_input by default
  def render
    render &.text_input
  end
end
