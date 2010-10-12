require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Japaneggae::Mecabable do

    before do
        @str = '犬は水を恐れる'
        @str.extend(Japaneggae::Mecabable)
    end

    describe 'parsing methods' do

        it '#words return Japanese words' do
            @words = @str.words
        end

        it '#parse return Japanese words' do
            @words = @str.parse
        end

        after do
            @words.should == ['犬', 'は', '水', 'を', '恐れる']
            @words.each do |word|
                word.japanese?.should be_true
                word.featured?.should be_true
            end
        end

    end

    describe '#mecab_nodes' do

        before do
            @nodes = Array.new(5) { mock('DummyNode') }
            @nodes.each_with_index do |node, i|
              node.should_receive(:next).once.and_return(@nodes[i+1])
            end
            @tagger = mock('DummyTagger')
            @tagger.should_receive(:parseToNode).once.and_return(@nodes.first)
            MeCab::Tagger.should_receive(:new).once.and_return(@tagger)
        end

        it 'returns mecab nodes' do
            @nodes.each_with_index do |node, i|
              node.should_receive(:feature).once.and_return('dummy feature')
            end
            @str.send(:mecab_nodes).should == @nodes
        end

        it 'returns neither EOS nor BOS/EOS node' do
            @nodes[1..3].each_with_index do |node, i|
              node.should_receive(:feature).once.and_return('dummy feature')
            end
            @nodes[0].should_receive(:feature).once.and_return('BOS/EOS,')
            @nodes[4].should_receive(:feature).once.and_return('EOS,')
            @str.send(:mecab_nodes).should == @nodes[1..3]
        end

    end

end

