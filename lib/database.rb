class Database
  def self.store(data)
    @@database = []
    @@database << data
  end

  def self.return(data)
    data
  end
end