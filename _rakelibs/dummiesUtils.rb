corpusFile = "#{__dir__}/dictionaries/corpus.txt"
$corpus = File.readlines(corpusFile).map {|i| i.chomp}

def get_dummy_title( length = 5 )
  $corpus.sample(length).join(' ').capitalize
end

def get_categories_pool(collectionName)
  categoriesForCollection = $kbCategoriesDatas[collectionName]
  categories = categoriesForCollection.sample($numberOfCategories)
  d1("++++++++++ categories poll #{$numberOfCategories} : #{categories}")
  categories
end

def get_tags_pool(numberOfTags = $numberOfTags)
  tags = $corpus.sample(numberOfTags)
  tags.each {|tag| tag.to_s}
  d2("++++++++++ tags poll #{numberOfTags} : #{tags}")
  tags
end

def get_tags()
  prng = Random.new
  tagsArray = $tagsPool.sample(prng.rand($minTagsPerItem...$maxTagsPerItem))
  d1("assigned TAGS : #{tagsArray.join(", ")}")
  tagsArray
end

def get_categories()
  prng = Random.new
  catsArray = $tagsPool.sample(prng.rand($minTagsPerItem...$maxTagsPerItem))
  d1("assigned TAGS : #{tagsArray.join(", ")}")
  tagsArray
end

def get_content( paraNumber = 3, paraLength = 20)
  prng = Random.new
  content = prng.rand(2...paraNumber).times.map do |c|
    $corpus.sample(prng.rand(2...paraLength)).join(' ').capitalize
  end.join(".\n\n")
  # get all space chr occurence in current content
  i = -1
  all = []
  while i = content.index(' ',i+1)
    all << i
  end
  # insert tags in content
  $tags.each {|tag|
    pos = all.sample()
    content.insert(pos, " #{tag}")
  }
  content
end

# > time_rand
# => 1977-11-02 04:42:02 0100
# > time_rand Time.local(2010, 1, 1)
# => 2010-07-17 00:22:42 0200
# > time_rand Time.local(2010, 1, 1), Time.local(2010, 7, 1)
# => 2010-06-28 06:44:27 0200
def time_rand from = 0.0, to = Time.now
  Time.at(from + rand * (to.to_f - from.to_f))
end

def create_file(filename, front, content = "<h1>Toto</h1>")
  d2( "Creating new file: #{filename}" )

  open(filename, 'w') do |f|
    f.puts "---"
    front.each{ |key,value| f.puts "#{key}: #{value}" }
    f.puts "---"
    f.puts ""
    f.puts content
  end
end

