table 50287 "Examiner-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                     Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00114   10/01/2019       OnInsert()                                 Get "No Series","Academic Year",Date Values
    // 02    CSPL-00114   10/01/2019       Code - OnValidate()                        Code added for No Series Related
    // 03    CSPL-00114   10/01/2019       AssistEdit - Function                      Code added for No Series Assist Edit Field Related

    Caption = 'Examiner-CS';
    // DrillDownPageID = "Card Examinar-CS";
    // LookupPageID = "Card Examinar-CS";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
            NotBlank = true;

            trigger OnValidate()
            begin
                //Code added for No Series Related::CSPL-00114::10012019: Start
                IF Code <> xRec.Code THEN BEGIN
                    AcademicsSetupCS.GET();
                    NoSeriesManagement.TestManual(AcademicsSetupCS."Examiner No.");
                    Address1 := '';
                END;
                //Code added for No Series Related::CSPL-00114::10012019: End
            end;
        }
        field(2; Name; Text[30])
        {
            Caption = 'Name';
            DataClassification = CustomerContent;
        }
        field(3; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = CustomerContent;
        }
        field(4; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS";
        }
        field(5; Address1; Text[30])
        {
            Caption = 'Address1';
            DataClassification = CustomerContent;
        }
        field(6; Address2; Text[30])
        {
            Caption = 'Address2';
            DataClassification = CustomerContent;
        }
        field(7; City; Text[30])
        {
            Caption = 'City';
            DataClassification = CustomerContent;
        }
        field(8; State; Code[20])
        {
            Caption = 'State';
            DataClassification = CustomerContent;


        }
        field(9; Country; Code[20])
        {
            Caption = 'Country';
            DataClassification = CustomerContent;
            TableRelation = "Country/Region";
        }
        field(10; Qualification; Text[30])
        {
            Caption = 'Qualification';
            DataClassification = CustomerContent;
        }
        field(11; Designation; Text[30])
        {
            Caption = 'Designation';
            DataClassification = CustomerContent;
        }
        field(12; "College / University"; Text[30])
        {
            Caption = 'College / University';
            DataClassification = CustomerContent;
        }
        field(13; "Post Code"; Code[20])
        {
            Caption = 'Post Code';
            DataClassification = CustomerContent;
            //     TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            //  ValidateTableRelation = false;
        }
        field(14; "Phone No."; Code[20])
        {
            Caption = 'Phone No.';
            DataClassification = CustomerContent;
        }
        field(15; "Mobile No."; Code[20])
        {
            Caption = 'Mobile No.';
            DataClassification = CustomerContent;
        }
        field(330487920; "User ID"; Code[20])
        {
            Caption = 'User ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10012019';
        }
        field(330487921; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 10012019';
        }
    }

    keys
    {
        key(Key1; "Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //Code added for Get "No Series","Academic Year",Date Values ::CSPL-00114::10012019: Start
        AcademicsSetupCS.GET();
        IF Code = '' THEN BEGIN
            AcademicsSetupCS.TESTFIELD("Examiner No.");
            NoSeriesManagement.InitSeries(AcademicsSetupCS."Examiner No.", xRec."No. Series", 0D, Code, "No. Series");
        END;
        "Academic Year" := VerticalEducationCS.CreateSessionYear();
        //Code added for Get "No Series","Academic Year",Date Values ::CSPL-00114::10012019: End
    end;

    var

        AcademicsSetupCS: Record "Academics Setup-CS";
        ExaminerCS: Record "Examiner-CS";
        NoSeriesManagement: Codeunit "NoSeriesManagement";
        VerticalEducationCS: Codeunit "CSLMVerticalEducation-CS";


    procedure AssistEdit(OldExaminerCS: Record "Examiner-CS"): Boolean
    begin
        //Code added for No Series Assist Edit Field Related::CSPL-00114::10012019: Start
        WITH ExaminerCS DO BEGIN
            ExaminerCS := Rec;
            AcademicsSetupCS.GET();
            AcademicsSetupCS.TESTFIELD("Examiner No.");
            IF NoSeriesManagement.SelectSeries(AcademicsSetupCS."Examiner No.", OldExaminerCS."No. Series", "No. Series") THEN BEGIN
                NoSeriesManagement.SetSeries(Code);
                Rec := ExaminerCS;
                EXIT(TRUE);
            END;

            //Code added for No Series Assist Edit Field Related::CSPL-00114::10012019: End
        end;
    end;
}

