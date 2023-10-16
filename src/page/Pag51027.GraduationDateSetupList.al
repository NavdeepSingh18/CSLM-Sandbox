page 51027 "Graduation Date Setup List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Graduation Date Setup";
    Caption = 'Graduation Date Setup';

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                ///********CSPL-00307--Start Graduation Date Setup*****************
                field("Degree Code"; Rec.DegreeCode)
                {
                    ApplicationArea = All;
                }
                field(Day_StartDate; Rec.Day_StartDate)
                {
                    ToolTip = 'Specifies the value of the Day_StartDate field.';
                    ApplicationArea = All;
                }
                field(Month_StartDate; Rec.Month_StartDate)
                {
                    ToolTip = 'Specifies the value of the Month_StartDate field.';
                    ApplicationArea = All;
                }
                field(Day_EndDate; Rec.Day_EndDate)
                {
                    ToolTip = 'Specifies the value of the Day_EndDate field.';
                    ApplicationArea = All;
                }
                field(Month_EndDate; Rec.Month_EndDate)
                {
                    ToolTip = 'Specifies the value of the Month_EndDate field.';
                    ApplicationArea = All;
                }
                field(Day_GraduationDate; Rec.Day_GraduationDate)
                {
                    ToolTip = 'Specifies the value of the Day_GraduationDate field.';
                    ApplicationArea = All;
                }
                field(Month_GraduationDate; Rec.Month_GraduationDate)
                {
                    ToolTip = 'Specifies the value of the Month_GraduationDate field.';
                    ApplicationArea = All;
                }

            }
        }
    }
}