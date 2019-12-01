module Authentication
  class SetResponseToken
    def initialize app
      @app = app
    end

    def call env
      res = @app.call(env)
      if res[0] < 300 && !skip_request(env)
        res[1]["Access-Token"] = env['warden'].user.token
      end
      res
    end

    private

    def skip_request(env)
      env['REQUEST_URI'] =~ /\/login$/
    end
  end
end