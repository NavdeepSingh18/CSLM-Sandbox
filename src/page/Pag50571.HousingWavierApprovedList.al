page 50571 "Housing Wavier Approved List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Opt Out";
    Caption = 'Housing Waiver Approved/Rejected List';
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;
    SourceTableView = sorting("Application No.")
                      order(descending) Where(Status = filter(Rejected | Approved), "Application Type" = filter("Housing Wavier"));

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Application No."; Rec."Application No.")
                {
                    ApplicationArea = All;
                    Caption = 'Application No.';

                }
                Field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = All;
                }
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                    Caption = 'Student No.';
                }

                field("Enrolment No."; Rec."Enrolment No.")
                {
                    ApplicationArea = All;
                    Caption = 'Enrollment No.';

                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                    Caption = 'Student Name';
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                    Caption = 'Semester';
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                    Caption = 'Academic Year';
                }
                field(Term; Rec.Term)
                {
                    ApplicationArea = All;
                    Caption = 'Term';
                }

                field("Present Address1"; Rec."Present Address1")
                {
                    ApplicationArea = All;

                }
                field("Present Address2"; Rec."Present Address2")
                {
                    ApplicationArea = All;

                }
                field("Present Address3"; Rec."Present Address3")
                {
                    ApplicationArea = All;

                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = All;

                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;

                }

                field(State; Rec.County)
                {
                    ApplicationArea = All;

                }
                field(Country; Rec.Country)
                {
                    ApplicationArea = All;

                }
                field("Lease Agreement/Contract No."; Rec."Lease Agreement/Contract No.")
                {
                    ApplicationArea = All;

                }
                field("Lease Agreement Group"; Rec."Lease Agreement Group")
                {
                    ApplicationArea = All;

                }
                field(Transportation; Rec.Transportation)
                {
                    ApplicationArea = All;

                }
                field("Transport Cell"; Rec."Transport Cell")
                {
                    ApplicationArea = All;

                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Caption = 'Status';
                }
                field("Approved Condition Failed"; Rec."Approved Condition Failed")
                {
                    ApplicationArea = All;
                    Caption = 'Approved Condition Failed';
                }
                field("Approved/Rejected By"; Rec."Approved/Rejected By")
                {
                    ApplicationArea = All;
                    Caption = 'Approved/Rejected By';
                }
                field("Approved/Rejected On"; Rec."Approved/Rejected On")
                {
                    ApplicationArea = All;
                    Caption = 'Approved/Rejected On';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Show Document")
            {
                ApplicationArea = All;
                Caption = 'Show Document';
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                PromotedIsBig = true;
                Image = Document;
                trigger OnAction()
                Var
                    AcademicBasicOptionOut_lRec: Record "Opt Out";
                    HousingWavier_lPage: Page "Pending Housing Wavier Card";

                begin
                    AcademicBasicOptionOut_lRec.Reset();
                    AcademicBasicOptionOut_lRec.SetRange("Application No.", Rec."Application No.");
                    IF AcademicBasicOptionOut_lRec.FindFirst() then BEGIN
                        HousingWavier_lPage.SetTableView(AcademicBasicOptionOut_lRec);
                        //HousingWavier_lPage.Editable := False;
                        HousingWavier_lPage.Run();
                    END;
                end;
            }
            action("Student Card")
            {
                ApplicationArea = All;
                Image = Card;
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Caption = 'Student Card';
                Runobject = page "Student Detail Card-CS";
                RunPageLink = "No." = FIELD("Student No.");
            }
            Action("Email Notification List")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                Promotedonly = True;
                PromotedIsBig = true;
                RunObject = Page "E-Mail Notification List";
                RunPageLink = ReceiverId = Field("Student No."), Subject = filter('*Housing*');

            }
        }
    }
    //SD-SN-17-Dec-2020 +
    trigger OnOpenPage()
    var
        StudentsInfoCSCSLM: codeunit StudentsInfoCSCSLM;

    begin
        Rec.FilterGroup(2);
        Rec.SetFilter("Global Dimension 1 Code", StudentsInfoCSCSLM.GetuserSetupInstitudeCode());
        Rec.FilterGroup(0);
    end;
    //SD-SN-17-Dec-2020 -
}