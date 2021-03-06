require "spec_helper"

RSpec.describe Realms::Cards::MechWorld do
  include_examples "type", :outpost
  include_examples "defense", 6
  include_examples "factions", :machine_cult
  include_examples "cost", 5

  describe "#static_ability" do
    include_context "automatic_ally_ability", Realms::Cards::Cutter

    it "counts as an ally ability for all factions" do
      expect { game.play(card) }.to change { game.active_turn.combat }.by(4)
      expect(game.active_player.in_play.actions.map(&:key)).to_not include("base_ability.#{card.key}")
    end
  end
end
