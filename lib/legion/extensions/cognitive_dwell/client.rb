# frozen_string_literal: true

module Legion
  module Extensions
    module CognitiveDwell
      class Client
        include Runners::CognitiveDwell

        def initialize(engine: nil)
          @default_engine = engine || Helpers::DwellEngine.new
        end
      end
    end
  end
end
