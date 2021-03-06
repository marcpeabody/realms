require "spec_helper"

RSpec.describe Realms::Actions::AllyAbility do
  let(:game) { Realms::Game.new }

  context "when playing two different, same faction cards" do
    let(:card1) { Realms::Cards::BlobFighter.new(game.p1) }
    let(:card2) { Realms::Cards::BattlePod.new(game.p1) }

    before do
      game.p1.hand << card1
      game.p1.hand << card2
      game.start
    end

    it "triggers both cards" do
      game.play(card1)
      expect(game).to_not have_option(:ally_ability, card1)

      expect {
        game.play(card2)
        selected_card = game.trade_deck.trade_row.sample
        game.decide(:scrap_card_from_trade_row, selected_card)
      }.to change { game.active_turn.combat }.by(6)

      expect { game.ally_ability(card1) }.to change { game.active_turn.active_player.hand.length }.by(1)

      expect(game).to_not have_option(:ally_ability, card1)
      expect(game).to_not have_option(:ally_ability, card2)
    end
  end

  context "when playing two of the same card" do
    let(:card1) { Realms::Cards::BlobFighter.new(game.active_player, index: 0) }
    let(:card2) { Realms::Cards::BlobFighter.new(game.active_player, index: 1) }

    before do
      game.p1.hand << card1
      game.p1.hand << card2
      game.start
    end

    it "triggers both cards once" do
      game.play(card1)
      game.play(card2)

      expect { game.ally_ability(card1) }.to change { game.active_turn.active_player.hand.length }.by(1)
      expect { game.ally_ability(card2) }.to change { game.active_turn.active_player.hand.length }.by(1)

      expect(game).to_not have_option(:ally_ability, card1)
      expect(game).to_not have_option(:ally_ability, card2)
    end
  end

  context "when playing a card that doesn't have an ally ability" do
    let(:scout_or_viper) { game.p1.hand.sample }

    it "triggers both cards once" do
      game.start
      game.p1.hand.each do |card|
        game.play(card)
      end
      game.p1.in_play.each do |card|
        expect(game).to_not have_option(:ally_ability, card)
      end
    end
  end
end
