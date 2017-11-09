classdef nesteddict < defaultdict
    
    methods
        
        function self = nesteddict(default)
            if nargin < 1
                default = @nesteddict;
            end
            self@defaultdict(default)
        end
        
        function sub = subsref(self, index)
            % For multiple indices, access subsequent levels
            if strcmp(index(1).type, '()') && ~isscalar(index(1).subs) && ...
                    all(cellfun(@(s)ischar(s), index(1).subs))
                sub = self;
                for ref = index(1).subs
                    sub = sub.subsref(substruct('()', ref));
                end
                if length(index) > 1
                    sub = self.subsref(index(2:end));
                end
            else
                sub = self.subsref@defaultdict(index);
            end
        end
        
        function self = subsasgn(self, index, value)
            if strcmp(index(1).type, '()') && ~isscalar(index(1).subs) && ...
                    all(cellfun(@(s)ischar(s), index(1).subs))
                sub = self;
                for ref = index(1).subs(1:end-1)
                    % This is recursive if sub is another nesteddict
                    sub = subsref(sub, substruct('()', ref));
                end
                sub = subsasgn(sub, substruct('()', index(1).subs(end)), value); %#ok<NASGU> It's a handle so the value is preserved.
            else
                self = subsasgn@defaultdict(self, index, value);
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
            fprintf('  nesteddict Object with %d key-value pair%s\n', length(self), plural)
            disp(self.items()')
        end
        
    end
    
end