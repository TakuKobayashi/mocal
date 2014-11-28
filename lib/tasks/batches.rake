namespace :batches do
  task :crwal_articles => :environment do
    AsahiArticle.crawl
  end

  task :analize_articles => :environment do
    Article.bulk_analize!
  end

  task :compact_word_score => :environment do
    Article.find_each do |article|
      word_scores = article.sentences.map(&:word_scores).flatten
      delete_list, remain_list = word_scores.partition{|w| w.score == 0}
      if remain_list.size > 5
        word_score_groups = remain_list.group_by(&:word)
      else
      	word_score_groups = word_scores.group_by(&:word)
      	delete_list = []
      end
      word_score_groups.each do |word, word_scores|
      	word_scores[0].update!(score: word_scores.sum(&:score))
      	delete_list << word_scores[1..word_scores.size]
      end
      delete_list.flatten!.compact!
      delete_list.each do |w|
      	puts "delete id: " + w.id.to_s + " word:" + w.word.to_s + " score:" + w.score.to_s
      end
      WordScore.delete_all(id: delete_list.flatten.compact.map(&:id)) if delete_list.present?
    end
  end
end