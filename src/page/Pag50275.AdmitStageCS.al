page 50275 "Admit Stage-CS"
{
    // version V.001-CS

    // 
    // Sr.No   Emp.ID      Date            Trigger                                     Remarks
    // ----------------------------------------------------------------------------------------
    // 01    CSPL-00059   07/02/2019      OnOpenPage()                              Code added for field editable non editable.
    // 02    CSPL-00059   07/02/2019      OnAfterGetCurrRecord()                    Code added for Academic Year Details.
    // 03    CSPL-00059   07/02/2019      Religion - OnValidate()                   Code added for field editable non editable.
    // 04    CSPL-00059   07/02/2019      Quota - OnValidate()                      Code added for field editable non editable.
    // 05    CSPL-00059   07/02/2019      Type Of Course - OnValidate()             Code added for field editable non editable.
    // 06    CSPL-00059   07/02/2019      Admit Student - OnAction()                Code added for field validation and admit student.
    // 07    CSPL-00059   07/02/2019      Scholarship Declaration Form - OnAction()  Code added for report run.
    // 08    CSPL-00059   07/02/2019      Admit - OnAction()                        Code added for admit student and apply discount.

    Caption = 'Admit Stage-CS';
    PageType = Card;
    SourceTable = "Application-CS";
    SourceTableView = SORTING("No.")
                      WHERE("Application Status" = FILTER('Received'));
    ApplicationArea = All;
    UsageCategory = Administration;
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
                    Editable = false;
                }
                field("Applicant Name"; Rec."Applicant Name")
                {
                    ApplicationArea = All;
                    Caption = 'Applicant Name*';
                    Editable = false;
                }
                field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = All;
                    Caption = 'Course Code*';
                    Editable = true;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = All;
                    Caption = 'Gender*';
                }
                field("Date of Birth"; Rec."Date of Birth")
                {
                    ApplicationArea = All;
                    Caption = 'Date of Birth*';
                }
                field("Stage1 Selection List No."; Rec."Stage1 Selection List No.")
                {
                    ApplicationArea = All;
                    Caption = 'Stage1 Selection List No.*';
                    Editable = false;
                    Visible = false;
                }
                field("Eligibility Rank"; Rec."Eligibility Rank")
                {
                    ApplicationArea = All;
                    Caption = 'Eligibility Rank*';
                    Editable = false;
                    Visible = false;
                }
                field("Eligibility Percertage"; Rec."Eligibility Percertage")
                {
                    ApplicationArea = All;
                    Caption = 'Eligibility Percertage*';
                    Editable = false;
                    Visible = false;
                }
                field(Religion; Rec.Religion)
                {
                    ApplicationArea = All;
                    Caption = 'Religion*';

                    trigger OnValidate()
                    begin
                        //Code added for field editable non editable::CSPL-00059::07022019: Start
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
                        //Code added for field editable non editable::CSPL-00059::07022019: End
                    end;
                }
                field(Quota; Rec.Quota)
                {
                    ApplicationArea = All;
                    Caption = 'Quota/Category*';
                    Editable = true;

                    trigger OnValidate()
                    begin
                        //Code added for field editable non editable::CSPL-00059::07022019: Start
                        IF (Rec.Quota = 'ST') OR (Rec.Quota = 'SC') THEN
                            GVar_Edit := TRUE
                        ELSE
                            GVar_Edit := FALSE;
                        IF Rec.Quota = '' THEN
                            Rec."Pay Type" := Rec."Pay Type"::" ";
                        Rec.VALIDATE(Rec.Religion);
                        //Code added for field editable non editable::CSPL-00059::07022019: End
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
                field(Nationality; Rec.Nationality)
                {
                    ApplicationArea = All;
                    Caption = 'Nationality*';
                }
                field("Parents Mobile Number"; Rec."Parents Mobile Number")
                {
                    ApplicationArea = All;
                    Caption = 'Parents Mobile Number*';
                }
                field("Mobile Number"; Rec."Mobile Number")
                {
                    ApplicationArea = All;
                    Caption = 'Student Mobile Number';
                }
                field("Eligibilty Quota"; Rec."Eligibilty Quota")
                {
                    ApplicationArea = All;
                    Caption = 'Eligibilty Quota*';
                    Editable = false;
                    Visible = false;
                }
                field("Eligibility Quota Rank"; Rec."Eligibility Quota Rank")
                {
                    ApplicationArea = All;
                    Caption = 'Eligibility Quota Rank*';
                    Editable = false;
                    Visible = false;
                }
                field("Interview Attended"; Rec."Interview Attended")
                {
                    ApplicationArea = All;
                    Caption = 'Interview Attended*';
                    Visible = false;
                }
                field(State; Rec.State)
                {
                    ApplicationArea = All;
                }
                field(District; Rec.District)
                {
                    ApplicationArea = All;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                    Caption = 'City*';
                    Style = AttentionAccent;
                    StyleExpr = TRUE;
                }
                field("Interview Selected"; Rec."Interview Selected")
                {
                    ApplicationArea = All;
                    Caption = 'Interview Selected*';
                    Visible = false;
                }
                field("Type Of Course"; Rec."Type Of Course")
                {
                    ApplicationArea = All;
                    Caption = 'Type Of Course*';

                    trigger OnValidate()
                    begin
                        //Code added for field editable non editable::CSPL-00059::07022019: Start
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
                        //Code added for field editable non editable::CSPL-00059::07022019: End
                    end;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                    Caption = 'Semester*';
                    Editable = GVar_Edit_Sem;
                }
                field(Year; Rec.Year)
                {
                    ApplicationArea = All;
                    Caption = 'Year*';
                    Editable = GVar_Edit_Year;
                }
                field(Section; Rec.Section)
                {
                    Caption = 'Section*';
                    ApplicationArea = All;
                }
                field("Fee Classification Code"; Rec."Fee Classification Code")
                {
                    Caption = 'Fee Classification Code*';
                    ApplicationArea = All;
                }
                field(Alloted; Rec.Alloted)
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    Caption = 'Session*';
                    ApplicationArea = All;
                }
                field("Stage2 Selection List No."; Rec."Stage2 Selection List No.")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Selection Rank"; Rec."Selection Rank")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Selection Percentage"; Rec."Selection Percentage")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Selected Quota"; Rec."Selected Quota")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Selected Quota Rank"; Rec."Selected Quota Rank")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Prospectus No."; Rec."Prospectus No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Discount Applicable"; Rec."Discount Applicable")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Father Name"; Rec."Father Name")
                {
                    Caption = 'Father''s Name*';
                    ApplicationArea = All;
                }
                field("Mother Name"; Rec."Mother Name")
                {
                    Caption = 'Mother''s Name*';
                    ApplicationArea = All;
                }
                field("Rejected Reason"; Rec."Rejected Reason")
                {
                    Caption = ' Reason';
                    ApplicationArea = All;
                    Style = Favorable;
                    StyleExpr = TRUE;
                }
                field(Admitted; Rec.Admitted)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Call Letter Sent"; Rec."Call Letter Sent")
                {
                    Caption = 'Skip Prequalification';
                    ApplicationArea = All;
                }
                field("Hostel Allow"; Rec."Hostel Allow")
                {
                    ApplicationArea = All;
                }
                field("Transport Allow"; Rec."Transport Allow")
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
            group(Admission)
            {
                Caption = '&Admission';
                action("Admit Student")
                {
                    Caption = 'Admit Student';
                    Image = AddContacts;
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        //Code added for field validation and admit student::CSPL-00059::14022019: Start
                        ApplicationCS.Reset();
                        ApplicationCS.SETRANGE("No.", Rec."No.");
                        IF ApplicationCS.FindFirst() THEN BEGIN
                            ApplicationCS.TESTFIELD("Applicant Name");
                            ApplicationCS.TESTFIELD("Course Code");
                            ApplicationCS.TESTFIELD("Academic Year");
                            ApplicationCS.TESTFIELD("Date of Birth");
                            ApplicationCS.TESTFIELD(Religion);
                            ApplicationCS.TESTFIELD(Quota);
                            ApplicationCS.TESTFIELD(ApplicationCS."Prospectus No.");
                            ApplicationCS.TESTFIELD("Father Name");
                            ApplicationCS.TESTFIELD("Mother Name");
                            ApplicationCS.TESTFIELD(Gender);
                            ApplicationCS.TESTFIELD(Nationality);
                            ApplicationCS.TESTFIELD(ApplicationCS.City);
                            IF ApplicationCS."Type Of Course" = ApplicationCS."Type Of Course"::Semester THEN
                                ApplicationCS.TESTFIELD(Semester);
                            IF ApplicationCS."Type Of Course" = ApplicationCS."Type Of Course"::Year THEN
                                ApplicationCS.TESTFIELD(Year);
                            IF (ApplicationCS."Mobile Number" = '') AND (ApplicationCS."Parents Mobile Number" = '') THEN
                                ERROR('Please fill the Student Mobile No or Parents Mobile No');
                            IF (Rec.Quota = 'SC') OR (Rec.Quota = 'ST') THEN
                                ApplicationCS.TESTFIELD("Pay Type");
                        END;
                        // CheckPreQulification();
                        // TestCollege();
                        ApplPrequalificationCS.Reset();
                        ApplPrequalificationCS.SETRANGE("No.", Rec."No.");
                        APP_Total := 0;
                        Count_Total := 0;
                        IF NOT ApplPrequalificationCS.FindFirst() THEN
                            IF CONFIRM('Do You Want to Continue For Rejected Student', TRUE) THEN BEGIN
                                IF Rec."Rejected Reason" <> '' THEN BEGIN
                                    FeeDiscountHeadCS.Reset();
                                    FeeDiscountHeadCS.SETRANGE("Fee Clasification Code", Rec.Religion);
                                    IF FeeDiscountHeadCS.FindFirst() THEN
                                        Rec.Modify();
                                    Rec.Submited := TRUE;
                                END
                                ELSE
                                    ERROR('Please Fill The Reason for continue');
                            END
                            ELSE BEGIN
                                Rec."Rejected Reason" := 'Not Eligible for Prequalification Marks';
                                Rec.Rejected := TRUE;
                                MESSAGE('Not Eligibile');
                            END;


                        CourseEligibleSummaryCS.Reset();
                        CourseEligibleSummaryCS.SETRANGE("Course Code", Rec."Course Code");
                        APP_Course := 0;
                        Count_Course := 0;
                        IF CourseEligibleSummaryCS.FINDSET() THEN
                            REPEAT
                                APP_Course := APP_Course + CourseEligibleSummaryCS.Percentage;
                                Count_Course += 1;
                                Elig_Course := (APP_Course / Count_Course);
                            UNTIL
CourseEligibleSummaryCS.NEXT() = 0;


                        IF ApplPrequalificationCS.FINDSET() THEN BEGIN
                            REPEAT
                                APP_Total := APP_Total + ApplPrequalificationCS."Percentage of Mark";
                                Count_Total += 1;
                                Elig_Total := (APP_Total / Count_Total);
                            UNTIL
ApplPrequalificationCS.NEXT() = 0;


                            ApplPrequalificationCS.SETRANGE("Course Code", CourseEligibleSummaryCS."Course Code");
                            IF Elig_Total > Elig_Course THEN BEGIN
                                FeeDiscountHeadCS.Reset();
                                FeeDiscountHeadCS.SETRANGE("Fee Clasification Code", Rec.Religion);
                                IF FeeDiscountHeadCS.FindFirst() THEN
                                    Rec."Discount Applicable" := TRUE;
                                Rec.Modify();
                                IF CONFIRM('Do You want to continue the process', TRUE) THEN
                                    Rec.Submited := TRUE;
                            END
                            ELSE
                                IF CONFIRM('Do You Want to Continue For Rejected Student', TRUE) THEN BEGIN
                                    IF Rec."Rejected Reason" <> '' THEN BEGIN
                                        FeeDiscountHeadCS.Reset();
                                        FeeDiscountHeadCS.SETRANGE("Fee Clasification Code", Rec.Religion);
                                        IF FeeDiscountHeadCS.FindFirst() THEN
                                            Rec."Discount Applicable" := TRUE;
                                        Rec.Modify();
                                        Rec.Submited := TRUE;
                                    END
                                    ELSE
                                        ERROR('Please Fill The Reason for continue');
                                END
                                ELSE BEGIN
                                    Rec."Rejected Reason" := 'Not Eligible for Prequalification Marks';
                                    Rec.Rejected := TRUE;
                                    MESSAGE('Not Eligibile');
                                END;
                        END;
                        MESSAGE('Application successful Submited');
                        //Code added for field validation and admit student::CSPL-00059::14022019: End
                    end;
                }
                action("Scholarship Declaration Form")
                {
                    Image = Report2;
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        //Code added for report run::CSPL-00059::14022019: Start
                        ApplicationCS.Reset();
                        ApplicationCS.SETRANGE("No.", Rec."No.");
                        IF ApplicationCS.FINDFIRST() THEN
                            REPORT.RUNMODAL(50122, TRUE, FALSE, ApplicationCS);
                        //Code added for report run::CSPL-00059::14022019: End
                    end;
                }
                action("Prequalification Details")
                {
                    Promoted = true;
                    PromotedOnly = true;
                    RunObject = Page "Hall Ticket Detail-CS";
                    RunPageLink = "No." = FIELD("No.");
                    ShortCutKey = 'Ctrl+P';
                    ApplicationArea = All;
                }
                action(Admit)
                {
                    ApplicationArea = All;
                    trigger OnAction()
                    var
                        Text001Lbl: Label 'Do you want continu';
                    begin
                        //Code added for admit student and apply discount::CSPL-00059::14022019: Start
                        IF CONFIRM(Text001Lbl, TRUE) THEN BEGIN
                            AdmissionStage1CS.StudentNoAllotCS(Rec."No.");
                            // IF Rec.Religion = 'JAIN' THEN
                            //     DiscApplyJain()
                            // ELSE
                            //     ApplyDiscount();
                        END;
                        //Code added for admit student and apply discount::CSPL-00059::14022019: End
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        //Code added for Academic Year Details::CSPL-00059::07022019: Start
        Rec."Admitted Year" := FORMAT(DATE2DMY(TODAY(), 3));
        Rec."Fee Classification Code" := 'GEN';
        //Code added for Academic Year Details::CSPL-00059::07022019: End
    end;

    trigger OnOpenPage()
    begin
        //Code added for field editable non editable::CSPL-00059::07022019: Start
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
        Rec."Admitted Year" := FORMAT(DATE2DMY(TODAY(), 3));
        //Code added for field editable non editable::CSPL-00059::07022019: End
    end;

    var


        ApplicationCS: Record "Application-CS";
        ApplPrequalificationCS: Record "Appl Prequalification-CS";
        CourseEligibleSummaryCS: Record "Course Eligible Summary-CS";
        FeeDiscountHeadCS: Record "Fee Discount Head-CS";
        AdmissionStage1CS: Codeunit "Admission Stage1-CS";
        APP_Total: Decimal;
        Count_Total: Decimal;
        Elig_Total: Decimal;
        APP_Course: Decimal;
        Count_Course: Decimal;
        Elig_Course: Decimal;
        GVar_Edit_Year: Boolean;
        GVar_Edit_Sem: Boolean;
        GVar_Edit: Boolean;
        GVar_SubRel_Edit: Boolean;



}

