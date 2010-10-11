Japaneggae
======

Japaneggae is miso-soup library for the Japanese language.

Usage
-------

### Morph Analysis

    jstr = Japanese('これは日本語です')
    jstr.class #=> String
    words = jstr.words # => ["\343\201\223\343\202\214", "\343\201\257", "\346\227\245\346\234\254\350\252\236", "\343\201\247\343\201\231"]
    words.each do |word|
        puts "#{word}\t(#{word.pos})"
    end

output:

    これ    (名詞)
    は      (助詞)
    日本語  (名詞)
    です    (助動詞)

### Conjugation

### Web APIs

Hatena association keyword API:

Social IME API:

Text Conversion Service:

Requirements
-------

* ruby 1.8.7
* MeCab
* mecab-ruby

Links
-------

* Documentation: coming late
* Source code: [http://github.com/tily/ruby-japaneggae](http://github.com/tily/ruby-japaneggae)

Copyright
-------

Copyright (c) 2010 tily. See LICENSE for details.
