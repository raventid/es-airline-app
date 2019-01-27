module EmailComponent
  module Controls
    module Email
      def self.example
        email = EmailComponent::Email.build

        email.id = self.id
        email.something_happened_time = Time::Effective::Raw.example

        email
      end

      def self.id
        ID.example(increment: id_increment)
      end

      def self.id_increment
        1111
      end

      module New
        def self.example
          EmailComponent::Email.build
        end
      end

      module Identified
        def self.example
          email = New.example
          email.id = Email.id
          email
        end
      end
    end
  end
end
