module ChartersComponent
  module Controls
    module Charters
      def self.example
        charters = ChartersComponent::Charters.build

        charters.id = self.id
        charters.something_happened_time = Time::Effective::Raw.example

        charters
      end

      def self.id
        ID.example(increment: id_increment)
      end

      def self.id_increment
        1111
      end

      module New
        def self.example
          ChartersComponent::Charters.build
        end
      end

      module Identified
        def self.example
          charters = New.example
          charters.id = Charters.id
          charters
        end
      end
    end
  end
end
