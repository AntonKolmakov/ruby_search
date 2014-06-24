# search_spec.rb

require './search'

describe Index do
  describe "#where" do

    before do
      @persons = load_persons_array(10)
    end

    it "returns the correct size of records" do
      society = Index.new(@persons)
      records = society.where(age: 1..3, salary: 1..10, height: 1..3)
      expect(records.size).to eq(3)
    end
  end
end