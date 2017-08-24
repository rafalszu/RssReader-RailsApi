module Requests
  module JsonHelpers
    def json
      JSON.parse(last_response.body)
    end

    def last_response_as_json
      json
    end
  end
end
