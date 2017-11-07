function tests = test_list()
tests = functiontests(localfunctions);
end

function test_generic(test)
x = list();
test.verifyTrue(isempty(list))
test.verifyEqual(length(x), 0)
end

function test_constructor(test)
data = 1:5;
x = list(data);
test.verifyEqual(length(x), 5)
for ii = 1:length(data)
    test.verifyEqual(x{ii}, data(ii))
end

data = {'a'; 'b'; 'c'; 'd'};
x = list(data);
test.verifyEqual(length(x), 4)
for ii = 1:length(data)
    test.verifyEqual(x{ii}, data{ii})
end
end
