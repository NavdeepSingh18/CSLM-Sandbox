page 50986 "USMLE Windows"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = USMLE;
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;


    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Student ID"; Rec."Student ID")
                {
                    ApplicationArea = All;

                }
                field(StudentName; StudentName)
                {
                    Caption = 'Student Name';
                    ApplicationArea = All;
                }
                field(UsmleID; Rec.UsmleID)
                {
                    Caption = 'USMLE ID';
                    ApplicationArea = All;
                }
                field("USMLE Step Number"; Rec.USMLEStepNumber)
                {
                    Caption = 'USMLE Step Number';
                    ApplicationArea = All;
                }
                field(USMLEAttempt; Rec.USMLEAttempt)
                {
                    Caption = 'USMLE Attempt';
                    ApplicationArea = All;
                }
                field(USMLEExtention; Rec.USMLEExtention)
                {
                    Caption = 'USMLE Extention';
                    ApplicationArea = All;
                }

                field(USMLECancle; Rec.USMLECancle)
                {
                    Caption = 'USMLE Cancle ID';
                    ApplicationArea = All;
                }
                field(USMLEOrigin; Rec.USMLEOrigin)
                {
                    Caption = 'USMLE Origin';
                    ApplicationArea = All;
                }
                field(USMLEExtended; Rec.USMLEExtended)
                {
                    Caption = 'USMLE Extended';
                    ApplicationArea = All;
                }
                field(USMLESentDate; Rec.USMLESentDate)
                {
                    Caption = 'USMLE Sent Date';
                    ApplicationArea = All;
                }
                field(USMLETestWindow; Rec.USMLETestWindow)
                {
                    Caption = 'USMLE Test Window';
                    ApplicationArea = All;
                }
                field(USMLEWindowStartDate; Rec.USMLEWindowStartDate)
                {
                    Caption = 'USMLE Window Start Date';
                    ApplicationArea = All;
                }
                field(USMLEWindowEndDate; Rec.USMLEWindowEndDate)
                {
                    Caption = 'USMLE Window End Date';
                    ApplicationArea = All;
                }
                field(Score; Rec.Score)
                {
                    Caption = 'USMLE Test Score';
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    Caption = 'USMLE Status';
                    ApplicationArea = All;
                }
            }
        }

    }
    var
        StudentName: Text;

    trigger OnOpenPage()
    var
        StudentRac: Record "Student Master-CS";

    begin
        StudentName := '';
        StudentRac.Reset();
        StudentRac.SetRange("Original Student No.", Rec."Student ID");
        if StudentRac.FindFirst() then
            StudentName := StudentRac."Student Name";
    end;

    trigger OnAfterGetRecord()
    var
        StudentRac: Record "Student Master-CS";

    begin
        StudentName := '';
        StudentRac.Reset();
        StudentRac.SetRange("Original Student No.", Rec."Student ID");
        if StudentRac.FindFirst() then
            StudentName := StudentRac."Student Name";
    end;
}