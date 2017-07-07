require "spec_helper"

RSpec.describe Realms::Zones::InPlay do
  context "ship" do
    context "primary_ability" do
      include_context "primary_ability" do
        let(:card) { Realms::Cards::BlobFighter.new(game.p1) }
      end

      it do
        expect {
          game.play(card)
        }.to change { game.active_turn.combat }.by(3)
      end
    end

    context "ally_ability" do
      context "manual" do
        include_context "ally_ability", Realms::Cards::BlobFighter do
          let(:card) { Realms::Cards::BlobFighter.new(game.p1) }
        end

        it do
          expect {
            game.ally_ability(card)
            game.ally_ability(ally)
          }.to change { game.p1.draw_pile.length }.by(-2)

          expect(game.current_choice.options.keys).to_not include(:"ally_ability.#{card.key}")
          expect(game.current_choice.options.keys).to_not include(:"ally_ability.#{ally.key}")
        end
      end

      context "automatic" do
        include_context "automatic_ally_ability", Realms::Cards::Corvette do
          let(:card) { Realms::Cards::Corvette.new(game.p1) }
        end

        it do
          expect {
            game.play(card)
          }.to change { game.active_turn.combat }.by(5).and \
               change { game.p1.draw_pile.length }.by(-1)

          expect(game.current_choice.options.keys).to_not include(:"ally_ability.#{card.key}")
          expect(game.current_choice.options.keys).to_not include(:"ally_ability.#{ally.key}")
        end
      end
    end
  end

  context "base" do
    context "playing from hand" do
      context "primary_ability" do
        context "manual" do
          include_context "base_ability" do
            let(:card) { Realms::Cards::TradingPost.new(game.p1) }
          end

          it do
            expect {
              game.base_ability(card)
              game.decide(:authority)
            }.to change { game.active_player.authority }.by(1)
            expect(game.current_choice.options.keys).to_not include(:"base_ability.#{card.key}")
          end
        end

        context "automatic" do
          include_context "primary_ability" do
            let(:card) { Realms::Cards::BlobWheel.new(game.p1) }
          end

          it do
            expect {
              game.play(card)
            }.to change { game.active_turn.combat }.by(1)
            expect(game.current_choice.options.keys).to_not include(:"base_ability.#{card.key}")
          end
        end
      end

      context "ally_ability" do
        context "manual" do
          include_context "ally_ability", Realms::Cards::BlobFighter do
            let(:card) { Realms::Cards::TheHive.new(game.p1) }
          end

          it do
            expect {
              game.ally_ability(card)
            }.to change { game.p1.draw_pile.length }.by(-1)
            expect(game.current_choice.options.keys).to_not include(:"ally_ability.#{card.key}")
          end
        end

        context "automatic" do
          include_context "automatic_ally_ability", Realms::Cards::Corvette do
            let(:card) { Realms::Cards::WarWorld.new(game.p1) }
          end

          it do
            expect {
              game.play(card)
            }.to change { game.active_turn.combat }.by(9)
            expect(game.current_choice.options.keys).to_not include(:"ally_ability.#{card.key}")
          end
        end
      end
    end

    xcontext "already in play" do
      context "primary_ability" do
        context "manual" do
          include_context "base_ability" do
            let(:card) { Realms::Cards::TradingPost.new(game.p1) }
          end

          it do
            expect {
              game.base_ability(card)
              game.decide(:authority)
            }.to change { game.active_player.authority }.by(1)
            expect(game.current_choice.options.keys).to_not include(:"base_ability.#{card.key}")
          end
        end

        context "automatic" do
          include_context "primary_ability" do
            let(:card) { Realms::Cards::BlobWheel.new(game.p1) }
          end

          it do
            expect {
              game.play(card)
            }.to change { game.active_turn.combat }.by(1)
            expect(game.current_choice.options.keys).to_not include(:"base_ability.#{card.key}")
          end
        end
      end

      context "ally_ability" do
        context "manual" do
          include_context "ally_ability", Realms::Cards::BlobFighter do
            let(:card) { Realms::Cards::TheHive.new(game.p1) }
          end

          it do
            expect {
              game.ally_ability(card)
            }.to change { game.p1.draw_pile.length }.by(-1)
            expect(game.current_choice.options.keys).to_not include(:"ally_ability.#{card.key}")
          end
        end

        context "automatic" do
          include_context "automatic_ally_ability", Realms::Cards::Corvette do
            let(:card) { Realms::Cards::WarWorld.new(game.p1) }
          end

          it do
            expect {
              game.play(card)
            }.to change { game.active_turn.combat }.by(9)
            expect(game.current_choice.options.keys).to_not include(:"ally_ability.#{card.key}")
          end
        end
      end
    end
  end
end
