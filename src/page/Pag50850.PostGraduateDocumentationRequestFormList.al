page 50850 "Post Grd. Doc. Req. Form"
{
    Caption = 'Post Graduate Documentation Request Form List';
    PageType = List;
    SourceTable = "Post Grad. Doc. Req. Form";
    SourceTableView = sorting("Application No") order(descending);
    ApplicationArea = All;
    UsageCategory = Administration;
    CardPageId = "Post Grd. Doc. Request Card";
    Editable = false;
    InsertAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Application No"; Rec."Application No")
                {
                    ApplicationArea = All;
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = All;
                }
                field("States for licensure"; Rec."States for licensure")
                {
                    Caption = 'State(s) where you are applying for licensure:';
                    ApplicationArea = All;
                }
                field("Type of licensure permit"; Rec."Type of licensure permit")
                {
                    Caption = 'Type of licensure permit (full or training):';
                    ApplicationArea = All;
                }
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                }
                field("Hospital name"; Rec."Hospital name")
                {
                    ApplicationArea = All;
                }
                field(Specialty; Rec.Specialty)
                {
                    ApplicationArea = All;
                }
                field("Documents Needed"; Rec."Documents Needed")
                {
                    Caption = 'Documents(s) needed from AUA:';
                    ApplicationArea = All;
                }
                field("Other information needed"; Rec."Other information needed")
                {
                    Caption = 'Other information needed (i.e. dates of enrollment, gaps, etc.):';
                    ApplicationArea = All;
                }
                field("Recipient Name"; Rec."Recipient Name")
                {
                    ApplicationArea = All;
                }
                field("Recipient Address"; Rec."Recipient Address")
                {
                    ApplicationArea = All;
                }
                field("Recipient Email"; Rec."Recipient Email")
                {
                    ApplicationArea = All;
                }
                field("Process Status"; Rec."Process Status")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Processed By"; Rec."Processed By")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Processing Date"; Rec."Processing Date")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Created On"; Rec."Created On")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Modified By"; Rec."Modified By")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Modified On"; Rec."Modified On")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Student Card")
            {
                Caption = 'Student Card';
                Image = Document;
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                Promotedonly = True;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    StudentMaster_lRec: Record "Student Master-CS";
                    StudentCard_lPag: Page "Student Detail Card-CS";
                begin
                    Clear(StudentCard_lPag);
                    StudentMaster_lRec.Reset();
                    StudentMaster_lRec.SetRange("No.", Rec."Student No.");
                    StudentCard_lPag.SetTableView(StudentMaster_lRec);
                    StudentCard_lPag.Editable := False;
                    StudentCard_lPag.RunModal();
                end;
            }
        }
    }
}
