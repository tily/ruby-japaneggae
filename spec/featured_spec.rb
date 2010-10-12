require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Japanese::Featured do

    before do
        @feature = '名詞,一般,*,*,*,*,犬,イヌ,イヌ'

        @str = '犬は水を恐れる'
        @str.extend(Japanese::Featured)
        @str.feature = @feature
    end

    describe '#featured?' do

        it 'returns true' do
            @str.featured?.should be_true
        end

        it 'returns false' do
            @str.feature = nil
            @str.featured?.should be_false
        end

    end

    it '#feature=' do
        expect = '名詞,一般,*,*,*,*,水,ミズ,ミズ'
        @str.feature = expect
        @str.feature.should == expect
    end

    it '#feature' do
        @str.feature.should == @feature
    end

    Japanese::Featured::FIELDS.each_with_index do |field, i|

        it "##{field} returns value" do
            expect = @feature.split(',')[i]
            expect = expect == '*' ? nil : expect
            @str.send(field).should == expect
        end

    end

end

