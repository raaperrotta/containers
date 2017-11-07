classdef list < handle
    
    properties (SetAccess=private)
        len = 0
    end
    
    properties (SetAccess=private, Hidden)
        head = listelement.empty()
    end
    
    methods
        
        function self = list(array)
            if nargin < 1
                array = [];
            end
            assert(sum(size(array)>1) <= 1, 'Can only create list from 1D data.')
            if iscell(array)
                cellfun(@(x) self.append(x), array)
            else
                arrayfun(@(x) self.append(x), array)
            end
        end
        
        function append(self, x)
            new = listelement(x);
            if isempty(self.head)
                self.head = new;
            else
                tail = subsref(self, substruct('()', {length(self)}));
                new.insertAfter(tail)
            end
            self.len = self.len + 1;
        end
        
        function out = pop(self, index)
            if nargin < 2
                index = length(self);
            end
            out = self.head;
            for ii = 2:index
                out = out.next;
            end
            self.len = self.len - 1;
            out = out.pop();
        end
        
        function len = length(self)
            len = self.len;
        end
        
        function out = isempty(self)
            out = self.len == 0;
        end
        
        function varargout = subsref(self, index)
            if any(strcmp(index(1).type, {'()', '{}'})) && isscalar(index(1).subs)
                assert(index(1).subs{1} >= 1, 'list index must be a positive number')
                assert(index(1).subs{1} <= length(self), 'index out of range')
                out = self.head;
                for ii = 2:index(1).subs{1}
                    out = out.next;
                end
                if strcmp(index(1).type, '{}')
                    out = out.data;
                end
                if length(index) > 1
                    varargout = {subsref(out, index(2:end))};
                else
                    varargout = {out};
                end
            elseif nargout
                varargout = {builtin('subsref', self, index)};
            else
                builtin('subsref', self, index)
            end
        end
        
        function self = subsasgn(self, index, value)
            element = subsref(self, index);
            element.data = value;
        end
        
        function out = items(self)
            out = cell(length(self), 1);
            if ~isempty(self)
                element = self.head;
                out{1} = element.data;
                for ii = 2:length(self)
                    element = element.next;
                    out{ii} = element.data;
                end
            end
        end
        
    end
    
    methods (Hidden)
        
        function disp(self)
            fprintf('  <a href="matlab:help list">list</a> with %d elements\n', length(self))
            disp(self.items())
        end
        
    end
    
end
