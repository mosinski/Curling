atom_feed do |feed|
  feed.title "Gdańsk Curling Club - Komentarze Aktualności"
  feed.updated @komentarze.first.created_at
  @komentarze.each do |komentarz|
    feed.entry komentarz, {:url => "/#{komentarz.commentable_type.downcase}/#{komentarz.commentable_id}"} do |entry|
      if komentarz.user_id == 3
      entry.title komentarz.body.lines.first+"(Gość)"
      entry.content komentarz.body.sub(komentarz.body.lines.first, ''), :type => 'html'
      else
      @user = @users.detect{|w| w.id == komentarz.user_id}
      entry.title @user.username
      entry.content komentarz.body, :type => 'html'
      end
      entry.url "/#{komentarz.commentable_type}/#{komentarz.commentable_id}"
      entry.author do |author|
        author.name "Gdańsk Curling Club"
      end
    end
  end
end
