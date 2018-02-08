# encoding: utf-8
require 'open-uri'
require 'nokogiri'

urls = [
]

urls.each do |url|
  charset = nil
  html = open(url) do |f|
    charset = f.charset
    f.read
  end
  doc = Nokogiri::HTML.parse(html, nil, "UTF-8")
  doc.css('a').each do |link|
    if link['target'] == '_blank'
      charset2 = nil
      html2 = open(link['href']) do |c|
        charset2 = c.charset
        c.read
      end
      doc2 = Nokogiri::HTML.parse(html2, nil, "shift_jis")
      doc2.css('p').each do |ptag|
        if ptag.text.index("広告が見つかりません")
          puts link['href']
          puts ptag.text
          next
        end
      end
    end
  end
end
