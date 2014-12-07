namespace :batches do
  task :crwal_articles => :environment do
    AsahiArticle.crawl
  end

  task :analize_articles => :environment do
    Article.bulk_analize!
  end

  task :article_split_ngrams => :environment do
    Article.find_each do |article|
      article.split_ngrams!
    end
  end

  task :compact_word_score => :environment do
    Article.find_each do |article|
      word_scores = article.sentences.map(&:word_scores).flatten
      delete_list, remain_list = word_scores.partition{|w| w.score == 0}
      if remain_list.size > 5
        word_score_groups = remain_list.group_by(&:word)
      else
        word_score_groups = word_scores.group_by(&:word)
      end
      delete_list = [] if delete_list.blank?
      word_score_groups.each do |word, word_scores|
        word_scores[0].update!(score: word_scores.sum(&:score))
        delete_list << word_scores[1..word_scores.size]
      end
      delete_list.flatten!
      delete_list.compact!
      delete_list.each do |w|
        puts "delete id: " + w.id.to_s + " word:" + w.word.to_s + " score:" + w.score.to_s
      end
      if delete_list.present?
        delete_list.flatten.compact.each_slice(1000) do |dl|
          WordScore.delete_all(id: dl.map(&:id))
        end
      end
    end
  end

  task :compact_phrase_relation => :environment do
    PhraseRelation.find_each do |pr|
      prs = PhraseRelation.where(source_id: pr.source_id, source_type: pr.source_type, morpheme_id: pr.morpheme_id, dependency_id: pr.dependency_id)
      prs = prs.where.not(id: pr.id)
      prs.delete_all
    end
  end

  task :compact_companysource_relation => :environment do
    CompanySourceRelation.where(source_type: "Sentence").delete_all
  end
end