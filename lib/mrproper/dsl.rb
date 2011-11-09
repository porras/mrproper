module MrProper
  
  class DSL
    
    attr_reader :properties, :data_blocks
    
    def initialize
      @properties = []
      @data_blocks = []
    end
    
    def data(spec = nil, &block)
      @data_blocks << DataBlock.new(spec, &block)
    end
    
    def property(message, &block)
      @properties << [message, block]
    end
    
  end
  
end