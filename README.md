# NameMapper
NameMapper scans a directory for ada sourcefiles (both body and specifications) and creates the file gnat.adc containing a pragma Source_File_Name for every file with a name longer than 10 characters. NameMap does not search all files for compilation units, it simply assumes that the package name and the filename are identical.

Why is that useful ? Well, the current RISCOS port of GNAT (The GNU Ada translator) can only handle filenames up to 10 characters long. Supplying the file with those pragma statements gets arround that limitation and namemap will do the tedious work of creating those files. This can save a lot of time when porting large aplications.

NOTE: This is a RISC OS app and will not work on other platforms.

## Frontend use
 
### Setup window

 Icon |             Action/Meaning   |                  Default
 ---- |             --------------   |                  -------
 Source |           This is the path of source dir  (mandatory, typed or dragged) |      nil
 Library    |       This is the path to a library -  can be empty. |

### Setup Menu

 Entry     |        Action/Meaning         |            Default
 -----     |        --------------          |           -------
 Command line |  any other options can be entered. (See the manual for full details.) |  auto
                   

### Display (NameMapper) Window
This window is opened automatically and displays any output.