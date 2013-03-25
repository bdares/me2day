require 'forwardable'
require 'me2day/publishable'
require 'me2day/identity'
require 'me2day/api/utils'

module Me2day
  class MetooResult < Me2day::Base
    extend Forwardable
    attr_reader :page, :totalCount, :totalPage, :itemsPerPage

    # @return [Me2day::Metoo]
    def metoos
      return unless @attrs[:metoos]
      @metoos ||= Me2day::API::Utils.objects_from_array(Me2day::Metoo, @attrs[:metoos])
    end
  end
end
