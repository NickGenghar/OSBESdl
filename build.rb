puts "Initialising..."
require 'rubygems'
require 'archive/zip'
require 'dir'
require 'fileutils'
require 'tempfile'
require 'git'

def ZipDir(directory, zipfile_name)
  Zip::ZipFile.open(zipfile_name, Zip::ZipFile::CREATE) do |zipfile|
      Dir[File.join(directory+"/**/*")].each do |file|
        zipfile.add(file.sub(directory[1..-1], ''), file)
      end
  end
end
def createDir(dir)
  Dir.mkdir(dir) unless File.exists?(dir)
  FileUtils.rm_rf Dir.glob("#{dir}/*")
end

def replaceInFile(filename, originalstring, newstring)
  # save the content of the file
  file = File.read(filename)
  # replace (globally) the search string with the new string
  new_content = file.gsub(originalstring, newstring)
  # open the file again and write the new content to it
  File.open(filename, 'w') { |line| line.puts new_content }
end

def makePage(id)
  createDir("siteBuild/"+id)
  FileUtils.copy_entry("siteBuild/index.html", "siteBuild/"+id+"/index.html")
end

puts "Checking for pack base update..."
system("git submodule update --init --recursive")
if ARGV[0]!="--no-pack"
  puts "Creating directories..."
  createDir("packBuild")
  createDir("BUILD")
  createDir("BUILD/packs")
  
  puts "\nCopying pack base... (This takes a while)"
  FileUtils.copy_entry("packBase/", "packBuild/pack")
  
  puts "Cleaning up pack base..."
  FileUtils.rm("packBuild/pack/.git")
  begin
    FileUtils.rm("packBuild/pack/.gitignore ")
  rescue
    0
  end
  FileUtils.rm("packBuild/pack/LICENSE")
  FileUtils.rm("packBuild/pack/README.md")
  
  # from the right
  # 1 - dark mode
  # 2 - compatability mode
  # 3 - experimental features

  $exportMode='r' # Release mode
  puts "Building normal dark nether pack..."
  load("buildScripts/00.rb")
  
  puts "Building normal light nether pack..."
  load("buildScripts/01.rb")
  
  puts "Building compatable light nether pack..."
  load("buildScripts/11.rb")

  puts "Building compatable dark nether pack..."
  load("buildScripts/10.rb")
  
  puts "Cleaning up..."
  FileUtils.rm_rf("packBuild/pack")
  
  puts "\nCloning experimental pack... (This takes a while)"
  Git.clone('https://github.com/jebbyk/OSBES-minecraft-bedrock-edition-shader', 'packBuild/pack')

  $exportMode='e' # Experimental mode
  puts "Building normal dark nether experimental pack..."
  load("buildScripts/00.rb")
  
  puts "Building normal light nether experimental pack..."
  load("buildScripts/01.rb")
  
  puts "Building compatable light nether experimental pack..."
  load("buildScripts/11.rb")
  
  puts "Building compatable dark nether experimental pack..."
  load("buildScripts/10.rb")
  
  puts "Cleaning up..."
  FileUtils.rm_rf("packBuild/pack")
  FileUtils.copy_entry("packBuild/", "BUILD/packs")
  FileUtils.rm_rf("packBuild")
end
puts "\nCopying site base..."
FileUtils.copy_entry("siteBase/", "BUILD")
puts "\ndone."