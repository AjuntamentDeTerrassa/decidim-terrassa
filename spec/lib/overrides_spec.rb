# frozen_string_literal: true

require "rails_helper"
require "digest/md5"

# We check the checksum of the files overriden.
# If the test fails, the overriden file should be reviewed and re-synced with the
# upstream version (then update the signature here).
#
# app/views/decidim/manifests/show.json.erb overrides the decidim-core template to wrap the
# PWA favicon icon URLs in `raw`, so the "&" in the signed Active Storage URLs is not escaped
# to "&amp;" (which produces an invalid manifest and broken PWA icons).
checksums = [
  {
    package: "decidim-core",
    files: {
      "/app/views/decidim/manifests/show.json.erb" => "e4b66c0375df2f02cef7f003320564f3"
    }
  }
]

describe "Overriden files", type: :view do
  checksums.each do |item|
    spec = Gem::Specification.find_by_name(item[:package])
    item[:files].each do |file, signature|
      it "#{spec.gem_dir}#{file} matches checksum" do
        expect(md5("#{spec.gem_dir}#{file}")).to eq(signature)
      end
    end
  end

  private

  def md5(file)
    Digest::MD5.hexdigest(File.read(file))
  end
end
