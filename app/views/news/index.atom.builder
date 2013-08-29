atom_feed do |feed|
  feed.title "Gdańsk Curling Club - Aktualności"
  feed.updated @news.first.created_at
  @news.each do |article|
    feed.entry article do |entry|
      entry.title article.tytul
      entry.content article.tekst_pl, :type => 'html'
      entry.author do |author|
        author.name "Gdańsk Curling Club"
      end
    end
  end
end
