#!/usr/local/bin/ruby
require 'benchmark'

class Index

  def initialize(records)
    @all_records = records
  end

  def where(conditions = {})
    search_the_objects conditions 
  end

  private

  def search_the_objects(conditions)
    result = []
    n = 1
    conditions.each do |field, search_value|
      case n
        when 1
          result = grip_by_condition(field, search_value, @all_records)
          n += 1
        when 2 
          result = grip_by_condition(field, search_value, result)
          n += 1
        when 3
          result = grip_by_condition(field, search_value, result)
          n += 1
        when 4
          result = grip_by_condition(field, search_value, result)
          n += 1 
      end
      result
    end
    result
  end

  def grip_by_condition(field, search_value, ary)
    ary.select do |object|
      (search_value).member?(object.send(field))
    end 
  end

end


Person = Struct.new(:age, :salary, :height, :weight)

def load_persons_array(n)
  persons = Array.new(n)

  (0..n).each do |i|
    persons[i] = Person.new( i % 100, i % 1000000.0, i % 200, i % 200 )
  end

  persons
end

n = 10_000_000
persons = load_persons_array(n)
society = Index.new(persons)

puts "Database consists of #{n} elements"

puts "\nsearching..."
records = nil
puts Benchmark.measure {
  records = society.where(age: 1..3, salary: 1..10, height: 1..3)
}
puts "\n#{records.size} records were found!"