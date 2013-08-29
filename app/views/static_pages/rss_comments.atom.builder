atom_feed do |feed|
  feed.title "Gdańsk Curling Club - Komentarze Aktualności"
  feed.updated @komentarze.first.created_at
  @komentarze.each do |komentarz|
    feed.entry komentarz, {:url => "/#{komentarz.commentable_type.downcase}/#{komentarz.commentable_id}"} do |entry|
      entry.title komentarz.user_id
      entry.content komentarz.body, :type => 'html'
      entry.url "/#{komentarz.commentable_type}/#{komentarz.commentable_id}"
      entry.author do |author|
        author.name "Gdańsk Curling Club"
      end
    end
  end
end
