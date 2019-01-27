module ReserveComponent
  module Controls
    module Reserve
      def self.example
        reserve = ReserveComponent::Reserve.build

        reserve.id = self.id
        reserve.something_happened_time = Time::Effective::Raw.example

        reserve
      end

      def self.id
        ID.example(increment: id_increment)
      end

      def self.id_increment
        1111
      end

      module New
        def self.example
          ReserveComponent::Reserve.build
        end
      end

      module Identified
        def self.example
          reserve = New.example
          reserve.id = Reserve.id
          reserve
        end
      end
    end
  end
end
