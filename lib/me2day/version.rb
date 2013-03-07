module Me2day
  class Version
    MAJOR = 0 unless defined? Me2day::Version::MAJOR
    MINOR = 0 unless defined? Me2day::Version::MINOR
    PATCH = 1 unless defined? Me2day::Version::PATCH
    PRE = 'alpha' unless defined? Me2day::Version::PRE

    class << self

      # @return [String]
      def to_s
        [MAJOR, MINOR, PATCH, PRE].compact.join('.')
      end

    end

  end
end
