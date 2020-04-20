require_relative "connection.rb"
require_relative "../model/task.rb"
class Task_controler 
    $connection = Conection.new()

    def show
        tasks = []
        c =$connection.connectionDatabase("Select * from tasks")
        c.each  {
            |row|
            if row["state"] != 1 
                state = "Complete"
            else
                state = "Pending"
            end 
            tasks<< Task.new(row["idtask"] ,row["name"] ,state)
        }
        return tasks
    end

    def update(task)  
        c =$connection.connectionDatabase("UPDATE tasks SET name='#{task.task}' WHERE idtask ='#{task.id}'")
    end

    def delete(id)
        c=$connection.connectionDatabase("DELETE FROM tasks WHERE idtask ='#{id}'")
    end
    def create(task)
        c =$connection.connectionDatabase("INSERT INTO tasks(name,state) VALUES ('#{task}',true)")
    end
    def found(string)
        c =$connection.connectionDatabase("SELECT * FROM tasks where name like '#{string}%'")
        c.each  {
            |row|
            if row["state"] != 1 
                state = "Complete"
            else
                state = "Pending"
            end 
            puts "#{row["idtask"]} #{row["name"]} #{state}" 
        }
    end
    def complete(id)
        c =$connection.connectionDatabase("UPDATE tasks SET state='0' WHERE idtask ='#{id}'")
    end

end
item = Task_controler.new()
item.show()