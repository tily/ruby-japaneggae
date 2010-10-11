
module Japanese

    module Featured

      attr_accessor :feature

      def featured?
        feature ? true : false
      end

      FIELDS = [:pos, :pos1, :pos2, :pos3, :conj_type, :conj_form, :base_form, :kana, :pronunciation]
      FIELDS.each_with_index do |field, i|
          define_method field do
              features = feature.split(',')
              features[i] == '*' ? nil : features[i]
          end
      end
  
    end

end

