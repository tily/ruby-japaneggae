require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe 'Japanese' do

    describe 'Argument errors' do

        it 'throws error when arg is not String object' do
            NotString = Class.new
            not_string = NotString.new
            lambda {
                Japanese(not_string)
            }.should raise_error(ArgumentError, 'Not String object')
        end

        it 'throws error when arg is not Japanese' do
            lambda {
              Japanese('This is English.')
            }.should raise_error(ArgumentError, 'Not Japanese')
        end

    end

    describe 'General situation' do

        before do
            @jstr = Japanese('これは日本語です')
        end

        it '#japanese? returns true' do
            @jstr.japanese?.should be_true
        end

        it '#ja? returns true' do
            @jstr.ja?.should be_true
        end

        it 'has singleton methods' do
            expects = ['japanese?', 'ja?', 'words', 'conj', 'associate_hatena_keywords']
            expects.each do |expect|
                @jstr.singleton_methods.include?(expect).should be_true
            end
        end

    end

end

