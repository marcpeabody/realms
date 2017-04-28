module Realms
  module Zones
    class InPlay < Zone
      def actions
        return attack_actions if owner == active_turn.passive_player
        base_actions +
          ally_actions +
          scrap_actions
      end

      private

      def base_actions
        cards.each_with_object([]) do |card, actions|
          if card.base? && active_turn.activated_base_ability.exclude?(card)
            actions << Actions::BaseAbility.new(active_turn, card)
          end
        end
      end

      def ally_actions
        cards.each_with_object([]) do |card, actions|
          if card.ally_ability? && active_turn.activated_ally_ability.exclude?(card)
            actions << Actions::AllyAbility.new(active_turn, card)
          end
        end
      end

      def scrap_actions
        cards.select(&:scrap_ability?).map { |card| Actions::ScrapAbility.new(active_turn, card) }
      end

      def attack_actions
        eligible = ->(base) { active_turn.combat >= base.defense }
        outposts, bases = cards.select(&:base?).partition(&:outpost?)

        if outposts.any?
          outposts.select(&eligible).map { |card| Actions::Attack.new(active_turn, card) }
        else
          targets = bases.select(&eligible).map { |card| Actions::Attack.new(active_turn, card) }
          targets << Actions::Attack.new(active_turn, owner) if active_turn.combat.positive?
          targets
        end
      end
    end
  end
end
