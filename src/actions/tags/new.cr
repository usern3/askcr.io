class Tags::New < BrowserAction
  route do
    html NewPage, operation: SaveTag.new
  end
end
