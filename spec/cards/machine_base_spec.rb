require "spec_helper"

RSpec.describe Realms::Cards::MachineBase do
  include_examples "type", :outpost
  include_examples "defense", 6
  include_examples "factions", :machine_cult
  include_examples "cost", 7

  describe "#primary_ability" do
    include_context "base_ability"

    it "draws a card and scraps a card from hand" do
      expect {
        game.base_ability(card)
      }.to change { game.p1.deck.draw_pile.length }.by(-1)

      card_in_hand = game.p1.deck.hand.sample

      expect {
        game.decide(card_in_hand.key)
      }.to change { game.trade_deck.scrap_heap.length }.by(1)
    end
  end
end
