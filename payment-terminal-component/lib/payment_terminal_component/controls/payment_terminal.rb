module PaymentTerminalComponent
  module Controls
    module PaymentTerminal
      def self.example
        payment_terminal = PaymentTerminalComponent::PaymentTerminal.build

        payment_terminal.id = self.id
        payment_terminal.something_happened_time = Time::Effective::Raw.example

        payment_terminal
      end

      def self.id
        ID.example(increment: id_increment)
      end

      def self.id_increment
        1111
      end

      module New
        def self.example
          PaymentTerminalComponent::PaymentTerminal.build
        end
      end

      module Identified
        def self.example
          payment_terminal = New.example
          payment_terminal.id = PaymentTerminal.id
          payment_terminal
        end
      end
    end
  end
end
