require 'evoasm/domain'

module Evoasm
  class Parameter < FFI::Pointer
    def id
      Libevoasm.param_id self
    end

    def domain
      Domain.wrap Libevoasm.param_domain(self)
    end
  end
end