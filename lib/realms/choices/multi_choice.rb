module Realms
  module Choices
    class MultiChoice < Choice
      attr_reader :count

      def initialize(subject, options, count:)
        super(subject, options)
        @count = count
        @decision = []
      end

      def decide(key)
        decision << option_hash.delete(key) do
          raise InvalidOption, "missing #{key} in #{options_hash.keys}"
        end
      end

      def undecided?
        decision.length != count
      end

      def decision
        decision.reject(&:noop?)
      end

      def actionable?
        return true if undecided?
        decision.none?(&:noop?)
      end

      def clear
        @decision = [] unless undecided?
      end
    end
  end
end
