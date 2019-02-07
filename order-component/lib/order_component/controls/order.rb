module OrderComponent
  module Controls
    module Order
      def self.example
        order = OrderComponent::Order.build

        order.id = self.id
        order.something_happened_time = Time::Effective::Raw.example

        order
      end

      def self.id
        ID.example(increment: id_increment)
      end

      def self.id_increment
        1111
      end

      module New
        def self.example
          OrderComponent::Order.build
        end
      end

      module Identified
        def self.example
          order = New.example
          order.id = Order.id
          order
        end
      end
    end
  end
end
