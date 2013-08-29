atom_feed do |feed|
  feed.title "Gdańsk Curling Club - Aktualności Klubowe"
  feed.updated @dashboards.first.created_at
  @dashboards.each do |article|
    feed.entry article do |entry|
      entry.title article.tytul
      entry.content article.tekst, :type => 'html'
      entry.author do |author|
        author.name "Gdańsk Curling Club"
      end
    end
  end
end
