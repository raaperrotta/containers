classdef uniquelist < handle
    
    properties (SetAccess=private, Hidden)
        data
    end
    
    methods
        
        function self = uniquelist(array)
            if nargin < 1
                array = [];
            end
            self.data = list();
            assert(sum(size(array)>1) <= 1, 'Can only create set from 1D data.')
            if iscell(array)
                cellfun(@(x) self.add(x), array)
            else
                arrayfun(@(x) self.add(x), array)
            end
        end
        
        function add(self, x)
            if ~self.data.contains(x)
                self.data.append(x)
            end
        end
        
        function remove(self, x)
            ind = self.data.index(x);
            self.data.pop(ind)
        end
        
        function len = length(self)
            len = length(self.data);
        end
        
        function out = isempty(self)
            out = isempty(self.data);
        end
        
        function bool = contains(self, x)
            bool = self.data.contains(x);
        end
        
        function varargout = subsref(self, index)
            if strcmp(index(1).type, '()')
                sub = self.data{index(1).subs{:}};
                if length(index) > 1
                    varargout = {subsref(sub, index(2:end))};
                else
                    varargout = {sub};
                end
            else
                if nargout
                    varargout = {builtin('subsref', self, index)};
                else
                    builtin('subsref', self, index)
                end
            end
        end
        
        function out = items(self)
            out = self.data.items();
        end
        
    end
    
    methods (Hidden)
        
        function disp(self)
            if length(self) == 1
                plural = '';
            else
                plural = 's';
            end
            fprintf('  <a href="matlab:help uniquelist">uniquelist</a> with %d element%s\n', length(self), plural)
            disp(self.items())
        end
        
    end
    
end
