page 51033 "Post Grd. Doc. Request Card"
{
    PageType = Card;
    UsageCategory = None;
    SourceTable = "Post Grad. Doc. Req. Form";
    Caption = 'Post Graduate Documentation Request Form';
    RefreshOnActivate = true;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Application No"; Rec."Application No")//GMCSCOM
                {
                    ApplicationArea = All;
                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit(xRec) then
                            CurrPage.Update();
                    end;
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

                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                }
                field("Type of licensure permit"; Rec."Type of licensure permit")
                {
                    Caption = 'Type of licensure permit (full or training):';
                    ApplicationArea = All;
                }
            }
            group("Applying for Program or Position")
            {
                Caption = 'If applying for program or position at a hospital, fill out the below:';
                field("Hospital name"; Rec."Hospital name")
                {
                    ApplicationArea = All;
                }
                field(Specialty; Rec.Specialty)
                {
                    ApplicationArea = All;
                }
            }
            group(Others)
            {
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
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Processed By"; Rec."Processed By")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Processing Date"; Rec."Processing Date")
                {
                    ApplicationArea = All;
                    Visible = false;
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