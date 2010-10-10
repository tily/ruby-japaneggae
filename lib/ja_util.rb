$:.unshift(File.dirname(__FILE__)) unless
$:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'ja_util/mecabable'
require 'ja_util/conjugatable'
require 'ja_util/hatenable'

module Japanese

    REGEXP = /[一-龠]|[ぁ-ん]|[ァ-ヴー]/u

    include Mecabable
    include Conjugatable
    include Hatenable

    def japanese?; true end
    alias ja? japanese?

end

module Kernel

    def Japanese(str)
        raise ArgumentError, 'Not String object' if !str.is_a? String
        raise ArgumentError, 'Not Japanese' if !str.match(Japanese::REGEXP)
        str.extend(Japanese)
        yield str if block_given?
        str
    end

end

