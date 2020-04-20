require_relative "../controlers/task_controller.rb"
require_relative "../model/task.rb"
require "readline"

def execute
    $task =  Task_controler.new()
    @help = "HELP \n
            'task add [DESCRIPTION]' to add a task\n
            'task list' to list all tasks\n
            'task complete [TASK ID]' to mark a task as complete\n
            'task update [TASK ID] [NEW TASK]' to update a task\n
            'task delete [TASK ID]' to delete a task\n
            'task found [ANY WORD]'\n
            'task help' to show available commands\n
            'task exit' to finish the program"
    while (input = Readline.readline("> ", true))
        input = input.strip
        input = input.strip.split("\s")
        commands_WithoutParameter=[:list,:help,:exit]
        
        if input[0].to_sym != :task
          puts "Did you mean 'task'?"
          puts "Type 'help' to list available commands"
          execute()
        end
    
        if !input[1].nil?
          command = input[1].strip.to_sym
        else
          puts "Type 'help' to list available commands"
          execute()
        end
        unless commands_WithoutParameter.include? (command)
            if !input[2].nil?
                body = input[2...input.length].join(" ").strip
            else
                puts "Syntax error"
                execute()
            end
        end
    
        case command
        when :add
          $task.create(body)
          
        when :list

            if !input[2].nil?
                body = input[2...input.length].join(" ").strip
                if body == "--complete"
                  $task.show().each{|value|
                      if value.active == "Complete"
                        puts "#{value.id} #{value.task} #{value.active}"
                      end
                  }
                end
            else
                $task.show().each{|value|
                    puts "#{value.id} #{value.task} #{value.active}"
                }
            end

        when :complete
          $task.complete(body)
        when :update
            body2 = body.split("\s")
            newTask=body2[1...body2.size].join("\s")
            task_element = Task.new(body2[0].to_i,newTask,nil)
            if newTask.empty?
              puts "You must provide a new task"
            else
                $task.update(task_element)
            end
          
        when :help
          puts @help
        when :delete
            $task.delete(body)
        when :found
              $task.found(body)
        when :exit
          puts "Bye"
          break
        else
          puts "Error: unexpected input"
          puts "Type 'help' if you need help"
        end
        body = nil
    end
end
execute()