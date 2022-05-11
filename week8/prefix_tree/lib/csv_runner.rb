class CsvRunner
  EXTENSION = '.csv'.freeze
  FILE_NAME = 'data'.freeze
  SEPARATOR = '_'.freeze

  def initialize;end

  def self.load_from_file(file)
    data = []

    unless check_file(file) 
      puts "\e[31mfile #{file} does not exist\e[0m" 
      return false
    end

    CSV.foreach(file) do |row|
      data << row.first
    end
    obj = Node.new(false)
    data.map{ |item| obj.add(item) }

    obj
  end

  def self.save_to_file(data)
    file_name = file_name(data)
    unless check_file(file_name)
      puts "\e[31mfile #{file_name} does not exist, so i'm making it for you\e[0m"
    end
    csv = CSV.open(file_name, "w")
      data.each do |word|
        csv << [word]
      end
    puts "\e[32mdata saved in #{Dir.pwd}/#{file_name(data)}\e[0m"
  end

  private

  def self.check_file(file)
    File.file?(file)
  end

  def self.file_name(data)
    data.object_id.to_s + SEPARATOR + FILE_NAME + EXTENSION
  end

end
