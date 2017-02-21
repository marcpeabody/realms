require "realms/choice"
require "realms/actions"
require "realms/abilities"
require "realms/cards"

module Realms
  class PlayerAction < Choice
    attr_reader :turn

    def initialize(turn)
      @turn = turn
      @options = {}
      @options[:play] = play_card_from_hand
      @options[:primary] = primary_abilities
      @options[:ally] = ally_abilities
      @options[:scrap] = scrap_abilities
      @options[:acquire] = trade_row
      @options[:end_turn] = end_turn
      @options[:use_combat] = use_combat
    end

    def play_card_from_hand
      turn.active_player.deck.hand.each_with_object({}) do |card, opts|
        opts[card.key] = Actions::PlayCard.new(card)
      end
    end

    def primary_abilities
      turn.active_player.deck.battlefield.select(&:base?).each_with_object({}) do |card, opts|
        opts[card.key] = Actions::UsePrimaryAbility.new(card)
      end.except(*turn.activated_base_ability)
    end

    def ally_abilities
      turn.active_player.deck.battlefield.each_with_object({}) do |card, opts|
        if card.ally_ability_activated?
          opts[card.key] = Actions::UseAllyAbility.new(card)
        end
      end.except(*turn.activated_ally_ability)
    end

    def scrap_abilities
      turn.active_player.deck.battlefield.each_with_object({}) do |card, opts|
        opts[card.key] = Actions::UseScrapAbility.new(card)
      end
    end

    def trade_row
      turn.trade_deck.trade_row.each_with_object({}) do |card, opts|
        if turn.trade >= card.cost
          opts[card.key] = Actions::AcquireCard.new(turn.active_player, card)
        end
      end.merge(explorer: Actions::AcquireExplorer.new(turn))
    end

    def use_combat
      { turn.passive_player.name.to_sym => Actions::UseCombat.new(turn) }
    end

    def end_turn
      Actions::EndMainPhase.new(turn)
    end
  end
end
