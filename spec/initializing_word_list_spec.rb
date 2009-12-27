require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe JaUtil::WordList, "initialized with class methods" do

  it ".from_text returns JaUtil::WordList object" do
    wl = JaUtil::WordList.from_text('私は犬が好きです')
    wl.class.should == JaUtil::WordList
    wl.each {|w| w.class.should == JaUtil::Word }
  end

  it ".from_word returns JaUtil::WordList object" do
    m = MeCab::Tagger.new
    word = JaUtil::Word.new(m.parseToNode('私は犬が好きです'))
    wl = JaUtil::WordList.from_word(word)
    wl.class.should == JaUtil::WordList
    wl.each {|w| w.class.should == JaUtil::Word }
  end

  it ".new returns JaUtil::WordList object" do
    m = MeCab::Tagger.new
    wl = JaUtil::WordList.new
    w = JaUtil::Word.new(m.parseToNode('私は犬が好きです'))
    wl.class.should == JaUtil::WordList
    wl.each {|w| w.class.should == JaUtil::Word }
  end

end
