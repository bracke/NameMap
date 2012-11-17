with RASCAL.Utility;               use RASCAL.Utility;
with RASCAL.FileInternal;          use RASCAL.FileInternal;
with RASCAL.FileExternal;          use RASCAL.FileExternal;

with Ada.Strings.Unbounded;        use Ada.Strings.Unbounded;
with Ada.Strings;                  use Ada.Strings;
with Ada.Strings.Maps;             use Ada.Strings.Maps;
with Ada.Command_Line;             use Ada.Command_Line;
with Reporter;
with Ada.Text_IO;

procedure NameMapper is

   --

   package Utility      renames RASCAL.Utility;
   package FileInternal renames RASCAL.FileInternal;
   package FileExternal renames RASCAL.FileExternal;

   --

   procedure Main is

      Source      : String := Argument(1);
      Library     : String := Argument(2);
      Target      : String := Source & ".adc.gnat";
      Name        : Unbounded_string;
      Name2       : Unbounded_String;
      Start       : integer            := 0;
      Stop        : integer            := 0;
      Translated,adsfiles,adbfiles : Unbounded_String;
   begin
      if not Exists(Source & ".adc") then
         Create_Directory(Source & ".adc");
      end if;

      if Exists(Source & ".ads") then
         Append(adsfiles,"," & Get_FileNames(Source & ".ads") & ",");
      end if;
      if Exists(Library & ".ads") then
         Append(adsfiles,Get_FileNames(Library & ".ads") & ",");
      end if;

      if Exists(Source & ".adb") then
         Append(adbfiles,"," & Get_FileNames(Source & ".adb") & ",");
      end if;
      if Exists(Library & ".adb") then
         Append(adbfiles,Get_FileNames(Library & ".adb") & ",");
      end if;

      declare
         File     : FileHandle_Type(new UString'(U(Target)),Write);
      begin
         -- ADS files
         Name := adsfiles;
         
         if Length(Name) > 2 then
         
            Find_Token(Name,To_Set(','), Outside, start, stop);
            Name2 := U(Ada.Strings.Unbounded.Slice(Name,start,stop));
         
            while Length(Name2) > 0 loop
         
               if Length(Name2) > 10 then
                  Translated := Translate(Name2,To_Mapping("-","."));
                  Put_String(File,"pragma Source_File_Name (");
                  Put_String(File,"UNIT_NAME => " & S(Translated) & ",");
                  Put_String(File,"SPEC_FILE_NAME => " &
                                  '"' & S(Name2) & ".ads" & '"' & ");");
         
               end if;
         
               Delete(Name,start,stop);
               Name := Trim(Name,both);
                        
               Find_Token(Name,To_Set(','), Outside, start, stop);
               Name2 := U(Ada.Strings.Unbounded.Slice(Name,start,stop));
            end loop;
         end if;

         -- ADB files
         Name := adbfiles;
         
         if Length(Name) > 2 then
         
            Find_Token(Name,To_Set(','), Outside, start, stop);
            Name2 := U(Ada.Strings.Unbounded.Slice(Name,start,stop));
         
            while Length(Name2) > 0 loop
               if Length(Name2) > 10 then           
                  Translated := Translate(Name2,To_Mapping("-","."));
                  Put_String(File,"pragma Source_File_Name (");
                  Put_String(File,"UNIT_NAME => " & S(Translated) & ",");
                  Put_String(File,"BODY_FILE_NAME => " &
                                  '"' & S(Name2) & ".adb" & '"' & ");");
           
                  Ada.Text_IO.Put_Line(S(Name2));
               end if;
         
               Delete(Name,start,stop);
               Name := Trim(Name,both);
                        
               Find_Token(Name,To_Set(','), Outside, start, stop);
               Name2 := U(Ada.Strings.Unbounded.Slice(Name,start,stop));
            end loop;
         end if;
         Close(File);
         Set_FileType(Target,16#FFF#);
      end;
   end Main;
begin
   if Argument_Count in 1..2 then
      Main;
   else
      Ada.Text_IO.Put_Line ("**** Wrong number of arguments (1..2) ****");
      Ada.Text_IO.Put_Line ("Use : NameMapper <directory> [<Library>]");
      Ada.Text_IO.New_Line;
   end if;
end NameMapper;