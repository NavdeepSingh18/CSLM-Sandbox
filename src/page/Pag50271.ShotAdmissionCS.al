page 50271 "Shot Admission-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                     Remarks
    // ----------------------------------------------------------------------------------------
    // 01    CSPL-00059   07/02/2019      OnAfterGetRecord()                        Code added for field editable non editable.
    // 02    CSPL-00059   07/02/2019      OnInsertRecord                            Code added for field editable non editable.
    // 03    CSPL-00059   07/02/2019      OnAfterGetCurrRecord()                    Code added for Academic Year Details.
    // 04    CSPL-00059   07/02/2019      No. - OnAssistEdit()                      Code added for Lookup No. Series.
    // 05    CSPL-00059   07/02/2019      Prospectus No.-OnAssistEdit()             Code added for Lookup No. Series.
    // 06    CSPL-00059   07/02/2019      Course Code - OnValidate()                Code added for field editable non editable.
    // 07    CSPL-00059   07/02/2019      Course Code - OnLookup                    Code added for open page college wise.
    // 06    CSPL-00059   07/02/2019      Applicant Name - OnValidate()             Code added for field editable non editable.
    // 08    CSPL-00059   07/02/2019      Date of Birth - OnValidate()              Code added for field validation.
    // 09    CSPL-00059   07/02/2019      Religion - OnValidate()                   Code added for field editable non editable.
    // 10    CSPL-00059   07/02/2019      Quota - OnValidate()                      Code added for field editable non editable.
    // 11    CSPL-00059   07/02/2019      Type Of Course - OnValidate()             Code added for field editable non editable.
    // 12    CSPL-00059   07/02/2019      Admit Student - OnAction()                Code added for field validation and admit student.
    // 13    CSPL-00059   07/02/2019      Scholarship Declaration Form -OnAction()  Code added for report run.
    // 14    CSPL-00059   07/02/2019      Application Details Form - OnAction()     Code added for report run.

    ApplicationArea = All;
    UsageCategory = Administration;

    Caption = 'Shot Admission-CS';
    PageType = Card;
    SourceTable = "Application-CS";
    SourceTableView = SORTING("No.")
                      WHERE("Application Status" = FILTER(' '));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    ToolTip = 'No.';
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        //Code added for Lookup No.Series::CSPL-00059::07022019: Start
                        IF Rec.Assistedit(xRec) THEN
                            CurrPage.Update();
                        //Code added for Lookup No.Series::CSPL-00059::07022019: End
                    end;
                }
                field("Prospectus No."; Rec."Prospectus No.")
                {
                    ToolTip = 'Prospectus No.';
                    ApplicationArea = All;
                    Editable = false;

                    trigger OnAssistEdit()
                    begin
                        //Code added for Lookup No.Series::CSPL-00059::07022019: Start
                        IF Rec.Assistedit(xRec) THEN
                            CurrPage.Update();
                        //Code added for Lookup No.Series::CSPL-00059::07022019: End
                    end;
                }
                field("Course Code"; Rec."Course Code")
                {
                    ToolTip = 'Course Code';
                    ApplicationArea = All;
                    Editable = true;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        //Code added for open page college wise::CSPL-00059::07022019: Start
                        recUserSetup1.RESET();
                        recUserSetup1.SETRANGE(recUserSetup1."User ID", Rec."User ID");
                        recUserSetup1.SETRANGE(recUserSetup1."Global Dimension 1 Code", Rec."Global Dimension 1 Code");
                        recUserSetup1.SETFILTER(recUserSetup1."Global Dimension 1 Code", '<>%1', '');
                        IF recUserSetup1.FindFirst() THEN BEGIN
                            CourseMasterCS.RESET();
                            CourseMasterCS.SETRANGE(CourseMasterCS."Global Dimension 1 Code", recUserSetup1."Global Dimension 1 Code");
                            IF PAGE.RUNMODAL(0, CourseMasterCS) = ACTION::LookupOK THEN
                                Rec."Course Code" := CourseMasterCS.Code;
                        END ELSE
                            IF PAGE.RUNMODAL(0, CourseMasterCS) = ACTION::LookupOK THEN
                                Rec."Course Code" := CourseMasterCS.Code;

                        Rec.VALIDATE("Course Code");
                        //Code added for open page college wise::CSPL-00059::07022019: Start
                    end;

                    trigger OnValidate()
                    begin
                        //Code added for field editable non editable::CSPL-00059::07022019: Start
                        IF Rec."Type Of Course" = Rec."Type Of Course"::Year THEN BEGIN
                            Edit_Year := TRUE;
                            Edit_Sem := FALSE;
                        END ELSE BEGIN
                            Edit_Year := FALSE;
                            Edit_Sem := TRUE;
                        END;
                        //Code added for field editable non editable::CSPL-00059::07022019: End
                    end;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ToolTip = 'Global Dimension 1 Code';
                    ApplicationArea = All;
                    Caption = 'College Code';
                }
                field("Applicant Name"; Rec."Applicant Name")
                {
                    ToolTip = 'Applicant Name';
                    ApplicationArea = All;
                    Editable = true;

                    trigger OnValidate()
                    begin
                        //Code added for field editable non editable::CSPL-00059::07022019: Start
                        IF Rec."Type Of Course" = Rec."Type Of Course"::Year THEN BEGIN
                            Edit_Year := TRUE;
                            Edit_Sem := FALSE;
                        END ELSE BEGIN
                            Edit_Year := FALSE;
                            Edit_Sem := TRUE;
                        END;
                        //Code added for field editable non editable::CSPL-00059::07022019: End
                    end;
                }
                field("Date of Birth"; Rec."Date of Birth")
                {
                    ToolTip = 'Date of Birth';
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        //Code added for field validation::CSPL-00059::07022019: Start
                        ApplicationCS.RESET();
                        ApplicationCS.SETRANGE("Applicant Name", Rec."Applicant Name");
                        ApplicationCS.SETRANGE("Course Code", Rec."Course Code");
                        ApplicationCS.SETRANGE("Date of Birth", Rec."Date of Birth");
                        IF ApplicationCS.FindFirst() THEN
                            ERROR(Text002Lbl, Rec."Applicant Name", Rec."Course Code", Rec."Date of Birth");
                        //Code added for field validation::CSPL-00059::07022019: End
                    end;
                }
                field(Age; Rec.Age)
                {
                    ToolTip = 'Date of Birth';
                    ApplicationArea = All;
                }
                field(Months; Rec.Months)
                {
                    ToolTip = 'Months';
                    ApplicationArea = All;
                }
                field(Gender; Rec.Gender)
                {
                    ToolTip = 'Gender';
                    ApplicationArea = All;
                }
                field(Religion; Rec.Religion)
                {
                    ToolTip = 'Religion';
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        //Code added for field editable non editable::CSPL-00059::07022019: Start
                        IF Rec.Religion = 'JAIN' THEN
                            "SubRel_Edit" := TRUE
                        ELSE BEGIN
                            SubRel_Edit := FALSE;
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
                    ToolTip = 'Quota';
                    ApplicationArea = All;
                    Caption = 'Category';

                    trigger OnValidate()
                    begin
                        //Code added for field editable non editable::CSPL-00059::07022019: Start
                        IF (Rec.Quota = 'ST') OR (Rec.Quota = 'SC') THEN
                            EditF := TRUE
                        ELSE
                            EditF := FALSE;
                        IF Rec.Quota = '' THEN
                            Rec."Pay Type" := Rec."Pay Type"::" ";
                        Rec.VALIDATE(Religion);
                        //Code added for field editable non editable::CSPL-00059::07022019: End
                    end;
                }
                field("Sub Religion"; Rec."Sub Religion")
                {
                    ToolTip = 'Sub Religion';
                    ApplicationArea = All;
                    Editable = SubRel_Edit;
                }
                field("Pay Type"; Rec."Pay Type")
                {
                    ToolTip = 'Pay Type';
                    ApplicationArea = All;
                    Editable = EditF;
                }
                field(Disability; Rec.Disability)
                {
                    ToolTip = 'Disability';
                    ApplicationArea = All;
                }
                field("Resident Status"; Rec."Resident Status")
                {
                    ToolTip = 'Resident Status';
                    ApplicationArea = All;
                }
                field("Marital Status"; Rec."Marital Status")
                {
                    ToolTip = 'Marital Status';
                    ApplicationArea = All;
                }
                field("Mother Tongue"; Rec."Mother Tongue")
                {
                    ToolTip = 'Mother Tongue';
                    ApplicationArea = All;
                }
                field(Nationality; Rec.Nationality)
                {
                    ToolTip = 'Nationality';
                    ApplicationArea = All;
                }
                field("Type Of Course"; Rec."Type Of Course")
                {
                    ToolTip = 'Type Of Course';
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        //Code added for field editable non editable::CSPL-00059::07022019: Start
                        IF Rec."Type Of Course" = Rec."Type Of Course"::Year THEN BEGIN
                            Edit_Year := TRUE;
                            Edit_Sem := FALSE;
                        END;
                        IF Rec."Type Of Course" = Rec."Type Of Course"::Semester THEN BEGIN
                            Edit_Year := FALSE;
                            Edit_Sem := TRUE;
                        END;
                        IF Rec."Type Of Course" = Rec."Type Of Course"::" " THEN BEGIN
                            Rec.Semester := '';
                            Rec.Year := '';
                        END;
                        //Code added for field editable non editable::CSPL-00059::07022019: End
                    end;
                }
                field(Year; Rec.Year)
                {
                    ToolTip = 'Year';
                    ApplicationArea = All;
                    Editable = Edit_Year;
                }
                field(Semester; Rec.Semester)
                {
                    ToolTip = 'Semester';
                    ApplicationArea = All;
                    Editable = Edit_Sem;
                }
                field("Applicant Image"; Rec."Applicant Image")
                {
                    ToolTip = 'Applicant Image';
                    ApplicationArea = All;
                }
                field("Fee Classification Code"; Rec."Fee Classification Code")
                {
                    ToolTip = 'Fee Classification Code';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ToolTip = 'Academic Year';
                    ApplicationArea = All;
                    Caption = 'Session';
                    Editable = false;
                }
                field("Admitted Year"; Rec."Admitted Year")
                {
                    ToolTip = 'Admitted Year';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Rejected Reason"; Rec."Rejected Reason")
                {
                    ToolTip = 'Rejected Reason';
                    ApplicationArea = All;
                    Caption = 'Reason';
                }
                field("Discount Applicable"; Rec."Discount Applicable")
                {
                    ToolTip = 'Discount Applicable';
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Spot; Rec.Spot)
                {
                    ToolTip = 'Spot';
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Admitted; Rec.Admitted)
                {
                    ToolTip = 'Admitted';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Call Letter Sent"; Rec."Call Letter Sent")
                {
                    ToolTip = 'Call Letter Sent';
                    ApplicationArea = All;
                    Caption = 'Skip Prequlification';
                }
                field("Hostel Allow"; Rec."Hostel Allow")
                {
                    ToolTip = 'Hostel Allow';
                    ApplicationArea = All;
                }
                field("Transport Allow"; Rec."Transport Allow")
                {
                    ToolTip = 'Transport Allow';
                    ApplicationArea = All;
                }
            }
            group("Family Information")
            {
                field("Father Name"; Rec."Father Name")
                {
                    ToolTip = 'Father Name';
                    ApplicationArea = All;
                    Caption = 'Father''s Name*';
                }
                field("Mother Name"; Rec."Mother Name")
                {
                    ToolTip = 'Mother Name';
                    ApplicationArea = All;
                    Caption = 'Mother''s Name*';
                }
                field("Guardian Name"; Rec."Guardian Name")
                {
                    ToolTip = 'Guardian Name';
                    ApplicationArea = All;
                }
                group("Parents/ Gurdians Ocupation:")
                {
                    field("Father's Occupation"; Rec."Father's Occupation")
                    {
                        ToolTip = 'Father Occupation';
                        ApplicationArea = All;
                    }
                    field("Mother's Occupation"; Rec."Mother's Occupation")
                    {
                        ToolTip = 'Mother Occupation';
                        ApplicationArea = All;
                    }
                }
                group("Parents/ Gurdians Education:")
                {
                    field("Father's Qualification"; Rec."Father's Qualification")
                    {
                        ToolTip = 'Father Qualificatione';
                        ApplicationArea = All;
                    }
                    field("Mother's Qualification"; Rec."Mother's Qualification")
                    {
                        ToolTip = 'Mother Qualification';
                        ApplicationArea = All;
                    }
                }
                group("Parents/ Gurdians Income:")
                {
                    field("Father's Annual Income"; Rec."Father's Annual Income")
                    {
                        ToolTip = 'Father Annual Income"';
                        ApplicationArea = All;
                    }
                    field("Mother's Annual Income"; Rec."Mother's Annual Income")
                    {
                        ToolTip = 'Mother Annual Income';
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
                        ToolTip = 'Address1';
                        ApplicationArea = All;
                    }
                    field(Address2; Rec.Address2)
                    {
                        ToolTip = 'Address2';
                        ApplicationArea = All;
                    }
                    field("Post Code"; Rec."Post Code")
                    {
                        ToolTip = 'Post Code';
                        ApplicationArea = All;
                        Caption = 'Post Code/City';
                    }
                    field(State; Rec.State)
                    {
                        ToolTip = 'State';
                        ApplicationArea = All;
                    }
                    field(District; Rec.District)
                    {
                        ToolTip = 'District';
                        ApplicationArea = All;
                    }
                    field(City; Rec.City)
                    {
                        ToolTip = 'City';
                        ApplicationArea = All;
                        Caption = 'City*';
                        Importance = Standard;
                        StyleExpr = TRUE;
                    }
                    field("Country Code"; Rec."Country Code")
                    {
                        ToolTip = 'Country Code';
                        ApplicationArea = All;
                    }
                    field("Same As Permanent Address"; Rec."Same As Permanent Address")
                    {
                        ToolTip = 'Same As Permanent Address';
                        ApplicationArea = All;
                    }
                }
                group("Corresponding Address")
                {

                    field(Address3; Rec.Address3)
                    {
                        ToolTip = 'Address3';
                        ApplicationArea = All;
                    }
                    field(Address4; Rec.Address4)
                    {
                        ToolTip = 'Address4';
                        ApplicationArea = All;
                    }
                    field("Cor City"; Rec."Cor City")
                    {
                        ToolTip = 'Cor City';
                        ApplicationArea = All;
                    }
                    field("Cor Post Code"; Rec."Cor Post Code")
                    {
                        ToolTip = 'Cor Post Code';
                        ApplicationArea = All;
                    }
                    field("Cor Country Code"; Rec."Cor Country Code")
                    {
                        ToolTip = 'Cor Country Code';
                        ApplicationArea = All;
                    }
                }
                group("Student Contacts")
                {
                    field("Phone Number"; Rec."Phone Number")
                    {
                        ToolTip = 'Phone Number';
                        ApplicationArea = All;
                        Caption = 'Phone Number';
                    }
                    field("Mobile Number"; Rec."Mobile Number")
                    {
                        ToolTip = 'Mobile Number';
                        ApplicationArea = All;
                        Caption = 'Student Mobile Number*';
                    }
                    field("E-Mail Address"; Rec."E-Mail Address")
                    {
                        ToolTip = 'E-Mail Address';
                        ApplicationArea = All;
                    }
                    field("Facebook ID"; Rec."Facebook ID")
                    {
                        ToolTip = 'Facebook ID';
                        ApplicationArea = All;
                    }
                }
                group("Parent Contacts")
                {

                    field("Parents Phone Number"; Rec."Parents Phone Number")
                    {
                        ToolTip = 'Parents Phone Number';
                        ApplicationArea = All;
                    }
                    field("Parents Mobile Number"; Rec."Parents Mobile Number")
                    {
                        ToolTip = 'Parents Mobile Number';
                        ApplicationArea = All;
                        Caption = 'Parents Mobile Number*';
                    }
                    field("Parents Email Id"; Rec."Parents Email Id")
                    {
                        ToolTip = 'Parents Email Id';
                        ApplicationArea = All;
                    }
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
                    ApplicationArea = All;
                    ToolTip = 'Admit Student';
                    Caption = 'Admit Student';

                    trigger OnAction()
                    begin
                        //Code added for field validation and admit student::CSPL-00059::07022019: Start
                        ApplicationCS.RESET();
                        ApplicationCS.SETRANGE("No.", Rec."No.");
                        IF ApplicationCS.FindFirst() THEN BEGIN
                            ApplicationCS.TESTFIELD("Applicant Name");
                            ApplicationCS.TESTFIELD("Course Code");
                            ApplicationCS.TESTFIELD("Academic Year");
                            ApplicationCS.TESTFIELD("Admitted Year");
                            ApplicationCS.TESTFIELD("Date of Birth");
                            ApplicationCS.TESTFIELD(Religion);
                            ApplicationCS.TESTFIELD(Quota);
                            ApplicationCS.TESTFIELD(ApplicationCS."Prospectus No.");
                            ApplicationCS.TESTFIELD("Father Name");
                            ApplicationCS.TESTFIELD("Mother Name");
                            ApplicationCS.TESTFIELD(Gender);
                            ApplicationCS.TESTFIELD(Nationality);
                            ApplicationCS.TESTFIELD(ApplicationCS.City);

                            IF (ApplicationCS."Mobile Number" = '') AND (ApplicationCS."Parents Mobile Number" = '') THEN
                                ERROR('Please fill the Student Mobile No or Parents Mobile No');
                            IF ApplicationCS."Type Of Course" = ApplicationCS."Type Of Course"::Semester THEN
                                ApplicationCS.TESTFIELD(Semester);
                            IF ApplicationCS."Type Of Course" = ApplicationCS."Type Of Course"::Year THEN
                                ApplicationCS.TESTFIELD(Year);

                        END;

                        Rec.CheckPreQulification();
                        Rec.TestCollege();
                        ApplPrequalificationCS.RESET();
                        ApplPrequalificationCS.SETRANGE("No.", Rec."No.");
                        APTotal := 0;
                        Count_Stu := 0;
                        IF NOT ApplPrequalificationCS.FindFirst() THEN
                            IF CONFIRM('Do You Want to Continue with out mark Eligibility', TRUE) THEN
                                IF Rec."Rejected Reason" <> '' THEN BEGIN
                                    FeeDiscountHeadCS1.RESET();
                                    FeeDiscountHeadCS1.SETRANGE("Fee Clasification Code", Rec.Religion);
                                    IF FeeDiscountHeadCS1.FindFirst() THEN
                                        Rec.MODIFY();
                                    AdmissionStage1CS1.StudentNoAllotCS(Rec."No.")
                                END ELSE
                                    ERROR('Please Fill The Reason for continue');



                        CourseEligibleSummaryCS.RESET();
                        CourseEligibleSummaryCS.SETRANGE("Course Code", Rec."Course Code");
                        A_Prog := 0;
                        A_Prog := 0;
                        IF CourseEligibleSummaryCS.FINDSET() THEN
                            REPEAT
                                A_Prog := A_Prog + CourseEligibleSummaryCS.Percentage;
                                A_Prog += 1;
                                Req_Course := (A_Prog / A_Prog);
                            UNTIL CourseEligibleSummaryCS.NEXT() = 0;
                        IF ApplPrequalificationCS.FINDSET() THEN BEGIN
                            REPEAT
                                APTotal := APTotal + ApplPrequalificationCS."Percentage of Mark";
                                Count_Stu += 1;
                                REq_Total := (APTotal / Count_Stu);
                            UNTIL ApplPrequalificationCS.NEXT() = 0;


                            ApplPrequalificationCS.SETRANGE("Course Code", CourseEligibleSummaryCS."Course Code");
                            IF REq_Total > Req_Course THEN BEGIN
                                FeeDiscountHeadCS.RESET();
                                FeeDiscountHeadCS.SETRANGE("Fee Clasification Code", Rec.Religion);
                                IF FeeDiscountHeadCS.FindFirst() THEN
                                    Rec.MODIFY();
                                IF CONFIRM('Do You want to continue the process', TRUE) THEN
                                    AdmissionStage1CS.StudentNoAllotCS(Rec."No.");
                            END
                            ELSE
                                IF CONFIRM('Do You Want to Continue with out mark Eligibility', TRUE) THEN
                                    IF Rec."Rejected Reason" <> '' THEN BEGIN
                                        FeeDiscountHeadCS1.RESET();
                                        FeeDiscountHeadCS1.SETRANGE("Fee Clasification Code", Rec.Religion);
                                        IF FeeDiscountHeadCS1.FindFirst() THEN
                                            Rec.Spot := TRUE;
                                        Rec.MODIFY();
                                        AdmissionStage1CS1.StudentNoAllotCS(Rec."No.");
                                    END
                                    ELSE
                                        ERROR('Please Fill The Reason for continue');

                        END;
                        Rec.OnSpotReceiptFee(Rec."Prospectus No.");
                        IF Rec.Religion = 'JAIN' THEN
                            Rec.DiscApplyJain()
                        ELSE
                            Rec.ApplyDiscount();
                        //Code added for field validation and admit student::CSPL-00059::07022019: End
                    end;
                }
                action("<Page Application Certificates>")
                {
                    ApplicationArea = All;
                    ToolTip = 'Page Application Certificates';
                    Caption = 'Certificate';
                    Promoted = true;
                    PromotedOnly = true;
                    RunObject = Page "Student Exam Marks Detail-CS";
                    RunPageLink = "Student No." = FIELD("No.");
                }
                action("Scholarship Declaration Form")
                {
                    ApplicationArea = All;
                    ToolTip = 'Scholarship Declaration Form';
                    trigger OnAction()
                    begin
                        //Code added for report run::CSPL-00059::07022019: Start
                        ApplicationCS.RESET();
                        ApplicationCS.SETRANGE("No.", Rec."No.");
                        IF ApplicationCS.FINDFIRST() THEN
                            "REPORT".RUNMODAL(50122, TRUE, FALSE, ApplicationCS);
                        //Code added for report run::CSPL-00059::07022019: End
                    end;
                }
                action("Application Details Form")
                {
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedOnly = true;
                    ToolTip = 'Application Details Form';
                    trigger OnAction()
                    begin
                        //Code added for report run::CSPL-00059::07022019: Start
                        ApplicationCS.RESET();
                        ApplicationCS.SETRANGE("No.", Rec."No.");
                        IF ApplicationCS.FINDFIRST() THEN
                            REPORT.RUNMODAL(50079, TRUE, FALSE, ApplicationCS);
                        //Code added for report run::CSPL-00059::07022019: End
                    end;
                }
                action("Prequalification Details")
                {
                    ApplicationArea = all;
                    ToolTip = 'Prequalification Details';
                    Promoted = true;
                    PromotedOnly = true;
                    RunObject = Page "Prequalification Detail-CS";
                    RunPageLink = Code = FIELD("No.");
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

    trigger OnAfterGetRecord()
    begin
        //Code added for field editable non editable::CSPL-00059::07022019: Start
        IF Rec."Type Of Course" = Rec."Type Of Course"::Year THEN BEGIN
            Edit_Year := TRUE;
            Edit_Sem := FALSE;
        END;
        IF Rec."Type Of Course" = Rec."Type Of Course"::Semester THEN BEGIN
            Edit_Year := FALSE;
            Edit_Sem := TRUE;
        END;
        IF Rec."Type Of Course" = Rec."Type Of Course"::" " THEN BEGIN
            Rec.Semester := '';
            Rec.Year := '';
        END;
        //Code added for field editable non editable::CSPL-00059::07022019: End
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        //Code added for field editable non editable::CSPL-00059::07022019: Start
        IF Rec."Type Of Course" = Rec."Type Of Course"::Year THEN BEGIN
            Edit_Year := TRUE;
            Edit_Sem := FALSE;
        END;
        IF Rec."Type Of Course" = Rec."Type Of Course"::Semester THEN BEGIN
            Edit_Year := FALSE;
            Edit_Sem := TRUE;
        END;
        IF Rec."Type Of Course" = Rec."Type Of Course"::" " THEN BEGIN
            Rec.Semester := '';
            Rec.Year := '';
        END;
        //Code added for field editable non editable::CSPL-00059::07022019: End
    end;

    var


        CourseMasterCS: Record "Course Master-CS";
        ApplicationCS: Record "Application-CS";
        recUserSetup1: Record "User Setup";
        ApplPrequalificationCS: Record "Appl Prequalification-CS";
        CourseEligibleSummaryCS: Record "Course Eligible Summary-CS";
        FeeDiscountHeadCS: Record "Fee Discount Head-CS";
        FeeDiscountHeadCS1: Record "Fee Discount Head-CS";
        AdmissionStage1CS: Codeunit "Admission Stage1-CS";
        AdmissionStage1CS1: Codeunit "Admission Stage1-CS";
        Text002Lbl: Label 'Applicant already exist..%1..%2..%3';
        Edit_Year: Boolean;
        Edit_Sem: Boolean;
        APTotal: Decimal;
        Count_Stu: Decimal;
        REq_Total: Decimal;
        A_Prog: Decimal;
        Req_Course: Decimal;
        SubRel_Edit: Boolean;
        EditF: Boolean;

}

