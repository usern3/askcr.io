module Cry
  class Log
    private getter log_path

    def initialize(@log_path : String)
    end

    def code : String
      File.read(log_path.gsub("_result.log", ".cr"))
    end

    def results : String
      File.read(log_path)
    end
  end
end
