require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe JaUtil::Word do

  before(:all) do
    next_node = stub('second node', :surface => 'が')
    node = stub('MeCab::Node', :surface => '犬', :feature => '名詞,一般,*,*,*,*,犬,イヌ,イヌ', :next => next_node)
    @word = JaUtil::Word.new(node)
  end

  it 'has the same surface with MeCab::Node' do
    @word.surface.should == '犬'
  end

  it 'has the same feature with MeCab::Node' do
    @word.feature.should == '名詞,一般,*,*,*,*,犬,イヌ,イヌ'
  end

  it 'extracts part-of-speech information from MeCab::Node' do
    @word.pos.should == '名詞'
    @word.pos1.should == '一般'
    @word.pos2.should be_nil
    @word.pos3.should be_nil
  end

  it 'extracts conjugation information from MeCab::Node' do
    @word.conj_type.should be_nil
    @word.conj_form.should be_nil
    @word.base_form.should == '犬'
  end

  it 'extracts kana and pronunciation information from MeCab::Node' do
    @word.kana.should == 'イヌ'
    @word.pronunciation.should  == 'イヌ'
  end

  it 'returns next node' do
    @word.next.surface.should == 'が'
  end

end
