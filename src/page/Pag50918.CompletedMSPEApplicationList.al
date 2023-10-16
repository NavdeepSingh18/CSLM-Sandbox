page 50918 "Completed MSPE App List"
{
    Caption = 'Completed MSPE App List';
    Editable = false;
    PageType = List;
    PromotedActionCategories = 'New,Process,Navigate';
    SourceTable = MSPE;
    SourceTableView = sorting("Application No")
                      order(descending)
                      where("Processing Status" = filter(Completed));
    UsageCategory = Lists;
    ApplicationArea = all;
    CardPageId = "MSPE Application Card";
    InsertAllowed = false;
    layout
    {
        area(Content)
        {
            repeater(Group1)
            {
                field("Application No"; Rec."Application No")
                {
                    ApplicationArea = All;
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = All;
                }
                field("Application Type"; Rec."Application Type")
                {
                    ApplicationArea = All;
                }
                field("Student No"; Rec."Student No")
                {
                    ApplicationArea = All;
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = All;
                }
                field("Last Name"; Rec."Last Name")
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
                Field("AUA Email Address"; Rec."AUA Email Address")
                {
                    ApplicationArea = All;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
                field("Creation On"; Rec."Creation On")
                {
                    ApplicationArea = All;
                }
                field("Modified By"; Rec."Modified By")
                {
                    ApplicationArea = All;
                }
                field("Modified On"; Rec."Modified On")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec."Processing Status")
                {
                    ApplicationArea = All;
                    Caption = 'Status';
                }


            }

        }
        area(FactBoxes)
        {
            Part("MSPE Status FactBox"; "MSPE FactBox")
            {
                ApplicationArea = All;
                Caption = 'MSPE Status FactBox';
                SubPageLink = "Application No" = Field("Application No"), "Application Type" = Field("Application Type"), "Student No" = Field("Student No");
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
                    StudentMaster_lRec.SetRange("No.", Rec."Student No");
                    StudentCard_lPag.SetTableView(StudentMaster_lRec);
                    StudentCard_lPag.Editable := False;
                    StudentCard_lPag.RunModal();
                end;
            }

            action("Student Document Attachment")
            {
                Caption = 'Student Document Attachment';
                Image = List;
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                Promotedonly = True;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    StudentDocAtt: Record "Student Document Attachment";
                begin
                    StudentDocAtt.Reset();
                    StudentDocAtt.FilterGroup(2);
                    StudentDocAtt.SetRange("Student No.", Rec."Student No");
                    // StudentDocAtt.SetRange("Document Category", 'GRADUATE AFFAIRS');
                    StudentDocAtt.FilterGroup(0);
                    Page.RunModal(Page::"Student Document Attachment", StudentDocAtt);
                end;
            }
        }
    }



}
