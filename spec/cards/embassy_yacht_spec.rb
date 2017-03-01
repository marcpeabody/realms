require "spec_helper"

RSpec.describe Realms::Cards::EmbassyYacht do
  let(:game) { Realms::Game.new }
  let(:card) { described_class.new(game.p1) }

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
    end

    context "no bases in play" do
      before { game.start }
      it {
        expect {
          game.decide(:play, :embassy_yacht_0)
        }.to change { game.p1.authority }.by(3).and \
             change { game.active_turn.trade }.by(2)
      }
    end

    context "one base in play" do
      before do
        game.p1.deck.hand << card
        game.p1.deck.battlefield << Realms::Cards::BlobWheel.new(game.p1)
        game.start
      end

      it {
        expect {
          game.decide(:play, :embassy_yacht_0)
        }.to change { game.p1.authority }.by(3).and \
             change { game.active_turn.trade }.by(2)
      }
    end

    context "two bases in play" do
      before do
        game.p1.deck.hand << card
        game.p1.deck.battlefield << Realms::Cards::BlobWheel.new(game.p1, index: 0)
        game.p1.deck.battlefield << Realms::Cards::BlobWheel.new(game.p1, index: 1)
        game.start
      end

      it {
        expect {
          game.decide(:play, :embassy_yacht_0)
        }.to change { game.p1.authority }.by(3).and \
             change { game.active_turn.trade }.by(2).and \
             change { game.p1.deck.draw_pile.length }.by(-2)
      }
    end
  end
end