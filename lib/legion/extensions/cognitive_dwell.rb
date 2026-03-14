# frozen_string_literal: true

require_relative 'cognitive_dwell/version'
require_relative 'cognitive_dwell/helpers/constants'
require_relative 'cognitive_dwell/helpers/dwell_topic'
require_relative 'cognitive_dwell/helpers/dwell_engine'
require_relative 'cognitive_dwell/runners/cognitive_dwell'
require_relative 'cognitive_dwell/client'

module Legion
  module Extensions
    module CognitiveDwell
      extend Legion::Extensions::Core if defined?(Legion::Extensions::Core)
    end
  end
end
