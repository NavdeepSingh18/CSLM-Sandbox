page 50928 "STD Clinical Required Document"
{
    PageType = Worksheet;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "CLN Required Document Buffer";
    SourceTableView = sorting("User ID", "Student No.") where("Type" = filter('CLINICAL'));
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;
    Caption = 'Student Wise Clinical Required Document';

    layout
    {
        area(Content)
        {
            repeater(Rows)
            {
                Editable = false;
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Enrollment No."; Rec."Enrollment No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Document Due On"; Rec."Document Due On")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Document Specialist ID"; Rec."Document Specialist ID")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.FilterGroup(2);
        Rec.SetRange("User ID", UserId);
        Rec.FilterGroup(0);
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        CLNBuffer: Record "CLN Required Document Buffer";
    begin
        CLNBuffer.Reset();
        CLNBuffer.SetRange("User ID", UserId);
        if CLNBuffer.FindFirst() then
            repeat
                CLNBuffer.Delete();
            until CLNBuffer.Next() = 0;
    end;
}