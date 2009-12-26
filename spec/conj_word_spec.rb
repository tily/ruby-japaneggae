require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'tempfile'

describe JaUtil::Word, 'when initialized with conjugational word' do

  before(:all) do
    cforms = <<EOF
(五段・カ行イ音便
    (   ; (語幹        *         )
     (基本形      く    ク  )   
     (未然形      か    カ  )   
     (未然ウ接続  こ    コ  )   
     (連用形      き    キ  )   
     (連用タ接続  い    イ  )   
     (仮定形      け    ケ  )   
     (命令ｅ      け    ケ  )   
     (仮定縮約１  きゃ  キャ))
)
(形容詞・イ段
    (   ; (語幹            *             )
     (基本形          い      イ    )   
     (文語基本形      *       *    )   
     (未然ヌ接続      から    カラ  )   
     (未然ウ接続      かろ    カロ  )   
     (連用タ接続      かっ    カッ  )   
     (連用テ接続      く      ク    )   
     (連用テ接続      くっ    クッ  )   
     (連用ゴザイ接続  ゅう    ュウ  ュー) 
     (連用ゴザイ接続  ゅぅ    ュゥ  ュー) 
     (体言接続        き      キ    )   
     (仮定形          けれ    ケレ  )   
     (命令ｅ          かれ    カレ  )   
     (仮定縮約１      けりゃ  ケリャ) 
     (仮定縮約２      きゃ    キャ  )   
     (ガル接続        *             ))
)
(特殊・タ
    (	; (語幹    *     )
     (基本形  *     )
     (未然形  ろ    ロ)
     (仮定形  ら    ラ))
)
EOF
    @cforms_file = Tempfile.new('cforms.cha')
    @cforms_file.print(cforms)
    @cforms_file.open
    JaUtil::Word.get_cforms(@cforms_file.path)
  end

  it '#conj returns JaUtil::Word object' do
    node = stub('verb node', :surface => '動く', :feature => '動詞,自立,*,*,五段・カ行イ音便,基本形,動く,ウゴク,ウゴク')
    word = JaUtil::Word.new(node)
    word.conj('基本形').class.should       == JaUtil::Word
  end

  it 'of verb conjugates good' do
    node = stub('verb node', :surface => '動く', :feature => '動詞,自立,*,*,五段・カ行イ音便,基本形,動く,ウゴク,ウゴク')
    word = JaUtil::Word.new(node)
    word.conj('基本形').surface.should     == '動く'
    word.conj('未然形').surface.should     == '動か'
    word.conj('未然ウ接続').surface.should == '動こ'
    word.conj('連用形').surface.should     == '動き'
    word.conj('連用タ接続').surface.should == '動い'
    word.conj('仮定形').surface.should     == '動け'
    word.conj('命令ｅ').surface.should     == '動け'
    word.conj('仮定縮約１').surface.should   == '動きゃ'
  end

  it 'of adjective conjugates good' do
    node = stub('verb node', :surface => '美しい', :feature => '形容詞,自立,*,*,形容詞・イ段,基本形,美しい,ウツクシイ,ウツクシイ')
    word = JaUtil::Word.new(node)
    word.conj('基本形').surface.should         == '美しい'  
    word.conj('文語基本形').surface.should     == '美し'
    word.conj('未然ヌ接続').surface.should     == '美しから'
    word.conj('未然ウ接続').surface.should     == '美しかろ'
    word.conj('連用タ接続').surface.should     == '美しかっ'
    word.conj('連用テ接続').surface.should     == '美しく'
    #word.conj('連用テ接続').surface.should == '美しくっ'
    word.conj('連用ゴザイ接続').surface.should == '美しゅう'
    #word.conj('連用ゴザイ接続').surface.should == '美しゅぅ'
    word.conj('体言接続').surface.should       == '美しき'  
    word.conj('仮定形').surface.should         == '美しけれ'
    word.conj('命令ｅ').surface.should         == '美しかれ'
    word.conj('仮定縮約１').surface.should     == '美しけりゃ'
    word.conj('仮定縮約２').surface.should     == '美しきゃ'
    word.conj('ガル接続').surface.should       == '美し'
  end

  it 'of auxiliary verb conjugates good' do
    node = stub('verb node', :surface => 'た', :feature => '助動詞,*,*,*,特殊・タ,基本形,た,タ,タ')
    word = JaUtil::Word.new(node)
    word.conj('基本形').surface.should == 'た'
    word.conj('未然形').surface.should == 'たろ'
    word.conj('仮定形').surface.should == 'たら'
  end

  after(:all) do
    @cforms_file.close
  end
end
