classdef listelement < handle
    
    properties
        data
    end
    
    properties (SetAccess=?list, Hidden)
        next = listelement.empty()
        prev = listelement.empty()
    end
    
    methods
        
        function self = listelement(data)
            self.data = data;
        end
        
        function bool = hasNext(self)
            bool = ~isempty(self.next);
        end
        
        function insertAfter(self, node_before)
            self.prev = node_before;
            node_before.next = self;
        end
        
        function insertBefore(self, node_before)
            self.next = node_before;
            node_before.prev = self;
        end
        
        function insertBetween(self, nodeBefore, nodeAfter)
            self.insertAfter(nodeBefore)
            self.insertBefore(nodeAfter)
        end
        
        function value = pop(self)
            if ~isempty(self.next)
                self.next.prev = self.prev;
            end
            if ~isempty(self.prev)
                self.prev.next = self.next;
            end
            value = self.data;
        end
        
    end
    
end
