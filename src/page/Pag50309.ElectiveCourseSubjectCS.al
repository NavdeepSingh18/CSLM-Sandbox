page 50309 "Elective Course Subject -CS"
{
    // version V.001-CS

    // No   Date      Sign     Trigger                         Description
    // -----------------------------------------------------------------------------------------------
    // 01  28.09.09  VIGNESH Form - OnOpenForm()               Code added to reset
    // 02  28.09.09  VIGNESH Form - OnAfterGetRecord()         Code added to fetch the data
    // 03  28.09.09  VIGNESH Form - OnAfterGetCurrRecord()     Code added to fetch the data
    // 04  28.09.09  VIGNESH SelectElective - OnValidate()     Code added to inseted the value in Student subject table
    // 05  28.09.09  VIGNESH matMatrix - OnAfterGetRecord()    Code added to fetch the data
    // 06  28.09.09  VIGNESH matMatrix - OnAfterGetCurrRecord()Code added to fetch the data

    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Elective Course Subject -CS';
    PageType = Card;
    SourceTable = "Student Master-CS";
    SourceTableView = SORTING("No.")
                      ORDER(Ascending)
                      WHERE("Student Status" = FILTER('Student'));

    layout
    {
    }

    actions
    {
    }

    var
}