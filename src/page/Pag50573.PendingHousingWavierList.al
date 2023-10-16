page 50573 "Pending Housing Wavier List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Opt Out";
    CardPageId = "Pending Housing Wavier Card";
    Editable = False;
    SourceTableView = sorting("Created On") order(descending) where(Status = Filter("Pending for Approval"), "Application Type" = filter("Housing Wavier"));
    Caption = 'Pending Housing Waiver List';
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
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = All;
                    Caption = 'Application Date';
                }
                field("Application Type"; Rec."Application Type")
                {
                    ApplicationArea = All;
                    Caption = 'Application Type';
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
                Field(Status; Rec.Status)
                {
                    ApplicationArea = All;
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



                field("Subject 1"; Rec."Subject 1")
                {
                    ApplicationArea = All;
                    Caption = 'Subject 1';

                }
                field("Subject Description 1"; Rec."Subject Description 1")
                {
                    ApplicationArea = All;
                    Caption = 'Subject Description 1';
                }
                field("Subject 2"; Rec."Subject 2")
                {
                    ApplicationArea = All;
                    Caption = 'Subject 2';

                }
                field("Subject Description 2"; Rec."Subject Description 2")
                {
                    ApplicationArea = All;
                    Caption = 'Subject Description 2';
                }
                field("Subject 3"; Rec."Subject 3")

                {
                    ApplicationArea = All;
                    Caption = 'Subject 3';

                }
                field("Subject Description 3"; Rec."Subject Description 3")
                {
                    ApplicationArea = All;
                    Caption = 'Subject Description 3';
                }
                field("Subject 4"; Rec."Subject 4")
                {
                    ApplicationArea = All;
                    Caption = 'Subject 4';

                }
                field("Subject Description 4"; Rec."Subject Description 4")
                {
                    ApplicationArea = All;
                    Caption = 'Subject Description 4';
                }
                field("Subject 5"; Rec."Subject 5")
                {
                    ApplicationArea = All;
                    Caption = 'Subject 5';

                }
                field("Subject Description 5"; Rec."Subject Description 5")
                {
                    ApplicationArea = All;
                    Caption = 'Subject Description 5';
                }
                field("Approved Condition Failed"; Rec."Approved Condition Failed")
                {
                    ApplicationArea = All;
                    Caption = 'Approved Condition Failed';
                }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
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
        }

    }
    //SD-SN-17-Dec-2020 +
    trigger OnOpenPage()
    var
    //StudentsInfoCSCSLM: codeunit StudentsInfoCSCSLM;

    begin
        // FilterGroup(2);
        // SetFilter("Global Dimension 1 Code", StudentsInfoCSCSLM.GetuserSetupInstitudeCode());
        // FilterGroup(0);
    end;
    //SD-SN-17-Dec-2020 -
}