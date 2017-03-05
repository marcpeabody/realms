require "spec_helper"

RSpec.describe Realms::Cards::TradingPost do
  let(:game) { Realms::Game.new }
  let(:card) { described_class.new(game.p1) }

  describe "#type" do
    subject { card.type }
    it { is_expected.to eq(:outpost) }
  end

  describe "#defense" do
    subject { card.defense }
    it { is_expected.to eq(4) }
  end

  describe "#faction" do
    subject { card.faction }
    it { is_expected.to eq(:trade_federation) }
  end

  describe "#cost" do
    subject { card.cost }
    it { is_expected.to eq(3) }
  end

  describe "#primary_ability" do
    before do
      game.p1.deck.hand << card
      game.start
      game.decide(:play, card.key)
      game.decide(:primary, card.key)
    end

    context "authority" do
      it { expect { game.decide(:option_0) }.to change { game.p1.authority }.by(1) }
    end

    context "trade" do
      it { expect { game.decide(:option_1) }.to change { game.active_turn.trade }.by(1) }
    end
  end

  describe "#scrap_ability" do
    before do
      game.p1.deck.hand << card
      game.start
      game.decide(:play, card.key)
    end

    it { expect { game.decide(:scrap, card.key) }.to change { game.active_turn.combat }.by(3) }
  end
end
