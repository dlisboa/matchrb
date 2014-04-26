require "matchrb/version"

module Matchrb
  extend self

  def match(something, patterns)
    apply = lambda do |action, value|
      return action unless action.respond_to?(:to_proc)

      action = action.to_proc
      action.arity.zero? ? action[] : action[value]
    end

    patterns.each do |pattern, action|
      if (value = pattern === something)
        return apply[action, value]
      end
    end

    nil
  end

  def otherwise
    Object
  end
end
