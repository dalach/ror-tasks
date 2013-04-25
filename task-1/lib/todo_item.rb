class Item
    attr_assesor :description, :completed
    def initialize(description = '')
	@description = description
	@completed = false
    end

    def to_s
	@descritpion
    end
