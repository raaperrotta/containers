classdef dict < handle & containers.Map
    
    methods
        
        function self = dict(keys, vals)
            if nargin
                args = {keys, vals, 'UniformValues', false};
            else
                args = {};
            end
            self = self@containers.Map(args{:});
        end
        
        function self = subsasgn(self, index, value)
            if isscalar(index) && strcmp(index.type, '()') && ...
                    isscalar(index.subs) && ...
                    isempty(value) && isequal(value, [])
                self.remove(index.subs{1});
            else
                self = self.subsasgn@containers.Map(index, value);
            end
        end
        
        function data = items(self)
            % To support looping over key-value pairs
            %   for i1 = my_dict.items()
            %      [key, val] = i1{:};
            %      ...
            %  end
            data = [self.keys(); self.values()];
        end
        
        function new = copy(self)
            new = dict(self.keys(), self.values());
        end
        
    end
    
    methods (Hidden)
        
        function disp(self)
            if length(self) == 1
                plural = '';
            else
                plural = 's';
            end
            fprintf('  dict Object with %d key-value pair%s\n', length(self), plural)
            disp(self.items()')
        end
        
    end
    
end
