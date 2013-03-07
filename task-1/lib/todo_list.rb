class TodoList

  # Initialize the TodoList with +items+ (empty by default).
  def initialize(items=[])
  	@items = items
  end

  def empty?
    @items.empty?
  end

  def size
    if @items.empty?
       0 
    else
       @items.length
    end
  end
  def <<(item_description) 
    not @items.empty?
 
  end

end
