module Realms
  module Abilities
    class ScrapFromHandOrDiscardPile < Ability
      def self.key
        :scrap_from_hand_or_discard_pile
      end

      def execute
        (arg || 1).times do
          choose(Choice.new(cards_in_hand_or_discard_pile, optional: optional)) do |card|
            turn.trade_deck.scrap_heap << turn.active_player.deck.scrap(card)
          end
        end
      end

      def cards_in_hand_or_discard_pile
        turn.active_player.deck.hand + turn.active_player.deck.discard_pile
      end
    end
  end
end