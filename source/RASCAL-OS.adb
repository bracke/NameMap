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

-- $Author$
-- $Date$
-- $Revision$

with Interfaces.C;            use Interfaces.C;
with Ada.Exceptions;          use Ada.Exceptions;

with RASCAL.Utility;

package body RASCAL.OS is

   --
   
   procedure Raise_Error (Error : OSError_Access) is

      Nr      : Integer := Utility."And"(Integer(Error.ErrNum),16#FF#);
      Message : String  := To_Ada(Error.ErrMess);
   begin
      case Nr is
      when Error_Escape                           => Raise_Exception (Exception_Escape'Identity , Message);
      when Error_Bad_mode                         => Raise_Exception (Exception_Bad_mode'Identity , Message);
      when Error_Is_adir                          => Raise_Exception (Exception_Is_adir'Identity , Message);
      when Error_Types_dont_match                 => Raise_Exception (Exception_Types_dont_match'Identity , Message);
      when Error_Bad_rename                       => Raise_Exception (Exception_Bad_rename'Identity , Message);
      when Error_Bad_copy                         => Raise_Exception (Exception_Bad_copy'Identity , Message);
      when Error_Outside_file                     => Raise_Exception (Exception_Outside_file'Identity , Message);
      when Error_Access_violation                 => Raise_Exception (Exception_Access_violation'Identity , Message);
      when Error_Too_many_open_files              => Raise_Exception (Exception_Too_many_open_files'Identity , Message);
      when Error_Not_open_for_update              => Raise_Exception (Exception_Not_open_for_update'Identity , Message);
      when Error_File_open                        => Raise_Exception (Exception_File_open'Identity , Message);
      when Error_Object_locked                    => Raise_Exception (Exception_Object_locked'Identity , Message);
      when Error_Already_exists                   => Raise_Exception (Exception_Already_exists'Identity , Message);
      when Error_Bad_file_name                    => Raise_Exception (Exception_Bad_file_name'Identity , Message);
      when Error_File_not_found                   => Raise_Exception (Exception_File_not_found'Identity , Message);
      when Error_Syntax                           => Raise_Exception (Exception_Syntax'Identity , Message);
      when Error_Channel                          => Raise_Exception (Exception_Channel'Identity , Message);
      when Error_End_of_file                      => Raise_Exception (Exception_End_of_file'Identity , Message);
      when Error_Buffer_Overflow                  => Raise_Exception (Exception_Buffer_Overflow'Identity , Message);
      when Error_Bad_filing_system_name           => Raise_Exception (Exception_Bad_filing_system_name'Identity , Message);
      when Error_Bad_key                          => Raise_Exception (Exception_Bad_key'Identity , Message);
      when Error_Bad_address                      => Raise_Exception (Exception_Bad_address'Identity , Message);
      when Error_Bad_string                       => Raise_Exception (Exception_Bad_string'Identity , Message);
      when Error_Bad_command                      => Raise_Exception (Exception_Bad_command'Identity , Message);
      when Error_Bad_mac_val                      => Raise_Exception (Exception_Bad_mac_val'Identity , Message);
      when Error_Bad_var_nam                      => Raise_Exception (Exception_Bad_var_nam'Identity , Message);
      when Error_Bad_var_type                     => Raise_Exception (Exception_Bad_var_type'Identity , Message);
      when Error_Var_no_room                      => Raise_Exception (Exception_Var_no_room'Identity , Message);
      when Error_Var_cant_find                    => Raise_Exception (Exception_Var_cant_find'Identity , Message);
      when Error_Var_too_long                     => Raise_Exception (Exception_Var_too_long'Identity , Message);
      when Error_Redirect_fail                    => Raise_Exception (Exception_Redirect_fail'Identity , Message);
      when Error_Stack_full                       => Raise_Exception (Exception_Stack_full'Identity , Message);
      when Error_Bad_hex                          => Raise_Exception (Exception_Bad_hex'Identity , Message);
      when Error_Bad_expr                         => Raise_Exception (Exception_Bad_expr'Identity , Message);
      when Error_Bad_bra                          => Raise_Exception (Exception_Bad_bra'Identity , Message);
      when Error_Stk_oflo                         => Raise_Exception (Exception_Stk_oflo'Identity , Message);
      when Error_Miss_opn                         => Raise_Exception (Exception_Miss_opn'Identity , Message);
      when Error_Miss_opr                         => Raise_Exception (Exception_Miss_opr'Identity , Message);
      when Error_Bad_bits                         => Raise_Exception (Exception_Bad_bits'Identity , Message);
      when Error_Str_oflo                         => Raise_Exception (Exception_Str_oflo'Identity , Message);
      when Error_Bad_itm                          => Raise_Exception (Exception_Bad_itm'Identity , Message);
      when Error_Div_zero                         => Raise_Exception (Exception_Div_zero'Identity , Message);
      when Error_Bad_base                         => Raise_Exception (Exception_Bad_base'Identity , Message);
      when Error_Bad_numb                         => Raise_Exception (Exception_Bad_numb'Identity , Message);
      when Error_Numb_too_big                     => Raise_Exception (Exception_Numb_too_big'Identity , Message);
      when Error_Bad_claim_num                    => Raise_Exception (Exception_Bad_claim_num'Identity , Message);
      when Error_Bad_release                      => Raise_Exception (Exception_Bad_release'Identity , Message);
      when Error_Bad_dev_no                       => Raise_Exception (Exception_Bad_dev_no'Identity , Message);
      when Error_Bad_dev_vec_rel                  => Raise_Exception (Exception_Bad_dev_vec_rel'Identity , Message);
      when Error_Bad_env_number                   => Raise_Exception (Exception_Bad_env_number'Identity , Message);
      when Error_Cant_cancel_quit                 => Raise_Exception (Exception_Cant_cancel_quit'Identity , Message);
      when Error_Ch_dynam_cao                     => Raise_Exception (Exception_Ch_dynam_cao'Identity , Message);
      when Error_Ch_dynam_not_all_moved           => Raise_Exception (Exception_Ch_dynam_not_all_moved'Identity , Message);
      when Error_Apl_wspace_in_use                => Raise_Exception (Exception_Apl_wspace_in_use'Identity , Message);
      when Error_Ram_fs_unchangeable              => Raise_Exception (Exception_Ram_fs_unchangeable'Identity , Message);
      when Error_Oscli_long_line                  => Raise_Exception (Exception_Oscli_long_line'Identity , Message);
      when Error_Oscli_too_hard                   => Raise_Exception (Exception_Oscli_too_hard'Identity , Message);
      when Error_Rc_exc                           => Raise_Exception (Exception_Rc_exc'Identity , Message);
      when Error_Sys_heap_full                    => Raise_Exception (Exception_Sys_heap_full'Identity , Message);
      when Error_Buff_overflow                    => Raise_Exception (Exception_Buff_overflow'Identity , Message);
      when Error_Bad_time                         => Raise_Exception (Exception_Bad_time'Identity , Message);
      when Error_No_such_swi                      => Raise_Exception (Exception_No_such_swi'Identity , Message);
      when Error_Unimplemented                    => Raise_Exception (Exception_Unimplemented'Identity , Message);
      when Error_Out_of_range                     => Raise_Exception (Exception_Out_of_range'Identity , Message);
      when Error_No_oscli_specials                => Raise_Exception (Exception_No_oscli_specials'Identity , Message);
      when Error_Bad_parameters                   => Raise_Exception (Exception_Bad_parameters'Identity , Message);
      when Error_Arg_repeated                     => Raise_Exception (Exception_Arg_repeated'Identity , Message);
      when Error_Bad_read_sys_info                => Raise_Exception (Exception_Bad_read_sys_info'Identity , Message);
      when Error_Cdat_stack_overflow              => Raise_Exception (Exception_Cdat_stack_overflow'Identity , Message);
      when Error_Cdat_buffer_overflow             => Raise_Exception (Exception_Cdat_buffer_overflow'Identity , Message);
      when Error_Cdat_bad_field                   => Raise_Exception (Exception_Cdat_bad_field'Identity , Message);
      when Error_Cant_start_application           => Raise_Exception (Exception_Cant_start_application'Identity , Message);

      when Error_ADFS_Driver_In_Use               => Raise_Exception (Exception_ADFS_Driver_In_Use'Identity , Message);

      when Error_CD_Base                          => Raise_Exception (Exception_CD_Base'Identity , Message);
      when Error_CD_Bad_Alignment                 => Raise_Exception (Exception_CD_Bad_Alignment'Identity , Message);
      when Error_CD_Drive_Not_Supported           => Raise_Exception (Exception_CD_Drive_Not_Supported'Identity , Message);
      when Error_CD_Bad_Mode                      => Raise_Exception (Exception_CD_Bad_Mode'Identity , Message);
      when Error_CD_Invalid_Parameter             => Raise_Exception (Exception_CD_Invalid_Parameter'Identity , Message);
      when Error_CD_Not_Audio_Track               => Raise_Exception (Exception_CD_Not_Audio_Track'Identity , Message);
      when Error_CD_No_Caddy                      => Raise_Exception (Exception_CD_No_Caddy'Identity , Message);
      when Error_CD_No_Drive                      => Raise_Exception (Exception_CD_No_Drive'Identity , Message);
      when Error_CD_Invalid_Format                => Raise_Exception (Exception_CD_Invalid_Format'Identity , Message);
      when Error_CD_Bad_Minutes                   => Raise_Exception (Exception_CD_Bad_Minutes'Identity , Message);
      when Error_CD_Bad_Seconds                   => Raise_Exception (Exception_CD_Bad_Seconds'Identity , Message);
      when Error_CD_Bad_Blocks                    => Raise_Exception (Exception_CD_Bad_Blocks'Identity , Message);
      when Error_CD_Physical_Block_Bad            => Raise_Exception (Exception_CD_Physical_Block_Bad'Identity , Message);
      when Error_CD_Drawer_Locked                 => Raise_Exception (Exception_CD_Drawer_Locked'Identity , Message);
      when Error_CD_Wrong_Data_Mode               => Raise_Exception (Exception_CD_Wrong_Data_Mode'Identity , Message);
      when Error_CD_Channel_Not_Supported         => Raise_Exception (Exception_CD_Channel_Not_Supported'Identity , Message);
      when Error_CD_Bad_Device_ID                 => Raise_Exception (Exception_CD_Bad_Device_ID'Identity , Message);
      when Error_CD_Bad_Card_Number               => Raise_Exception (Exception_CD_Bad_Card_Number'Identity , Message);
      when Error_CD_Bad_Lun_Number                => Raise_Exception (Exception_CD_Bad_Lun_Number'Identity , Message);
      when Error_CD_No_Such_Track                 => Raise_Exception (Exception_CD_No_Such_Track'Identity , Message);
      when Error_CD_Faulty_Disc                   => Raise_Exception (Exception_CD_Faulty_Disc'Identity , Message);
      when Error_CD_No_Such_Block                 => Raise_Exception (Exception_CD_No_Such_Block'Identity , Message);
      when Error_CD_Not_Supported                 => Raise_Exception (Exception_CD_Not_Supported'Identity , Message);
      when Error_CD_Driver_Not_Present            => Raise_Exception (Exception_CD_Driver_Not_Present'Identity , Message);
      when Error_CD_SWI_Not_Supported             => Raise_Exception (Exception_CD_SWI_Not_Supported'Identity , Message);
      when Error_CD_Too_Many_Drivers              => Raise_Exception (Exception_CD_Too_Many_Drivers'Identity , Message);
      when Error_CD_Not_Registered                => Raise_Exception (Exception_CD_Not_Registered'Identity , Message);       

      when Error_Colour_DBox_Tasks_Active           => Raise_Exception (Exception_Colour_DBox_Tasks_Active'Identity , Message);
      when Error_Colour_DBox_Alloc_Failed           => Raise_Exception (Exception_Colour_DBox_Alloc_Failed'Identity , Message);
      when Error_Colour_DBox_Short_Buffer           => Raise_Exception (Exception_Colour_DBox_Short_Buffer'Identity , Message);
      when Error_Colour_DBox_No_Such_Task           => Raise_Exception (Exception_Colour_DBox_No_Such_Task'Identity , Message);
      when Error_Colour_DBox_No_Such_Method         => Raise_Exception (Exception_Colour_DBox_No_Such_Method'Identity , Message);
      when Error_Colour_DBox_No_Such_Misc_op_Method => Raise_Exception (Exception_Colour_DBox_No_Such_Misc_op_Method'Identity , Message);

      when Error_Colour_Picker_Uninit             => Raise_Exception (Exception_Colour_Picker_Uninit'Identity , Message);
      when Error_Colour_Picker_Bad_Model          => Raise_Exception (Exception_Colour_Picker_Bad_Model'Identity , Message);
      when Error_Colour_Picker_Bad_Handle         => Raise_Exception (Exception_Colour_Picker_Bad_Handle'Identity , Message);
      when Error_Colour_Picker_Bad_Flags          => Raise_Exception (Exception_Colour_Picker_Bad_Flags'Identity , Message);
      when Error_Colour_Picker_In_Use             => Raise_Exception (Exception_Colour_Picker_In_Use'Identity , Message);
      when Error_Colour_Picker_Model_In_Use       => Raise_Exception (Exception_Colour_Picker_Model_In_Use'Identity , Message);
      when Error_Colour_Picker_Bad_Reason         => Raise_Exception (Exception_Colour_Picker_Bad_Reason'Identity , Message);

      when Error_Colour_Trans_Bad_Calib           => Raise_Exception (Exception_Colour_Trans_Bad_Calib'Identity , Message);
      when Error_Colour_Trans_Conv_Over           => Raise_Exception (Exception_Colour_Trans_Conv_Over'Identity , Message);
      when Error_Colour_Trans_Bad_HSV             => Raise_Exception (Exception_Colour_Trans_Bad_HSV'Identity , Message);
      when Error_Colour_Trans_Switched            => Raise_Exception (Exception_Colour_Trans_Switched'Identity , Message);
      when Error_Colour_Trans_Bad_Misc_Op         => Raise_Exception (Exception_Colour_Trans_Bad_Misc_Op'Identity , Message);
      when Error_Colour_Trans_Bad_Flags           => Raise_Exception (Exception_Colour_Trans_Bad_Flags'Identity , Message);
      when Error_Colour_Trans_Buff_Over           => Raise_Exception (Exception_Colour_Trans_Buff_Over'Identity , Message);
      when Error_Colour_Trans_Bad_Depth           => Raise_Exception (Exception_Colour_Trans_Bad_Depth'Identity , Message);  

      when Error_Compress_JPEG_Bad_BPP               => Raise_Exception (Exception_Compress_JPEG_Bad_BPP'Identity , Message);
      when Error_Compress_JPEG_Bad_Line_Count        => Raise_Exception (Exception_Compress_JPEG_Bad_Line_Count'Identity , Message);
      when Error_Compress_JPEG_Bad_Buffer            => Raise_Exception (Exception_Compress_JPEG_Bad_Buffer'Identity , Message);
      when Error_Compress_JPEG_Bad_Size              => Raise_Exception (Exception_Compress_JPEG_Bad_Size'Identity , Message);
      when Error_Compress_JPEG_Arith_Not_Impl        => Raise_Exception (Exception_Compress_JPEG_Arith_Not_Impl'Identity , Message);
      when Error_Compress_JPEG_Bad_Align_Type        => Raise_Exception (Exception_Compress_JPEG_Bad_Align_Type'Identity , Message);
      when Error_Compress_JPEG_Bad_Alloc_Chunk       => Raise_Exception (Exception_Compress_JPEG_Bad_Alloc_Chunk'Identity , Message);
      when Error_Compress_JPEG_Bad_Buffer_Mode       => Raise_Exception (Exception_Compress_JPEG_Bad_Buffer_Mode'Identity , Message);
      when Error_Compress_JPEG_Bad_Component_ID      => Raise_Exception (Exception_Compress_JPEG_Bad_Component_ID'Identity , Message);
      when Error_Compress_JPEG_Bad_DCT_Size          => Raise_Exception (Exception_Compress_JPEG_Bad_DCT_Size'Identity , Message);
      when Error_Compress_JPEG_Bad_In_Colour_Space   => Raise_Exception (Exception_Compress_JPEG_Bad_In_Colour_Space'Identity , Message);
      when Error_Compress_JPEG_Bad_KColour_Space     => Raise_Exception (Exception_Compress_JPEG_Bad_KColour_Space'Identity , Message);
      when Error_Compress_JPEG_Bad_Length            => Raise_Exception (Exception_Compress_JPEG_Bad_Length'Identity , Message);
      when Error_Compress_JPEG_Bad_MCU_Size          => Raise_Exception (Exception_Compress_JPEG_Bad_MCU_Size'Identity , Message);
      when Error_Compress_JPEG_Bad_Pool_ID           => Raise_Exception (Exception_Compress_JPEG_Bad_Pool_ID'Identity , Message);
      when Error_Compress_JPEG_Bad_Precision         => Raise_Exception (Exception_Compress_JPEG_Bad_Precision'Identity , Message);
      when Error_Compress_JPEG_Bad_Sampling          => Raise_Exception (Exception_Compress_JPEG_Bad_Sampling'Identity , Message);
      when Error_Compress_JPEG_Bad_State             => Raise_Exception (Exception_Compress_JPEG_Bad_State'Identity , Message);
      when Error_Compress_JPEG_Bad_Virtual_Access    => Raise_Exception (Exception_Compress_JPEG_Bad_Virtual_Access'Identity , Message);
      when Error_Compress_JPEG_Buffer_Size           => Raise_Exception (Exception_Compress_JPEG_Buffer_Size'Identity , Message);
      when Error_Compress_JPEG_Cant_Suspend          => Raise_Exception (Exception_Compress_JPEG_Cant_Suspend'Identity , Message);
      when Error_Compress_JPEGCCIR601_Not_Impl       => Raise_Exception (Exception_Compress_JPEGCCIR601_Not_Impl'Identity , Message);
      when Error_Compress_JPEG_Component_Count       => Raise_Exception (Exception_Compress_JPEG_Component_Count'Identity , Message);
      when Error_Compress_JPEG_Conversion_Not_Impl   => Raise_Exception (Exception_Compress_JPEG_Conversion_Not_Impl'Identity , Message);
      when Error_Compress_JPEGDAC_Index              => Raise_Exception (Exception_Compress_JPEGDAC_Index'Identity , Message);
      when Error_Compress_JPEGDAC_Value              => Raise_Exception (Exception_Compress_JPEGDAC_Value'Identity , Message);
      when Error_Compress_JPEGDHT_Index              => Raise_Exception (Exception_Compress_JPEGDHT_Index'Identity , Message);
      when Error_Compress_JPEGDQT_Index              => Raise_Exception (Exception_Compress_JPEGDQT_Index'Identity , Message);
      when Error_Compress_JPEG_Empty_Image           => Raise_Exception (Exception_Compress_JPEG_Empty_Image'Identity , Message);
      when Error_Compress_JPEGEOI_Expected           => Raise_Exception (Exception_Compress_JPEGEOI_Expected'Identity , Message);
      when Error_Compress_JPEG_File_Read             => Raise_Exception (Exception_Compress_JPEG_File_Read'Identity , Message);
      when Error_Compress_JPEG_File_Write            => Raise_Exception (Exception_Compress_JPEG_File_Write'Identity , Message);
      when Error_Compress_JPEG_Fract_Sample_Not_Impl => Raise_Exception (Exception_Compress_JPEG_Fract_Sample_Not_Impl'Identity , Message);
      when Error_Compress_JPEG_Huff_Clen_Overflow    => Raise_Exception (Exception_Compress_JPEG_Huff_Clen_Overflow'Identity , Message);
      when Error_Compress_JPEG_Huff_Missing_Code     => Raise_Exception (Exception_Compress_JPEG_Huff_Missing_Code'Identity , Message);
      when Error_Compress_JPEG_Image_Too_Big         => Raise_Exception (Exception_Compress_JPEG_Image_Too_Big'Identity , Message);
      when Error_Compress_JPEG_Input_Empty           => Raise_Exception (Exception_Compress_JPEG_Input_Empty'Identity , Message);
      when Error_Compress_JPEG_Input_EOF             => Raise_Exception (Exception_Compress_JPEG_Input_EOF'Identity , Message);
      when Error_Compress_JPEG_Not_Impl              => Raise_Exception (Exception_Compress_JPEG_Not_Impl'Identity , Message);
      when Error_Compress_JPEG_Not_Compiled          => Raise_Exception (Exception_Compress_JPEG_Not_Compiled'Identity , Message);
      when Error_Compress_JPEG_No_Backing_Store      => Raise_Exception (Exception_Compress_JPEG_No_Backing_Store'Identity , Message);
      when Error_Compress_JPEG_No_Huff_Table         => Raise_Exception (Exception_Compress_JPEG_No_Huff_Table'Identity , Message);
      when Error_Compress_JPEG_No_Image              => Raise_Exception (Exception_Compress_JPEG_No_Image'Identity , Message);
      when Error_Compress_JPEG_No_Quant_Table        => Raise_Exception (Exception_Compress_JPEG_No_Quant_table'Identity , Message);
      when Error_Compress_JPEG_No_Soi                => Raise_Exception (Exception_Compress_JPEG_No_Soi'Identity , Message);
      when Error_Compress_JPEG_Out_Of_Memory         => Raise_Exception (Exception_Compress_JPEG_Out_Of_Memory'Identity , Message);
      when Error_Compress_JPEG_Quant_Components      => Raise_Exception (Exception_Compress_JPEG_Quant_Components'Identity , Message);
      when Error_Compress_JPEG_Quant_Few_Colours     => Raise_Exception (Exception_Compress_JPEG_Quant_Few_Colours'Identity , Message);
      when Error_Compress_JPEG_Quant_Many_Colours    => Raise_Exception (Exception_Compress_JPEG_Quant_Many_Colours'Identity , Message);
      when Error_Compress_JPEGSOF_Duplicate          => Raise_Exception (Exception_Compress_JPEGSOF_Duplicate'Identity , Message);
      when Error_Compress_JPEGSOF_No_Sos             => Raise_Exception (Exception_Compress_JPEGSOF_No_Sos'Identity , Message);
      when Error_Compress_JPEGSOF_Unsupported        => Raise_Exception (Exception_Compress_JPEGSOF_Unsupported'Identity , Message);
      when Error_Compress_JPEGSOI_Duplicate          => Raise_Exception (Exception_Compress_JPEGSOI_Duplicate'Identity , Message);
      when Error_Compress_JPEGSOS_No_Sof             => Raise_Exception (Exception_Compress_JPEGSOS_No_Sof'Identity , Message);
      when Error_Compress_JPEG_Too_Little_Data       => Raise_Exception (Exception_Compress_JPEG_Too_Little_Data'Identity , Message);
      when Error_Compress_JPEG_Unknown_Marker        => Raise_Exception (Exception_Compress_JPEG_Unknown_Marker'Identity , Message);
      when Error_Compress_JPEG_Virtual_Bug           => Raise_Exception (Exception_Compress_JPEG_Virtual_Bug'Identity , Message);
      when Error_Compress_JPEG_Width_Overflow        => Raise_Exception (Exception_Compress_JPEG_Width_Overflow'Identity , Message);
      when Error_Compress_JPEG_Bad_DCT_Coef          => Raise_Exception (Exception_Compress_JPEG_Bad_DCT_Coef'Identity , Message);
      when Error_Compress_JPEG_Bad_Huff_Table        => Raise_Exception (Exception_Compress_JPEG_Bad_Huff_Table'Identity , Message);
      when Error_Compress_JPEG_Bad_Progression       => Raise_Exception (Exception_Compress_JPEG_Bad_Progression'Identity , Message);
      when Error_Compress_JPEG_Bad_Prog_Script       => Raise_Exception (Exception_Compress_JPEG_Bad_Prog_Script'Identity , Message);
      when Error_Compress_JPEG_Bad_Scan_Script       => Raise_Exception (Exception_Compress_JPEG_Bad_Scan_Script'Identity , Message);
      when Error_Compress_JPEG_Mismatched_Quant_Table => Raise_Exception (Exception_Compress_JPEG_Mismatched_Quant_Table'Identity , Message);
      when Error_Compress_JPEG_Missing_Data          => Raise_Exception (Exception_Compress_JPEG_Missing_Data'Identity , Message);
      when Error_Compress_JPEG_Mode_Change           => Raise_Exception (Exception_Compress_JPEG_Mode_Change'Identity , Message);
      when Error_Compress_JPEGW_Buffer_Size          => Raise_Exception (Exception_Compress_JPEGW_Buffer_Size'Identity , Message);           

      when Error_DDE_Utils_Unknown_SWI               => Raise_Exception (Exception_DDE_Utils_Unknown_SWI'Identity , Message);
      when Error_DDE_Utils_No_CLI_Buffer             => Raise_Exception (Exception_DDE_Utils_No_CLI_Buffer'Identity , Message);
      when Error_DDE_Utils_Not_Desktop               => Raise_Exception (Exception_DDE_Utils_Not_Desktop'Identity , Message);
      when Error_DDE_Utils_No_Task                   => Raise_Exception (Exception_DDE_Utils_No_Task'Identity , Message);
      when Error_DDE_Utils_Already_Registered        => Raise_Exception (Exception_DDE_Utils_Already_Registered'Identity , Message);
      when Error_DDE_Utils_Not_Registered            => Raise_Exception (Exception_DDE_Utils_Not_Registered'Identity , Message);    

      when Error_Debug_Break_Not_Found               => Raise_Exception (Exception_Debug_Break_Not_Found'Identity , Message);
      when Error_Debug_invalid_Value                 => Raise_Exception (Exception_Debug_invalid_Value'Identity , Message);
      when Error_Debug_Resetting                     => Raise_Exception (Exception_Debug_Resetting'Identity , Message);
      when Error_Debug_No_Room                       => Raise_Exception (Exception_Debug_No_Room'Identity , Message);
      when Error_Debug_No_Breakpoints                => Raise_Exception (Exception_Debug_No_Breakpoints'Identity , Message);
      when Error_Debug_Bad_Breakpoint                => Raise_Exception (Exception_Debug_Bad_Breakpoint'Identity , Message);
      when Error_Debug_Undefined                     => Raise_Exception (Exception_Debug_Undefined'Identity , Message);
      when Error_Debug_Non_Aligned                   => Raise_Exception (Exception_Debug_Non_Aligned'Identity , Message);
      when Error_Debug_No_Workspace                  => Raise_Exception (Exception_Debug_No_Workspace'Identity , Message);   

      when Error_Draw_No_Draw_In_IRQ_Mode            => Raise_Exception (Exception_Draw_No_Draw_In_IRQ_Mode'Identity , Message);
      when Error_Draw_Bad_Draw_Reason_Code           => Raise_Exception (Exception_Draw_Bad_Draw_Reason_Code'Identity , Message);
      when Error_Draw_Reserved_Draw_Bits             => Raise_Exception (Exception_Draw_Reserved_Draw_Bits'Identity , Message);
      when Error_Draw_Invalid_Draw_Address           => Raise_Exception (Exception_Draw_Invalid_Draw_Address'Identity , Message);
      when Error_Draw_Bad_Path_Element               => Raise_Exception (Exception_Draw_Bad_Path_Element'Identity , Message);
      when Error_Draw_Bad_Path_Sequence              => Raise_Exception (Exception_Draw_Bad_Path_Sequence'Identity , Message);
      when Error_Draw_May_Expand_Path                => Raise_Exception (Exception_Draw_May_Expand_Path'Identity , Message);
      when Error_Draw_Path_Full                      => Raise_Exception (Exception_Draw_Path_Full'Identity , Message);
      when Error_Draw_Path_Not_Flat                  => Raise_Exception (Exception_Draw_Path_Not_Flat'Identity , Message);
      when Error_Draw_Bad_Caps_Or_Joins              => Raise_Exception (Exception_Draw_Bad_Caps_Or_Joins'Identity , Message);
      when Error_Draw_Transform_Overflow             => Raise_Exception (Exception_Draw_Transform_Overflow'Identity , Message);
      when Error_Draw_Draw_Needs_Graphics_Mode       => Raise_Exception (Exception_Draw_Draw_Needs_Graphics_Mode'Identity , Message);
      when Error_Draw_Unimplemented_Draw             => Raise_Exception (Exception_Draw_Unimplemented_Draw'Identity , Message);

      when Error_Draw_File_Not_Draw                  => Raise_Exception (Exception_Draw_File_Not_Draw'Identity , Message);
      when Error_Draw_File_Version                   => Raise_Exception (Exception_Draw_File_Version'Identity , Message);
      when Error_Draw_File_Font_Tab                  => Raise_Exception (Exception_Draw_File_Font_Tab'Identity , Message);
      when Error_Draw_File_Bad_Font_No               => Raise_Exception (Exception_Draw_File_Bad_Font_No'Identity , Message);
      when Error_Draw_File_Bad_Mode                  => Raise_Exception (Exception_Draw_File_Bad_Mode'Identity , Message);
      when Error_Draw_File_Bad_File                  => Raise_Exception (Exception_Draw_File_Bad_File'Identity , Message);
      when Error_Draw_File_Bad_Group                 => Raise_Exception (Exception_Draw_File_Bad_Group'Identity , Message);
      when Error_Draw_File_Bad_Tag                   => Raise_Exception (Exception_Draw_File_Bad_Tag'Identity , Message);
      when Error_Draw_File_Syntax                    => Raise_Exception (Exception_Draw_File_Syntax'Identity , Message);
      when Error_Draw_File_Font_No                   => Raise_Exception (Exception_Draw_File_Font_No'Identity , Message);
      when Error_Draw_File_Area_Ver                  => Raise_Exception (Exception_Draw_File_Area_Ver'Identity , Message);
      when Error_Draw_File_No_Area_Ver               => Raise_Exception (Exception_Draw_File_No_Area_Ver'Identity , Message);
                                                                                                    
      when Error_Econet_Tx_Ready                     => Raise_Exception (Exception_Econet_Tx_Ready'Identity , Message);
      when Error_Econet_Transmitting                 => Raise_Exception (Exception_Econet_Transmitting'Identity , Message);
      when Error_Econet_Rx_Ready                     => Raise_Exception (Exception_Econet_Rx_Ready'Identity , Message);
      when Error_Econet_Receiving                    => Raise_Exception (Exception_Econet_Receiving'Identity , Message);
      when Error_Econet_Received                     => Raise_Exception (Exception_Econet_Received'Identity , Message);
      when Error_Econet_Transmitted                  => Raise_Exception (Exception_Econet_Transmitted'Identity , Message);
      when Error_Econet_Bad_Station                  => Raise_Exception (Exception_Econet_Bad_Station'Identity , Message);
      when Error_Econet_Bad_Network                  => Raise_Exception (Exception_Econet_Bad_Network'Identity , Message);
      when Error_Econet_Unable_To_Default            => Raise_Exception (Exception_Econet_Unable_To_Default'Identity , Message);
      when Error_Econet_Bad_Port                     => Raise_Exception (Exception_Econet_Bad_Port'Identity , Message);
      when Error_Econet_Bad_Control                  => Raise_Exception (Exception_Econet_Bad_Control'Identity , Message);
      when Error_Econet_Bad_Buffer                   => Raise_Exception (Exception_Econet_Bad_Buffer'Identity , Message);
      when Error_Econet_Bad_Size                     => Raise_Exception (Exception_Econet_Bad_Size'Identity , Message);
      when Error_Econet_Bad_Mask                     => Raise_Exception (Exception_Econet_Bad_Mask'Identity , Message);
      when Error_Econet_Bad_Count                    => Raise_Exception (Exception_Econet_Bad_Count'Identity , Message);
      when Error_Econet_Bad_Delay                    => Raise_Exception (Exception_Econet_Bad_Delay'Identity , Message);
      when Error_Econet_Bad_Status                   => Raise_Exception (Exception_Econet_Bad_Status'Identity , Message);
      when Error_Econet_No_Hardware                  => Raise_Exception (Exception_Econet_No_Hardware'Identity , Message);
      when Error_Econet_No_Econet                    => Raise_Exception (Exception_Econet_No_Econet'Identity , Message);
      when Error_Econet_No_More_Domains              => Raise_Exception (Exception_Econet_No_More_Domains'Identity , Message);
      when Error_Econet_Bad_Domain                   => Raise_Exception (Exception_Econet_Bad_Domain'Identity , Message);
      when Error_Econet_Un_Registered_Domain         => Raise_Exception (Exception_Econet_Un_Registered_Domain'Identity , Message);
      when Error_Econet_Port_Not_Allocated           => Raise_Exception (Exception_Econet_Port_Not_Allocated'Identity , Message);
      when Error_Econet_Port_Allocated               => Raise_Exception (Exception_Econet_Port_Allocated'Identity , Message);
      when Error_Econet_No_More_Ports                => Raise_Exception (Exception_Econet_No_More_Ports'Identity , Message);        

      when Error_Filer_No_Recursion                  => Raise_Exception (Exception_Filer_No_Recursion'Identity , Message);
      when Error_Filer_No_Template                   => Raise_Exception (Exception_Filer_No_Template'Identity , Message);
      when Error_Filer_Failed_Save                   => Raise_Exception (Exception_Filer_Failed_Save'Identity , Message);
      when Error_Filer_Bad_Path                      => Raise_Exception (Exception_Filer_Bad_Path'Identity , Message);

      when Error_File_Switch_No_Claim                       => Raise_Exception (Exception_File_Switch_No_Claim'Identity , Message);
      when Error_Bad_FS_Control_Reason                      => Raise_Exception (Exception_Bad_FS_Control_Reason'Identity , Message);
      when Error_Bad_OS_File_Reason                         => Raise_Exception (Exception_Bad_OS_File_Reason'Identity , Message);
      when Error_Bad_OS_Args_Reason                         => Raise_Exception (Exception_Bad_OS_Args_Reason'Identity , Message);
      when Error_Bad_OSGBPB_Reason                          => Raise_Exception (Exception_Bad_OSGBPB_Reason'Identity , Message);
      when Error_Bad_Mode_For_OS_Find                       => Raise_Exception (Exception_Bad_Mode_For_OS_Find'Identity , Message);
      when Error_No_Room_For_Transient                      => Raise_Exception (Exception_No_Room_For_Transient'Identity , Message);
      when Error_Exec_Addr_Not_In_Code                      => Raise_Exception (Exception_Exec_Addr_Not_In_Code'Identity , Message);
      when Error_Exec_Addr_TOO_Low                          => Raise_Exception (Exception_Exec_Addr_TOO_Low'Identity , Message);
      when Error_Unknown_Action_Type                        => Raise_Exception (Exception_Unknown_Action_Type'Identity , Message);
      when Error_Too_Many_Levels                            => Raise_Exception (Exception_Too_Many_Levels'Identity , Message);
      when Error_No_Selected_Filing_System                  => Raise_Exception (Exception_No_Selected_Filing_System'Identity , Message);
      when Error_Cant_Remove_FS_By_Number                   => Raise_Exception (Exception_Cant_Remove_FS_By_Number'Identity , Message);
      when Error_Unaligned_FS_Entry                         => Raise_Exception (Exception_Unaligned_FS_Entry'Identity , Message);
      when Error_Unsupported_FS_Entry                       => Raise_Exception (Exception_Unsupported_FS_Entry'Identity , Message);
      when Error_Fs_Not_Special                             => Raise_Exception (Exception_Fs_Not_Special'Identity , Message);
      when Error_Core_Not_Readable                          => Raise_Exception (Exception_Core_Not_Readable'Identity , Message);
      when Error_Core_Not_Writeable                         => Raise_Exception (Exception_Core_Not_Writeable'Identity , Message);
      when Error_Bad_Buffer_Size_For_Stream                 => Raise_Exception (Exception_Bad_Buffer_Size_For_Stream'Identity , Message);
      when Error_Not_Open_For_Reading                       => Raise_Exception (Exception_Not_Open_For_Reading'Identity , Message);
      when Error_Not_Enough_Stack_For_FS_Entry              => Raise_Exception (Exception_Not_Enough_Stack_For_FS_Entry'Identity , Message);
      when Error_Nothing_To_Copy                            => Raise_Exception (Exception_Nothing_To_Copy'Identity , Message);
      when Error_Nothing_To_Delete                          => Raise_Exception (Exception_Nothing_To_Delete'Identity , Message);
      when Error_File_Switch_Cant_Be_Killed_Whilst_Threaded => Raise_Exception (Exception_File_Switch_Cant_Be_Killed_Whilst_Threaded'Identity , Message);
      when Error_Invalid_Error_Block                        => Raise_Exception (Exception_Invalid_Error_Block'Identity , Message);
      when Error_FS_File_Too_Big                            => Raise_Exception (Exception_FS_File_Too_Big'Identity , Message);
      when Error_Cant_RM_Faster_File_Switch                 => Raise_Exception (Exception_Cant_RM_Faster_File_Switch'Identity , Message);
      when Error_Inconsistent_Handle_Set                    => Raise_Exception (Exception_Inconsistent_Handle_Set'Identity , Message);
      when Error_Is_AFile                                   => Raise_Exception (Exception_Is_AFile'Identity , Message);
      when Error_Bad_File_Type                              => Raise_Exception (Exception_Bad_File_Type'Identity , Message);
      when Error_Library_Somewhere_Else                     => Raise_Exception (Exception_Library_Somewhere_Else'Identity , Message);
      when Error_Path_Is_Self_Contradictory                 => Raise_Exception (Exception_Path_Is_Self_Contradictory'Identity , Message);
      when Error_Wasnt_Dollar_After_Disc                    => Raise_Exception (Exception_Wasnt_Dollar_After_Disc'Identity , Message);
      when Error_Not_Enough_Memory_For_Wildcard_Resolution  => Raise_Exception (Exception_Not_Enough_Memory_For_Wildcard_Resolution'Identity , Message);
      when Error_Not_Enough_Stack_For_Wildcard_Resolution   => Raise_Exception (Exception_Not_Enough_Stack_For_Wildcard_Resolution'Identity , Message);
      when Error_Dir_Wanted_File_Found                      => Raise_Exception (Exception_Dir_Wanted_File_Found'Identity , Message);
      when Error_Not_Found                                  => Raise_Exception (Exception_Not_Found'Identity , Message);
      when Error_Multipart_Path_Used                        => Raise_Exception (Exception_Multipart_Path_Used'Identity , Message);
      when Error_Recursive_Path                             => Raise_Exception (Exception_Recursive_Path'Identity , Message);
      when Error_Multi_FS_Does_Not_Support_GBPB11           => Raise_Exception (Exception_Multi_FS_Does_Not_Support_GBPB11'Identity , Message);
      when Error_File_Switch_Data_Lost                      => Raise_Exception (Exception_File_Switch_Data_Lost'Identity , Message);
      when Error_Too_Many_Error_Lookups                     => Raise_Exception (Exception_Too_Many_Error_Lookups'Identity , Message);
      when Error_Message_File_Busy                          => Raise_Exception (Exception_Message_File_Busy'Identity , Message);
      when Error_Partition_Busy                             => Raise_Exception (Exception_Partition_Busy'Identity , Message);                             

      when Error_Font_No_Room                        => Raise_Exception (Exception_Font_No_Room'Identity , Message);
      when Error_Font_Cache_Full                     => Raise_Exception (Exception_Font_Cache_Full'Identity , Message);
      when Error_Font_No_Cache                       => Raise_Exception (Exception_Font_No_Cache'Identity , Message);
      when Error_Font_Too_Long                       => Raise_Exception (Exception_Font_Too_Long'Identity , Message);
      when Error_Font64K                             => Raise_Exception (Exception_Font64K'Identity , Message);
      when Error_Font_Pal_Too_Big                    => Raise_Exception (Exception_Font_Pal_Too_Big'Identity , Message);
      when Error_Font_Bad_Tran_Bits                  => Raise_Exception (Exception_Font_Bad_Tran_Bits'Identity , Message);
      when Error_Font_Not_Enough_Bits                => Raise_Exception (Exception_Font_Not_Enough_Bits'Identity , Message);
      when Error_Font_No_Font                        => Raise_Exception (Exception_Font_No_Font'Identity , Message);
      when Error_Font_No_Pixels                      => Raise_Exception (Exception_Font_No_Pixels'Identity , Message);
      when Error_Font_Bad_Font_Number                => Raise_Exception (Exception_Font_Bad_Font_Number'Identity , Message);
      when Error_Font_Not_Found                      => Raise_Exception (Exception_Font_Not_Found'Identity , Message);
      when Error_Font_Bad_Font_File                  => Raise_Exception (Exception_Font_Bad_Font_File'Identity , Message);
      when Error_Font_No_Handles                     => Raise_Exception (Exception_Font_No_Handles'Identity , Message);
      when Error_Font_Bad_Counter                    => Raise_Exception (Exception_Font_Bad_Counter'Identity , Message);
      when Error_Font_Bad_CTRL_Char                  => Raise_Exception (Exception_Font_Bad_CTRL_Char'Identity , Message);
      when Error_FontS_In_Use                        => Raise_Exception (Exception_FontS_In_Use'Identity , Message);
      when Error_Font_Bad_Segment                    => Raise_Exception (Exception_Font_Bad_Segment'Identity , Message);
      when Error_Font_Bad_Prefix                     => Raise_Exception (Exception_Font_Bad_Prefix'Identity , Message);
      when Error_Font_Reserved                       => Raise_Exception (Exception_Font_Reserved'Identity , Message);
      when Error_Font_Bad_Char_Code                  => Raise_Exception (Exception_Font_Bad_Char_Code'Identity , Message);
      when Error_Font_No_Bitmaps                     => Raise_Exception (Exception_Font_No_Bitmaps'Identity , Message);
      when Error_Font_No_Bitmaps2                    => Raise_Exception (Exception_Font_No_Bitmaps2'Identity , Message);
      when Error_Font_Bad_Font_Cache_File            => Raise_Exception (Exception_Font_Bad_Font_Cache_File'Identity , Message);
      when Error_Font_Field_Not_Found                => Raise_Exception (Exception_Font_Field_Not_Found'Identity , Message);
      when Error_Font_Bad_Matrix                     => Raise_Exception (Exception_Font_Bad_Matrix'Identity , Message);
      when Error_Font_Overflow                       => Raise_Exception (Exception_Font_Overflow'Identity , Message);
      when Error_Font_Divby0                         => Raise_Exception (Exception_Font_Divby0'Identity , Message);
      when Error_Font_Bad_Read_Metrics               => Raise_Exception (Exception_Font_Bad_Read_Metrics'Identity , Message);
      when Error_Font_Bad_RGB                        => Raise_Exception (Exception_Font_Bad_RGB'Identity , Message);
      when Error_Font_Encoding_Not_Found             => Raise_Exception (Exception_Font_Encoding_Not_Found'Identity , Message);
      when Error_Font_Must_Have_Slash                => Raise_Exception (Exception_Font_Must_Have_Slash'Identity , Message);
      when Error_Font_Bad_Encoding_Size              => Raise_Exception (Exception_Font_Bad_Encoding_Size'Identity , Message);
      when Error_Font_Too_Many_Ids                   => Raise_Exception (Exception_Font_Too_Many_Ids'Identity , Message);
      when Error_Font_Too_Few_Ids                    => Raise_Exception (Exception_Font_Too_Few_Ids'Identity , Message);
      when Error_Font_No_Base_Encoding               => Raise_Exception (Exception_Font_No_Base_Encoding'Identity , Message);
      when Error_Font_Identifier_Not_Found           => Raise_Exception (Exception_Font_Identifier_Not_Found'Identity , Message);
      when Error_Font_Too_Many_Chunks                => Raise_Exception (Exception_Font_Too_Many_Chunks'Identity , Message);
      when Error_Font_Bad_Font_File2                 => Raise_Exception (Exception_Font_Bad_Font_File2'Identity , Message);

      when Error_FS_Lock_Unknown_SWI                 => Raise_Exception (Exception_FS_Lock_Unknown_SWI'Identity , Message);
      when Error_FS_Lock_Locked                      => Raise_Exception (Exception_FS_Lock_Locked'Identity , Message);
      when Error_FS_Lock_Unknown_FS                  => Raise_Exception (Exception_FS_Lock_Unknown_FS'Identity , Message);
      when Error_FS_Lock_FS_Not_Lockable             => Raise_Exception (Exception_FS_Lock_FS_Not_Lockable'Identity , Message);
      when Error_FS_Lock_No_Locked_FS                => Raise_Exception (Exception_FS_Lock_No_Locked_FS'Identity , Message);
      when Error_FS_Lock_Protected_Disc              => Raise_Exception (Exception_FS_Lock_Protected_Disc'Identity , Message);
      when Error_FS_Lock_Killed                      => Raise_Exception (Exception_FS_Lock_Killed'Identity , Message);

      when Error_Message_Trans_Syntax                => Raise_Exception (Exception_Message_Trans_Syntax'Identity , Message);
      when Error_Message_Trans_File_Open             => Raise_Exception (Exception_Message_Trans_File_Open'Identity , Message);
      when Error_Message_Trans_Token_Not_Found       => Raise_Exception (Exception_Message_Trans_Token_Not_Found'Identity , Message);
      when Error_Message_Trans_Recurse               => Raise_Exception (Exception_Message_Trans_Recurse'Identity , Message);                                          

      when Error_Net_FS_Bad_Command_Code             => Raise_Exception (Exception_Net_FS_Bad_Command_Code'Identity , Message);
      when Error_Net_FS_Unexpected_Command_Code      => Raise_Exception (Exception_Net_FS_Unexpected_Command_Code'Identity , Message);
      when Error_Net_FS_Unknown_Function_Code        => Raise_Exception (Exception_Net_FS_Unknown_Function_Code'Identity , Message);
      when Error_Net_FS_Unknown_Station_Name         => Raise_Exception (Exception_Net_FS_Unknown_Station_Name'Identity , Message);
      when Error_Net_FS_Unknown_Station_Number       => Raise_Exception (Exception_Net_FS_Unknown_Station_Number'Identity , Message);
      when Error_Net_FS_Station_Not_Found            => Raise_Exception (Exception_Net_FS_Station_Not_Found'Identity , Message);
      when Error_Net_FS_File_Server_Name_Too_Long    => Raise_Exception (Exception_Net_FS_File_Server_Name_Too_Long'Identity , Message);
      when Error_Net_FS_Bad_File_Server_Date         => Raise_Exception (Exception_Net_FS_Bad_File_Server_Date'Identity , Message);
      when Error_Net_FS_Net_FS_Internal_Error        => Raise_Exception (Exception_Net_FS_Net_FS_Internal_Error'Identity , Message);
      when Error_Net_FS_File_Server_Not_Capable      => Raise_Exception (Exception_Net_FS_File_Server_Not_Capable'Identity , Message);
      when Error_Net_FS_Broadcast_Server_Dead        => Raise_Exception (Exception_Net_FS_Broadcast_Server_Dead'Identity , Message);
      when Error_Net_FS_File_Server_Only24_Bit       => Raise_Exception (Exception_Net_FS_File_Server_Only24_Bit'Identity , Message);
      when Error_Net_Utils_Wrong_Version             => Raise_Exception (Exception_Net_Utils_Wrong_Version'Identity , Message);
      when Error_Net_Utils_Net_FS_No_Go              => Raise_Exception (Exception_Net_Utils_Net_FS_No_Go'Identity , Message);
      when Error_Net_Utils_Is_Threaded               => Raise_Exception (Exception_Net_Utils_Is_Threaded'Identity , Message);
      when Error_Net_FS_Set_Free_Syntax              => Raise_Exception (Exception_Net_FS_Set_Free_Syntax'Identity , Message);
      when Error_Net_FS_FS_Cli_Syntax                => Raise_Exception (Exception_Net_FS_FS_Cli_Syntax'Identity , Message);

      when Error_Net_Print_Name_Too_Long             => Raise_Exception (Exception_Net_Print_Name_Too_Long'Identity , Message);
      when Error_Net_Print_Single_Stream             => Raise_Exception (Exception_Net_Print_Single_Stream'Identity , Message);
      when Error_Net_Print_All_Printers_Busy         => Raise_Exception (Exception_Net_Print_All_Printers_Busy'Identity , Message);
      when Error_Net_Print_Off_Line                  => Raise_Exception (Exception_Net_Print_Off_Line'Identity , Message);
      when Error_Net_Print_Not_Found                 => Raise_Exception (Exception_Net_Print_Not_Found'Identity , Message);
      when Error_Net_Print_Internal_Error            => Raise_Exception (Exception_Net_Print_Internal_Error'Identity , Message);    

      when Error_Heap_Bad_Reason                     => Raise_Exception (Exception_Heap_Bad_Reason'Identity , Message);
      when Error_Heap_Init                           => Raise_Exception (Exception_Heap_Init'Identity , Message);
      when Error_Heap_Bad_Desc                       => Raise_Exception (Exception_Heap_Bad_Desc'Identity , Message);
      when Error_Heap_Bad_Link                       => Raise_Exception (Exception_Heap_Bad_Link'Identity , Message);
      when Error_Heap_Alloc                          => Raise_Exception (Exception_Heap_Alloc'Identity , Message);
      when Error_Heap_Not_ABlock                     => Raise_Exception (Exception_Heap_Not_ABlock'Identity , Message);
      when Error_Heap_Bad_Extend                     => Raise_Exception (Exception_Heap_Bad_Extend'Identity , Message);
      when Error_Heap_Excessive_Shrink               => Raise_Exception (Exception_Heap_Excessive_Shrink'Identity , Message);
      when Error_Heap_Heap_Locked                    => Raise_Exception (Exception_Heap_Heap_Locked'Identity , Message);     
                                                                                                        
      when Error_Window_Alloc_Failed                 => Raise_Exception (Exception_Window_Alloc_Failed'Identity,Message);
      when Error_Window_Short_Buffer                 => Raise_Exception (Exception_Window_Short_Buffer'Identity,Message);
      when Error_Window_Bad_Version                  => Raise_Exception (Exception_Window_Bad_Version'Identity,Message);
      when Error_Window_Invalid_Flags                => Raise_Exception (Exception_Window_Invalid_Flags'Identity,Message);
      when Error_Window_Tasks_Active                 => Raise_Exception (Exception_Window_Tasks_Active'Identity,Message);
      when Error_Window_No_Such_Task                 => Raise_Exception (Exception_Window_No_Such_Task'Identity,Message);
      when Error_Window_No_Such_Method               => Raise_Exception (Exception_Window_No_Such_Method'Identity,Message);
      when Error_Window_No_Such_Misc_Op_Method       => Raise_Exception (Exception_Window_No_Such_Misc_Op_Method'Identity,Message);
      when Error_Window_Invalid_Component_Id         => Raise_Exception (Exception_Window_Invalid_Component_Id'Identity,Message);
      when Error_Window_Duplicate_Component_Id       => Raise_Exception (Exception_Window_Duplicate_Component_Id'Identity,Message);
      when Error_Window_Invalid_Gadget_Type          => Raise_Exception (Exception_Window_Invalid_Gadget_Type'Identity,Message);
                                                     
      when Error_Tool_Action_Out_of_Memory           => Raise_Exception (Exception_Tool_Action_Out_of_Memory'Identity , Message);
      when Error_Tool_Action_Cant_Create_Icon        => Raise_Exception (Exception_Tool_Action_Cant_Create_Icon'Identity , Message);
      when Error_Tool_Action_Cant_Create_Object      => Raise_Exception (Exception_Tool_Action_Cant_Create_Object'Identity , Message);
                                                     
      when Error_Prog_Info_Tasks_Active              => Raise_Exception (Exception_Prog_Info_Tasks_Active'Identity, Message);
      when Error_Prog_Info_Alloc_Failed              => Raise_Exception (Exception_Prog_Info_Alloc_Failed'Identity, Message);
      when Error_Prog_Info_Short_Buffer              => Raise_Exception (Exception_Prog_Info_Short_Buffer'Identity, Message);
      when Error_Prog_Info_No_Such_Task              => Raise_Exception (Exception_Prog_Info_No_Such_Task'Identity, Message);
      when Error_Prog_Info_No_Such_Method            => Raise_Exception (Exception_Prog_Info_No_Such_Method'Identity, Message);
      when Error_Prog_Info_No_Such_Misc_Op_Method    => Raise_Exception (Exception_Prog_Info_No_Such_Misc_Op_Method'Identity , Message);
      when Error_Print_DBox_Tasks_Active             => Raise_Exception (Exception_Print_DBox_Tasks_Active'Identity, Message);
      when Error_Print_DBox_Alloc_Failed             => Raise_Exception (Exception_Print_DBox_Alloc_Failed'Identity, Message);
      when Error_Print_DBox_Short_Buffer             => Raise_Exception (Exception_Print_DBox_Short_Buffer'Identity, Message);
      when Error_Print_DBox_No_Such_Task             => Raise_Exception (Exception_Print_DBox_No_Such_Task'Identity, Message);
      when Error_Print_DBox_No_Such_Method           => Raise_Exception (Exception_Print_DBox_No_Such_Method'Identity, Message);
      when Error_Print_DBox_No_Such_Misc_Op_Method   => Raise_Exception (Exception_Print_DBox_No_Such_Misc_Op_Method'Identity, Message);
                                                     
      when Error_Menu_Tasks_Active                   => Raise_Exception (Exception_Menu_Tasks_Active'Identity, Message);
      when Error_Menu_Alloc_Failed                   => Raise_Exception (Exception_Menu_Alloc_Failed'Identity, Message);
      when Error_Menu_Short_Buffer                   => Raise_Exception (Exception_Menu_Short_Buffer'Identity, Message);
      when Error_Menu_No_Such_Task                   => Raise_Exception (Exception_Menu_No_Such_Task'Identity, Message);
      when Error_Menu_No_Such_Method                 => Raise_Exception (Exception_Menu_No_Such_Method'Identity, Message);
      when Error_Menu_No_Such_Misc_op_method         => Raise_Exception (Exception_Menu_No_Such_Misc_op_method'Identity, Message);
      when Error_Menu_No_Such_Component              => Raise_Exception (Exception_Menu_No_Such_Component'Identity, Message);
      when Error_Menu_Sprite_Not_Text                => Raise_Exception (Exception_Menu_Sprite_Not_Text'Identity, Message);
      when Error_Menu_Text_Not_Sprite                => Raise_Exception (Exception_Menu_Text_Not_Sprite'Identity, Message);
      when Error_Menu_No_Top_Menu                    => Raise_Exception (Exception_Menu_No_Top_Menu'Identity, Message);
      when Error_Menu_Unknown_Sub_Menu               => Raise_Exception (Exception_Menu_Unknown_Sub_Menu'Identity, Message);
      when Error_Menu_No_Sprite_Name                 => Raise_Exception (Exception_Menu_No_Sprite_Name'Identity, Message);        
                                                     
      when Error_Iconbar_Alloc_Failed                => Raise_Exception (Exception_Iconbar_Alloc_Failed'Identity, Message);
      when Error_Iconbar_Short_Buffer                => Raise_Exception (Exception_Iconbar_Short_Buffer'Identity, Message);
      when Error_Iconbar_Bad_Object_Version          => Raise_Exception (Exception_Iconbar_Bad_Object_Version'Identity, Message);
      when Error_Iconbar_Bad_Flags                   => Raise_Exception (Exception_Iconbar_Bad_Flags'Identity, Message);
      when Error_Iconbar_No_Such_Task                => Raise_Exception (Exception_Iconbar_No_Such_Task'Identity, Message);
      when Error_Iconbar_No_Such_Method              => Raise_Exception (Exception_Iconbar_No_Such_Method'Identity, Message);
      when Error_Iconbar_No_Such_Misc_Op_Method      => Raise_Exception (Exception_Iconbar_No_Such_Misc_Op_Method'Identity, Message);
      when Error_Iconbar_Wrong_Show_Type             => Raise_Exception (Exception_Iconbar_Wrong_Show_Type'Identity, Message);
      when Error_Iconbar_No_Text                     => Raise_Exception (Exception_Iconbar_No_Text'Identity, Message);
      when Error_Iconbar_Tasks_Active                => Raise_Exception (Exception_Iconbar_Tasks_Active'Identity, Message);

      when Error_FontOrColour_Menu_Tasks_Active           => Raise_Exception (Exception_FontOrColour_Menu_Tasks_Active'Identity, Message);
      when Error_FontOrColour_Menu_Alloc_Failed           => Raise_Exception (Exception_FontOrColour_Menu_Alloc_Failed'Identity, Message);
      when Error_FontOrColour_Menu_Short_Buffer           => Raise_Exception (Exception_FontOrColour_Menu_Short_Buffer'Identity, Message);
      when Error_FontOrColour_Menu_No_Such_Task           => Raise_Exception (Exception_FontOrColour_Menu_No_Such_Task'Identity, Message);
      when Error_FontOrColour_Menu_No_Such_Method         => Raise_Exception (Exception_FontOrColour_Menu_No_Such_Method'Identity, Message);
      when Error_FontOrColour_Menu_No_Such_Misc_Op_Method => Raise_Exception (Exception_FontOrColour_Menu_No_Such_Misc_Op_Method'Identity, Message);

      when Error_Font_DBox_Tasks_Active           => Raise_Exception (Exception_Font_DBox_Tasks_Active'Identity, Message);
      when Error_Font_DBox_Alloc_Failed           => Raise_Exception (Exception_Font_DBox_Alloc_Failed'Identity, Message);
      when Error_Font_DBox_Short_Buffer           => Raise_Exception (Exception_Font_DBox_Short_Buffer'Identity, Message);
      when Error_Font_DBox_No_Such_Task           => Raise_Exception (Exception_Font_DBox_No_Such_Task'Identity, Message);
      when Error_Font_DBox_No_Such_Method         => Raise_Exception (Exception_Font_DBox_No_Such_Method'Identity, Message);
      when Error_Font_DBox_No_Such_Misc_Op_Method => Raise_Exception (Exception_Font_DBox_No_Such_Misc_Op_Method'Identity, Message);
      when Error_Font_DBox_No_Such_Font           => Raise_Exception (Exception_Font_DBox_No_Such_Font'Identity, Message);
      when Error_Font_DBox_No_Fonts               => Raise_Exception (Exception_Font_DBox_No_Fonts'Identity, Message);
      when Error_Font_DBox_Out_Of_Message_Space   => Raise_Exception (Exception_Font_DBox_Out_Of_Message_Space'Identity, Message);

      when Error_File_Info_Tasks_Active           => Raise_Exception (Exception_File_Info_Tasks_Active'Identity, Message);
      when Error_File_Info_Alloc_Failed           => Raise_Exception (Exception_File_Info_Alloc_Failed'Identity, Message);
      when Error_File_Info_Short_Buffer           => Raise_Exception (Exception_File_Info_Short_Buffer'Identity, Message);
      when Error_File_Info_No_Such_Task           => Raise_Exception (Exception_File_Info_No_Such_Task'Identity, Message);
      when Error_File_Info_No_Such_Method         => Raise_Exception (Exception_File_Info_No_Such_Method'Identity, Message);
      when Error_File_Info_No_Such_Misc_Op_Method => Raise_Exception (Exception_File_Info_No_Such_Misc_Op_Method'Identity, Message);

      when Error_DCS_Alloc_Failed                 => Raise_Exception (Exception_DCS_Alloc_Failed'Identity, Message);
      when Error_DCS_Tasks_Active                 => Raise_Exception (Exception_DCS_Tasks_Active'Identity, Message);

      when Error_Toolbox_No_Mem                   => Raise_Exception (Exception_Toolbox_No_Mem'Identity, Message);
      when Error_Toolbox_Bad_SWI                  => Raise_Exception (Exception_Toolbox_Bad_SWI'Identity, Message);
      when Error_Toolbox_Invalid_object_Id        => Raise_Exception (Exception_Toolbox_Invalid_object_Id'Identity, Message);
      when Error_Toolbox_Not_Atoolbox_Task        => Raise_Exception (Exception_Toolbox_Not_Atoolbox_Task'Identity, Message);
      when Error_Toolbox_No_Dir_Name              => Raise_Exception (Exception_Toolbox_No_Dir_Name'Identity, Message);
      when Error_Toolbox_No_Msgs_Fd               => Raise_Exception (Exception_Toolbox_No_Msgs_Fd'Identity, Message);
      when Error_Toolbox_No_Id_Block              => Raise_Exception (Exception_Toolbox_No_Id_Block'Identity, Message);
      when Error_Toolbox_Bad_Res_File             => Raise_Exception (Exception_Toolbox_Bad_Res_File'Identity, Message);
      when Error_Toolbox_Tasks_Active             => Raise_Exception (Exception_Toolbox_Tasks_Active'Identity, Message);
      when Error_Toolbox_Template_Not_Found       => Raise_Exception (Exception_Toolbox_Template_Not_Found'Identity, Message);
      when Error_Toolbox_No_Such_Pre_Filter       => Raise_Exception (Exception_Toolbox_No_Such_Pre_Filter'Identity, Message);
      when Error_Toolbox_Not_Ares_File            => Raise_Exception (Exception_Toolbox_Not_Ares_File'Identity, Message);
      when Error_Toolbox_Bad_Res_File_Version     => Raise_Exception (Exception_Toolbox_Bad_Res_File_Version'Identity, Message);
      when Error_Toolbox_Bad_Flags                => Raise_Exception (Exception_Toolbox_Bad_Flags'Identity, Message);           

      when others => Raise_Exception(Exception_Unknown_Error'Identity,"Error: " & Utility.intstr(Nr) & " - " & Message);
      end case;
   end Raise_Error;

   --

end RASCAL.OS;