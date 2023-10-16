page 50003 "Subject Detail Clsific-CS"
{
    // version V.001-CS

    Caption = 'Subject Detail Clsific-CS';
    //Editable = false;
    PageType = List;
    UsageCategory = Administration;
    ApplicationArea = All;
    SourceTable = "Subject Classification-CS";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Rec.Code)
                {
                    ToolTip = 'Code';
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Description';
                    ApplicationArea = All;
                }
                field("Show Internal Marks"; Rec."Show Internal Marks")
                {
                    ToolTip = 'Show Internal Marks';
                    ApplicationArea = All;
                }
                field("Show External Marks"; Rec."Show External Marks")
                {
                    ToolTip = 'Show External Marks';
                    ApplicationArea = All;
                }
                field("Last Semester Evaluation"; Rec."Last Semester Evaluation")
                {
                    ToolTip = 'Last Semester Evaluation';
                    ApplicationArea = All;
                }
                field("Attendance Not Applicable"; Rec."Attendance Not Applicable")
                {
                    ToolTip = 'Attendance Not Applicable';
                    ApplicationArea = All;
                }
                field("External Pass Not Mandatory"; Rec."External Pass Not Mandatory")
                {
                    ToolTip = 'External Pass Not Mandatory';
                    ApplicationArea = All;
                }
                field("Int. Exam Not Applicable"; Rec."Int. Exam Not Applicable")
                {
                    ToolTip = 'Int. Exam Not Applicable';
                    ApplicationArea = All;
                }
                field("Hall Ticket"; Rec."Hall Ticket")
                {
                    ToolTip = 'Hall Ticket';
                    ApplicationArea = All;
                }
                Field("Occurence Not Applicale"; Rec."Occurence Not Applicale")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}

