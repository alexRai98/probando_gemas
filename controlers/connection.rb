require "mysql2"
class Conection
    def connectionDatabase(query)
        client = Mysql2::Client.new(:host => "localhost", :username => "root",:password => "password" , :port => "3306", :database => "Task")
        results = client.query(query)
        return results
    end
end

# c = Conection.new()
# a =c.conectionDatabase("Select * from tasks")

# a.each  {
#     |row|
#     puts "#{row["idtask"]} #{row["name"]} #{row["state"]}"
# }


