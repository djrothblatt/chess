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
        subordinate.bonus(mult) + subordinate.salary * mult
      else
        subordinate.bonus(mult)
      end
    end
    bonuses.reduce(:+)
  end

  def add_employee(emp)
    @subordinates << emp unless @subordinates.include?(emp)
  end
end
