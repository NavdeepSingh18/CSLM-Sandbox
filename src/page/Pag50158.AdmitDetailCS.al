page 50158 "Admit Detail-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                     Remarks
    // ----------------------------------------------------------------------------------------
    // 01    CSPL-00059   07/02/2019       OnOpenPage()                Code added for open page user wise.

    Caption = 'Admit List - Coll';
    Editable = false;
    InsertAllowed = false;
    PageType = List;
    UsageCategory = Administration;
    ApplicationArea = All;
    SourceTable = "Application-CS";
    SourceTableView = SORTING("No.")
                      WHERE("Application Status" = FILTER(Received),
                            Alloted = CONST(false),
                            Admitted = CONST(False));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Applicant Name"; Rec."Applicant Name")
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    Caption = 'Session';
                    ApplicationArea = All;
                }
                field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                field(Section; Rec.Section)
                {
                    ApplicationArea = All;
                }
                field(Alloted; Rec.Alloted)
                {
                    ApplicationArea = All;
                }
                field("Admission Date"; Rec."Admission Date")
                {
                    ApplicationArea = All;
                }
                field("Date of Birth"; Rec."Date of Birth")
                {
                    ApplicationArea = All;
                }
                field("Father Name"; Rec."Father Name")
                {
                    ApplicationArea = All;
                }
                field("Mother Name"; Rec."Mother Name")
                {
                    ApplicationArea = All;
                }
                field(Citizenship; Rec.Citizenship)
                {
                    ApplicationArea = All;
                }
                field(Address1; Rec.Address1)
                {
                    ApplicationArea = All;
                }
                field(Address2; Rec.Address2)
                {
                    ApplicationArea = All;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = All;
                }
                field("Country Code"; Rec."Country Code")
                {
                    ApplicationArea = All;
                }
                field("E-Mail Address"; Rec."E-Mail Address")
                {
                    ApplicationArea = All;
                }
                field("Mobile Number"; Rec."Mobile Number")
                {
                    ApplicationArea = All;
                }
                field("Phone Number"; Rec."Phone Number")
                {
                    ApplicationArea = All;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = All;
                }
                field(State; Rec.State)
                {
                    ApplicationArea = All;
                }
                field(Quota; Rec.Quota)
                {
                    ApplicationArea = All;
                }
                field("Father's Qualification"; Rec."Father's Qualification")
                {
                    ApplicationArea = All;
                }
                field("Father's Occupation"; Rec."Father's Occupation")
                {
                    ApplicationArea = All;
                }
                field("Father's Annual Income"; Rec."Father's Annual Income")
                {
                    ApplicationArea = All;
                }
                field("Mother's Qualification"; Rec."Mother's Qualification")
                {
                    ApplicationArea = All;
                }
                field("Mother's Occupation"; Rec."Mother's Occupation")
                {
                    ApplicationArea = All;
                }
                field("Mother's Annual Income"; Rec."Mother's Annual Income")
                {
                    ApplicationArea = All;
                }
                field("Guardian Name"; Rec."Guardian Name")
                {
                    ApplicationArea = All;
                }
                field("Guardian Qualification"; Rec."Guardian Qualification")
                {
                    ApplicationArea = All;
                }
                field("Guardian Occupation"; Rec."Guardian Occupation")
                {
                    ApplicationArea = All;
                }
                field("Guardian Annual Income"; Rec."Guardian Annual Income")
                {
                    ApplicationArea = All;
                }
                field(Nationality; Rec.Nationality)
                {
                    ApplicationArea = All;
                }
                field("Physically Challanged"; Rec."Physically Challanged")
                {
                    ApplicationArea = All;
                }
                field("Visually Challanged"; Rec."Visually Challanged")
                {
                    ApplicationArea = All;
                }
                field("First Generation Leaner"; Rec."First Generation Leaner")
                {
                    ApplicationArea = All;
                }
                field("Enquiry No."; Rec."Enquiry No.")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        //Code added for open page user wise::CSPL-00059::07022019: Start
        IF recUserSetup.GET(UserId()) THEN BEGIN
            Rec.FILTERGROUP(2);
            IF recUserSetup."Global Dimension 1 Code" <> '' THEN
                Rec.SETFILTER("Global Dimension 1 Code", recUserSetup."Global Dimension 1 Code");
            Rec.FILTERGROUP(0);
        END;
        //Code added for open page user wise::CSPL-00059::07022019: End
    end;

    var
        recUserSetup: Record "User Setup";
}

