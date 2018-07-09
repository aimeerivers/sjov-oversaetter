require 'net/http'
require 'json'
require 'cgi'

SPROG_KODE = {
  'Engelsk': 'en',
  'Dansk': 'da',
  'Tysk': 'de',
  'Fransk': 'fr',
  'Japansk': 'ja',
  'Bengali': 'bn',
  'Latin': 'la',
  'Swahili': 'sw'
}

Givet("filen {string} som er på {string}") do |fil, første_sprog|
  @tekst = File.read(File.join('filer', fil))
  @fra = første_sprog
  @resultat = "#{@fra}:\n#{@tekst}\n\n"
end

Når("den oversættes gennem folgende sprog:") do |sprog_list|
  sprog_list.raw.flatten.each do |sprog|
    p sprog
    uri = URI('https://translation.googleapis.com/language/translate/v2')
    req = Net::HTTP::Post.new(
      uri,
      'Content-Type' => 'application/json; charset=utf-8',
      'Authorization' => 'Bearer ' + `gcloud auth application-default print-access-token`)
    req.body = {
      q: @tekst,
      source: SPROG_KODE.fetch(@fra.to_sym),
      target: SPROG_KODE.fetch(sprog.to_sym)
    }.to_json
    res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
      http.request(req)
    end

    @tekst = CGI::unescapeHTML(JSON.parse(res.body)['data']['translations'][0]['translatedText'])
    @fra = sprog
    @resultat += "#{@fra}:\n#{@tekst}\n\n"
  end
end

Så("bliver resultatet gemt i filen {string}") do |fil|
  File.open(File.join('filer', fil), 'w') do |f|
    f.write @resultat
  end
end
