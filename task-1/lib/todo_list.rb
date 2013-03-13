class TodoList

  # Initialize the TodoList with +items+ (empty by default).
  def initialize(items=[])
    if items == nil
      raise IllegalArgument
    else
      @items = items
      @tasks = {}
      @items.each do |item|
        @tasks[item] = false
      end
    end
  end

  def <<(other_object)
    @items << other_object
    @tasks[other_object] = false
  end

  def size
    @items.size
  end

  def empty?
    @items.empty?
  end

  def last
    @items.last
  end

  def first
    @items.first
  end

  def complete(index)
    @tasks[@items[index]] = true
  end

  def completed?(object)
    true if @tasks[@items[object]] == true
  end
  
  def uncomplete(index)
    @tasks[@items[index]] = false
  end
end