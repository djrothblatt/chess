class Employee
  attr_reader :name, :title, :salary, :boss

  def initialize(name, title, salary, boss = nil)
    @name = name
    @title = title
    @salary = salary
    @boss = boss
    boss.add_employee(self)
  end

  def bonus(mult)
    salary * mult
  end
end

class Manager < Employee
  attr_accessor :subordinates

  def initialize(name, title, salary, boss)
    super
    @subordinates = []
  end

  def bonus(mult)
    subordinates.map { |el| el.bonus(mult) }.reduce(:+)
  end
end
