module Realms
  module Abilities
    class Choose < Ability
      def self.[](*args)
        super(args)
      end

      def execute
        may_choose(arg) do |ability|
          perform ability.new(card, turn)
        end
      end
    end
  end
end
