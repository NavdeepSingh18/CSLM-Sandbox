page 50514 "Grade Book Breakup List"
{

    PageType = List;
    SourceTable = "Grade Book";
    Caption = 'Grade Book Breakup List';
    UsageCategory = None;
    // Editable = false;
    // InsertAllowed = false;
    // DeleteAllowed = false;
    // ModifyAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;

                }
                field("Enrollment No."; Rec."Enrollment No.")
                {
                    ApplicationArea = All;

                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;

                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;

                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;

                }
                field("Exam Code"; Rec."Exam Code")
                {
                    ApplicationArea = All;
                }
                field("Exam Description"; Rec."Exam Description")
                {
                    ApplicationArea = All;
                }
                field("Type of Input"; Rec."Type of Input")
                {
                    ApplicationArea = All;
                }
                field("Input Sequence"; Rec."Input Sequence")
                {
                    ApplicationArea = All;
                }
                field("Earned Points"; Rec."Earned Points")
                {
                    ApplicationArea = All;
                }
                field("Available Points"; Rec."Available Points")
                {
                    ApplicationArea = All;
                }
                field("Earned Points Percentage"; Rec."Earned Points Percentage")
                {
                    ApplicationArea = All;
                }
                field("% Range"; Rec."% Range")
                {
                    ApplicationArea = All;
                }
                field("Grade Result"; Rec."Grade Result")
                {
                    ApplicationArea = All;
                }
                field(Recommendation; Rec.Recommendation)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        IF Rec."Exam Code" <> '' THEN
            Hide1 := TRUE
        ELSE
            Hide1 := FALSE;
    end;

    trigger OnOpenPage()
    begin
        Rec.FilterGroup(2);
        Rec.SetFilter("Type of Input", '<>%1&<>%2', Rec."Type of Input"::" ", Rec."Type of Input"::Best);
        Rec.FilterGroup(0);
    end;

    var
        Hide1: Boolean;
}
