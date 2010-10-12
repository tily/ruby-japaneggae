$:.unshift(File.dirname(__FILE__)) unless
$:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'japaneggae/featured'
require 'japaneggae/mecabable'
require 'japaneggae/conjugatable'
require 'japaneggae/hatenable'

module Japaneggae

    REGEXP = /[一-龠]|[ぁ-ん]|[ァ-ヴー]/u

    include Featured
    include Mecabable
    include Conjugatable
    include Hatenable

    def japanese?; true end
    alias ja? japanese?

end

module Kernel

    def Japanese(str)
        raise ArgumentError, 'Not String object' if !str.is_a? String
        raise ArgumentError, 'Not Japanese' if !str.match(Japaneggae::REGEXP)
        str.extend(Japaneggae)
        yield str if block_given?
        str
    end

end

