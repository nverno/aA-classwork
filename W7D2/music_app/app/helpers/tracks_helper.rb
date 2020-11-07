# coding: utf-8
module TracksHelper
  def ugly_lyrics(lyrics)
    res = '<pre>' +
          lyrics.lines.map { |s| '♫ ' + h(s) }.join +
          '</pre>'
    res.html_safe
  end
end
