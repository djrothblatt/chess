require 'byebug'
class Employee
  attr_reader :name, :title, :salary, :boss

  def initialize(name, title, salary, boss = nil)
    @name = name
    @title = title
    @salary = salary
    @boss = boss
    boss.add_employee(self) if boss
  end

  def bonus(mult)
    salary * mult
  end
end

class Manager < Employee
  attr_reader :subordinates

  def initialize(name, title, salary, boss = nil)
    super
    @subordinates = []
  end

  def bonus(mult)
    bonuses = subordinates.map do |subordinate|
      if subordinate.is_a?(Manager)
        subordinate.bonus(1) + subordinate.salary
      else
        subordinate.salary
      end
    end
    bonuses.reduce(:+) * mult
  end

  def add_employee(emp)
    @subordinates << emp unless @subordinates.include?(emp)
  end
end

if __FILE__ == $PROGRAM_NAME
  ned = Manager.new('Ned', 'Founder', 1_000_000)
  darren = Manager.new('Darren', 'TA Manager', 78_000, ned)
  david = Employee.new('David', 'TA', 10_000, darren)
  shawna = Employee.new('Shawna', 'TA', 12_000, darren)
  # debugger
  puts ned.bonus(5)
  puts darren.bonus(4)
  puts david.bonus(3)
end
