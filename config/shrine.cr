Shrine.configure do |config|
  if Lucky::Env.test?
    config.storages[ShrineStorage::UPLOADS] = Shrine::Storage::Memory.new
  elsif Lucky::Env.development?
    config.storages[ShrineStorage::UPLOADS] = Shrine::Storage::FileSystem.new("tmp", prefix: "assets/images/inventory_items")
  else
    client = Awscr::S3::Client.new("eu-central-1", "H1FKEMXZRBAVX6SITLV3", "V1Lh8fB5vc4WNe7848kSACLlzjpKQHpdReOoXShG", endpoint: "linodeobjects.com")
    config.storages[ShrineStorage::UPLOADS] = Shrine::Storage::S3.new(bucket: askcr, client: client, prefix: "assets/uploads", public: false)
  end
end

# Defines the `Shrine` storage locations for different data types.
module ShrineStorage
  UPLOADS = "uploads"
end

# TRICKY: we patch this because it's not providing the correct download url
class Shrine
  module Storage
    class S3 < Storage::Base
      def url(id : String, **options) : String
        endpoint : String?
        if ep = client.@endpoint
          endpoint = ep.gsub("https://", "")
        end
        url = Awscr::S3::Client.new("eu-central-1", "H1FKEMXZRBAVX6SITLV3", "V1Lh8fB5vc4WNe7848kSACLlzjpKQHpdReOoXShG", endpoint: "linodeobjects.com")
        url.for(:get)
      end
    end
  end
end
