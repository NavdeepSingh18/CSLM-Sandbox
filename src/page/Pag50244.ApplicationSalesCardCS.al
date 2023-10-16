page 50244 "Application Sales Card-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                     Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00059   07/01/2019       OnOpenPage()-Trigger                      Code added to make the Bank Name & Cheque DD No. Blank
    // 02    CSPL-00059   07/01/2019       No.-OnAssistEdit()-Trigger                Use for No.generation
    // 03    CSPL-00059   07/01/2019       Prospectus No.-OnAssistEdit()-Trigger     Use for Prospectus No.generation
    // 04    CSPL-00059   07/01/2019       Course Code - OnValidate()-Trigger        Code add for validate college
    // 05    CSPL-00059   07/01/2019       Course Code - OnLookup()-Trigger          Code added for open page user wise
    // 06    CSPL-00059   07/01/2019       Religion - OnValidate()-Trigger           Code added for field editable and non editable and make blank field
    // 07    CSPL-00059   07/01/2019       Quota - OnValidate()-Trigger              Code added for field editable and non editable and validate field
    // 08    CSPL-00059   07/01/2019       Mode of Payment - OnValidate()            Code added for field editable and non editable and make blank field
    // 09    CSPL-00059   07/01/2019       Type Of Course - OnValidate()-Trigger     Code added for field editable and non editable and make blank field
    // 10    CSPL-00059   07/01/2019       CheckMandatryField()                      Code added for validation Mandatry Field
    // 11    CSPL-00059   07/01/2019       OnAction()                                Code added for run report
    // 12    CSPL-00059   07/01/2019       OnAction()                                Code added for run report
    // 13    CSPL-00059   07/01/2019       OnAction()                                Code added for run report
    // 14    CSPL-00059   07/01/2019       Post Journal - OnAction()                 Code added for posting application
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Application Sales Card';
    PageType = Card;
    SourceTable = "Application-CS";
    SourceTableView = SORTING("No.")
                      ORDER(Ascending)
                      WHERE("Application Status" = FILTER(<= Sold));

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

                    trigger OnAssistEdit()
                    begin
                        //Code added for No. genration:CSPL-00059::07012019: Start
                        IF Rec.Assistedit(xRec) THEN
                            CurrPage.Update();
                        //Code added for No. genration::CSPL-00059::07012019: End
                    end;
                }
                field("Prospectus No."; Rec."Prospectus No.")
                {
                    ApplicationArea = All;
                    Editable = false;

                    trigger OnAssistEdit()
                    begin
                        //Code added for Prospectus no. genration:CSPL-00059::07012019: Start
                        IF Rec.Assistedit(xRec) THEN
                            CurrPage.Update();
                        //Code added for Prospectus no. genration:CSPL-00059::07012019: Start
                    end;
                }
                field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        //Code added for open page user wise :CSPL-00059::07012019: Start
                        recUserSetup1.Reset();
                        recUserSetup1.SETRANGE("User ID", UserId());
                        recUserSetup1.SETFILTER("Global Dimension 1 Code", '<>%1', '');
                        IF recUserSetup1.FindFirst() THEN BEGIN
                            CourseMasterCS.Reset();
                            CourseMasterCS.SETRANGE("Global Dimension 1 Code", recUserSetup1."Global Dimension 1 Code");
                            IF PAGE.RUNMODAL(0, CourseMasterCS) = ACTION::LookupOK THEN
                                Rec."Course Code" := CourseMasterCS.Code;
                        END ELSE
                            IF PAGE.RUNMODAL(0, CourseMasterCS) = ACTION::LookupOK THEN
                                Rec."Course Code" := CourseMasterCS.Code;
                        //Code added for open page user wise :CSPL-00059::07012019: End
                    end;

                    trigger OnValidate()
                    begin
                        //Code added for validate college :CSPL-00059::07012019: Start
                        // TestCollege();
                        //Code added for validate college :CSPL-00059::07012019: End
                    end;
                }
                field("Enquiry No."; Rec."Enquiry No.")
                {
                    ApplicationArea = All;
                }
                field("Applicant Name"; Rec."Applicant Name")
                {
                    ApplicationArea = All;
                }
                field("Date of Birth"; Rec."Date of Birth")
                {
                    ApplicationArea = All;
                    Caption = 'Date of Birth';
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = All;
                    Caption = 'Gender*';
                }
                field(Religion; Rec.Religion)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        //Code added for field editable and non editable and make blank field::CSPL-00059::07012019: Start
                        IF Rec.Religion = 'JAIN' THEN
                            GVar_SubRel_Edit := TRUE
                        ELSE BEGIN
                            GVar_SubRel_Edit := FALSE;
                            Rec."Sub Religion" := Rec."Sub Religion"::" ";
                        END;
                        IF ((Rec.Religion = 'JAIN') OR (Rec.Religion = 'BUDDHIST') OR (Rec.Religion = 'CHRISTIAN') OR (Rec.Religion = 'MUSLIM') OR (Rec.Religion = 'PARSI') OR (Rec.Religion = 'SIKH')) THEN
                            Rec.Quota := 'MIN'
                        ELSE
                            Rec.Quota := 'GEN';
                        //Code added for field editable and non editable and make blank field::CSPL-00059::07012019: End
                    end;
                }
                field(Quota; Rec.Quota)
                {
                    ApplicationArea = All;
                    Caption = 'Category';

                    trigger OnValidate()
                    begin
                        //Code added for field editable and non editable and validate field::CSPL-00059::07012019: Start
                        IF (Rec.Quota = 'ST') OR (Rec.Quota = 'SC') THEN
                            GVar_Edit := TRUE
                        ELSE
                            GVar_Edit := FALSE;
                        IF Rec.Quota = '' THEN
                            Rec."Pay Type" := Rec."Pay Type"::" ";

                        Rec.VALIDATE(Religion);
                        //Code added for field editable and non editable and validate field::CSPL-00059::07012019: Start
                    end;
                }
                field("Sub Religion"; Rec."Sub Religion")
                {
                    ApplicationArea = All;
                    Editable = GVar_SubRel_Edit;
                }
                field("Pay Type"; Rec."Pay Type")
                {
                    ApplicationArea = All;
                    Editable = GVar_Edit;
                }
                field(Disability; Rec.Disability)
                {
                    ApplicationArea = All;
                    Caption = 'Disability';
                }
                field("Application Status"; Rec."Application Status")
                {
                    ApplicationArea = All;
                }
                field("Resident Status"; Rec."Resident Status")
                {
                    ApplicationArea = All;
                }
                field("Marital Status"; Rec."Marital Status")
                {
                    ApplicationArea = All;
                    Caption = 'Marital Status';
                }
                field("Mother Tongue"; Rec."Mother Tongue")
                {
                    ApplicationArea = All;
                    Caption = 'Mother Tongue';
                }
                field("Applicant Image"; Rec."Applicant Image")
                {
                    ApplicationArea = All;
                }
                field(Citizenship; Rec.Citizenship)
                {
                    ApplicationArea = All;
                    Caption = 'Nationality';
                }
                field("Application Cost"; Rec."Application Cost")
                {
                    ApplicationArea = All;
                }
                field("Mode of Payment"; Rec."Mode of Payment")
                {
                    ApplicationArea = All;
                    Caption = 'Mode of Payment*';

                    trigger OnValidate()
                    begin
                        //Code added for field editable and non editable and make blank field::CSPL-00059::07012019: Start
                        IF Rec."Mode of Payment" = 'CASH' THEN
                            EditVar := FALSE
                        ELSE
                            EditVar := TRUE;
                        IF Rec."Mode of Payment" = 'CASH' THEN BEGIN
                            Rec."Cheque / DD Date" := 0D;
                            Rec."Cheque / DD No." := '';
                            Rec."Bank Name" := '';
                        END;
                        //Code added for field editable and non editable and make blank field::CSPL-00059::07012019: End
                    end;
                }
                field("Cheque / DD No."; Rec."Cheque / DD No.")
                {
                    ApplicationArea = All;
                    Caption = 'Cheque / DD No. / Account No.';
                    Editable = EditVar;
                }
                field("Cheque / DD Date"; Rec."Cheque / DD Date")
                {
                    ApplicationArea = All;
                    Caption = 'Cheque / DD Date / Date';
                    Editable = EditVar;
                }
                field("Bank Name"; Rec."Bank Name")
                {
                    ApplicationArea = All;
                    Editable = EditVar;
                }
                field("Type Of Course"; Rec."Type Of Course")
                {
                    ApplicationArea = All;
                    Caption = 'Type Of Course*';
                    Visible = false;

                    trigger OnValidate()
                    begin
                        //Code added for field editable and non editable and make blank field::CSPL-00059::07012019: Start
                        IF Rec."Type Of Course" = Rec."Type Of Course"::Year THEN BEGIN
                            GVar_Edit_Year := TRUE;
                            GVar_Edit_Sem := FALSE;
                        END;
                        IF Rec."Type Of Course" = Rec."Type Of Course"::Semester THEN BEGIN
                            GVar_Edit_Year := FALSE;
                            GVar_Edit_Sem := TRUE;
                        END;
                        IF Rec."Type Of Course" = Rec."Type Of Course"::" " THEN BEGIN
                            Rec.Semester := '';
                            Rec.Year := '';
                        END;
                        //Code added for field editable and non editable and make blank field::CSPL-00059::07012019: End
                    end;
                }
                field(Year; Rec.Year)
                {
                    ApplicationArea = All;
                    Editable = GVar_Edit_Year;
                    Visible = false;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                    Editable = GVar_Edit_Sem;
                    HideValue = false;
                    Visible = false;
                }
                field("Portal ID"; Rec."Portal ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
            }
            group("Family Information")
            {
                field("Father Name"; Rec."Father Name")
                {
                    ApplicationArea = All;
                    Caption = 'Father''s Name*';
                }
                field("Mother Name"; Rec."Mother Name")
                {
                    ApplicationArea = All;
                    Caption = 'Mother''s Name*';
                }
                field("Guardian Name"; Rec."Guardian Name")
                {
                    ApplicationArea = All;
                }
                field("Address To"; Rec."Address To")
                {
                    ApplicationArea = All;
                }
                group("Parents/ Gurdians Ocupation:")
                {
                    field("Father's Occupation"; Rec."Father's Occupation")
                    {
                        ApplicationArea = All;
                    }
                    field("Mother's Occupation"; Rec."Mother's Occupation")
                    {
                        ApplicationArea = All;
                    }
                }
                group("Parents/ Gurdians Education:")
                {
                    field("Father's Qualification"; Rec."Father's Qualification")
                    {
                        ApplicationArea = All;
                    }
                    field("Mother's Qualification"; Rec."Mother's Qualification")
                    {
                        ApplicationArea = All;
                    }
                }
                group("Parents/ Gurdians Income:")
                {
                    field("Father's Annual Income"; Rec."Father's Annual Income")
                    {
                        ApplicationArea = All;
                    }
                    field("Mother's Annual Income"; Rec."Mother's Annual Income")
                    {
                        ApplicationArea = All;
                    }
                }
            }
            group(Communication)
            {
                Caption = 'Communication';
                group("Permanent Address")
                {
                    field(Address1; Rec.Address1)
                    {
                        ApplicationArea = All;
                    }
                    field(Address2; Rec.Address2)
                    {
                        ApplicationArea = All;
                    }
                    field(State; Rec.State)
                    {
                        ApplicationArea = All;
                        Caption = 'State**';
                    }
                    field(District; Rec.District)
                    {
                        ApplicationArea = All;
                    }
                    field(City; Rec.City)
                    {
                        ApplicationArea = All;
                        Caption = 'City';
                        Importance = Standard;
                        StyleExpr = TRUE;
                    }
                    field("Post Code"; Rec."Post Code")
                    {
                        ApplicationArea = All;
                        Caption = 'Post Code/City';
                    }
                    field("Country Code"; Rec."Country Code")
                    {
                        ApplicationArea = All;
                    }
                    field("Same As Permanent Address"; Rec."Same As Permanent Address")
                    {
                        ApplicationArea = All;
                    }
                }
                group("Corresponding Address")
                {
                    field(Address3; Rec.Address3)
                    {
                        ApplicationArea = All;
                    }
                    field(Address4; Rec.Address4)
                    {
                        ApplicationArea = All;
                    }
                    field("Cor City"; Rec."Cor City")
                    {
                        ApplicationArea = All;
                    }
                    field("Cor Post Code"; Rec."Cor Post Code")
                    {
                        ApplicationArea = All;
                    }
                    field("Cor Country Code"; Rec."Cor Country Code")
                    {
                        ApplicationArea = All;
                    }
                }
                group("Student Contacts")
                {
                    field("Phone Number"; Rec."Phone Number")
                    {
                        ApplicationArea = All;
                        Caption = 'Phone Number*';
                        Visible = false;
                    }
                    field("Mobile Number"; Rec."Mobile Number")
                    {
                        ApplicationArea = All;
                        Caption = 'Student Mobile Number*';
                    }
                    field("E-Mail Address"; Rec."E-Mail Address")
                    {
                        ApplicationArea = All;
                    }
                    field("Facebook ID"; Rec."Facebook ID")
                    {
                        ApplicationArea = All;
                    }
                }
                group("Parent Contacts")
                {
                    field("Parents Phone Number"; Rec."Parents Phone Number")
                    {
                        ApplicationArea = All;
                    }
                    field("Parents Mobile Number"; Rec."Parents Mobile Number")
                    {
                        ApplicationArea = All;
                    }
                    field("Parents Email Id"; Rec."Parents Email Id")
                    {
                        ApplicationArea = All;
                    }
                }
            }
        }
        area(factboxes)
        {
            systempart(Link; Links)
            {
                ApplicationArea = All;
                ToolTip = 'Link';
                Visible = true;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Sales Application")
            {
                Caption = '&Sales Application';
                action("Print &App.Form")
                {
                    Caption = 'Print &App.Form';
                    Visible = false;
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        //Code added for run report::CSPL-00059::07012019: Start
                        ApplicationCS.Reset();
                        ApplicationCS.SETRANGE("No.", Rec."No.");
                        IF ApplicationCS.FINDFIRST() THEN
                            REPORT.RUNMODAL(33049003, TRUE, FALSE, ApplicationCS);
                        //Code added for run report::CSPL-00059::07012019: end
                    end;
                }
                action("&Print")
                {
                    Caption = '&Print';
                    Image = Print;
                    Visible = false;
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        //Code added for run report::CSPL-00059::07012019: Start
                        ApplicationCS.Reset();
                        ApplicationCS.SETRANGE("No.", Rec."No.");
                        IF ApplicationCS.FINDFIRST() THEN
                            REPORT.RUNMODAL(33049001, TRUE, FALSE, ApplicationCS);
                        //Code added for run report::CSPL-00059::07012019: End
                    end;
                }

                action("&Certificate")
                {
                    ApplicationArea = All;
                    Caption = '&Certificate';
                    Promoted = true;
                    PromotedOnly = true;
                    RunObject = page "Student Exam Marks Detail-CS";
                    RunPageLink = "Student No." = FIELD("No.");

                }

                action("Application Details Form")
                {
                    Promoted = true;
                    PromotedOnly = true;
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        //Code added for run report::CSPL-00059::07012019: Start
                        ApplicationCS.Reset();
                        ApplicationCS.SETRANGE("No.", Rec."No.");
                        IF ApplicationCS.FINDFIRST() THEN
                            REPORT.RUNMODAL(50079, TRUE, FALSE, ApplicationCS);
                        //Code added for run report::CSPL-00059::07012019: End
                    end;
                }

                action("Post Journal")
                {
                    Caption = 'P&ost';
                    Image = Post;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';
                    ApplicationArea = All;
                    trigger OnAction()
                    var
                        AdmissionStage1CS: Codeunit "Admission Stage1-CS";
                        Process: Option Sales,Registration;
                    begin
                        //Code added for posting application::CSPL-00059::07012019: Start
                        CheckMandatryField();
                        IF AdmissionStage1CS.ApplicationDateCheckCS(Rec."Course Code") THEN
                            IF CONFIRM(Text000Lbl, TRUE) THEN
                                AdmissionStage1CS.ApplicationCostCheckCS(Rec."No.", Process::Sales);
                        //Code added for posting application::CSPL-00059::07012019: End
                    end;
                }

                action("Prequalification Details")
                {
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedOnly = true;
                    RunObject = Page "Hall Ticket Detail-CS";
                    RunPageLink = "No." = FIELD("No."),
                                  "Receipt No." = FIELD("Course Code");
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        //Code added for to make the Bank Name & Cheque DD No. Blank::CSPL-00059::07012019: Start
        IF Rec."Mode of Payment" = 'CASH' THEN BEGIN
            Rec."Cheque / DD Date" := 0D;
            Rec."Cheque / DD No." := '';
            Rec."Bank Name" := '';
        END;
        //Code added for to make the Bank Name & Cheque DD No. Blank::CSPL-00059::07012019: End
    end;

    var
        ApplicationCS: Record "Application-CS";
        recUserSetup1: Record "User Setup";
        CourseMasterCS: Record "Course Master-CS";

        GVar_Edit_Year: Boolean;
        GVar_Edit_Sem: Boolean;
        GVar_SubRel_Edit: Boolean;
        GVar_Edit: Boolean;
        EditVar: Boolean;
        Text000Lbl: Label 'Do you want to Sale this Application ?';


    procedure CheckMandatryField()
    begin
        //Code added for check validate::CSPL-00059::07012019: Start
        IF Rec."Mode of Payment" <> 'CASH' THEN
            IF ((Rec."Cheque / DD No." = '') OR (Rec."Cheque / DD Date" = 0D) OR (Rec."Bank Name" = '')) THEN
                ERROR('Please Fill Payment Details');
        //Code added for check validate::CSPL-00059::07012019: End
    end;
}