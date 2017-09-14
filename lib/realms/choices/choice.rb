module Realms
  module Choices
    class Choice
      attr_reader :subject, :options, :decision

      def initialize(subject, options)
        @subject = subject
        @options = options
      end

      def decide(key)
        @decision = options_hash.fetch(key) do
          raise InvalidOption, "missing #{key} in #{options_hash.keys}"
        end
      end

      def noop?
        @noop ||= options.reject(&:noop?).empty?
      end

      def undecided?
        decision.nil?
      end

      def actionable?
        return true if undecided?
        decision != decision.noop?
      end

      def clear
        @decision = nil
      end

      private

      def options_hash
        @options_hash ||= options.each_with_object({}) do |option, opts|
          key = [subject, option.key].compact.join(".").to_sym
          opts[key] = option
        end
      end
    end
  end
end
