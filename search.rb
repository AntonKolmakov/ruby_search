#!/usr/local/bin/ruby
require 'benchmark'
require 'pry'

class Index

  def initialize(records)
    @all_records = records
  end

  def where(conditions = {})
    search_simple conditions
  end

  private

  def search_simple(conditions)
    result = []
    result = @all_records.select do |object| 
      (conditions[:age]).member?(object.age) && (conditions[:salary]).member?(object.salary)
    end
  end
end


Person = Struct.new(:age, :salary, :height, :weight)

def load_persons_array(n)
  persons = Array.new(n)

  (0..n).each do |i|
    persons[i] = Person.new( i % 100, rand(i % 1000000.0), i % 200, i % 200 )
  end

  persons
end

n = 10
persons = load_persons_array(n)
society = Index.new(persons)

puts "Database consists of #{n} elements"

puts "\nsearching..."
records = nil
puts Benchmark.measure {
  records = society.where(age: 1..30, salary: 1..100)
}
puts "\n#{records.size} records were found!"