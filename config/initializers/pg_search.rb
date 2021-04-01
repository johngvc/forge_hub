PgSearch.multisearch_options = {
  using: { 
          tsearch: { 
                    prefix: true,
                    dictionary: 'english'
                    },
          trigram: {
                      word_similarity: true
                    }
         }
}