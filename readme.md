# Generic Object Notation (.gon)  
This is a notation that does exactly what it is supposed to do, which is to create an easy to write, read and use notation for any object.
(The idea originally came, because I didnt like JSON and wanted to create something easier to write a parser for)  
Another focus is on human writeability, so it should be easy to understand and mostly be able to be written and read by humans.

## Supported languages
[Beeflang](https://github.com/Booklordofthedings/gon/tree/main/Beef)  
more coming ... probably

## Example
```
//This is a comment and wont be parsed
n:number:213.2
b:booleans:true
s:string:lmao
t:text:3
this allows for
multiple lines
of text
rgb:bg_color:255,255,255

d:rawData:3
0d8scd8as
dsa9dc
976sd
o:object
O:object
```


## Rules
```
[type]:[name]:[value] is the format of a line of gon
```

there are 6(7) default types of gon lines:

- Single line Strings
- Numbers
- Booleans
- Multiline Strings
- Objects
- Customs
- Lines of data

Each of them have a 1 character type indicator.  
If the format is correct, but the type doesnt fit to any of the indicators its treated as a custom of the given type.  

There is no single key rule, so the same name may be used multiple times.


Objects start with a lowercase o and end with a uppercase O with the same name parameter.  
Also they dont need a value paramter.

The two multiline entries need an int as a value paramter which indicates how many of the next n lines are part of the multiline object.
