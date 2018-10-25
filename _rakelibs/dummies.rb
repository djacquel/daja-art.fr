require "stringex"
require "safe_yaml/load"

def create_elements( type = 'post', numberOf = 1, clean = false, collectionName = "methods" )
  d1("## Create_elements : type=#{type} - numberOf=#{numberOf} - clean=#{clean} - collectionName=#{collectionName}")

  currentCounter     = 0
  $config            = SafeYAML::load_file($configPath)

  $kbCategoriesDatas = SafeYAML::load_file($kb_categories_file)
  $articleTypesDatas = SafeYAML::load_file($kb_type_file)

  $categoriesPool = get_categories_pool(collectionName)
  $tags     = get_tags()
  tagsAsStr = "[#{$tags.join(', ')}]"
  content   = get_content($maxParagraphNumber, $maxParagraphLength)

  case type
    when "post"
      elementsFolder = $posts_dir
      categories     = $categoriesPool
    when "page"
      elementsFolder = $pages_dir
    when "collection"
      elementsFolder  = "_#{collectionName}"
      #collectionDatas = $config["collections"][collectionName]
      categories      = $categoriesPool
      types           = $articleTypesDatas
    else
      raise "### Wrong element type. Can be 'post' or 'page'. Passed : #{type}"
  end

  # work early with absolute path
  elementsFolderFullPath = File.join($rootPath, elementsFolder)
  d2("Working in #{elementsFolderFullPath}")
  # check for path validity
  inRootPath?($rootPath, elementsFolderFullPath)

  # clean old elements ?
  if clean == true
    safe_clean_folder( elementsFolderFullPath )
  end

  d1("------------------------------------- Creating #{numberOf} #{type}")
  for i in 1..numberOf do

    d2("Creating ##{i} #{type}")

    title = get_dummy_title
    date  = time_rand Time.local(2010, 1, 1)

    fileFullPath = elementsFolderFullPath
    filename = "#{title.to_url}.#{$default_ext}"

    case type
      when "post"
        y = sprintf("%04d", date.year)
        m = sprintf("%02d", date.month)
        d = sprintf("%02d", date.day)
        filename = "#{y}-#{m}-#{d}-#{title.to_url}.#{$default_ext}"
      when "page"
        # this is default behavior
      when "collection"
        categoryFolder = categories.sample(1).first['slug']
        d1("categoryFolder = #{categoryFolder}")
        fileFullPath = "#{elementsFolderFullPath}/#{categoryFolder}"
    end

    # ensure that elementsFolderFullPath exists
    unless File.directory?(fileFullPath)
      d1("creating #{fileFullPath}")
      FileUtils.mkdir_p(fileFullPath)
    end

    filenameFullPath = "#{fileFullPath}/#{filename}"

    front = {
      'title' => "#{title.gsub(/&/,'&amp;')}",
      'date'  => "#{date.strftime('%Y-%m-%d %H:%M:%S %:z')}",
      'lang'  => $locales.sample()
    }

    case type
      when "post"
        tags = tagsAsStr
        front["tags"] = tags
        front["category"] = $categoriesPool.sample(1).first['slug']
      when "page"
        #
      when "collection"
        tags          = tagsAsStr
        front["tags"] = tags
        itemType      = types.sample(1).first
        front["type"] = itemType["slug"]
    end

    create_file(filenameFullPath, front, content)
    $elementCounter += 1
    currentCounter += 1

  end

  d1( "created #{currentCounter} item of type #{type}" )
end
