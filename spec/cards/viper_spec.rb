require "spec_helper"

RSpec.describe Realms2::Cards::Viper do
  let(:game) { Realms2::Game.new.start }
  let(:viper) { described_class.new(game.p1) }

  describe "#primary_ability" do
    before { viper.primary_ability.execute }
    it { expect(game.active_turn.combat).to eq(1) }
  end
end
