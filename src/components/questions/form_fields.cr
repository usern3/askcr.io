class Questions::FormFields < BaseComponent
  needs operation : SaveQuestion

  def render
    div do
      mount Shared::Field, operation.title, &.text_input(autofocus: "true")
    end
    div do
      mount Shared::Field, operation.body, &.textarea(rows: "10")
    end
    div do 
      mount Shared::Field, operation.tags, &.text_input
    end
  end
end
