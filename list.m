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
            if index == 1
                self.head = self.head.next;
            end
            for ii = 2:index
                out = out.next;
            end
            self.len = self.len - 1;
            out = out.pop();
        end
        
        function insert(self, x, index)
            new = listelement(x);
            if index == 1
                new.insertBefore(self.head)
                self.head = new;
            else
                node = subsref(self, substruct('()', {index}));
                new.insertBetween(node, node.next)
            end
            self.len = self.len + 1;
        end
        
        function len = length(self)
            len = self.len;
        end
        
        function out = isempty(self)
            out = self.len == 0;
        end
        
        function bool = contains(self, value)
            if isempty(self)
                bool = false;
                return
            end
            bool = true;
            node = self.head;
            while true
                if isequal(node.data, value)
                    return
                elseif node.hasNext()
                    node = node.next;
                else
                    break
                end
            end
            bool = false;
        end
        
        function ind = index(self, value)
            ind = 1;
            node = self.head;
            if isequal(node.data, value)
                return
            end
            while node.hasNext()
                node = node.next;
                ind = ind + 1;
                if isequal(node.data, value)
                    return
                end
            end
            error('list:index', 'Value not found in list.')
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
        
        function out = sorted(self)
            % Only works when all elements have string values
            out = sort(self.items());
        end
        
    end
    
    methods (Hidden)
        
        function disp(self)
            fprintf('  <a href="matlab:help list">list</a> with %d elements\n', length(self))
            disp(self.items())
        end
        
    end
    
end
