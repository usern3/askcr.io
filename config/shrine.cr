require "shrine/plugins/determine_mime_type"

client = Awscr::S3::Client.new(ENV["BUCKETEER_AWS_REGION"], ENV["BUCKETEER_AWS_ACCESS_KEY_ID"], ENV["BUCKETEER_AWS_SECRET_ACCESS_KEY"])
Shrine.configure do |config|
  config.storages["uploads"] = Shrine::Storage::S3.new(bucket: ENV["BUCKETEER_BUCKET_NAME"], client: client, prefix: "public/uploads", public: true)
end

class ShrineUploader < Shrine
  load_plugin(
    Shrine::Plugins::DetermineMimeType,
    analyzer: Shrine::Plugins::DetermineMimeType::Tools::File
  )

  finalize_plugins!
end


module Lucky
  class Storage

    def self.upload(content : IO, filename : String, container : String)
      # Shrine::UploadedFile
      result = ShrineUploader.upload(content, container, metadata: { "filename" => filename })

      # HACK: https://github.com/jetrockets/shrine.cr/issues/12
      uri = URI.parse(result.url)
      String.build do |str|
        str << "https://"
        str << uri.host.to_s << uri.path
      end
    end
  end
  endclient = Awscr::S3::Client.new(ENV["BUCKETEER_AWS_REGION"], ENV["BUCKETEER_AWS_ACCESS_KEY_ID"], ENV["BUCKETEER_AWS_SECRET_ACCESS_KEY"])
  Shrine.configure do |config|
    config.storages["uploads"] = Shrine::Storage::S3.new(bucket: ENV["BUCKETEER_BUCKET_NAME"], client: client, prefix: "public/uploads", public: true)
  end

  class ShrineUploader < Shrine
    load_plugin(
      Shrine::Plugins::DetermineMimeType,
      analyzer: Shrine::Plugins::DetermineMimeType::Tools::File
    )

    finalize_plugins!
  end
end

module Lucky
  class Storage

    def self.upload(content : IO, filename : String, container : String)
      # Shrine::UploadedFile
      result = ShrineUploader.upload(content, container, metadata: { "filename" => filename })

      # HACK: https://github.com/jetrockets/shrine.cr/issues/12
      uri = URI.parse(result.url)
      String.build do |str|
        str << "https://"
        str << uri.host.to_s << uri.path
      end
    end
  end
end