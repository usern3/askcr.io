class Tags::FormFields < BaseComponent
  needs operation : SaveTag

  def render
    mount Shared::Field, operation.name, &.text_input(autofocus: "true")
    mount Shared::Field, operation.slug
    mount Shared::Field, operation.description
  end
end
