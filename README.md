# Containers: Python-like data structures for MATLAB

These MATLAB classes define handle-based data structures that behave similarly to their python counterparts.

### list
Implements linked lists, which are convenient when building arrays of unknown size and
have simple methods for inserting and extracting values from the middle or ends of the array.
Currently, building a list is much slower than building an array or cell-array.

```
>> x = list()
x = 
  list with 0 elements
>> for word = strsplit('The quick brown fox jumped over the lazy dog')
    x.append(word{1})
end
>> x
x = 
  list with 9 elements
    'The'
    'quick'
    'brown'
    'fox'
    'jumped'
    'over'
    'the'
    'lazy'
    'dog'
>> x(2)
ans = 
  listelement with properties:

    data: 'quick'
>> x{2}
ans =
quick
>> x.pop()
ans =
dog
>> x
x = 
  list with 8 elements
    'The'
    'quick'
    'brown'
    'fox'
    'jumped'
    'over'
    'the'
    'lazy'
>> x.append('cat')
>> x
x = 
  list with 9 elements
    'The'
    'quick'
    'brown'
    'fox'
    'jumped'
    'over'
    'the'
    'lazy'
    'cat'
>> x.pop(1)
ans =
The
>> x.insert('A', 1)
>> x
x = 
  list with 9 elements
    'A'
    'quick'
    'brown'
    'fox'
    'jumped'
    'over'
    'the'
    'lazy'
    'cat'
>> x.pop(4)
ans =
fox
>> x.insert('mouse', 4)
>> x
x = 
  list with 9 elements
    'A'
    'quick'
    'brown'
    'mouse'
    'jumped'
    'over'
    'the'
    'lazy'
    'cat'
>> x.items()
ans = 
    'A'
    'quick'
    'brown'
    'mouse'
    'jumped'
    'over'
    'the'
    'lazy'
    'cat'
```

### uniquelist
Implements functionality similar to a `set` in python.
Elements are guarenteed unique (as determined by `isequal`).

```
>> s = uniquelist({'rain', 'rain', 'go', 'away'})
s = 
  uniquelist with 3 elements
    'rain'
    'go'
    'away'
>> s(2)
ans =
go
>> s.add('go'), s
s = 
  uniquelist with 3 elements
    'rain'
    'go'
    'away'
>> s.add('please'), s
s = 
  uniquelist with 4 elements
    'rain'
    'go'
    'away'
    'please'
>> s.contains('go')
ans =
     1
>> s.contains('sun')
ans =
     0
>> s.remove('please'), s
ans =
please
s = 
  uniquelist with 3 elements
    'rain'
    'go'
    'away'
>> s.items()
ans = 
    'rain'
    'go'
    'away'
```

### dict
This class adds a thin wrapper around MATLAB's `containers.Map` class with string valued keys and any value types.

```
>> d = dict()
d = 
  dict Object with 0 key-value pairs
>> d('hello') = 'hola'
d = 
  dict Object with 1 key-value pair
    'hello'    'hola'
>> d('goodbye') = 'adios'
d = 
  dict Object with 2 key-value pairs
    'goodbye'    'adios'
    'hello'      'hola' 
>> d('hello') = 'ciao'
d = 
  dict Object with 2 key-value pairs
    'goodbye'    'adios'
    'hello'      'ciao' 
>> d.items()
ans = 
    'goodbye'    'hello'
    'adios'      'ciao' 
>> d('goodbye') = []
d = 
  dict Object with 1 key-value pair
    'hello'    'ciao'
>> d('hello')
ans =
ciao
```

### defaultdict
Extends `dict` by assigning a default value when a key is accessed that is not already in the dictionary.

```
>> d = defaultdict(@nan)
d = 
  defaultdict Object with 0 key-value pairs
  default: nan
>> d('hello')
ans =
   NaN
>> d
d = 
  defaultdict Object with 1 key-value pair
  default: nan
    'hello'    [NaN]
>> d('hello') = 'ciao'
d = 
  defaultdict Object with 1 key-value pair
  default: nan
    'hello'    'ciao'
```

### nesteddict
Extends `defaultdict` by allowing multi-layer indexing.

```
>> n = nesteddict()
n = 
  nesteddict Object with 0 key-value pairs
>> n('lastname', 'firstname') = 12345678
n = 
  nesteddict Object with 1 key-value pair
    'lastname'    [1x1 nesteddict]
>> n('lastname')
ans = 
  nesteddict Object with 1 key-value pair
    'firstname'    [12345678]
>> n('lastname', 'firstname')
ans =
    12345678
>> n('a', 'b', 'c', 'd', 'e')
ans = 
  nesteddict Object with 0 key-value pairs
>> n
n = 
  nesteddict Object with 2 key-value pairs
    'a'           [1x1 nesteddict]
    'lastname'    [1x1 nesteddict]
```
