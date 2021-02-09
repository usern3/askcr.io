Shrine.configure do |config|
  config.storages["cache"] = Shrine::Storage::FileSystem.new("public/uploads", prefix: "cache")
  config.storages["store"] = Shrine::Storage::FileSystem.new("public/uploads")
end