class Questions::New < BrowserAction
  route do
    html NewPage, operation: SaveQuestion.new
  end
end
