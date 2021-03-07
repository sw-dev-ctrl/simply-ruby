require_relative "First/version"

module Exporter
  class AnExporter
    def letsUpload
      puts("lets upload")
      Documentz::AwsUploader.new.s3upload(docs: [1,2])
    end
  end
end
