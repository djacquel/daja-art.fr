module Jekyll
  class SampleGenerator < Generator
    def generate(site)
      puts "Firing SampleGenerator : " + File.basename(__FILE__)
    end
  end
end