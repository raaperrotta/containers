classdef defaultdict < dict
    
    properties (SetAccess = private)
        default
    end
    
    methods
        
        function self = defaultdict(default_generator)
            assert(isa(default_generator, 'function_handle'))
            self.default = default_generator;
        end
        
        function sub = subsref(self, index)
            % On access of new key, assign default value
            if strcmp(index(1).type, '()') && isscalar(index(1).subs) && ...
                    ischar(index(1).subs{1}) && ~self.isKey(index(1).subs{1})
                self.subsasgn(index(1), self.default());
            end
            sub = self.subsref@dict(index);
        end
        
        function new = copy(self)
            new = defaultdict(self.default);
            for iter = self.items()
                [key, val] = iter{:};
                new(key) = val;
            end
        end
        
    end
    
    methods (Hidden)
        
        function disp(self)
            if length(self) == 1
                plural = '';
            else
                plural = 's';
            end
            fprintf('  defaultdict Object with %d key-value pair%s\n', length(self), plural)
            fprintf('  default: %s\n', func2str(self.default))
            disp(self.items()')
        end
        
    end
    
end