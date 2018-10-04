require_relative "tping/version"

module Tping
  def self.request_build(opts)
    headers = ["Content-Type: application/json",
               "Accept: application/json",
               "Travis-API-Version: 3",
               "Authorization: token #{opts[:token]}"].flat_map do |header|
      ["-H", header]
    end

    command = %w(curl -v -s -X POST)
    command += headers
    command += ["-d", %Q|{ "request": { "branch": "#{opts[:branch]}" }}|]
    command <<  "https://api.travis-ci.#{opts[:pro] ? "com" : "org"}/repo/#{opts[:user]}%2F#{opts[:repo]}/requests"
    p command
    system(*command)
  end
end
