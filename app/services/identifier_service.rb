class IdentifierService
    def initialize(params)
        @params = params
    end

    def generate_uid
        loop do
          uid = "%s%s" % [@params.upcase, SecureRandom.hex(5).upcase]
          return uid
        end
    end
end