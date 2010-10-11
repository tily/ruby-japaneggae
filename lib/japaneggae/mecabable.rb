require 'MeCab'

module Japanese

    module Mecabable

        def words
            mecab_nodes.map do |node|
                Japanese(node.surface) do |str|
                    str.feature = node.feature
                end
            end
        end

        alias parse words

    private

        def mecab_nodes
            nodes = []
            tagger = MeCab::Tagger.new 
            node = tagger.parseToNode(self)
            while node
                nodes.push(node) if !node.feature.match(%r{^(EOS|BOS/EOS),})
                node = node.next
            end
            nodes
        end

    end

end

