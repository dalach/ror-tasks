require 'bundler/setup'
require 'rspec/expectations'
require_relative '../lib/todo_list'
require_relative '../lib/exceptions'

describe TodoList do
  def compare_lists(output_list, compare_list)
    output_list.each do |item|
      break if item != compare_list.shift
    end
    compare_list.should be_empty
  end

  subject(:list)            { TodoList.new(items) }
  let(:items)               { [] }
  let(:item_description)    { "Buy toilet paper" }

  it { should be_empty }
  
  it "return comp" do
    list.complete(0)
    list.completed_items.size.should == 1
    list.completed_items.first.to_s.should == item_description
  end
  
  it "should raise an exception when nil is passed to the constructor" do
    expect { TodoList.new(nil) }.to raise_error(IllegalArgument)
  end

  it "should have size of 0" do
    list.size.should == 0
  end

  it "should accept an item" do
    list << item_description
    list.should_not be_empty
  end

  it "should add the item to the end" do
    list << item_description
    list.last.to_s.should == item_description
  end

  it "should have the added item uncompleted" do
    list << item_description
    list.completed?(0).should be_false
  end

  context "with one item" do
    let(:items)             { [item_description] }

    it { should_not be_empty }

    it "should have size of 1" do
      list.size.should == 1
    end

    it "should have the first and the last item the same" do
      list.first.to_s.should == list.last.to_s
    end

    it "should not have the first item completed" do
      list.completed?(0).should be_false
    end

    it "should change the state of a completed item" do
      list.complete(0)
      list.completed?(0).should be_true
    end 
    
    it "should change the state of a item to uncomplited" do
      list.uncomplete(0)
      list.completed?(0).should be_false
    end 
  end

  context "with many items" do
    before:each do
      list.remove_items
      list << "Go shopping"
      list << "Feed the dog"
      list << "Clean"
      list << "Call Grandma"
      list.complete(0)
      list.complete(1)
    end

    it {should_not be_empty}

    it "returns array of completed items" do
      output_list = list.return_completed
      compare_lists(output_list, ["Go shopping", "Feed the dog"])
    end

    it "returns array of uncompleted items" do
      output_list = list.return_uncompleted
      compare_lists(output_list, ["Clean", "Call Grandma"])
    end

    it "removes all items" do
      list.remove_items
      list.should be_empty
    end

    it "removes item by value" do
      list.delete("Go shopping")
      list.first.should == "Feed the dog"
    end

    it "removes item by index" do
      list.delete_at(0)
      list.first.should == "Feed the dog"
    end

    it "removes all completed items" do
      output_list = list.remove_completed
      compare_lists(output_list, ["Clean", "Call Grandma"])
    end

    it "reverses order of two items" do  
      list[0].should == "Go shopping"
      list[2].should == "Clean"
      list.reverse(0, 2)
      list[0].should == "Clean"
      list[2].should == "Go shopping"
    end

    it "reverses order of all items" do
      output_list = list.reverse
      compare_lists(output_list, ["Call Grandma", "Clean", "Feed the dog", "Go shopping"])
    end

    it "sorts all the items" do
      output_list = list.sort
      compare_lists(output_list, ["Call Grandma", "Clean", "Feed the dog", "Go shopping"])
    end

    it "allows item describtion change" do
      list[2] = "Do the homework"
      list[2].should == "Do the homework"
    end

    it "prints the list as in the example :)" do
      printed = list.print
    end

  end

end
