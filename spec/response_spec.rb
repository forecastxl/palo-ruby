require 'spec_helper'

describe "Response" do
  # Mock Response since it is a module
  let(:response_class) { Class.new { include Palo::Response } }
  let(:response) { response_class.new }



  context "when splitting result into lines" do
    let(:databases_results) { "1;\"BedrijfX\";31;32;1;0;1377002785;\n2;\"BedrijfY\";31;32;1;0;253233241;\n" }
   

    it "returns an array" do
      result = response.send(:split_lines, databases_results)
      expect(result).to be_an(Array)
    end

    it "ignores the last line end in the result while splitting" do
      result = response.send(:split_lines, databases_results)
      expect(result.count).to eq(2)
    end
  end

  context "when splitting line into columns" do
    let(:database_line) { "1;\"BedrijfX\";31;32;1;0;1377002785;" }

    it "returns an array" do
      result = response.send(:split_columns, database_line)
      expect(result).to be_an(Array)
    end

    xit "ignores the last column seperator in a line" do
      result = response.send(:split_columns, database_line)
      expect(result.count).to eq(7)
    end
  end

  context "when trimming extra quotes from strings" do
    let(:quoted_string) { "\"BedrijfX\"" }

    it "trims from the start" do
      result = response.send(:trim_extra_quotes, quoted_string)
      expect(result).not_to start_with("\"")
    end

    it "trims from the end" do
      result = response.send(:trim_extra_quotes, quoted_string)
      expect(result).not_to end_with("\"")
    end

    it "trims hash elements" do
      quoted_string_hash = { 'name' => quoted_string }
      result = response.send(:trim_quotes, quoted_string_hash, 'name')
      expect(result['name']).not_to start_with("\"")
    end

    it "trims multiple hash elements" do
      quoted_string_hash = { 'name' => quoted_string, 'database' => quoted_string }
      result = response.send(:trim_quotes, quoted_string_hash, 'name')
      #TODO: uitvinden of dit nou echt heel slecht is, meerdere expects
      expect(result['name']).not_to start_with("\"")
      expect(result['name']).not_to end_with("\"")
      expect(result['database']).not_to start_with("\"")
      expect(result['database']).not_to end_with("\"")
    end
  end
end