#!/usr/local/bin/ruby
require 'benchmark'

class Index

  def initialize(records)
    @all_records = records
  end

  def where(conditions = {})
    @y = []
    search_simple conditions 
    @x
  end

  private

  def search_simple(conditions)
    @x = []
    @y += @all_records
    conditions.each do |field, search_value|
      search_values_hash = search_value.inject({}) { |memo, i| memo[i] = true; memo }
      @y.select! { |object| search_values_hash.has_key? object.send(field) }
      @x += @y
    end
  end
end


Person = Struct.new(:age, :salary, :height, :weight)

def load_persons_array(n)
  persons = Array.new(n)

  (0...n).each do |i|
    persons[i] = Person.new( i % 100, i % 1000000.0, i % 200, i % 200 )
  end

  persons
end

n = 10000000
persons = load_persons_array(n)
society = Index.new(persons)

puts "Database consists of #{n} elements"

puts "\nsearching..."
records = nil
puts Benchmark.measure {
  records = society.where(age: 1..30, salary: 1..100)
}
puts "\n#{records.size} records were found!"