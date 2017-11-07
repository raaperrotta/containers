function tests = test_dict()
tests = functiontests(localfunctions);
end

function test_generic(test)
d = dict();
test.verifyEqual(length(d), 0)
test.verifyFalse(d.isKey('hi'))

d('hi') = 'hola';
test.verifyTrue(d.isKey('hi'))
test.verifyEqual(length(d), 1)

d('twenty-one') = 21;
test.verifyEqual(length(d), 2)

d('hi') = 'ciao';
test.verifyEqual(length(d), 2)

d('hi') = [];
test.verifyFalse(d.isKey('hi'))
test.verifyEqual(length(d), 1)
end

function test_constructor(test)
keys = {'a', 'b', 'c', 'd'};
vals = {1, 2, 3, 4};
d = dict(keys, vals);
test.verifyEqual(length(d), length(keys))
for ii = 1:length(keys)
    test.verifyEqual(d(keys{ii}), vals{ii})
end
end

function test_items(test)
keys = {'a', 'b', 'c', 'd'};
vals = {1, 2, 3, 4};
d = dict(keys, vals);
unused = keys;
for iter = d.items()
    [key, val] = iter{:};
    unused = setdiff(unused, key);
    index = find(strcmp(keys, key), 1);
    test.verifyEqual(val, vals{index})
end
test.verifyTrue(isempty(unused))
end
