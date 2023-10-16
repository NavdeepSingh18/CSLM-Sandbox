page 50570 "Billing Summary Factbox"
{
    PageType = CardPart;
    UsageCategory = None;
    SourceTable = "Student Master-CS";
    Caption = 'Student Clinical Billing Summary';
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            group(Information)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Style = Favorable;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                    Style = Favorable;
                }
                field(StatusDescription; StatusDescription)
                {
                    ApplicationArea = All;
                    Style = Favorable;
                    Caption = 'Student Status';
                }
                field("Course Name"; Rec."Course Name")
                {
                    ApplicationArea = All;
                    Style = Favorable;
                    Caption = 'Course Name';
                }
                field(ClnBldSem5; Rec.ClnBldSem5)
                {
                    ApplicationArea = All;
                    Style = Favorable;
                    Caption = 'Clinical 5th Semester Billed:';
                }
                field(ClnBldSem6; Rec.ClnBldSem6)
                {
                    ApplicationArea = All;
                    Style = Favorable;
                    Caption = 'Clinical 6th Semester Billed:';
                }
                field(ClnBldSem7; Rec.ClnBldSem7)
                {
                    ApplicationArea = All;
                    Style = Favorable;
                    Caption = 'Clinical 7th Semester Billed:';
                }
                field(ClnBldSem8; Rec.ClnBldSem8)
                {
                    ApplicationArea = All;
                    Style = Favorable;
                    Caption = 'Clinical 8th Semester Billed:';
                }
                field(ClnBldSemXtra; Rec.ClnBldSemXtra)
                {
                    ApplicationArea = All;
                    Style = Favorable;
                    Caption = 'Clinical Extra Semester Billed:';
                }
            }
        }
    }

    var
        StudentStatus: Record "Student Status";
        StatusDescription: Text[100];

    trigger OnAfterGetRecord()
    begin
        StudentStatus.Reset();
        if StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code") then
            StatusDescription := StudentStatus.Description;
    end;
}