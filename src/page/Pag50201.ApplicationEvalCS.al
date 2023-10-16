page 50201 "Application Eval-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                     Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00130   08/02/2019       Edit-OnPush()                              To Run the Page Rank Hdr Card
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Application Evaluation';
    InsertAllowed = false;
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = "Application-CS";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Applicant Name"; Rec."Applicant Name")
                {
                    ApplicationArea = All;
                }
                field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = All;
                }
                field("Date of Birth"; Rec."Date of Birth")
                {
                    ApplicationArea = All;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = All;
                }
                field(Religion; Rec.Religion)
                {
                    ApplicationArea = All;
                }
                field(Caste; Rec.Caste)
                {
                    ApplicationArea = All;
                }
                field(Quota; Rec.Quota)
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
                field("Hostel Acommodation"; Rec."Hostel Acommodation")
                {
                    ApplicationArea = All;
                }
                field("Medium of Instruction"; Rec."Medium of Instruction")
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
                field("Staff Child"; Rec."Staff Child")
                {
                    ApplicationArea = All;
                }
                field("Staff Code"; Rec."Staff Code")
                {
                    ApplicationArea = All;
                }
                field("Break In Study"; Rec."Break In Study")
                {
                    ApplicationArea = All;
                }
                field("Sports Person"; Rec."Sports Person")
                {
                    ApplicationArea = All;
                }
                field(Specialization; Rec.Specialization)
                {
                    ApplicationArea = All;
                }
                field(Prequalification; Rec.Prequalification)
                {
                    ApplicationArea = All;
                }

                field("Name of Previous Inst"; Rec."Name of Previous Inst")
                {
                    ApplicationArea = All;
                }
                field("Certification Authority"; Rec."Certification Authority")
                {
                    ApplicationArea = All;
                }
                field("Visa No."; Rec."Visa No.")
                {
                    ApplicationArea = All;
                }
                field("Visa Exp Date"; Rec."Visa Exp Date")
                {
                    ApplicationArea = All;
                }
                field("Passport No."; Rec."Passport No.")
                {
                    ApplicationArea = All;
                }
                field("Passport Exp Date"; Rec."Passport Exp Date")
                {
                    ApplicationArea = All;
                }
                field("Co-Curricular Activities"; Rec."Co-Curricular Activities")
                {
                    ApplicationArea = All;
                }
                field("Food Habits"; Rec."Food Habits")
                {
                    ApplicationArea = All;
                }
                field("Presently Residing with"; Rec."Presently Residing with")
                {
                    ApplicationArea = All;
                }
                field(Citizenship; Rec.Citizenship)
                {
                    ApplicationArea = All;
                }
                field("University Interested"; Rec."University Interested")
                {
                    ApplicationArea = All;
                }
                field(Rejected; Rec.Rejected)
                {
                    ApplicationArea = All;
                }
                field("Rejected Reason"; Rec."Rejected Reason")
                {
                    ApplicationArea = All;
                }
            }
            part("Marks line"; "Applicant Eval Mark-CS")
            {
                ApplicationArea = All;
            }
            group(Communication)
            {
                Caption = 'Communication';
                field("Address To"; Rec."Address To")
                {
                    ApplicationArea = All;
                }
                field(Addressee; Rec.Addressee)
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
                field(Address3; Rec.Address3)
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
                field(State; Rec.State)
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
            }
            group("Family Details")
            {
                Caption = 'Family Details';
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
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Application List")
            {
                Caption = '&Application List';
                action("&List")
                {
                    Caption = '&List';
                    RunObject = Page 50254;
                    ShortCutKey = 'Shift+Ctrl+L';
                    ApplicationArea = All;
                }
            }
        }
    }
}

