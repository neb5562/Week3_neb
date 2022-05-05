class CsvRunner
  EXTENSION = '.csv'.freeze
  FILE_NAME = 'data'.freeze
  SEPARATOR = '_'.freeze

  def initialize;end

  def self.load_from_file(file)
    data = []

    CSV.foreach(file) do |row|
      data << row.first
    end
    obj = Node.new(false)
    data.map{ |item| obj.add(item) }

    obj
  end

  def self.save_to_file(data)
    CSV.open(file_name(data), "w") do |csv|
      data.each do |word|
        csv << [word]
      end
    end
    puts "\e[32mdata saved in #{Dir.pwd}/#{file_name(data)}\e[0m"
  end

  private

  def self.file_name(data)
    data.object_id.to_s + SEPARATOR + FILE_NAME + EXTENSION
  end

end
