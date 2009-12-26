module JaUtil
  class Word
    @@conj_forms = nil
  
    def self.get_cforms(path)
      content = File.read(path)
      content.tr!(';', '#')
      content.tr!('()', '[]')
      content.gsub!(/\]/, '],')
      content.gsub!(/[\w\d\-+*%]+/u){ "'#{$&}'," }
      eval '@@conj_forms = [' + content + "\n]"
    end
  
    attr_writer :surface, :feature,
                :pos, :pos1, :pos2, :pos3,
                :conj_type, :conj_form, :base_form, 
                :kana, :pronunciation 
  
    def conj(form)
      return nil unless is_conj_word?
      suffix = forms[1].assoc(form)[1]
      kana = forms[1].assoc(form)[2]
      word = self.dup
      suffix.sub!(/^\*$/, '')
      if ['カ変・来ル', 'カ変・クル', '特殊・タ'].include?(forms[0])
        if forms[0] == '特殊・タ'
          word.surface = word.surface + suffix
        else
          word.surface = suffix
        end
        word.kana = kana
        word.pronunciation = kana
      else
        word.surface = word.surface.sub(/.$/u, suffix)
        # 1段動詞対応
        if kana
          word.kana = word.kana.sub(/.$/u, kana)
          word.pronunciation = word.pronunciation.sub(/.$/u, kana)
        else
          word.kana = word.kana.sub(/.$/u, '')
          word.pronunciation = word.pronunciation.sub(/.$/u, '')
        end
      end
      word.conj_form = form
      word
    end
  
    def forms
      @@conj_forms.assoc(conj_type)
    end
  
    def form_names
      return nil unless is_conj_word?
      forms[1].map{|f| f[0]}
    end
  
    def initialize(node)
      @node = node
    end
  
    def next
      if(next_node = @node.next)
        self.class.new(next_node)
      end
    end
  
    def is_conj_word?
      ['動詞', '形容詞', '助動詞'].include?(pos)
    end
  
    def is_content_word?
      ['動詞', '形容詞', '名詞'].include?(pos)
    end
  
    def length
      @length ||= pronunciation.split(//u).length
    end
  
    def surface
      @surface ||= @node.surface
    end
  
    def feature
      @feature ||= @node.feature
    end

    def features
      feature.split(',')
    end

    def pos
      features[0] == '*' ? nil : features[0]
    end
  
    def pos1
      features[1] == '*' ? nil : features[1]
    end
  
    def pos2
      features[2] == '*' ? nil : features[2]
    end
  
    def pos3
      features[3] == '*' ? nil : features[3]
    end
  
    def conj_type
      features[4] == '*' ? nil : features[4]
    end
  
    def conj_form
      features[5] == '*' ? nil : features[5]
    end
  
    def base_form
      features[6] == '*' ? nil : features[6]
    end
  
    def kana
      features[7] == '*' ? nil : features[7]
    end
  
    def pronunciation
      features[8] == '*' ? nil : features[8]
    end
  end
end
