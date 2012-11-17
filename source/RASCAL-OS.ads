--------------------------------------------------------------------------------
--                                                                            --
-- Copyright (C) 2004, RISC OS Ada Library (RASCAL) developers.               --
--                                                                            --
-- This library is free software; you can redistribute it and/or              --
-- modify it under the terms of the GNU Lesser General Public                 --
-- License as published by the Free Software Foundation; either               --
-- version 2.1 of the License, or (at your option) any later version.         --
--                                                                            --
-- This library is distributed in the hope that it will be useful,            --
-- but WITHOUT ANY WARRANTY; without even the implied warranty of             --
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU           --
-- Lesser General Public License for more details.                            --
--                                                                            --
-- You should have received a copy of the GNU Lesser General Public           --
-- License along with this library; if not, write to the Free Software        --
-- Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA    --
--                                                                            --
--------------------------------------------------------------------------------

-- @brief OS events and types. Abstract task definition.
-- $Author$
-- $Date$
-- $Revision$

with Kernel;                     use Kernel;
with System;                     use System;
with System.Unsigned_Types;      use System.Unsigned_Types;
with Ada.Unchecked_Conversion;

package RASCAL.OS is

   type OS_Coordinate is
   record
   X   : Integer;
   Y   : Integer;
   end record;
   pragma Convention (C, OS_Coordinate);

   type OS_BBox is
   record
   xmin : Integer;
   ymin : Integer;
   xmax : Integer;
   ymax : Integer;
   end record;
   pragma Convention (C, OS_BBox);   

   type Event_Type is (Wimp,Message,Toolbox);
   type Event_Listener (K : Event_Type) is abstract tagged record
   Kind : Event_Type := K;
   end record;

   type Event_Pointer is access all Event_Listener'Class;

   procedure Handle (The : in Event_Listener) is abstract;

   type Byte is mod 2**8;

   type Wimp_Handle_Type is new Integer;
   type Icon_Handle_Type is new Integer;
   
   type Reason_Event_Code_Type is new System.Unsigned_Types.Unsigned;

   Reason_Event_NullReason             : constant Reason_Event_Code_Type := 0;
   Reason_Event_RedrawWindow           : constant Reason_Event_Code_Type := 1;
   Reason_Event_OpenWindow             : constant Reason_Event_Code_Type := 2;
   Reason_Event_CloseWindow            : constant Reason_Event_Code_Type := 3;
   Reason_Event_PointerLeavingWindow   : constant Reason_Event_Code_Type := 4;
   Reason_Event_PointerEnteringWindow  : constant Reason_Event_Code_Type := 5;
   Reason_Event_MouseClick             : constant Reason_Event_Code_Type := 6;
   Reason_Event_UserDrag               : constant Reason_Event_Code_Type := 7;
   Reason_Event_KeyPressed             : constant Reason_Event_Code_Type := 8;
   Reason_Event_MenuSelection          : constant Reason_Event_Code_Type := 9;
   Reason_Event_ScrollRequest          : constant Reason_Event_Code_Type := 10;
   Reason_Event_LoseCaret              : constant Reason_Event_Code_Type := 11;
   Reason_Event_GainCaret              : constant Reason_Event_Code_Type := 12;
   Reason_Event_PollWordNonZero        : constant Reason_Event_Code_Type := 13;

   Reason_Event_UserMessage            : constant Reason_Event_Code_Type := 17;
   Reason_Event_UserMessageRecorded    : constant Reason_Event_Code_Type := 18;
   Reason_Event_UserMessageAcknowledge : constant Reason_Event_Code_Type := 19;

   Reason_Event_ToolboxEvent           : constant Reason_Event_Code_Type := 16#200#;

   type Wimp_EventListener (E : Reason_Event_Code_Type;
                            W : Wimp_Handle_Type;
                            I : Icon_Handle_Type) is abstract new Event_Listener(Wimp) with
   record
      Event_Code : Reason_Event_Code_Type := E;
      Window     : Wimp_Handle_Type  := W;
      Icon       : Icon_Handle_Type  := I;
   end record;

   type Message_Event_Code_Type is new System.Unsigned_Types.Unsigned;
   
   Message_Event_Quit                   : constant Message_Event_Code_Type := 0;
   Message_Event_DataSave               : constant Message_Event_Code_Type := 1;
   Message_Event_DataSaveAck            : constant Message_Event_Code_Type := 2;
   Message_Event_DataLoad               : constant Message_Event_Code_Type := 3;
   Message_Event_DataLoadAck            : constant Message_Event_Code_Type := 4;
   Message_Event_DataOpen               : constant Message_Event_Code_Type := 5;
   Message_Event_RAMFetch               : constant Message_Event_Code_Type := 6;
   Message_Event_RAMTransmit            : constant Message_Event_Code_Type := 7;
   
   Message_Event_PreQuit                : constant Message_Event_Code_Type := 8;
   Message_Event_PaletteChange          : constant Message_Event_Code_Type := 9;
   Message_Event_SaveDesktop            : constant Message_Event_Code_Type := 10;
   Message_Event_DeviceClaim            : constant Message_Event_Code_Type := 11;
   Message_Event_DeviceInUse            : constant Message_Event_Code_Type := 12;
   Message_Event_DataSaved              : constant Message_Event_Code_Type := 13;
   Message_Event_Shutdown               : constant Message_Event_Code_Type := 14;
   
   Message_Event_FilerOpenDir           : constant Message_Event_Code_Type := 16#400#;
   Message_Event_FilerCloseDir          : constant Message_Event_Code_Type := 16#401#;
   Message_Event_FilerOpenDirAt         : constant Message_Event_Code_Type := 16#402#;
   Message_Event_FilerSelectionDirectory: constant Message_Event_Code_Type := 16#403#;
   Message_Event_FilerAddSelection      : constant Message_Event_Code_Type := 16#404#;
   Message_Event_FilerAction            : constant Message_Event_Code_Type := 16#405#;
   Message_Event_FilerControlAction     : constant Message_Event_Code_Type := 16#406#;
   Message_Event_FilerSelection         : constant Message_Event_Code_Type := 16#407#;
   
   Message_Event_AlarmSet               : constant Message_Event_Code_Type := 16#500#;
   Message_Event_AlarmGoneOff           : constant Message_Event_Code_Type := 16#501#;
   Message_Event_HelpEnable             : constant Message_Event_Code_Type := 16#504#;
   
   Message_Event_Notify                 : constant Message_Event_Code_Type := 16#40040#;
   Message_Event_MenuWarning            : constant Message_Event_Code_Type := 16#400c0#;
   Message_Event_ModeChange             : constant Message_Event_Code_Type := 16#400c1#;
   
   Message_Event_TaskInitialise         : constant Message_Event_Code_Type := 16#400c2#;
   Message_Event_TaskCloseDown          : constant Message_Event_Code_Type := 16#400c3#;
   Message_Event_SlotSize               : constant Message_Event_Code_Type := 16#400c4#;
   Message_Event_SetSlot                : constant Message_Event_Code_Type := 16#400c5#;
   Message_Event_TaskNameRq             : constant Message_Event_Code_Type := 16#400c6#;
   Message_Event_TaskNameIs             : constant Message_Event_Code_Type := 16#400c7#;
   Message_Event_TaskStarted            : constant Message_Event_Code_Type := 16#400c8#;
   
   Message_Event_MenusDeleted           : constant Message_Event_Code_Type := 16#400c9#;
   Message_Event_Iconize                : constant Message_Event_Code_Type := 16#40c10#;
   Message_Event_IconizeAt              : constant Message_Event_Code_Type := 16#400D0#;
   Message_Event_WindowInfo             : constant Message_Event_Code_Type := 16#40c11#;
   Message_Event_WindowClosed           : constant Message_Event_Code_Type := 16#40c12#;
   Message_Event_FontChanged            : constant Message_Event_Code_Type := 16#400CF#;

   Message_Event_PrintFile              : constant Message_Event_Code_Type := 16#80140#;
   Message_Event_WillPrint              : constant Message_Event_Code_Type := 16#80141#;
   Message_Event_PrintSave              : constant Message_Event_Code_Type := 16#80142#;
   Message_Event_PrintInit              : constant Message_Event_Code_Type := 16#80143#;
   Message_Event_PrintError             : constant Message_Event_Code_Type := 16#80144#;
   Message_Event_PrintTypeOdd           : constant Message_Event_Code_Type := 16#80145#;
   Message_Event_PrintTypeKnown         : constant Message_Event_Code_Type := 16#80146#;
   Message_Event_SetPrinter             : constant Message_Event_Code_Type := 16#80147#;
   Message_Event_PSPrinterQuery         : constant Message_Event_Code_Type := 16#8014c#;
   Message_Event_PSPrinterAck           : constant Message_Event_Code_Type := 16#8014d#;
   Message_Event_PSPrinterModified      : constant Message_Event_Code_Type := 16#8014e#;
   Message_Event_PSPrinterDefaults      : constant Message_Event_Code_Type := 16#8014f#;
   Message_Event_PSPrinterDefaulted     : constant Message_Event_Code_Type := 16#80150#;
   Message_Event_PSPrinterNotPS         : constant Message_Event_Code_Type := 16#80151#;
   Message_Event_ResetPrinter           : constant Message_Event_Code_Type := 16#80152#;
   Message_Event_PSIsFontPrintRunning   : constant Message_Event_Code_Type := 16#80153#;
   
   Message_Event_HelpRequest            : constant Message_Event_Code_Type := 16#502#;
   Message_Event_HelpReply              : constant Message_Event_Code_Type := 16#503#;
   Message_Event_Help_Word              : constant Message_Event_Code_Type := 16#43B00#;
   
   Message_Event_TW_Input               : constant Message_Event_Code_Type := 16#808C0#;
   Message_Event_TW_Output              : constant Message_Event_Code_Type := 16#808C1#;
   Message_Event_TW_Ego                 : constant Message_Event_Code_Type := 16#808C2#;
   Message_Event_TW_Morio               : constant Message_Event_Code_Type := 16#808C3#;
   Message_Event_TW_Morite              : constant Message_Event_Code_Type := 16#808C4#;
   Message_Event_TW_NewTask             : constant Message_Event_Code_Type := 16#808C5#;
   Message_Event_TW_Suspend             : constant Message_Event_Code_Type := 16#808C6#;
   Message_Event_TW_Resume              : constant Message_Event_Code_Type := 16#808C7#;

   Message_Event_PlugInQuit             : constant Message_Event_Code_Type := 16#50D80#;
   Message_Event_PlugInQuitContinue     : constant Message_Event_Code_Type := 16#50D81#;
   Message_Event_PlugInQuitAbort        : constant Message_Event_Code_Type := 16#50D82#;
   Message_Event_OpenConfigWindow       : constant Message_Event_Code_Type := 16#50D83#;
                                        
   Message_Event_Bugz_Query             : constant Message_Event_Code_Type := 16#53B80#;
   Message_Event_Bugz_BugzFile          : constant Message_Event_Code_Type := 16#53B81#;
                                        
   Message_Event_OLE_FileChanged        : constant Message_Event_Code_Type := 16#80E1E#;
   Message_Event_OLEOpenSession         : constant Message_Event_Code_Type := 16#80E21#;
   Message_Event_OLEOpenSessionAck      : constant Message_Event_Code_Type := 16#80E22#;
   Message_Event_OLECloseSession        : constant Message_Event_Code_Type := 16#80E23#;

   Message_Event_ConfiX                 : constant Message_Event_Code_Type := 16#40D50#;
   
   Message_Event_StrongEDModeFileChanged : constant Message_Event_Code_Type := 16#43b06#;
   Message_Event_StrongEDInsertText      : constant Message_Event_Code_Type := 16#43b04#;

   Message_Event_InetSuite_Open_URL     : constant Message_Event_Code_Type := 16#4AF80#;
   
   type Message_EventListener (E : Message_Event_Code_Type) is abstract new Event_Listener(Message) with
   record
   Event_Code : Message_Event_Code_Type := E;
   end record;

   type Message_Event_Header is
   record
   Size       : System.Unsigned_Types.Unsigned;
   Sender     : Integer;
   MyRef      : System.Unsigned_Types.Unsigned;
   YourRef    : System.Unsigned_Types.Unsigned;
   Event_Code : Message_Event_Code_Type;
   end record;
   pragma Convention (C, Message_Event_Header);
   
   type ToolBox_Event_Code_Type is new System.Unsigned_Types.Unsigned;

   Toolbox_Event_Error                         : constant ToolBox_Event_Code_Type := 16#44EC0#;
   Toolbox_Event_ObjectAutoCreated             : constant ToolBox_Event_Code_Type := 16#44EC1#;
   Toolbox_Event_ObjectDeleted                 : constant ToolBox_Event_Code_Type := 16#44EC2#;
   
   Toolbox_Event_Menu_AboutToBeShown           : constant ToolBox_Event_Code_Type := 16#828C0#;
   Toolbox_Event_Menu_HasBeenHidden            : constant ToolBox_Event_Code_Type := 16#828C1#;
   Toolbox_Event_Menu_SubMenu                  : constant ToolBox_Event_Code_Type := 16#828C2#;
   Toolbox_Event_Menu_Selection                : constant ToolBox_Event_Code_Type := 16#828C3#;

   Toolbox_Event_ColourDbox_AboutToBeShown     : constant ToolBox_Event_Code_Type := 16#829C0#;
   Toolbox_Event_ColourDbox_DialogueCompleted  : constant ToolBox_Event_Code_Type := 16#829C1#;
   Toolbox_Event_ColourDbox_ColourSelected     : constant ToolBox_Event_Code_Type := 16#829C2#;
   Toolbox_Event_ColourDbox_ColourChanged      : constant ToolBox_Event_Code_Type := 16#829C3#;
   Toolbox_Event_ColourMenu_AboutToBeShown     : constant ToolBox_Event_Code_Type := 16#82980#;
   Toolbox_Event_ColourMenu_HasBeenHidden      : constant ToolBox_Event_Code_Type := 16#82981#;
   Toolbox_Event_ColourMenu_Selection          : constant ToolBox_Event_Code_Type := 16#82982#;
  
   Toolbox_Event_DCS_AboutToBeShown            : constant ToolBox_Event_Code_Type := 16#82A80#;
   Toolbox_Event_DCS_Discard                   : constant ToolBox_Event_Code_Type := 16#82A81#;
   Toolbox_Event_DCS_Save                      : constant ToolBox_Event_Code_Type := 16#82A82#;
   Toolbox_Event_DCS_DialogueCompleted         : constant ToolBox_Event_Code_Type := 16#82A83#;
   Toolbox_Event_DCS_Cancel                    : constant ToolBox_Event_Code_Type := 16#82A84#;

   Toolbox_Event_FileInfo_AboutToBeShown       : constant ToolBox_Event_Code_Type := 16#82AC0#;
   Toolbox_Event_FileInfo_DialogueCompleted    : constant ToolBox_Event_Code_Type := 16#82AC1#;
 
   Toolbox_Event_FontDbox_AboutToBeShown       : constant ToolBox_Event_Code_Type := 16#82A00#;
   Toolbox_Event_FontDbox_DialogueCompleted    : constant ToolBox_Event_Code_Type := 16#82A01#;
   Toolbox_Event_FontDbox_ApplyFont            : constant ToolBox_Event_Code_Type := 16#82A02#;
   Toolbox_Event_FontMenu_AboutToBeShown       : constant ToolBox_Event_Code_Type := 16#82A40#;
   Toolbox_Event_FontMenu_HasBeenHidden        : constant ToolBox_Event_Code_Type := 16#82A41#;
   Toolbox_Event_FontMenu_Selection            : constant ToolBox_Event_Code_Type := 16#82A42#;

   Toolbox_Event_Iconbar_Clicked               : constant ToolBox_Event_Code_Type := 16#82900#;
   Toolbox_Event_Iconbar_SelectAboutToBeShown  : constant ToolBox_Event_Code_Type := 16#82901#;
   Toolbox_Event_Iconbar_AdjustAboutToBeShown  : constant ToolBox_Event_Code_Type := 16#82902#;

   Toolbox_Event_PrintDbox_AboutToBeShown      : constant ToolBox_Event_Code_Type := 16#82B00#;
   Toolbox_Event_PrintDbox_DialogueCompleted   : constant ToolBox_Event_Code_Type := 16#82B01#;
   Toolbox_Event_PrintDbox_SetupAboutToBeShown : constant ToolBox_Event_Code_Type := 16#82B02#;
   Toolbox_Event_PrintDbox_Save                : constant ToolBox_Event_Code_Type := 16#82B03#;
   Toolbox_Event_PrintDbox_SetUp               : constant ToolBox_Event_Code_Type := 16#82B04#;
   Toolbox_Event_PrintDbox_Print               : constant ToolBox_Event_Code_Type := 16#82B05#;

   Toolbox_Event_ProgInfo_AboutToBeShown       : constant ToolBox_Event_Code_Type := 16#82B40#;
   Toolbox_Event_ProgInfo_DialogueCompleted    : constant ToolBox_Event_Code_Type := 16#82B41#;
   Toolbox_Event_ProgInfo_LaunchWebPage        : constant ToolBox_Event_Code_Type := 16#82B42#;

   Toolbox_Event_Quit_AboutToBeShown           : constant ToolBox_Event_Code_Type := 16#82A90#;
   Toolbox_Event_Quit_Quit                     : constant ToolBox_Event_Code_Type := 16#82A91#;
   Toolbox_Event_Quit_DialogueCompleted        : constant ToolBox_Event_Code_Type := 16#82A92#;
   Toolbox_Event_Quit_Cancel                   : constant ToolBox_Event_Code_Type := 16#82A93#;
 
   Toolbox_Event_SaveAs_AboutToBeShown         : constant ToolBox_Event_Code_Type := 16#82BC0#;
   Toolbox_Event_SaveAs_DialogueCompleted      : constant ToolBox_Event_Code_Type := 16#82BC1#;
   Toolbox_Event_SaveAs_SaveToFile             : constant ToolBox_Event_Code_Type := 16#82BC2#;
   Toolbox_Event_SaveAs_FillBuffer             : constant ToolBox_Event_Code_Type := 16#82BC3#;
   Toolbox_Event_SaveAs_SaveCompleted          : constant ToolBox_Event_Code_Type := 16#82BC4#;

   Toolbox_Event_Scale_AboutToBeShown          : constant ToolBox_Event_Code_Type := 16#82C00#;
   Toolbox_Event_Scale_DialogueCompleted       : constant ToolBox_Event_Code_Type := 16#82C01#;
   Toolbox_Event_Scale_ApplyFactor             : constant ToolBox_Event_Code_Type := 16#82C02#;

   Toolbox_Event_Window_AboutToBeShown         : constant ToolBox_Event_Code_Type := 16#82880#;
   Toolbox_Event_Window_GadgetLostFocus        : constant ToolBox_Event_Code_Type := 16#82891#;
   Toolbox_Event_ActionButton_Selected         : constant ToolBox_Event_Code_Type := 16#82881#;
   Toolbox_Event_OptionButton_StateChanged     : constant ToolBox_Event_Code_Type := 16#82882#;
   Toolbox_Event_RadioButton_StateChanged      : constant ToolBox_Event_Code_Type := 16#82883#;
   Toolbox_Event_DisplayField_ValueChanged     : constant ToolBox_Event_Code_Type := 16#82884#;
   Toolbox_Event_WritableField_ValueChanged    : constant ToolBox_Event_Code_Type := 16#82885#;
   Toolbox_Event_Slider_ValueChanged           : constant ToolBox_Event_Code_Type := 16#82886#;
   Toolbox_Event_Draggable_DragStarted         : constant ToolBox_Event_Code_Type := 16#82887#;
   Toolbox_Event_Draggable_DragEnded           : constant ToolBox_Event_Code_Type := 16#82888#;
   Toolbox_Event_PopUp_AboutToBeShown          : constant ToolBox_Event_Code_Type := 16#8288B#;
   Toolbox_Event_Adjuster_Clicked              : constant ToolBox_Event_Code_Type := 16#8288C#;
   Toolbox_Event_NumberRange_ValueChanged      : constant ToolBox_Event_Code_Type := 16#8288D#;
   Toolbox_Event_StringSet_ValueChanged        : constant ToolBox_Event_Code_Type := 16#8288E#;
   Toolbox_Event_StringSet_AboutToBeShown      : constant ToolBox_Event_Code_Type := 16#8288F#;
   Toolbox_Event_Window_HasBeenHidden          : constant ToolBox_Event_Code_Type := 16#82890#;
   ToolBox_Event_Quit                          : constant ToolBox_Event_Code_Type := 16#82A91#;
   Toolbox_Event_ScrollList_Selection          : constant ToolBox_Event_Code_Type := 16#140181#;
   Toolbox_Event_TextArea_DataLoaded           : constant ToolBox_Event_Code_Type := 16#140180#;

   Toolbox_Event_Scrollbar_PositionChanged     : constant ToolBox_Event_Code_Type := 16#140183#;

   Toolbox_Event_ToolAction_ButtonClicked      : constant ToolBox_Event_Code_Type := 16#140140#;

   TreeView_SWIBase                            : constant ToolBox_Event_Code_Type := 16#140280#;
   TreeView_EventBase                          : constant ToolBox_Event_Code_Type := TreeView_SWIBase;
   Toolbox_Event_TreeViewNodeSelected          : constant ToolBox_Event_Code_Type := TreeView_EventBase + 0;
   Toolbox_Event_TreeViewNodeExpanded          : constant ToolBox_Event_Code_Type := TreeView_EventBase + 1;
   Toolbox_Event_TreeViewNodeRenamed           : constant ToolBox_Event_Code_Type := TreeView_EventBase + 2;
   Toolbox_Event_TreeViewNodeDataRequired      : constant ToolBox_Event_Code_Type := TreeView_EventBase + 3;
   Toolbox_Event_TreeViewNodeDragged           : constant ToolBox_Event_Code_Type := TreeView_EventBase + 4;

   type Object_ID    is new Integer;
   type Component_ID is new Integer;

   subtype Error_Code_Type is Integer;

   Error_Escape                                    : constant Error_Code_Type := 16#11#;
   Error_Bad_mode                                  : constant Error_Code_Type := 16#19#;
   Error_Is_adir                                   : constant Error_Code_Type := 16#A8#;
   Error_Types_dont_match                          : constant Error_Code_Type := 16#AF#;
   Error_Bad_rename                                : constant Error_Code_Type := 16#B0#;
   Error_Bad_copy                                  : constant Error_Code_Type := 16#B1#;
   Error_Outside_file                              : constant Error_Code_Type := 16#B7#;
   Error_Access_violation                          : constant Error_Code_Type := 16#BD#;
   Error_Too_many_open_files                       : constant Error_Code_Type := 16#C0#;
   Error_Not_open_for_update                       : constant Error_Code_Type := 16#C1#;
   Error_File_open                                 : constant Error_Code_Type := 16#C2#;
   Error_Object_locked                             : constant Error_Code_Type := 16#C3#;
   Error_Already_exists                            : constant Error_Code_Type := 16#C4#;
   Error_Bad_file_name                             : constant Error_Code_Type := 16#CC#;
   Error_File_not_found                            : constant Error_Code_Type := 16#D6#;
   Error_Syntax                                    : constant Error_Code_Type := 16#DC#;
   Error_Channel                                   : constant Error_Code_Type := 16#DE#;
   Error_End_of_file                               : constant Error_Code_Type := 16#DF#;
   Error_Buffer_Overflow                           : constant Error_Code_Type := 16#E4#;
   Error_Bad_filing_system_name                    : constant Error_Code_Type := 16#F8#;
   Error_Bad_key                                   : constant Error_Code_Type := 16#FB#;
   Error_Bad_address                               : constant Error_Code_Type := 16#FC#;
   Error_Bad_string                                : constant Error_Code_Type := 16#FD#;
   Error_Bad_command                               : constant Error_Code_Type := 16#FE#;
   Error_Bad_mac_val                               : constant Error_Code_Type := 16#120#;
   Error_Bad_var_nam                               : constant Error_Code_Type := 16#121#;
   Error_Bad_var_type                              : constant Error_Code_Type := 16#122#;
   Error_Var_no_room                               : constant Error_Code_Type := 16#123#;
   Error_Var_cant_find                             : constant Error_Code_Type := 16#124#;
   Error_Var_too_long                              : constant Error_Code_Type := 16#125#;
   Error_Redirect_fail                             : constant Error_Code_Type := 16#140#;
   Error_Stack_full                                : constant Error_Code_Type := 16#141#;
   Error_Bad_hex                                   : constant Error_Code_Type := 16#160#;
   Error_Bad_expr                                  : constant Error_Code_Type := 16#161#;
   Error_Bad_bra                                   : constant Error_Code_Type := 16#162#;
   Error_Stk_oflo                                  : constant Error_Code_Type := 16#163#;
   Error_Miss_opn                                  : constant Error_Code_Type := 16#164#;
   Error_Miss_opr                                  : constant Error_Code_Type := 16#165#;
   Error_Bad_bits                                  : constant Error_Code_Type := 16#166#;
   Error_Str_oflo                                  : constant Error_Code_Type := 16#167#;
   Error_Bad_itm                                   : constant Error_Code_Type := 16#168#;
   Error_Div_zero                                  : constant Error_Code_Type := 16#169#;
   Error_Bad_base                                  : constant Error_Code_Type := 16#16A#;
   Error_Bad_numb                                  : constant Error_Code_Type := 16#16B#;
   Error_Numb_too_big                              : constant Error_Code_Type := 16#16C#;
   Error_Bad_claim_num                             : constant Error_Code_Type := 16#1A1#;
   Error_Bad_release                               : constant Error_Code_Type := 16#1A2#;
   Error_Bad_dev_no                                : constant Error_Code_Type := 16#1A3#;
   Error_Bad_dev_vec_rel                           : constant Error_Code_Type := 16#1A4#;
   Error_Bad_env_number                            : constant Error_Code_Type := 16#1B0#;
   Error_Cant_cancel_quit                          : constant Error_Code_Type := 16#1B1#;
   Error_Ch_dynam_cao                              : constant Error_Code_Type := 16#1C0#;
   Error_Ch_dynam_not_all_moved                    : constant Error_Code_Type := 16#1C1#;
   Error_Apl_wspace_in_use                         : constant Error_Code_Type := 16#1C2#;
   Error_Ram_fs_unchangeable                       : constant Error_Code_Type := 16#1C3#;
   Error_Oscli_long_line                           : constant Error_Code_Type := 16#1E0#;
   Error_Oscli_too_hard                            : constant Error_Code_Type := 16#1E1#;
   Error_Rc_exc                                    : constant Error_Code_Type := 16#1E2#;
   Error_Sys_heap_full                             : constant Error_Code_Type := 16#1E3#;
   Error_Buff_overflow                             : constant Error_Code_Type := 16#1E4#;
   Error_Bad_time                                  : constant Error_Code_Type := 16#1E5#;
   Error_No_such_swi                               : constant Error_Code_Type := 16#1E6#;
   Error_Unimplemented                             : constant Error_Code_Type := 16#1E7#;
   Error_Out_of_range                              : constant Error_Code_Type := 16#1E8#;
   Error_No_oscli_specials                         : constant Error_Code_Type := 16#1E9#;
   Error_Bad_parameters                            : constant Error_Code_Type := 16#1EA#;
   Error_Arg_repeated                              : constant Error_Code_Type := 16#1EB#;
   Error_Bad_read_sys_info                         : constant Error_Code_Type := 16#1EC#;
   Error_Cdat_stack_overflow                       : constant Error_Code_Type := 16#2C0#;
   Error_Cdat_buffer_overflow                      : constant Error_Code_Type := 16#2C1#;
   Error_Cdat_bad_field                            : constant Error_Code_Type := 16#2C2#;
   Error_Cant_start_application                    : constant Error_Code_Type := 16#600#;

   Error_ADFS_Driver_In_Use                        : constant Error_Code_Type := 16#108A0#;

   Error_CD_Base                                   : constant Error_Code_Type := 16#803400#;
   Error_CD_Bad_Alignment                          : constant Error_Code_Type := 16#803401#;
   Error_CD_Drive_Not_Supported                    : constant Error_Code_Type := 16#803402#;
   Error_CD_Bad_Mode                               : constant Error_Code_Type := 16#803403#;
   Error_CD_Invalid_Parameter                      : constant Error_Code_Type := 16#803404#;
   Error_CD_Not_Audio_Track                        : constant Error_Code_Type := 16#803405#;
   Error_CD_No_Caddy                               : constant Error_Code_Type := 16#803406#;
   Error_CD_No_Drive                               : constant Error_Code_Type := 16#803407#;
   Error_CD_Invalid_Format                         : constant Error_Code_Type := 16#803408#;
   Error_CD_Bad_Minutes                            : constant Error_Code_Type := 16#803409#;
   Error_CD_Bad_Seconds                            : constant Error_Code_Type := 16#80340A#;
   Error_CD_Bad_Blocks                             : constant Error_Code_Type := 16#80340B#;
   Error_CD_Physical_Block_Bad                     : constant Error_Code_Type := 16#80340C#;
   Error_CD_Drawer_Locked                          : constant Error_Code_Type := 16#80340D#;
   Error_CD_Wrong_Data_Mode                        : constant Error_Code_Type := 16#80340E#;
   Error_CD_Channel_Not_Supported                  : constant Error_Code_Type := 16#80340F#;
   Error_CD_Bad_Device_ID                          : constant Error_Code_Type := 16#803410#;
   Error_CD_Bad_Card_Number                        : constant Error_Code_Type := 16#803411#;
   Error_CD_Bad_Lun_Number                         : constant Error_Code_Type := 16#803412#;
   Error_CD_No_Such_Track                          : constant Error_Code_Type := 16#803413#;
   Error_CD_Faulty_Disc                            : constant Error_Code_Type := 16#803414#;
   Error_CD_No_Such_Block                          : constant Error_Code_Type := 16#803415#;
   Error_CD_Not_Supported                          : constant Error_Code_Type := 16#803416#;
   Error_CD_Driver_Not_Present                     : constant Error_Code_Type := 16#803417#;
   Error_CD_SWI_Not_Supported                      : constant Error_Code_Type := 16#803418#;
   Error_CD_Too_Many_Drivers                       : constant Error_Code_Type := 16#803419#;
   Error_CD_Not_Registered                         : constant Error_Code_Type := 16#80341A#;

   Error_Colour_DBox_Tasks_Active                  : constant Error_Code_Type := 16#80AE00#;
   Error_Colour_DBox_Alloc_Failed                  : constant Error_Code_Type := 16#80AE01#;
   Error_Colour_DBox_Short_Buffer                  : constant Error_Code_Type := 16#80AE02#;
   Error_Colour_DBox_No_Such_Task                  : constant Error_Code_Type := 16#80AE11#;
   Error_Colour_DBox_No_Such_Method                : constant Error_Code_Type := 16#80AE12#;
   Error_Colour_DBox_No_Such_Misc_op_Method        : constant Error_Code_Type := 16#80AE13#;

   Error_Colour_Picker_Uninit                      : constant Error_Code_Type := 16#20D00#;
   Error_Colour_Picker_Bad_Model                   : constant Error_Code_Type := 16#20D01#;
   Error_Colour_Picker_Bad_Handle                  : constant Error_Code_Type := 16#20D02#;
   Error_Colour_Picker_Bad_Flags                   : constant Error_Code_Type := 16#20D03#;
   Error_Colour_Picker_In_Use                      : constant Error_Code_Type := 16#20D04#;
   Error_Colour_Picker_Model_In_Use                : constant Error_Code_Type := 16#20D05#;
   Error_Colour_Picker_Bad_Reason                  : constant Error_Code_Type := 16#20D06#;

   Error_Colour_Trans_Bad_Calib                    : constant Error_Code_Type := 16#A00#;
   Error_Colour_Trans_Conv_Over                    : constant Error_Code_Type := 16#A01#;
   Error_Colour_Trans_Bad_HSV                      : constant Error_Code_Type := 16#A02#;
   Error_Colour_Trans_Switched                     : constant Error_Code_Type := 16#A03#;
   Error_Colour_Trans_Bad_Misc_Op                  : constant Error_Code_Type := 16#A04#;
   Error_Colour_Trans_Bad_Flags                    : constant Error_Code_Type := 16#A05#;
   Error_Colour_Trans_Buff_Over                    : constant Error_Code_Type := 16#A06#;
   Error_Colour_Trans_Bad_Depth                    : constant Error_Code_Type := 16#A07#;

   Error_Compress_JPEG_Bad_BPP                     : constant Error_Code_Type := 16#8183C0#;
   Error_Compress_JPEG_Bad_Line_Count              : constant Error_Code_Type := 16#8183C1#;
   Error_Compress_JPEG_Bad_Buffer                  : constant Error_Code_Type := 16#8183C2#;
   Error_Compress_JPEG_Bad_Size                    : constant Error_Code_Type := 16#8183C3#;
   Error_Compress_JPEG_Arith_Not_Impl              : constant Error_Code_Type := 16#81A881#;
   Error_Compress_JPEG_Bad_Align_Type              : constant Error_Code_Type := 16#81A882#;
   Error_Compress_JPEG_Bad_Alloc_Chunk             : constant Error_Code_Type := 16#81A883#;
   Error_Compress_JPEG_Bad_Buffer_Mode             : constant Error_Code_Type := 16#81A884#;
   Error_Compress_JPEG_Bad_Component_ID            : constant Error_Code_Type := 16#81A885#;
   Error_Compress_JPEG_Bad_DCT_Size                : constant Error_Code_Type := 16#81A886#;
   Error_Compress_JPEG_Bad_In_Colour_Space         : constant Error_Code_Type := 16#81A887#;
   Error_Compress_JPEG_Bad_KColour_Space           : constant Error_Code_Type := 16#81A888#;
   Error_Compress_JPEG_Bad_Length                  : constant Error_Code_Type := 16#81A889#;
   Error_Compress_JPEG_Bad_MCU_Size                : constant Error_Code_Type := 16#81A88A#;
   Error_Compress_JPEG_Bad_Pool_ID                 : constant Error_Code_Type := 16#81A88B#;
   Error_Compress_JPEG_Bad_Precision               : constant Error_Code_Type := 16#81A88C#;
   Error_Compress_JPEG_Bad_Sampling                : constant Error_Code_Type := 16#81A88D#;
   Error_Compress_JPEG_Bad_State                   : constant Error_Code_Type := 16#81A88E#;
   Error_Compress_JPEG_Bad_Virtual_Access          : constant Error_Code_Type := 16#81A88F#;
   Error_Compress_JPEG_Buffer_Size                 : constant Error_Code_Type := 16#81A890#;
   Error_Compress_JPEG_Cant_Suspend                : constant Error_Code_Type := 16#81A891#;
   Error_Compress_JPEGCCIR601_Not_Impl             : constant Error_Code_Type := 16#81A892#;
   Error_Compress_JPEG_Component_Count             : constant Error_Code_Type := 16#81A893#;
   Error_Compress_JPEG_Conversion_Not_Impl         : constant Error_Code_Type := 16#81A894#;
   Error_Compress_JPEGDAC_Index                    : constant Error_Code_Type := 16#81A895#;
   Error_Compress_JPEGDAC_Value                    : constant Error_Code_Type := 16#81A896#;
   Error_Compress_JPEGDHT_Index                    : constant Error_Code_Type := 16#81A897#;
   Error_Compress_JPEGDQT_Index                    : constant Error_Code_Type := 16#81A898#;
   Error_Compress_JPEG_Empty_Image                 : constant Error_Code_Type := 16#81A899#;
   Error_Compress_JPEGEOI_Expected                 : constant Error_Code_Type := 16#81A89A#;
   Error_Compress_JPEG_File_Read                   : constant Error_Code_Type := 16#81A89B#;
   Error_Compress_JPEG_File_Write                  : constant Error_Code_Type := 16#81A89C#;
   Error_Compress_JPEG_Fract_Sample_Not_Impl       : constant Error_Code_Type := 16#81A89D#;
   Error_Compress_JPEG_Huff_Clen_Overflow          : constant Error_Code_Type := 16#81A89E#;
   Error_Compress_JPEG_Huff_Missing_Code           : constant Error_Code_Type := 16#81A89F#;
   Error_Compress_JPEG_Image_Too_Big               : constant Error_Code_Type := 16#81A8A0#;
   Error_Compress_JPEG_Input_Empty                 : constant Error_Code_Type := 16#81A8A1#;
   Error_Compress_JPEG_Input_EOF                   : constant Error_Code_Type := 16#81A8A2#;
   Error_Compress_JPEG_Not_Impl                    : constant Error_Code_Type := 16#81A8A3#;
   Error_Compress_JPEG_Not_Compiled                : constant Error_Code_Type := 16#81A8A4#;
   Error_Compress_JPEG_No_Backing_Store            : constant Error_Code_Type := 16#81A8A5#;
   Error_Compress_JPEG_No_Huff_Table               : constant Error_Code_Type := 16#81A8A6#;
   Error_Compress_JPEG_No_Image                    : constant Error_Code_Type := 16#81A8A7#;
   Error_Compress_JPEG_No_Quant_Table              : constant Error_Code_Type := 16#81A8A8#;
   Error_Compress_JPEG_No_Soi                      : constant Error_Code_Type := 16#81A8A9#;
   Error_Compress_JPEG_Out_Of_Memory               : constant Error_Code_Type := 16#81A8AA#;
   Error_Compress_JPEG_Quant_Components            : constant Error_Code_Type := 16#81A8AB#;
   Error_Compress_JPEG_Quant_Few_Colours           : constant Error_Code_Type := 16#81A8AC#;
   Error_Compress_JPEG_Quant_Many_Colours          : constant Error_Code_Type := 16#81A8AD#;
   Error_Compress_JPEGSOF_Duplicate                : constant Error_Code_Type := 16#81A8AE#;
   Error_Compress_JPEGSOF_No_Sos                   : constant Error_Code_Type := 16#81A8AF#;
   Error_Compress_JPEGSOF_Unsupported              : constant Error_Code_Type := 16#81A8B0#;
   Error_Compress_JPEGSOI_Duplicate                : constant Error_Code_Type := 16#81A8B1#;
   Error_Compress_JPEGSOS_No_Sof                   : constant Error_Code_Type := 16#81A8B2#;
   Error_Compress_JPEG_Too_Little_Data             : constant Error_Code_Type := 16#81A8B3#;
   Error_Compress_JPEG_Unknown_Marker              : constant Error_Code_Type := 16#81A8B4#;
   Error_Compress_JPEG_Virtual_Bug                 : constant Error_Code_Type := 16#81A8B5#;
   Error_Compress_JPEG_Width_Overflow              : constant Error_Code_Type := 16#81A8B6#;
   Error_Compress_JPEG_Bad_DCT_Coef                : constant Error_Code_Type := 16#81A8B7#;
   Error_Compress_JPEG_Bad_Huff_Table              : constant Error_Code_Type := 16#81A8B8#;
   Error_Compress_JPEG_Bad_Progression             : constant Error_Code_Type := 16#81A8B9#;
   Error_Compress_JPEG_Bad_Prog_Script             : constant Error_Code_Type := 16#81A8BA#;
   Error_Compress_JPEG_Bad_Scan_Script             : constant Error_Code_Type := 16#81A8BB#;
   Error_Compress_JPEG_Mismatched_Quant_Table      : constant Error_Code_Type := 16#81A8BC#;
   Error_Compress_JPEG_Missing_Data                : constant Error_Code_Type := 16#81A8BD#;
   Error_Compress_JPEG_Mode_Change                 : constant Error_Code_Type := 16#81A8BE#;
   Error_Compress_JPEGW_Buffer_Size                : constant Error_Code_Type := 16#81A8BF#;

   Error_DDE_Utils_Unknown_SWI                     : constant Error_Code_Type := 16#20600#;
   Error_DDE_Utils_No_CLI_Buffer                   : constant Error_Code_Type := 16#20601#;
   Error_DDE_Utils_Not_Desktop                     : constant Error_Code_Type := 16#20602#;
   Error_DDE_Utils_No_Task                         : constant Error_Code_Type := 16#20603#;
   Error_DDE_Utils_Already_Registered              : constant Error_Code_Type := 16#20604#;
   Error_DDE_Utils_Not_Registered                  : constant Error_Code_Type := 16#20605#;

   Error_Debug_Break_Not_Found                     : constant Error_Code_Type := 16#800#;
   Error_Debug_invalid_Value                       : constant Error_Code_Type := 16#801#;
   Error_Debug_Resetting                           : constant Error_Code_Type := 16#802#;
   Error_Debug_No_Room                             : constant Error_Code_Type := 16#803#;
   Error_Debug_No_Breakpoints                      : constant Error_Code_Type := 16#804#;
   Error_Debug_Bad_Breakpoint                      : constant Error_Code_Type := 16#805#;
   Error_Debug_Undefined                           : constant Error_Code_Type := 16#806#;
   Error_Debug_Non_Aligned                         : constant Error_Code_Type := 16#807#;
   Error_Debug_No_Workspace                        : constant Error_Code_Type := 16#808#;

   Error_Draw_No_Draw_In_IRQ_Mode                  : constant Error_Code_Type :=16#980#;
   Error_Draw_Bad_Draw_Reason_Code                 : constant Error_Code_Type :=16#981#;
   Error_Draw_Reserved_Draw_Bits                   : constant Error_Code_Type :=16#982#;
   Error_Draw_Invalid_Draw_Address                 : constant Error_Code_Type :=16#983#;
   Error_Draw_Bad_Path_Element                     : constant Error_Code_Type :=16#984#;
   Error_Draw_Bad_Path_Sequence                    : constant Error_Code_Type :=16#985#;
   Error_Draw_May_Expand_Path                      : constant Error_Code_Type :=16#986#;
   Error_Draw_Path_Full                            : constant Error_Code_Type :=16#987#;
   Error_Draw_Path_Not_Flat                        : constant Error_Code_Type :=16#988#;
   Error_Draw_Bad_Caps_Or_Joins                    : constant Error_Code_Type :=16#989#;
   Error_Draw_Transform_Overflow                   : constant Error_Code_Type :=16#98A#;
   Error_Draw_Draw_Needs_Graphics_Mode             : constant Error_Code_Type :=16#98B#;
   Error_Draw_Unimplemented_Draw                   : constant Error_Code_Type :=16#9FF#;

   Error_Draw_File_Not_Draw                        : constant Error_Code_Type := 16#20C00#;
   Error_Draw_File_Version                         : constant Error_Code_Type := 16#20C01#;
   Error_Draw_File_Font_Tab                        : constant Error_Code_Type := 16#20C02#;
   Error_Draw_File_Bad_Font_No                     : constant Error_Code_Type := 16#20C03#;
   Error_Draw_File_Bad_Mode                        : constant Error_Code_Type := 16#20C04#;
   Error_Draw_File_Bad_File                        : constant Error_Code_Type := 16#20C05#;
   Error_Draw_File_Bad_Group                       : constant Error_Code_Type := 16#20C06#;
   Error_Draw_File_Bad_Tag                         : constant Error_Code_Type := 16#20C07#;
   Error_Draw_File_Syntax                          : constant Error_Code_Type := 16#20C08#;
   Error_Draw_File_Font_No                         : constant Error_Code_Type := 16#20C09#;
   Error_Draw_File_Area_Ver                        : constant Error_Code_Type := 16#20C0A#;
   Error_Draw_File_No_Area_Ver                     : constant Error_Code_Type := 16#20C0B#;

   Error_Econet_Tx_Ready                           : constant Error_Code_Type := 16#300#;
   Error_Econet_Transmitting                       : constant Error_Code_Type := 16#301#;
   Error_Econet_Rx_Ready                           : constant Error_Code_Type := 16#302#;
   Error_Econet_Receiving                          : constant Error_Code_Type := 16#303#;
   Error_Econet_Received                           : constant Error_Code_Type := 16#304#;
   Error_Econet_Transmitted                        : constant Error_Code_Type := 16#305#;
   Error_Econet_Bad_Station                        : constant Error_Code_Type := 16#306#;
   Error_Econet_Bad_Network                        : constant Error_Code_Type := 16#307#;
   Error_Econet_Unable_To_Default                  : constant Error_Code_Type := 16#308#;
   Error_Econet_Bad_Port                           : constant Error_Code_Type := 16#309#;
   Error_Econet_Bad_Control                        : constant Error_Code_Type := 16#30A#;
   Error_Econet_Bad_Buffer                         : constant Error_Code_Type := 16#30B#;
   Error_Econet_Bad_Size                           : constant Error_Code_Type := 16#30C#;
   Error_Econet_Bad_Mask                           : constant Error_Code_Type := 16#30D#;
   Error_Econet_Bad_Count                          : constant Error_Code_Type := 16#30E#;
   Error_Econet_Bad_Delay                          : constant Error_Code_Type := 16#30F#;
   Error_Econet_Bad_Status                         : constant Error_Code_Type := 16#310#;
   Error_Econet_No_Hardware                        : constant Error_Code_Type := 16#311#;
   Error_Econet_No_Econet                          : constant Error_Code_Type := 16#312#;
   Error_Econet_No_More_Domains                    : constant Error_Code_Type := 16#313#;
   Error_Econet_Bad_Domain                         : constant Error_Code_Type := 16#314#;
   Error_Econet_Un_Registered_Domain               : constant Error_Code_Type := 16#315#;
   Error_Econet_Port_Not_Allocated                 : constant Error_Code_Type := 16#316#;
   Error_Econet_Port_Allocated                     : constant Error_Code_Type := 16#317#;
   Error_Econet_No_More_Ports                      : constant Error_Code_Type := 16#318#;

   Error_Filer_No_Recursion                        : constant Error_Code_Type := 16#B80#;
   Error_Filer_No_Template                         : constant Error_Code_Type := 16#B81#;
   Error_Filer_Failed_Save                         : constant Error_Code_Type := 16#B82#;
   Error_Filer_Bad_Path                            : constant Error_Code_Type := 16#B83#;

   Error_File_Switch_No_Claim                      : constant Error_Code_Type := 16#400#;
   Error_Bad_FS_Control_Reason                     : constant Error_Code_Type := 16#401#;
   Error_Bad_OS_File_Reason                        : constant Error_Code_Type := 16#402#;
   Error_Bad_OS_Args_Reason                        : constant Error_Code_Type := 16#403#;
   Error_Bad_OSGBPB_Reason                         : constant Error_Code_Type := 16#404#;
   Error_Bad_Mode_For_OS_Find                      : constant Error_Code_Type := 16#405#;
   Error_No_Room_For_Transient                     : constant Error_Code_Type := 16#406#;
   Error_Exec_Addr_Not_In_Code                     : constant Error_Code_Type := 16#407#;
   Error_Exec_Addr_TOO_Low                         : constant Error_Code_Type := 16#408#;
   Error_Unknown_Action_Type                       : constant Error_Code_Type := 16#409#;
   Error_Too_Many_Levels                           : constant Error_Code_Type := 16#40A#;
   Error_No_Selected_Filing_System                 : constant Error_Code_Type := 16#40B#;
   Error_Cant_Remove_FS_By_Number                  : constant Error_Code_Type := 16#40C#;
   Error_Unaligned_FS_Entry                        : constant Error_Code_Type := 16#40D#;
   Error_Unsupported_FS_Entry                      : constant Error_Code_Type := 16#40E#;
   Error_Fs_Not_Special                            : constant Error_Code_Type := 16#40F#;
   Error_Core_Not_Readable                         : constant Error_Code_Type := 16#410#;
   Error_Core_Not_Writeable                        : constant Error_Code_Type := 16#411#;
   Error_Bad_Buffer_Size_For_Stream                : constant Error_Code_Type := 16#412#;
   Error_Not_Open_For_Reading                      : constant Error_Code_Type := 16#413#;
   Error_Not_Enough_Stack_For_FS_Entry             : constant Error_Code_Type := 16#414#;
   Error_Nothing_To_Copy                           : constant Error_Code_Type := 16#415#;
   Error_Nothing_To_Delete                         : constant Error_Code_Type := 16#416#;
   Error_File_Switch_Cant_Be_Killed_Whilst_Threaded: constant Error_Code_Type := 16#417#;
   Error_Invalid_Error_Block                       : constant Error_Code_Type := 16#418#;
   Error_FS_File_Too_Big                           : constant Error_Code_Type := 16#419#;
   Error_Cant_RM_Faster_File_Switch                : constant Error_Code_Type := 16#41A#;
   Error_Inconsistent_Handle_Set                   : constant Error_Code_Type := 16#41B#;
   Error_Is_AFile                                  : constant Error_Code_Type := 16#41C#;
   Error_Bad_File_Type                             : constant Error_Code_Type := 16#41D#;
   Error_Library_Somewhere_Else                    : constant Error_Code_Type := 16#41E#;
   Error_Path_Is_Self_Contradictory                : constant Error_Code_Type := 16#41F#;
   Error_Wasnt_Dollar_After_Disc                   : constant Error_Code_Type := 16#420#;
   Error_Not_Enough_Memory_For_Wildcard_Resolution : constant Error_Code_Type := 16#421#;
   Error_Not_Enough_Stack_For_Wildcard_Resolution  : constant Error_Code_Type := 16#422#;
   Error_Dir_Wanted_File_Found                     : constant Error_Code_Type := 16#423#;
   Error_Not_Found                                 : constant Error_Code_Type := 16#424#;
   Error_Multipart_Path_Used                       : constant Error_Code_Type := 16#425#;
   Error_Recursive_Path                            : constant Error_Code_Type := 16#426#;
   Error_Multi_FS_Does_Not_Support_GBPB11          : constant Error_Code_Type := 16#427#;
   Error_File_Switch_Data_Lost                     : constant Error_Code_Type := 16#428#;
   Error_Too_Many_Error_Lookups                    : constant Error_Code_Type := 16#429#;
   Error_Message_File_Busy                         : constant Error_Code_Type := 16#42A#;
   Error_Partition_Busy                            : constant Error_Code_Type := 16#42B#;

   Error_Font_No_Room                              : constant Error_Code_Type := 16#200#;
   Error_Font_Cache_Full                           : constant Error_Code_Type := 16#201#;
   Error_Font_No_Cache                             : constant Error_Code_Type := 16#202#;
   Error_Font_Too_Long                             : constant Error_Code_Type := 16#203#;
   Error_Font64K                                   : constant Error_Code_Type := 16#204#;
   Error_Font_Pal_Too_Big                          : constant Error_Code_Type := 16#205#;
   Error_Font_Bad_Tran_Bits                        : constant Error_Code_Type := 16#206#;
   Error_Font_Not_Enough_Bits                      : constant Error_Code_Type := 16#207#;
   Error_Font_No_Font                              : constant Error_Code_Type := 16#208#;
   Error_Font_No_Pixels                            : constant Error_Code_Type := 16#209#;
   Error_Font_Bad_Font_Number                      : constant Error_Code_Type := 16#20A#;
   Error_Font_Not_Found                            : constant Error_Code_Type := 16#20B#;
   Error_Font_Bad_Font_File                        : constant Error_Code_Type := 16#20C#;
   Error_Font_No_Handles                           : constant Error_Code_Type := 16#20D#;
   Error_Font_Bad_Counter                          : constant Error_Code_Type := 16#20E#;
   Error_Font_Bad_CTRL_Char                        : constant Error_Code_Type := 16#20F#;
   Error_FontS_In_Use                              : constant Error_Code_Type := 16#210#;
   Error_Font_Bad_Segment                          : constant Error_Code_Type := 16#211#;
   Error_Font_Bad_Prefix                           : constant Error_Code_Type := 16#212#;
   Error_Font_Reserved                             : constant Error_Code_Type := 16#213#;
   Error_Font_Bad_Char_Code                        : constant Error_Code_Type := 16#214#;
   Error_Font_No_Bitmaps                           : constant Error_Code_Type := 16#215#;
   Error_Font_No_Bitmaps2                          : constant Error_Code_Type := 16#216#;
   Error_Font_Bad_Font_Cache_File                  : constant Error_Code_Type := 16#217#;
   Error_Font_Field_Not_Found                      : constant Error_Code_Type := 16#218#;
   Error_Font_Bad_Matrix                           : constant Error_Code_Type := 16#219#;
   Error_Font_Overflow                             : constant Error_Code_Type := 16#21A#;
   Error_Font_Divby0                               : constant Error_Code_Type := 16#21B#;
   Error_Font_Bad_Read_Metrics                     : constant Error_Code_Type := 16#21C#;
   Error_Font_Bad_RGB                              : constant Error_Code_Type := 16#21D#;
   Error_Font_Encoding_Not_Found                   : constant Error_Code_Type := 16#21E#;
   Error_Font_Must_Have_Slash                      : constant Error_Code_Type := 16#21F#;
   Error_Font_Bad_Encoding_Size                    : constant Error_Code_Type := 16#220#;
   Error_Font_Too_Many_Ids                         : constant Error_Code_Type := 16#221#;
   Error_Font_Too_Few_Ids                          : constant Error_Code_Type := 16#222#;
   Error_Font_No_Base_Encoding                     : constant Error_Code_Type := 16#223#;
   Error_Font_Identifier_Not_Found                 : constant Error_Code_Type := 16#224#;
   Error_Font_Too_Many_Chunks                      : constant Error_Code_Type := 16#225#;
   Error_Font_Bad_Font_File2                       : constant Error_Code_Type := 16#226#;

   Error_FS_Lock_Unknown_SWI                       : constant Error_Code_Type := 16#806500#;
   Error_FS_Lock_Locked                            : constant Error_Code_Type := 16#806501#;
   Error_FS_Lock_Unknown_FS                        : constant Error_Code_Type := 16#806502#;
   Error_FS_Lock_FS_Not_Lockable                   : constant Error_Code_Type := 16#806503#;
   Error_FS_Lock_No_Locked_FS                      : constant Error_Code_Type := 16#806504#;
   Error_FS_Lock_Protected_Disc                    : constant Error_Code_Type := 16#806505#;
   Error_FS_Lock_Killed                            : constant Error_Code_Type := 16#806506#;

   Error_Message_Trans_Syntax                      : constant Error_Code_Type := 16#AC0#;
   Error_Message_Trans_File_Open                   : constant Error_Code_Type := 16#AC1#;
   Error_Message_Trans_Token_Not_Found             : constant Error_Code_Type := 16#AC2#;
   Error_Message_Trans_Recurse                     : constant Error_Code_Type := 16#AC3#;

   Error_Net_FS_Bad_Command_Code                   : constant Error_Code_Type := 16#10501#;
   Error_Net_FS_Unexpected_Command_Code            : constant Error_Code_Type := 16#10502#;
   Error_Net_FS_Unknown_Function_Code              : constant Error_Code_Type := 16#10503#;
   Error_Net_FS_Unknown_Station_Name               : constant Error_Code_Type := 16#10504#;
   Error_Net_FS_Unknown_Station_Number             : constant Error_Code_Type := 16#10505#;
   Error_Net_FS_Station_Not_Found                  : constant Error_Code_Type := 16#10506#;
   Error_Net_FS_File_Server_Name_Too_Long          : constant Error_Code_Type := 16#10507#;
   Error_Net_FS_Bad_File_Server_Date               : constant Error_Code_Type := 16#10508#;
   Error_Net_FS_Net_FS_Internal_Error              : constant Error_Code_Type := 16#10509#;
   Error_Net_FS_File_Server_Not_Capable            : constant Error_Code_Type := 16#1050A#;
   Error_Net_FS_Broadcast_Server_Dead              : constant Error_Code_Type := 16#1050B#;
   Error_Net_FS_File_Server_Only24_Bit             : constant Error_Code_Type := 16#1050C#;
   Error_Net_Utils_Wrong_Version                   : constant Error_Code_Type := 16#1053A#;
   Error_Net_Utils_Net_FS_No_Go                    : constant Error_Code_Type := 16#1053B#;
   Error_Net_Utils_Is_Threaded                     : constant Error_Code_Type := 16#1053C#;
   Error_Net_FS_Set_Free_Syntax                    : constant Error_Code_Type := 16#10540#;
   Error_Net_FS_FS_Cli_Syntax                      : constant Error_Code_Type := 16#10541#;

   Error_Net_Print_Name_Too_Long                   : constant Error_Code_Type := 16#10C00#;
   Error_Net_Print_Single_Stream                   : constant Error_Code_Type := 16#10C01#;
   Error_Net_Print_All_Printers_Busy               : constant Error_Code_Type := 16#10C02#;
   Error_Net_Print_Off_Line                        : constant Error_Code_Type := 16#10C09#;
   Error_Net_Print_Not_Found                       : constant Error_Code_Type := 16#10C0A#;
   Error_Net_Print_Internal_Error                  : constant Error_Code_Type := 16#10C0B#;

   Error_Heap_Bad_Reason                           : constant Error_Code_Type := 16#180#;
   Error_Heap_Init                                 : constant Error_Code_Type := 16#181#;
   Error_Heap_Bad_Desc                             : constant Error_Code_Type := 16#182#;
   Error_Heap_Bad_Link                             : constant Error_Code_Type := 16#183#;
   Error_Heap_Alloc                                : constant Error_Code_Type := 16#184#;
   Error_Heap_Not_ABlock                           : constant Error_Code_Type := 16#185#;
   Error_Heap_Bad_Extend                           : constant Error_Code_Type := 16#186#;
   Error_Heap_Excessive_Shrink                     : constant Error_Code_Type := 16#187#;
   Error_Heap_Heap_Locked                          : constant Error_Code_Type := 16#188#;

   Exception_Heap_Bad_Reason                            : Exception;
   Exception_Heap_Init                                  : Exception;  
   Exception_Heap_Bad_Desc                              : Exception;  
   Exception_Heap_Bad_Link                              : Exception;  
   Exception_Heap_Alloc                                 : Exception;  
   Exception_Heap_Not_ABlock                            : Exception;  
   Exception_Heap_Bad_Extend                            : Exception;  
   Exception_Heap_Excessive_Shrink                      : Exception;
   Exception_Heap_Heap_Locked                           : Exception;

   Exception_Net_Print_Name_Too_Long                    : Exception;
   Exception_Net_Print_Single_Stream                    : Exception;
   Exception_Net_Print_All_Printers_Busy                : Exception;
   Exception_Net_Print_Off_Line                         : Exception;
   Exception_Net_Print_Not_Found                        : Exception;
   Exception_Net_Print_Internal_Error                   : Exception;
                                    
   Exception_Net_FS_Bad_Command_Code                    : Exception;
   Exception_Net_FS_Unexpected_Command_Code             : Exception;
   Exception_Net_FS_Unknown_Function_Code               : Exception;
   Exception_Net_FS_Unknown_Station_Name                : Exception;
   Exception_Net_FS_Unknown_Station_Number              : Exception;
   Exception_Net_FS_Station_Not_Found                   : Exception;
   Exception_Net_FS_File_Server_Name_Too_Long           : Exception;
   Exception_Net_FS_Bad_File_Server_Date                : Exception;
   Exception_Net_FS_Net_FS_Internal_Error               : Exception;
   Exception_Net_FS_File_Server_Not_Capable             : Exception;
   Exception_Net_FS_Broadcast_Server_Dead               : Exception;
   Exception_Net_FS_File_Server_Only24_Bit              : Exception;
   Exception_Net_Utils_Wrong_Version                    : Exception;
   Exception_Net_Utils_Net_FS_No_Go                     : Exception;
   Exception_Net_Utils_Is_Threaded                      : Exception;
   Exception_Net_FS_Set_Free_Syntax                     : Exception;
   Exception_Net_FS_FS_Cli_Syntax                       : Exception;


   Exception_Message_Trans_Syntax                       : Exception;
   Exception_Message_Trans_File_Open                    : Exception;               
   Exception_Message_Trans_Token_Not_Found              : Exception;
   Exception_Message_Trans_Recurse                      : Exception;              

   Exception_FS_Lock_Unknown_SWI                        : Exception;
   Exception_FS_Lock_Locked                             : Exception; 
   Exception_FS_Lock_Unknown_FS                         : Exception; 
   Exception_FS_Lock_FS_Not_Lockable                    : Exception;
   Exception_FS_Lock_No_Locked_FS                       : Exception; 
   Exception_FS_Lock_Protected_Disc                     : Exception; 
   Exception_FS_Lock_Killed                             : Exception;

   Exception_Font_No_Room                               : Exception;
   Exception_Font_Cache_Full                            : Exception; 
   Exception_Font_No_Cache                              : Exception; 
   Exception_Font_Too_Long                              : Exception; 
   Exception_Font64K                                    : Exception; 
   Exception_Font_Pal_Too_Big                           : Exception; 
   Exception_Font_Bad_Tran_Bits                         : Exception; 
   Exception_Font_Not_Enough_Bits                       : Exception; 
   Exception_Font_No_Font                               : Exception; 
   Exception_Font_No_Pixels                             : Exception; 
   Exception_Font_Bad_Font_Number                       : Exception; 
   Exception_Font_Not_Found                             : Exception; 
   Exception_Font_Bad_Font_File                         : Exception; 
   Exception_Font_No_Handles                            : Exception; 
   Exception_Font_Bad_Counter                           : Exception; 
   Exception_Font_Bad_CTRL_Char                         : Exception; 
   Exception_FontS_In_Use                               : Exception; 
   Exception_Font_Bad_Segment                           : Exception; 
   Exception_Font_Bad_Prefix                            : Exception; 
   Exception_Font_Reserved                              : Exception; 
   Exception_Font_Bad_Char_Code                         : Exception; 
   Exception_Font_No_Bitmaps                            : Exception; 
   Exception_Font_No_Bitmaps2                           : Exception; 
   Exception_Font_Bad_Font_Cache_File                   : Exception; 
   Exception_Font_Field_Not_Found                       : Exception; 
   Exception_Font_Bad_Matrix                            : Exception; 
   Exception_Font_Overflow                              : Exception; 
   Exception_Font_Divby0                                : Exception; 
   Exception_Font_Bad_Read_Metrics                      : Exception; 
   Exception_Font_Bad_RGB                               : Exception; 
   Exception_Font_Encoding_Not_Found                    : Exception; 
   Exception_Font_Must_Have_Slash                       : Exception; 
   Exception_Font_Bad_Encoding_Size                     : Exception; 
   Exception_Font_Too_Many_Ids                          : Exception; 
   Exception_Font_Too_Few_Ids                           : Exception; 
   Exception_Font_No_Base_Encoding                      : Exception; 
   Exception_Font_Identifier_Not_Found                  : Exception;
   Exception_Font_Too_Many_Chunks                       : Exception; 
   Exception_Font_Bad_Font_File2                        : Exception; 

   Exception_File_Switch_No_Claim                       : Exception;
   Exception_Bad_FS_Control_Reason                      : Exception;
   Exception_Bad_OS_File_Reason                         : Exception;
   Exception_Bad_OS_Args_Reason                         : Exception;
   Exception_Bad_OSGBPB_Reason                          : Exception;
   Exception_Bad_Mode_For_OS_Find                       : Exception;
   Exception_No_Room_For_Transient                      : Exception;
   Exception_Exec_Addr_Not_In_Code                      : Exception;
   Exception_Exec_Addr_TOO_Low                          : Exception;
   Exception_Unknown_Action_Type                        : Exception;
   Exception_Too_Many_Levels                            : Exception;
   Exception_No_Selected_Filing_System                  : Exception;
   Exception_Cant_Remove_FS_By_Number                   : Exception;
   Exception_Unaligned_FS_Entry                         : Exception;
   Exception_Unsupported_FS_Entry                       : Exception;
   Exception_Fs_Not_Special                             : Exception;
   Exception_Core_Not_Readable                          : Exception;
   Exception_Core_Not_Writeable                         : Exception;
   Exception_Bad_Buffer_Size_For_Stream                 : Exception;
   Exception_Not_Open_For_Reading                       : Exception;
   Exception_Not_Enough_Stack_For_FS_Entry              : Exception;
   Exception_Nothing_To_Copy                            : Exception;
   Exception_Nothing_To_Delete                          : Exception;
   Exception_File_Switch_Cant_Be_Killed_Whilst_Threaded : Exception;
   Exception_Invalid_Error_Block                        : Exception;
   Exception_FS_File_Too_Big                            : Exception;
   Exception_Cant_RM_Faster_File_Switch                 : Exception;
   Exception_Inconsistent_Handle_Set                    : Exception;
   Exception_Is_AFile                                   : Exception;
   Exception_Bad_File_Type                              : Exception;
   Exception_Library_Somewhere_Else                     : Exception;
   Exception_Path_Is_Self_Contradictory                 : Exception;
   Exception_Wasnt_Dollar_After_Disc                    : Exception;
   Exception_Not_Enough_Memory_For_Wildcard_Resolution  : Exception;
   Exception_Not_Enough_Stack_For_Wildcard_Resolution   : Exception;
   Exception_Dir_Wanted_File_Found                      : Exception;
   Exception_Not_Found                                  : Exception;
   Exception_Multipart_Path_Used                        : Exception;
   Exception_Recursive_Path                             : Exception;
   Exception_Multi_FS_Does_Not_Support_GBPB11           : Exception;
   Exception_File_Switch_Data_Lost                      : Exception;
   Exception_Too_Many_Error_Lookups                     : Exception;
   Exception_Message_File_Busy                          : Exception;
   Exception_Partition_Busy                             : Exception;

   Exception_Filer_No_Recursion                    : Exception;
   Exception_Filer_No_Template                     : Exception;
   Exception_Filer_Failed_Save                     : Exception;
   Exception_Filer_Bad_Path                        : Exception;
                           
   Exception_Econet_Tx_Ready                       : Exception;
   Exception_Econet_Transmitting                   : Exception;
   Exception_Econet_Rx_Ready                       : Exception;
   Exception_Econet_Receiving                      : Exception;
   Exception_Econet_Received                       : Exception;
   Exception_Econet_Transmitted                    : Exception;
   Exception_Econet_Bad_Station                    : Exception;
   Exception_Econet_Bad_Network                    : Exception;
   Exception_Econet_Unable_To_Default              : Exception;
   Exception_Econet_Bad_Port                       : Exception;
   Exception_Econet_Bad_Control                    : Exception;
   Exception_Econet_Bad_Buffer                     : Exception;
   Exception_Econet_Bad_Size                       : Exception;
   Exception_Econet_Bad_Mask                       : Exception;
   Exception_Econet_Bad_Count                      : Exception;
   Exception_Econet_Bad_Delay                      : Exception;
   Exception_Econet_Bad_Status                     : Exception;
   Exception_Econet_No_Hardware                    : Exception;
   Exception_Econet_No_Econet                      : Exception;
   Exception_Econet_No_More_Domains                : Exception;
   Exception_Econet_Bad_Domain                     : Exception;
   Exception_Econet_Un_Registered_Domain           : Exception;
   Exception_Econet_Port_Not_Allocated             : Exception;
   Exception_Econet_Port_Allocated                 : Exception;
   Exception_Econet_No_More_Ports                  : Exception;

   Exception_Draw_File_Not_Draw                    : Exception;
   Exception_Draw_File_Version                     : Exception; 
   Exception_Draw_File_Font_Tab                    : Exception; 
   Exception_Draw_File_Bad_Font_No                 : Exception; 
   Exception_Draw_File_Bad_Mode                    : Exception; 
   Exception_Draw_File_Bad_File                    : Exception; 
   Exception_Draw_File_Bad_Group                   : Exception; 
   Exception_Draw_File_Bad_Tag                     : Exception; 
   Exception_Draw_File_Syntax                      : Exception; 
   Exception_Draw_File_Font_No                     : Exception; 
   Exception_Draw_File_Area_Ver                    : Exception; 
   Exception_Draw_File_No_Area_Ver                 : Exception;

   Exception_Draw_No_Draw_In_IRQ_Mode              : Exception;
   Exception_Draw_Bad_Draw_Reason_Code             : Exception; 
   Exception_Draw_Reserved_Draw_Bits               : Exception; 
   Exception_Draw_Invalid_Draw_Address             : Exception; 
   Exception_Draw_Bad_Path_Element                 : Exception; 
   Exception_Draw_Bad_Path_Sequence                : Exception; 
   Exception_Draw_May_Expand_Path                  : Exception; 
   Exception_Draw_Path_Full                        : Exception; 
   Exception_Draw_Path_Not_Flat                    : Exception; 
   Exception_Draw_Bad_Caps_Or_Joins                : Exception; 
   Exception_Draw_Transform_Overflow               : Exception; 
   Exception_Draw_Draw_Needs_Graphics_Mode         : Exception;
   Exception_Draw_Unimplemented_Draw               : Exception;

   Exception_Debug_Break_Not_Found                 : Exception;
   Exception_Debug_invalid_Value                   : Exception;  
   Exception_Debug_Resetting                       : Exception;  
   Exception_Debug_No_Room                         : Exception;  
   Exception_Debug_No_Breakpoints                  : Exception;  
   Exception_Debug_Bad_Breakpoint                  : Exception;  
   Exception_Debug_Undefined                       : Exception;  
   Exception_Debug_Non_Aligned                     : Exception;  
   Exception_Debug_No_Workspace                    : Exception;

   Exception_DDE_Utils_Unknown_SWI                 : Exception;
   Exception_DDE_Utils_No_CLI_Buffer               : Exception;
   Exception_DDE_Utils_Not_Desktop                 : Exception;
   Exception_DDE_Utils_No_Task                     : Exception;
   Exception_DDE_Utils_Already_Registered          : Exception;
   Exception_DDE_Utils_Not_Registered              : Exception;

   Exception_Compress_JPEG_Bad_BPP                 : Exception;
   Exception_Compress_JPEG_Bad_Line_Count          : Exception;
   Exception_Compress_JPEG_Bad_Buffer              : Exception;
   Exception_Compress_JPEG_Bad_Size                : Exception;
   Exception_Compress_JPEG_Arith_Not_Impl          : Exception;
   Exception_Compress_JPEG_Bad_Align_Type          : Exception;
   Exception_Compress_JPEG_Bad_Alloc_Chunk         : Exception;
   Exception_Compress_JPEG_Bad_Buffer_Mode         : Exception;
   Exception_Compress_JPEG_Bad_Component_ID        : Exception;
   Exception_Compress_JPEG_Bad_DCT_Size            : Exception;
   Exception_Compress_JPEG_Bad_In_Colour_Space     : Exception;
   Exception_Compress_JPEG_Bad_KColour_Space       : Exception;
   Exception_Compress_JPEG_Bad_Length              : Exception;
   Exception_Compress_JPEG_Bad_MCU_Size            : Exception;
   Exception_Compress_JPEG_Bad_Pool_ID             : Exception;
   Exception_Compress_JPEG_Bad_Precision           : Exception;
   Exception_Compress_JPEG_Bad_Sampling            : Exception;
   Exception_Compress_JPEG_Bad_State               : Exception;
   Exception_Compress_JPEG_Bad_Virtual_Access      : Exception;
   Exception_Compress_JPEG_Buffer_Size             : Exception;
   Exception_Compress_JPEG_Cant_Suspend            : Exception;
   Exception_Compress_JPEGCCIR601_Not_Impl         : Exception;
   Exception_Compress_JPEG_Component_Count         : Exception;
   Exception_Compress_JPEG_Conversion_Not_Impl     : Exception;
   Exception_Compress_JPEGDAC_Index                : Exception;
   Exception_Compress_JPEGDAC_Value                : Exception;
   Exception_Compress_JPEGDHT_Index                : Exception;
   Exception_Compress_JPEGDQT_Index                : Exception;
   Exception_Compress_JPEG_Empty_Image             : Exception;
   Exception_Compress_JPEGEOI_Expected             : Exception;
   Exception_Compress_JPEG_File_Read               : Exception;
   Exception_Compress_JPEG_File_Write              : Exception;
   Exception_Compress_JPEG_Fract_Sample_Not_Impl   : Exception;
   Exception_Compress_JPEG_Huff_Clen_Overflow      : Exception;
   Exception_Compress_JPEG_Huff_Missing_Code       : Exception;
   Exception_Compress_JPEG_Image_Too_Big           : Exception;
   Exception_Compress_JPEG_Input_Empty             : Exception;
   Exception_Compress_JPEG_Input_EOF               : Exception;
   Exception_Compress_JPEG_Not_Impl                : Exception;
   Exception_Compress_JPEG_Not_Compiled            : Exception;
   Exception_Compress_JPEG_No_Backing_Store        : Exception;
   Exception_Compress_JPEG_No_Huff_Table           : Exception;
   Exception_Compress_JPEG_No_Image                : Exception;
   Exception_Compress_JPEG_No_Quant_Table          : Exception;
   Exception_Compress_JPEG_No_Soi                  : Exception;
   Exception_Compress_JPEG_Out_Of_Memory           : Exception;
   Exception_Compress_JPEG_Quant_Components        : Exception;
   Exception_Compress_JPEG_Quant_Few_Colours       : Exception;
   Exception_Compress_JPEG_Quant_Many_Colours      : Exception;
   Exception_Compress_JPEGSOF_Duplicate            : Exception;
   Exception_Compress_JPEGSOF_No_Sos               : Exception;
   Exception_Compress_JPEGSOF_Unsupported          : Exception;
   Exception_Compress_JPEGSOI_Duplicate            : Exception;
   Exception_Compress_JPEGSOS_No_Sof               : Exception;
   Exception_Compress_JPEG_Too_Little_Data         : Exception;
   Exception_Compress_JPEG_Unknown_Marker          : Exception;
   Exception_Compress_JPEG_Virtual_Bug             : Exception;
   Exception_Compress_JPEG_Width_Overflow          : Exception;
   Exception_Compress_JPEG_Bad_DCT_Coef            : Exception;
   Exception_Compress_JPEG_Bad_Huff_Table          : Exception;
   Exception_Compress_JPEG_Bad_Progression         : Exception;
   Exception_Compress_JPEG_Bad_Prog_Script         : Exception;
   Exception_Compress_JPEG_Bad_Scan_Script         : Exception;
   Exception_Compress_JPEG_Mismatched_Quant_Table  : Exception;
   Exception_Compress_JPEG_Missing_Data            : Exception;
   Exception_Compress_JPEG_Mode_Change             : Exception;
   Exception_Compress_JPEGW_Buffer_Size            : Exception;

   Exception_Colour_Trans_Bad_Calib                : Exception; 
   Exception_Colour_Trans_Conv_Over                : Exception; 
   Exception_Colour_Trans_Bad_HSV                  : Exception; 
   Exception_Colour_Trans_Switched                 : Exception; 
   Exception_Colour_Trans_Bad_Misc_Op              : Exception;
   Exception_Colour_Trans_Bad_Flags                : Exception; 
   Exception_Colour_Trans_Buff_Over                : Exception; 
   Exception_Colour_Trans_Bad_Depth                : Exception; 

   Exception_Colour_Picker_Uninit                  : Exception; 
   Exception_Colour_Picker_Bad_Model               : Exception; 
   Exception_Colour_Picker_Bad_Handle              : Exception; 
   Exception_Colour_Picker_Bad_Flags               : Exception; 
   Exception_Colour_Picker_In_Use                  : Exception; 
   Exception_Colour_Picker_Model_In_Use            : Exception; 
   Exception_Colour_Picker_Bad_Reason              : Exception;

   Exception_Colour_DBox_Tasks_Active              : Exception;
   Exception_Colour_DBox_Alloc_Failed              : Exception;
   Exception_Colour_DBox_Short_Buffer              : Exception;
   Exception_Colour_DBox_No_Such_Task              : Exception;
   Exception_Colour_DBox_No_Such_Method            : Exception;
   Exception_Colour_DBox_No_Such_Misc_op_Method    : Exception;

   Exception_CD_Base                               : Exception; 
   Exception_CD_Bad_Alignment                      : Exception; 
   Exception_CD_Drive_Not_Supported                : Exception; 
   Exception_CD_Bad_Mode                           : Exception; 
   Exception_CD_Invalid_Parameter                  : Exception; 
   Exception_CD_Not_Audio_Track                    : Exception; 
   Exception_CD_No_Caddy                           : Exception; 
   Exception_CD_No_Drive                           : Exception; 
   Exception_CD_Invalid_Format                     : Exception; 
   Exception_CD_Bad_Minutes                        : Exception; 
   Exception_CD_Bad_Seconds                        : Exception; 
   Exception_CD_Bad_Blocks                         : Exception; 
   Exception_CD_Physical_Block_Bad                 : Exception; 
   Exception_CD_Drawer_Locked                      : Exception; 
   Exception_CD_Wrong_Data_Mode                    : Exception;
   Exception_CD_Channel_Not_Supported              : Exception;
   Exception_CD_Bad_Device_ID                      : Exception; 
   Exception_CD_Bad_Card_Number                    : Exception; 
   Exception_CD_Bad_Lun_Number                     : Exception; 
   Exception_CD_No_Such_Track                      : Exception; 
   Exception_CD_Faulty_Disc                        : Exception; 
   Exception_CD_No_Such_Block                      : Exception; 
   Exception_CD_Not_Supported                      : Exception; 
   Exception_CD_Driver_Not_Present                 : Exception; 
   Exception_CD_SWI_Not_Supported                  : Exception; 
   Exception_CD_Too_Many_Drivers                   : Exception; 
   Exception_CD_Not_Registered                     : Exception; 

   Exception_ADFS_Driver_In_Use                    : Exception;

   Exception_Escape                                : Exception;
   Exception_Bad_mode                              : Exception;
   Exception_Is_adir                               : Exception;
   Exception_Types_dont_match                      : Exception;
   Exception_Bad_rename                            : Exception;
   Exception_Bad_copy                              : Exception;
   Exception_Outside_file                          : Exception;
   Exception_Access_violation                      : Exception;
   Exception_Too_many_open_files                   : Exception;
   Exception_Not_open_for_update                   : Exception;
   Exception_File_open                             : Exception;
   Exception_Object_locked                         : Exception;
   Exception_Already_exists                        : Exception;
   Exception_Bad_file_name                         : Exception;
   Exception_File_not_found                        : Exception;
   Exception_Syntax                                : Exception;
   Exception_Channel                               : Exception;
   Exception_End_of_file                           : Exception;
   Exception_Buffer_Overflow                       : Exception;
   Exception_Bad_filing_system_name                : Exception;
   Exception_Bad_key                               : Exception;
   Exception_Bad_address                           : Exception;
   Exception_Bad_string                            : Exception;
   Exception_Bad_command                           : Exception;
   Exception_Bad_mac_val                           : Exception;
   Exception_Bad_var_nam                           : Exception;
   Exception_Bad_var_type                          : Exception;
   Exception_Var_no_room                           : Exception;
   Exception_Var_cant_find                         : Exception;
   Exception_Var_too_long                          : Exception;
   Exception_Redirect_fail                         : Exception;
   Exception_Stack_full                            : Exception;
   Exception_Bad_hex                               : Exception;
   Exception_Bad_expr                              : Exception;
   Exception_Bad_bra                               : Exception;
   Exception_Stk_oflo                              : Exception;
   Exception_Miss_opn                              : Exception;
   Exception_Miss_opr                              : Exception;
   Exception_Bad_bits                              : Exception;
   Exception_Str_oflo                              : Exception;
   Exception_Bad_itm                               : Exception;
   Exception_Div_zero                              : Exception;
   Exception_Bad_base                              : Exception;
   Exception_Bad_numb                              : Exception;
   Exception_Numb_too_big                          : Exception;
   Exception_Bad_claim_num                         : Exception;
   Exception_Bad_release                           : Exception;
   Exception_Bad_dev_no                            : Exception;
   Exception_Bad_dev_vec_rel                       : Exception;
   Exception_Bad_env_number                        : Exception;
   Exception_Cant_cancel_quit                      : Exception;
   Exception_Ch_dynam_cao                          : Exception;
   Exception_Ch_dynam_not_all_moved                : Exception;
   Exception_Apl_wspace_in_use                     : Exception;
   Exception_Ram_fs_unchangeable                   : Exception;
   Exception_Oscli_long_line                       : Exception;
   Exception_Oscli_too_hard                        : Exception;
   Exception_Rc_exc                                : Exception;
   Exception_Sys_heap_full                         : Exception;
   Exception_Buff_overflow                         : Exception;
   Exception_Bad_time                              : Exception;
   Exception_No_such_swi                           : Exception;
   Exception_Unimplemented                         : Exception;
   Exception_Out_of_range                          : Exception;
   Exception_No_oscli_specials                     : Exception;
   Exception_Bad_parameters                        : Exception;
   Exception_Arg_repeated                          : Exception;
   Exception_Bad_read_sys_info                     : Exception;
   Exception_Cdat_stack_overflow                   : Exception;
   Exception_Cdat_buffer_overflow                  : Exception;
   Exception_Cdat_bad_field                        : Exception;
   Exception_Cant_start_application                : Exception;
   Exception_Unknown_Error                         : Exception;

   -- Toolbox errors
   Error_Window_Alloc_Failed                       : constant Error_Code_Type := 16#80a901#;
   Error_Window_Short_Buffer                       : constant Error_Code_Type := 16#80a902#;
   Error_Window_Bad_Version                        : constant Error_Code_Type := 16#80a903#;
   Error_Window_Invalid_Flags                      : constant Error_Code_Type := 16#80a904#;
   Error_Window_Tasks_Active                       : constant Error_Code_Type := 16#80a905#;
   Error_Window_No_Such_Task                       : constant Error_Code_Type := 16#80a911#;
   Error_Window_No_Such_Method                     : constant Error_Code_Type := 16#80a912#;
   Error_Window_No_Such_Misc_Op_Method             : constant Error_Code_Type := 16#80a913#;
   Error_Window_Invalid_Component_Id               : constant Error_Code_Type := 16#80a914#;
   Error_Window_Duplicate_Component_Id             : constant Error_Code_Type := 16#80a915#;
   Error_Window_Invalid_Gadget_Type                : constant Error_Code_Type := 16#80a920#;
                                                   
   Error_Tool_Action_Out_of_Memory                 : constant Error_Code_Type := 16#80E920#;
   Error_Tool_Action_Cant_Create_Icon              : constant Error_Code_Type := 16#80E921#;
   Error_Tool_Action_Cant_Create_Object            : constant Error_Code_Type := 16#80E922#;
                                                   
   Error_Prog_Info_Tasks_Active                    : constant Error_Code_Type := 16#80B400#;
   Error_Prog_Info_Alloc_Failed                    : constant Error_Code_Type := 16#80B401#;
   Error_Prog_Info_Short_Buffer                    : constant Error_Code_Type := 16#80B402#;
   Error_Prog_Info_No_Such_Task                    : constant Error_Code_Type := 16#80B411#;
   Error_Prog_Info_No_Such_Method                  : constant Error_Code_Type := 16#80B412#;
   Error_Prog_Info_No_Such_Misc_Op_Method          : constant Error_Code_Type := 16#80B413#;
                                                   
   Error_Print_DBox_Tasks_Active                   : constant Error_Code_Type := 16#80B300#;
   Error_Print_DBox_Alloc_Failed                   : constant Error_Code_Type := 16#80B301#;
   Error_Print_DBox_Short_Buffer                   : constant Error_Code_Type := 16#80B302#;
   Error_Print_DBox_No_Such_Task                   : constant Error_Code_Type := 16#80B311#;
   Error_Print_DBox_No_Such_Method                 : constant Error_Code_Type := 16#80B312#;
   Error_Print_DBox_No_Such_Misc_Op_Method         : constant Error_Code_Type := 16#80B313#;
                                                   
   Error_Menu_Tasks_Active                         : constant Error_Code_Type := 16#80AA00#;
   Error_Menu_Alloc_Failed                         : constant Error_Code_Type := 16#80AA01#;
   Error_Menu_Short_Buffer                         : constant Error_Code_Type := 16#80AA02#;
   Error_Menu_No_Such_Task                         : constant Error_Code_Type := 16#80AA11#;
   Error_Menu_No_Such_Method                       : constant Error_Code_Type := 16#80AA12#;
   Error_Menu_No_Such_Misc_op_method               : constant Error_Code_Type := 16#80AA13#;
   Error_Menu_No_Such_Component                    : constant Error_Code_Type := 16#80AA14#;
   Error_Menu_Sprite_Not_Text                      : constant Error_Code_Type := 16#80AA21#;
   Error_Menu_Text_Not_Sprite                      : constant Error_Code_Type := 16#80AA22#;
   Error_Menu_No_Top_Menu                          : constant Error_Code_Type := 16#80AA31#;
   Error_Menu_Unknown_Sub_Menu                     : constant Error_Code_Type := 16#80AA32#;
   Error_Menu_No_Sprite_Name                       : constant Error_Code_Type := 16#80AA33#;
                                                   
   Error_Iconbar_Alloc_Failed                      : constant Error_Code_Type := 16#80AB01#;
   Error_Iconbar_Short_Buffer                      : constant Error_Code_Type := 16#80AB02#;
   Error_Iconbar_Bad_Object_Version                : constant Error_Code_Type := 16#80AB03#;
   Error_Iconbar_Bad_Flags                         : constant Error_Code_Type := 16#80AB04#;
   Error_Iconbar_No_Such_Task                      : constant Error_Code_Type := 16#80AB11#;
   Error_Iconbar_No_Such_Method                    : constant Error_Code_Type := 16#80AB12#;
   Error_Iconbar_No_Such_Misc_Op_Method            : constant Error_Code_Type := 16#80AB13#;
   Error_Iconbar_Wrong_Show_Type                   : constant Error_Code_Type := 16#80AB14#;
   Error_Iconbar_No_Text                           : constant Error_Code_Type := 16#80AB20#;
   Error_Iconbar_Tasks_Active                      : constant Error_Code_Type := 16#80AB21#;
                                                   
   Error_FontOrColour_Menu_Tasks_Active            : constant Error_Code_Type := 16#80B000#;
   Error_FontOrColour_Menu_Alloc_Failed            : constant Error_Code_Type := 16#80B001#;
   Error_FontOrColour_Menu_Short_Buffer            : constant Error_Code_Type := 16#80B002#;
   Error_FontOrColour_Menu_No_Such_Task            : constant Error_Code_Type := 16#80B011#;
   Error_FontOrColour_Menu_No_Such_Method          : constant Error_Code_Type := 16#80B012#;
   Error_FontOrColour_Menu_No_Such_Misc_Op_Method  : constant Error_Code_Type := 16#80B013#;
                                                   
   Error_Font_DBox_Tasks_Active                    : constant Error_Code_Type := 16#80AF00#;
   Error_Font_DBox_Alloc_Failed                    : constant Error_Code_Type := 16#80AF01#;
   Error_Font_DBox_Short_Buffer                    : constant Error_Code_Type := 16#80AF02#;
   Error_Font_DBox_No_Such_Task                    : constant Error_Code_Type := 16#80AF11#;
   Error_Font_DBox_No_Such_Method                  : constant Error_Code_Type := 16#80AF12#;
   Error_Font_DBox_No_Such_Misc_Op_Method          : constant Error_Code_Type := 16#80AF13#;
   Error_Font_DBox_No_Such_Font                    : constant Error_Code_Type := 16#80AF14#;
   Error_Font_DBox_No_Fonts                        : constant Error_Code_Type := 16#80AF21#;
   Error_Font_DBox_Out_Of_Message_Space            : constant Error_Code_Type := 16#80AF31#;


   Error_File_Info_Tasks_Active                    : constant Error_Code_Type := 16#80B200#;
   Error_File_Info_Alloc_Failed                    : constant Error_Code_Type := 16#80B201#;
   Error_File_Info_Short_Buffer                    : constant Error_Code_Type := 16#80B202#;
   Error_File_Info_No_Such_Task                    : constant Error_Code_Type := 16#80B211#;
   Error_File_Info_No_Such_Method                  : constant Error_Code_Type := 16#80B212#;
   Error_File_Info_No_Such_Misc_Op_Method          : constant Error_Code_Type := 16#80B213#;

   Error_DCS_Alloc_Failed                          : constant Error_Code_Type := 16#80B101#;
   Error_DCS_Tasks_Active                          : constant Error_Code_Type := 16#80B102#;

   Error_Toolbox_No_Mem                            : constant Error_Code_Type := 16#80CB00#;
   Error_Toolbox_Bad_SWI                           : constant Error_Code_Type := 16#80CB01#;
   Error_Toolbox_Invalid_object_Id                 : constant Error_Code_Type := 16#80CB02#;
   Error_Toolbox_Not_Atoolbox_Task                 : constant Error_Code_Type := 16#80CB03#;
   Error_Toolbox_No_Dir_Name                       : constant Error_Code_Type := 16#80CB04#;
   Error_Toolbox_No_Msgs_Fd                        : constant Error_Code_Type := 16#80CB05#;
   Error_Toolbox_No_Id_Block                       : constant Error_Code_Type := 16#80CB06#;
   Error_Toolbox_Bad_Res_File                      : constant Error_Code_Type := 16#80CB07#;
   Error_Toolbox_Tasks_Active                      : constant Error_Code_Type := 16#80CB08#;
   Error_Toolbox_Template_Not_Found                : constant Error_Code_Type := 16#80CB09#;
   Error_Toolbox_No_Such_Pre_Filter                : constant Error_Code_Type := 16#80CB0A#;
   Error_Toolbox_Not_Ares_File                     : constant Error_Code_Type := 16#80CB0B#;
   Error_Toolbox_Bad_Res_File_Version              : constant Error_Code_Type := 16#80CB0C#;
   Error_Toolbox_Bad_Flags                         : constant Error_Code_Type := 16#80CB0D#;

   Exception_Toolbox_No_Mem                        : Exception;
   Exception_Toolbox_Bad_SWI                       : Exception;
   Exception_Toolbox_Invalid_object_Id             : Exception;
   Exception_Toolbox_Not_Atoolbox_Task             : Exception;
   Exception_Toolbox_No_Dir_Name                   : Exception;
   Exception_Toolbox_No_Msgs_Fd                    : Exception;
   Exception_Toolbox_No_Id_Block                   : Exception;
   Exception_Toolbox_Bad_Res_File                  : Exception;
   Exception_Toolbox_Tasks_Active                  : Exception;
   Exception_Toolbox_Template_Not_Found            : Exception;
   Exception_Toolbox_No_Such_Pre_Filter            : Exception;
   Exception_Toolbox_Not_Ares_File                 : Exception;
   Exception_Toolbox_Bad_Res_File_Version          : Exception;
   Exception_Toolbox_Bad_Flags                     : Exception;

   Exception_DCS_Alloc_Failed                      : Exception;
   Exception_DCS_Tasks_Active                      : Exception;

   Exception_File_Info_Tasks_Active                : Exception;
   Exception_File_Info_Alloc_Failed                : Exception;
   Exception_File_Info_Short_Buffer                : Exception;
   Exception_File_Info_No_Such_Task                : Exception;
   Exception_File_Info_No_Such_Method              : Exception;
   Exception_File_Info_No_Such_Misc_Op_Method      : Exception;

   Exception_Font_DBox_Tasks_Active                : Exception;
   Exception_Font_DBox_Alloc_Failed                : Exception; 
   Exception_Font_DBox_Short_Buffer                : Exception; 
   Exception_Font_DBox_No_Such_Task                : Exception; 
   Exception_Font_DBox_No_Such_Method              : Exception; 
   Exception_Font_DBox_No_Such_Misc_Op_Method      : Exception; 
   Exception_Font_DBox_No_Such_Font                : Exception; 
   Exception_Font_DBox_No_Fonts                    : Exception; 
   Exception_Font_DBox_Out_Of_Message_Space        : Exception;

   Exception_FontOrColour_Menu_Tasks_Active           : Exception;
   Exception_FontOrColour_Menu_Alloc_Failed           : Exception;
   Exception_FontOrColour_Menu_Short_Buffer           : Exception;
   Exception_FontOrColour_Menu_No_Such_Task           : Exception;
   Exception_FontOrColour_Menu_No_Such_Method         : Exception;
   Exception_FontOrColour_Menu_No_Such_Misc_Op_Method : Exception;

   Exception_Iconbar_Alloc_Failed                  : Exception;
   Exception_Iconbar_Short_Buffer                  : Exception;
   Exception_Iconbar_Bad_Object_Version            : Exception;
   Exception_Iconbar_Bad_Flags                     : Exception;
   Exception_Iconbar_No_Such_Task                  : Exception;
   Exception_Iconbar_No_Such_Method                : Exception;
   Exception_Iconbar_No_Such_Misc_Op_Method        : Exception;
   Exception_Iconbar_Wrong_Show_Type               : Exception;
   Exception_Iconbar_No_Text                       : Exception;
   Exception_Iconbar_Tasks_Active                  : Exception;
                                                   
   Exception_Menu_Tasks_Active                     : Exception;
   Exception_Menu_Alloc_Failed                     : Exception;
   Exception_Menu_Short_Buffer                     : Exception;  
   Exception_Menu_No_Such_Task                     : Exception;  
   Exception_Menu_No_Such_Method                   : Exception;  
   Exception_Menu_No_Such_Misc_op_method           : Exception;  
   Exception_Menu_No_Such_Component                : Exception;  
   Exception_Menu_Sprite_Not_Text                  : Exception;  
   Exception_Menu_Text_Not_Sprite                  : Exception;  
   Exception_Menu_No_Top_Menu                      : Exception;  
   Exception_Menu_Unknown_Sub_Menu                 : Exception;  
   Exception_Menu_No_Sprite_Name                   : Exception;
                                                   
   Exception_Print_DBox_Tasks_Active               : Exception;
   Exception_Print_DBox_Alloc_Failed               : Exception;
   Exception_Print_DBox_Short_Buffer               : Exception;
   Exception_Print_DBox_No_Such_Task               : Exception;
   Exception_Print_DBox_No_Such_Method             : Exception;
   Exception_Print_DBox_No_Such_Misc_Op_Method     : Exception;
                                                   
   Exception_Prog_Info_Tasks_Active                : Exception;
   Exception_Prog_Info_Alloc_Failed                : Exception; 
   Exception_Prog_Info_Short_Buffer                : Exception; 
   Exception_Prog_Info_No_Such_Task                : Exception; 
   Exception_Prog_Info_No_Such_Method              : Exception; 
   Exception_Prog_Info_No_Such_Misc_Op_Method      : Exception;

   Exception_Tool_Action_Out_of_Memory             : Exception;
   Exception_Tool_Action_Cant_Create_Icon          : Exception;
   Exception_Tool_Action_Cant_Create_Object        : Exception;
                                                   
   Exception_Window_Alloc_Failed                   : Exception;
   Exception_Window_Short_Buffer                   : Exception;
   Exception_Window_Bad_Version                    : Exception;
   Exception_Window_Invalid_Flags                  : Exception;
   Exception_Window_Tasks_Active                   : Exception;
   Exception_Window_No_Such_Task                   : Exception;
   Exception_Window_No_Such_Method                 : Exception;
   Exception_Window_No_Such_Misc_Op_Method         : Exception;
   Exception_Window_Invalid_Component_Id           : Exception;
   Exception_Window_Duplicate_Component_Id         : Exception;
   Exception_Window_Invalid_Gadget_Type            : Exception;                                   
                                                   

   procedure Raise_Error (Error : OSError_Access);

   --
   -- Block filled in by the toolbox on WimpPoll
   --
   type ToolBox_Id_Block_Type is
   record
      Ancestor_Id       : Object_ID;
      Ancestor_Component: Component_ID;
      Parent_Id         : Object_ID;
      Parent_Component  : Component_ID;   
      Self_Id           : Object_ID;
      Self_Component    : Component_ID;
   end record;
   pragma Convention (C, ToolBox_Id_Block_Type);

   type ToolBox_Id_Block_Pointer is access ToolBox_Id_Block_Type;
   
   type Toolbox_EventListener (E : ToolBox_Event_Code_Type;
                               O : Object_ID;
                               C : Component_ID) is abstract new Event_Listener(Toolbox) with
   record      
   Event_Code   : ToolBox_Event_Code_Type   := E;
   Object       : Object_ID            := O;
   Component    : Component_ID         := C;
   ID_Block     : ToolBox_Id_Block_Pointer;
   end record;

   type Toolbox_UserEventListener (E : ToolBox_Event_Code_Type;
                                   O : Object_ID;
                                   C : Component_ID) is abstract new

   Toolbox_EventListener (E,O,C) with
   record
   Event : Event_Pointer;
   end record;

   type Toolbox_Event_Header is
   record
   Size             : System.Unsigned_Types.Unsigned;
   Reference_Number : Integer;
   Event_Code       : System.Unsigned_Types.Unsigned;
   Flags            : System.Unsigned_Types.Unsigned;
   end record;
   pragma Convention (C, Toolbox_Event_Header);

   Wimp_Block_Size        : constant integer := 63;
   type Wimp_Block_Type is array (0 .. Wimp_Block_Size) of integer;
   type Wimp_Block_Pointer is access Wimp_Block_Type;

   Number_Of_Messages       : integer  := 0;
   Max_Number_Of_Messages   : constant integer := 63;
   type Messages_List_Type is array (0 .. Max_Number_Of_Messages) of integer;
   type Messages_List_Pointer is access Messages_List_Type;

   type System_Sprite_Pointer is new Address;
   type Messages_Control_Block_Type is array (1 .. 6) of System.Unsigned_Types.Unsigned;
   type Messages_Handle_Type is access Messages_Control_Block_Type;

   type Wimp_Colour is new integer range 0..15;
   type Toolbox_Colour is new integer range -1..16;
   type OS_Colour is new System.Unsigned_Types.Unsigned;

end RASCAL.OS;