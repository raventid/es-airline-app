module WolfgangComponent
  module Controls
    module Wolfgang
      def self.example
        wolfgang = WolfgangComponent::Wolfgang.build

        wolfgang.id = self.id
        wolfgang.something_happened_time = Time::Effective::Raw.example

        wolfgang
      end

      def self.id
        ID.example(increment: id_increment)
      end

      def self.id_increment
        1111
      end

      module New
        def self.example
          WolfgangComponent::Wolfgang.build
        end
      end

      module Identified
        def self.example
          wolfgang = New.example
          wolfgang.id = Wolfgang.id
          wolfgang
        end
      end
    end
  end
end
