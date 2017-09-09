require_relative "tping/version"

module Tping
  def self.request_build(token, user, repo, pro = false)
    headers = ["Content-Type: application/json",
               "Accept: application/json",
               "Travis-API-Version: 3",
               "Authorization: token #{token}"].flat_map do |header|
      ["-H", header]
    end

    command = %w(curl -s -X POST)
    command += headers
    command += ["-d", '{ "request": { "branch": "master" }}']
    command <<  "https://api.travis-ci.#{pro ? "com" : "org"}/repo/#{user}%2F#{repo}/requests"
    system(*command)
  end
end
