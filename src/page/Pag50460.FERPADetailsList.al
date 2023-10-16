page 50460 "FERPA Details List"
{
    PageType = List;
    SourceTable = "FERPA Details";
    Caption = 'FERPA Details List';
    ApplicationArea = All;
    UsageCategory = Lists;
    InsertAllowed = false;
    DeleteAllowed = false;
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Enrolment No."; Rec."Enrolment No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                    Visible = false;
                }

                field(Term; Rec.Term)
                {
                    ApplicationArea = All;
                    Visible = false;

                }
                field(Relationship; Rec.Relationship)
                {
                    ApplicationArea = All;
                }
                field("Relationship Name"; Rec."Relationship Name")
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
                field("E-Mail Address"; Rec."E-Mail Address")
                {
                    ApplicationArea = All;
                }
                field("Phone Number"; Rec."Phone Number")
                {
                    ApplicationArea = All;
                }

                field("As of Date"; Rec."As of Date")
                {
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field(Addr1; Rec.Addr1)
                {
                    ApplicationArea = All;
                }
                field(Addr2; Rec.Addr2)
                {
                    ApplicationArea = All;
                }
                field(State; Rec.State)
                {
                    ApplicationArea = All;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                }
                field("Country Code"; Rec."Country Code")
                {
                    ApplicationArea = All;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                }


            }
            part(FERPAModuleAllowed; "FERPA Module Allowed List")
            {
                //SubPageLink = "Student No." = FIELD("Student No."), Semester = field(Semester), "Academic Year" = field("Academic Year"), Term = field(Term);
                SubPageLink = "Info Header No" = FIELD("Info Header No"), "Ferpa Detail Line No" = field("Ferpa Detail Line No");
                ApplicationArea = All;
            }
        }
    }
    Trigger OnOpenPage()
    begin
        Rec.SetCurrentKey("Student No.", "Academic Year");
        Rec.Ascending(false);
    end;

}
