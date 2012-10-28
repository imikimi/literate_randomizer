module LiterateRandomizer

# A few utility methods
class Util
  class << self

    # r can be an Integer of a Range. If an intenger, return r, else, return a the maximum value in the range.
    def max(r)
      return r if r.kind_of? Integer
      r.max
    end

    # r can be an Integer of a Range. If an intenger, return r, else, return a random number within the range.
    def rand_count(r,randomizer=Random.new)
      return r if r.kind_of? Integer
      randomizer.rand(r.max-r.min)+r.min
    end

    # return word with the first letter capitalized
    def capitalize(word)
      word.chars.first.upcase+word[1..-1]
    end

  end
end
end
