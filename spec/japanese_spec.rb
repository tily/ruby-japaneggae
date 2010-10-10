require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe 'Japanese()' do

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

        [:japanese?, :ja?].each do |message|
            it "##{message} returns true" do
                @jstr.send(message).should be_true
            end
        end

        it 'has singleton methods' do
            expects = ['japanese?', 'ja?', 'words', 'conj', 'associate_hatena_keywords']
            expects.each do |expect|
                @jstr.singleton_methods.include?(expect).should be_true
            end
        end

    end

    describe 'global String class is not polluted' do

        before do
            @str = 'This is just a string'
        end

        [:japanese?, :ja?].each do |message|
            it "String object does not respond to #{message}" do
                @str.respond_to?(:message).should be_false
            end
        end

        it 'String object does not have any singleton method' do
            @str.singleton_methods.should be_empty 
        end

    end

    describe 'Takes block' do
        it 'takes block' do        
            jstr = 'これも日本語です'
            Japanese(jstr) do |str|
                str.is_a?(String).should be_true
                str.should == jstr
            end
        end
    end

end

