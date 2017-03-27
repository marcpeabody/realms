require "spec_helper"

RSpec.describe Realms::Actions::AcquireCard do
  let(:game) { Realms::Game.new }

  context "acquiring cards from the trade row" do
    let(:card) { Realms::Cards::Scout.new(game.p1, index: 0) }

    before do
      game.p1.deck.hand << card
      game.trade_deck.trade_row = Realms::Zone.new(5.times.map { |i| Realms::Cards::BlobFighter.new(index: i) })
      game.start
    end

    it "acquires a card from the trade row paid for in trade" do
      expect {
        game.play(card)
      }.to change { game.active_turn.trade }.by(1)

      expect {
        new_card = game.trade_deck.trade_row.first
        game.acquire(new_card)
      }.to change { game.p1.deck.discard_pile.length }.by(1).and \
           change { game.trade_deck.trade_row.length }.by(0)

      expect(game.active_turn.trade).to eq(0)
    end
  end

  context "when the turn doesn't have enough trade" do
    before do
      game.p1.deck.hand = Realms::Zone.new([
        Realms::Cards::Scout.new(game.p1, index: 0),
        Realms::Cards::Scout.new(game.p1, index: 1),
        Realms::Cards::Viper.new(game.p1, index: 0),
      ])
      game.trade_deck.trade_row = Realms::Zone.new(5.times.map { |i| Realms::Cards::BlobWheel.new(index: i) })
      game.start
    end

    it "only sees explorer as an option" do
      expect {
        game.play(:scout_0)
        game.play(:scout_1)
        game.play(:viper_0)
      }.to change { game.active_turn.trade }.by(2).and \
           change { game.active_turn.combat }.by(1)

      expect(game.current_choice.options).to have_key("acquire.explorer_0")
    end
  end
end
