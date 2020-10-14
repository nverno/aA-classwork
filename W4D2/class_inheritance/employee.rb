class Employee
    attr_reader :name, :salary, :title, :boss, :bonus
    def initialize(name, salary, title, boss)
        @name = name
        @salary = salary
        @title = title
        @boss = boss
        @bonus = 0
    end

    def add_boss(boss)
        @boss = boss
    end

    def bonus(multiplier)
        @bonus = @salary * multiplier
    end
end

class Manager < Employee
    attr_reader :employees
    def initialize(name, salary, title, boss, employees=[])
        super(name, salary, title, boss)
        @employees = employees
    end

    def add_subordinate(employee)
        @employees << employee
        employee.add_boss(self)
    end

    def bonus(multiplier)
        sum = 0
        queue = [self]
        until queue.empty?
            curr_emp = queue.shift
            sum += curr_emp.salary unless curr_emp == self
            if curr_emp.is_a?(Manager)
                curr_emp.employees.each do |employee|
                    queue << employee
                end 
            end
        end
        sum * multiplier
    end
end


ned = Manager.new("Ned", 1_000_000, "Founder", nil)
darren = Manager.new("Darren", 78_000, "TA Manager", ned)
shawna = Employee.new("Shawna", 12_000, "TA", darren)
david = Employee.new("David", 10_000, "TA", darren)

ned.add_subordinate(darren)
darren.add_subordinate(shawna)
darren.add_subordinate(david)

p ned.bonus(5) # => 500_000
p darren.bonus(4) # => 88_000
p david.bonus(3) # => 30_000
