require 'MeCab'
require 'ja_util/word'

module JaUtil
  class WordList < Array
    def self.from_text(text)
      mecab = MeCab::Tagger.new
      word = Word.new(mecab.parseToNode(text))
      from_word(word)
    end
  
    def self.from_word(word)
      list = self.new
      while word
        list.push(word) unless ['EOS', 'BOS/EOS'].include?(word.pos)
        word = word.next
      end
      list
    end
  end
end
