module SmsComponent
  module Controls
    module Sms
      def self.example
        sms = SmsComponent::Sms.build

        sms.id = self.id
        sms.something_happened_time = Time::Effective::Raw.example

        sms
      end

      def self.id
        ID.example(increment: id_increment)
      end

      def self.id_increment
        1111
      end

      module New
        def self.example
          SmsComponent::Sms.build
        end
      end

      module Identified
        def self.example
          sms = New.example
          sms.id = Sms.id
          sms
        end
      end
    end
  end
end
