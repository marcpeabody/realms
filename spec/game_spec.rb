require "spec_helper"

RSpec.describe Realms::Game do
  let(:game) { described_class.new }
  let(:p1) { game.active_player }
  let(:p2) { game.passive_player }

  context "observing non player happenings" do
    it "can be subscribed to" do
      zts = []
      game.on(:card_moved) do |zt|
        zts << zt
      end
      game.start
      expect(zts.length).to eq(8)
    end
  end

  context "replaying card movement" do
    let(:game) { described_class.new(turn_checkpoint: 2) }

    it "only broadcasts card movements for the latest turn" do
      zts = []
      game.on(:card_moved) do |zt|
        zts << zt
      end
      game.start
      game.end_turn
      game.end_turn
      expect(zts.length).to eq(0)
      game.play(game.active_player.hand.sample)
      expect(zts.length).to eq(1)
      game.play(game.active_player.hand.sample)
      expect(zts.length).to eq(2)
    end
  end

  context "death by viper" do
    it "plays" do
      game.start

      expect(p1.authority).to eq(50)
      expect(p2.authority).to eq(50)

      expect(p1.deck.hand.length).to eq(3)
      expect(p2.deck.hand.length).to eq(5)

      until game.over?
        hand = game.active_player.hand

        until hand.empty?
          game.play(hand.first)
        end

        game.attack(game.passive_player) if game.active_turn.combat.positive?

        game.end_turn
      end
    end
  end

  describe 'Game 1 test' do
    let(:seed) { 309599894551866961338950272150965224107 }
    let(:game) { described_class.new(seed: seed) }
    it 'plays successfully' do
      game.start
      game.play(:scout_12)
      game.play(:viper_2)
      game.play(:scout_8)
      game.acquire(:blob_fighter_1)
      game.acquire(:trade_bot_2)
      game.attack(:frog)
      game.decide(:end_turn)
      game.play(:scout_4)
      game.play(:viper_0)
      game.play(:scout_0)
      game.play(:scout_2)
      game.play(:viper_1)
      game.acquire(:blob_wheel_1)
      game.attack(:bear)
      game.decide(:end_turn)
      game.play(:scout_10)
      game.play(:viper_3)
      game.play(:scout_15)
      game.play(:scout_11)
      game.play(:scout_9)
      game.acquire(:trading_post_1)
      game.attack(:frog)
      game.decide(:end_turn)
      game.play(:scout_7)
      game.play(:scout_3)
      game.play(:scout_1)
      game.play(:scout_5)
      game.play(:scout_6)
      game.acquire(:survey_ship_2)
      game.acquire(:explorer_0)
      game.decide(:end_turn)
      game.play(:scout_13)
      game.play(:scout_14)
      game.play(:scout_15)
      game.play(:viper_3)
      game.play(:scout_9)
      game.acquire(:freighter_0)
      game.attack(:frog)
      game.decide(:end_turn)
      game.play(:scout_7)
      game.play(:viper_1)
      game.play(:scout_6)
      game.play(:viper_0)
      game.play(:scout_5)
      game.attack(:bear)
      game.acquire(:explorer_1)
      game.decide(:end_turn)
      game.play(:viper_2)
      game.play(:scout_11)
      game.play(:scout_12)
      game.play(:trade_bot_2)
      game.decide(:viper_3)
      game.play(:trading_post_1)
      game.base_ability(:trading_post_1)
      game.decide(:trade)
      game.attack(:frog)
      game.acquire(:explorer_2)
      game.acquire(:explorer_3)
      game.decide(:end_turn)
      game.play(:scout_4)
      game.play(:survey_ship_2)
      game.play(:explorer_0)
      game.play(:blob_wheel_1)
      game.play(:scout_1)
      game.play(:scout_3)
      game.acquire(:missile_mech_0)
      game.scrap_ability(:survey_ship_2)
      game.scrap_ability(:blob_wheel_1)
      game.acquire(:explorer_4)
      game.scrap_ability(:explorer_0)
      game.decide(:end_turn)
      game.decide(:viper_2)
      game.play(:blob_fighter_1)
      game.play(:scout_8)
      game.play(:scout_10)
      game.play(:scout_11)
      game.base_ability(:trading_post_1)
      game.decide(:trade)
      game.acquire(:stealth_needle_0)
      game.attack(:frog)
      game.decide(:end_turn)
      game.play(:scout_0)
      game.play(:scout_2)
      game.play(:scout_4)
      game.play(:scout_5)
      game.play(:scout_3)
      game.acquire(:trade_escort_0)
      game.decide(:end_turn)
      game.decide(:trade_bot_2)
      game.play(:scout_14)
      game.play(:scout_12)
      game.play(:scout_13)
      game.play(:explorer_2)
      game.decide(:end_turn)
      game.play(:viper_1)
      game.play(:scout_1)
      game.play(:scout_7)
      game.play(:missile_mech_0)
      game.play(:explorer_4)
      game.attack(:trading_post_1)
      game.attack(:bear)
      game.scrap_ability(:explorer_4)
      game.attack(:bear)
      game.acquire(:federation_shuttle_2)
      game.acquire(:blob_wheel_0)
      game.decide(:end_turn)
      game.decide(:explorer_3)
      game.play(:freighter_0)
      game.play(:scout_15)
      game.play(:scout_9)
      game.play(:scout_12)
      game.acquire(:blob_carrier_0)
      game.decide(:end_turn)
      game.play(:explorer_1)
      game.play(:scout_6)
      game.play(:viper_0)
      game.play(:viper_1)
      game.play(:scout_3)
      game.attack(:bear)
      game.scrap_ability(:explorer_1)
      game.attack(:bear)
      game.acquire(:space_station_1)
      game.decide(:end_turn)
      game.decide(:scout_14)
      game.play(:explorer_2)
      game.play(:scout_10)
      game.play(:scout_13)
      game.play(:scout_8)
      game.scrap_ability(:explorer_2)
      game.acquire(:supply_bot_0)
      game.acquire(:corvette_0)
      game.attack(:frog)
      game.decide(:end_turn)
      game.play(:missile_mech_0)
      game.play(:scout_2)
      game.play(:scout_7)
      game.play(:scout_0)
      game.play(:federation_shuttle_2)
      game.acquire(:ram_1)
      game.attack(:bear)
      game.decide(:end_turn)
      game.decide(:viper_2)
      game.play(:trade_bot_2)
      game.decide(:viper_2)
      game.play(:blob_fighter_1)
      game.play(:stealth_needle_0)
      game.decide(:blob_fighter_1)
      game.ally_ability(:blob_fighter_1)
      game.ally_ability(:stealth_needle_0)
      game.play(:scout_11)
      game.play(:scout_12)
      game.play(:scout_9)
      game.attack(:frog)
      game.decide(:end_turn)
      game.play(:blob_wheel_0)
      game.play(:trade_escort_0)
      game.play(:scout_1)
      game.play(:scout_4)
      game.play(:scout_5)
      game.scrap_ability(:blob_wheel_0)
      game.acquire(:junkyard_0)
      game.attack(:bear)
      game.decide(:end_turn)
      game.decide(:scout_8)
      game.play(:explorer_3)
      game.play(:scout_13)
      game.play(:trading_post_1)
      game.play(:supply_bot_0)
      game.decide(:scout_11)
      game.base_ability(:trading_post_1)
      game.decide(:trade)
      game.scrap_ability(:explorer_3)
      game.acquire(:flagship_0)
      game.attack(:frog)
      game.decide(:end_turn)
      game.play(:missile_mech_0)
      game.play(:ram_1)
      game.play(:viper_0)
      game.play(:scout_6)
      game.play(:scout_2)
      game.attack(:trading_post_1)
      game.attack(:bear)
      game.decide(:end_turn)
      game.decide(:corvette_0)
      game.play(:blob_carrier_0)
      game.play(:scout_10)
      game.play(:scout_14)
      game.play(:freighter_0)
      game.attack(:frog)
      game.acquire(:supply_bot_1)
      game.acquire(:supply_bot_2)
      game.decide(:end_turn)
      game.play(:scout_5)
      game.play(:scout_0)
      game.play(:trade_escort_0)
      game.play(:scout_4)
      game.play(:junkyard_0)
      game.base_ability(:junkyard_0)
      game.decide(:viper_0)
      game.attack(:bear)
      game.decide(:end_turn)
      game.decide(:scout_15)
      game.play(:scout_8)
      game.play(:supply_bot_1)
      game.decide(:scout_15)
      game.play(:blob_fighter_1)
      game.play(:trade_bot_2)
      game.attack(:junkyard_0)
      game.attack(:frog)
      game.decide(:end_turn)
      game.play(:space_station_1)
      game.play(:scout_1)
      game.play(:federation_shuttle_2)
      game.play(:scout_7)
      game.play(:viper_1)
      game.attack(:bear)
      game.decide(:end_turn)
      game.decide(:supply_bot_0)
      game.play(:scout_12)
      game.play(:corvette_0)
      game.play(:scout_9)
      game.play(:blob_carrier_0)
      game.play(:stealth_needle_0)
      game.decide(:blob_carrier_0)
      game.ally_ability(:blob_carrier_0)
      game.decide(:mothership_0)
      game.ally_ability(:stealth_needle_0)
      game.decide(:blob_fighter_2)
      game.attack(:space_station_1)
      game.attack(:frog)
      game.decide(:end_turn)
      game.play(:scout_3)
      game.play(:junkyard_0)
      game.play(:scout_4)
      game.play(:viper_1)
      game.play(:scout_5)
      game.base_ability(:junkyard_0)
      game.decide(:none)
      game.attack(:bear)
      game.decide(:end_turn)
      game.decide(:blob_fighter_2)
      game.play(:mothership_0)
      game.play(:scout_10)
      game.play(:supply_bot_2)
      game.decide(:scout_8)
      game.play(:flagship_0)
      game.play(:scout_14)
      game.play(:freighter_0)
      game.acquire(:brain_world_0)
      game.decide(:end_turn)
      game.decide(:end_turn)
      game.decide(:scout_13)
      game.play(:trading_post_1)
      game.decide(:end_turn)
      game.play(:federation_shuttle_2)
      game.play(:scout_1)
      game.play(:scout_0)
      game.play(:trade_escort_0)
      game.play(:scout_5)
      game.acquire(:trade_bot_0)
      game.acquire(:battle_pod_1)
      game.base_ability(:junkyard_0)
      game.decide(:trade_bot_0)
      game.ally_ability(:trade_escort_0)
      game.play(:missile_mech_0)
      game.decide(:junkyard_0)
      game.attack(:trading_post_1)
      game.attack(:bear)
      game.decide(:end_turn)
      game.decide(:scout_9)
      game.decide(:end_turn)
      game.decide(:end_turn)
      game.decide(:brain_world_0)
      game.decide(:end_turn)
      game.decide(:end_turn)
      game.decide(:scout_14)
      game.play(:brain_world_0)
      game.base_ability(:brain_world_0)
      game.decide(:scout_14)
      game.decide(:freighter_0)
      game.play(:mothership_0)
      game.play(:stealth_needle_0)
      game.decide(:mothership_0)
      game.play(:corvette_0)
      game.play(:blob_fighter_2)
      game.ally_ability(:mothership_0)
      game.ally_ability(:stealth_needle_0)
      game.ally_ability(:blob_fighter_2)
      game.play(:flagship_0)
      game.play(:blob_fighter_1)
      game.ally_ability(:blob_fighter_1)
      game.play(:blob_carrier_0)
      game.ally_ability(:blob_carrier_0)
      game.decide(:battlecruiser_0)
      game.play(:trading_post_1)
      game.base_ability(:trading_post_1)
      game.decide(:authority)
      game.play(:supply_bot_0)
      game.decide(:scout_13)
      game.play(:supply_bot_1)
      game.decide(:scout_12)
      game.attack(:frog)
    end
  end
end
