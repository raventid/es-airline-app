module BookTicketComponent
  module Controls
    module SearchFare
      def self.example
        book_ticket = BookTicketComponent::BookTicket.build

        book_ticket.id = self.id
        book_ticket.something_happened_time = Time::Effective::Raw.example

        book_ticket
      end

      def self.id
        ID.example(increment: id_increment)
      end

      def self.id_increment
        1111
      end

      module New
        def self.example
          BookTicketComponent::BookTicket.build
        end
      end

      module Identified
        def self.example
          book_ticket = New.example
          book_ticket.id = BookTicket.id
          book_ticket
        end
      end
    end
  end
end
