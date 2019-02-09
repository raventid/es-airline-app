module PrepaidCardProviderComponent
  module Controls
    module PrepaidCardProvider
      def self.example
        prepaid_card_provider = PrepaidCardProviderComponent::PrepaidCardProvider.build

        prepaid_card_provider.id = self.id
        prepaid_card_provider.something_happened_time = Time::Effective::Raw.example

        prepaid_card_provider
      end

      def self.id
        ID.example(increment: id_increment)
      end

      def self.id_increment
        1111
      end

      module New
        def self.example
          PrepaidCardProviderComponent::PrepaidCardProvider.build
        end
      end

      module Identified
        def self.example
          prepaid_card_provider = New.example
          prepaid_card_provider.id = PrepaidCardProvider.id
          prepaid_card_provider
        end
      end
    end
  end
end
