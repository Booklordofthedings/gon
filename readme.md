# Generic Object Notation (.gon)  
This is a notation that does exactly what it is supposed to do, which is to create an easy to write, read and use notation for any object.
(The idea originally came, because I didnt like JSON and wanted to create something easier to write a parser for)  
Another focus is on human writeability, so it should be easy to understand and mostly be able to be written and read by humans.



## Rules
- A gon document contains lines (kinda like key/value pairs)
- Lines are always divided by the unix linefeed "\n" (though not every linefeed indicates a new line "object")
- The lines are divided into multiple different parts, which are divided by ":"
- As a first part of a line there is always a type declaration
- The second part is either a name/key or depending on the type contains some additional information about the type, such as size
- The last one is the raw data

### Type declarations
