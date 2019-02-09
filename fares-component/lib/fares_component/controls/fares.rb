module FaresComponent
  module Controls
    module Fares
      def self.example
        fares = FaresComponent::Fares.build

        fares.id = self.id
        fares.something_happened_time = Time::Effective::Raw.example

        fares
      end

      def self.id
        ID.example(increment: id_increment)
      end

      def self.id_increment
        1111
      end

      module New
        def self.example
          FaresComponent::Fares.build
        end
      end

      module Identified
        def self.example
          fares = New.example
          fares.id = Fares.id
          fares
        end
      end
    end
  end
end
