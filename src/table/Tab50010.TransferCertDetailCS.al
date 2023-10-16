table 50010 "Transfer Cert Detail-CS"
{
    // version V.001-CS

    // Sr.No.    Emp. ID       Date          Trigger                     Remarks
    // 1         CSPL-00092    23-04-2019    OnInsert                    No. Series and  Assign Value in Fields
    // 2         CSPL-00092    23-04-2019    Student No. - OnValidate  Assign Value in Fields
    // 3         CSPL-00092    23-04-2019    Date of Birth - OnValidate  Find Age
    // 4         CSPL-00092    23-04-2019    Withdrawl No. - OnValidate  Validate data

    Caption = 'Transfer Cert Detail-CS';
    //DrillDownPageID = 33049461;
    //ookupPageID = 33049461;

    fields
    {
        field(1; "TC No."; Code[20])
        {
            Caption = 'TC No.';
            DataClassification = CustomerContent;
        }
        field(2; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            DataClassification = CustomerContent;
            TableRelation = "Student Master-CS";

            trigger OnValidate()
            begin
                //Code added for Assign Value in Fields::CSPL-00092::23-04-2019: Start
                IF StudentMasterCS.GET("Student No.") THEN BEGIN
                    "Course Code" := StudentMasterCS."Course Code";
                    "Semester Code" := StudentMasterCS.Semester;
                    "Section Code" := StudentMasterCS.Section;
                END;
                //Code added for Assign Value in Fields::CSPL-00092::23-04-2019: End
            end;
        }
        field(3; "Course Code"; Code[20])
        {
            Caption = 'Course Code';
            DataClassification = CustomerContent;
            TableRelation = "Course Master-CS";
        }
        field(4; "Semester Code"; Code[10])
        {
            Caption = 'Semester Code';
            DataClassification = CustomerContent;
            TableRelation = "Semester Master-CS";
        }
        field(5; "Section Code"; Code[20])
        {
            Caption = 'Section Code';
            DataClassification = CustomerContent;
            TableRelation = "Section Master-CS";
        }
        field(6; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS";
        }
        field(7; "Withdrawl date"; Date)
        {
            Caption = 'Withdrawl date';
            DataClassification = CustomerContent;
        }
        field(9; "TC Issued"; Boolean)
        {
            Caption = 'TC Issued';
            DataClassification = CustomerContent;
        }
        field(20; "Date of Birth"; Date)
        {
            Caption = 'Date of Birth';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code added for find Age::CSPL-00092::23-04-2019: Start
                IF "Date of Birth" <> 0D THEN BEGIN
                    Age := TODAY() - "Date of Birth";
                    TempAge := ROUND(Age / 365, 1, '=');
                    Age2 := Age MOD 365;
                    Months := ROUND(Age2 / 30, 1, '=');
                    Age := TempAge - 1;
                END ELSE BEGIN
                    CLEAR(Age);
                    CLEAR(Months);
                END;
                //Code added for Find Age::CSPL-00092::23-04-2019: End
            end;
        }
        field(21; Age; Integer)
        {
            BlankZero = true;
            Caption = 'Age';
            DataClassification = CustomerContent;
        }
        field(22; "Date of Issue"; Date)
        {
            Caption = 'Date of Issue';
            DataClassification = CustomerContent;
        }
        field(23; Conduct; Text[100])
        {
            Caption = 'Conduct';
            DataClassification = CustomerContent;
        }
        field(24; "Withdrawl No."; Code[20])
        {
            Caption = 'Withdrawl No.';
            DataClassification = CustomerContent;
            TableRelation = "Withdrawal Student-CS" WHERE("TC Issued" = FILTER(false));

            trigger OnValidate()
            begin
                //Code added for Validate data::CSPL-00092::23-04-2019: Start
                IF WithdrawalStudentCS.GET("Withdrawl No.") THEN BEGIN
                    TRANSFERFIELDS(WithdrawalStudentCS);
                    IF StudentMasterCS.GET(WithdrawalStudentCS."Student No.") THEN BEGIN
                        "Date of Birth" := StudentMasterCS."Date of Birth";
                        VALIDATE("Date of Birth");
                    END;
                    "TC No." := xRec."TC No.";
                END;
                TransferCertDetailCS.Reset();
                TransferCertDetailCS.SETRANGE("Withdrawl No.", "Withdrawl No.");
                IF TransferCertDetailCS.FINDFIRST() THEN
                    ERROR(Text000Lbl);
                //Code added for Validate data::CSPL-00092::23-04-2019: End
            end;
        }
        field(25; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = CustomerContent;
        }
        field(26; "Reason for Leaving"; Code[20])
        {
            Caption = 'Reason for Leaving';
            DataClassification = CustomerContent;
            TableRelation = "Reason Code";
        }
        field(27; Months; Integer)
        {
            BlankZero = true;
            Caption = 'Months';
            DataClassification = CustomerContent;
        }
        field(50001; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 28-04-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(50002; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 28-04-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(50013; "Type Of Course"; Option)
        {
            Description = 'CS Field Added 28-04-2019';
            OptionCaption = ' ,Semester,Year';
            DataClassification = CustomerContent;
            OptionMembers = " ",Semester,Year;
        }
        field(50014; "Final Years Course"; Code[10])
        {
            Caption = 'Final Years Course';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 28-04-2019';
        }
        field(33048920; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 28-04-2019';
        }
        field(33048921; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 28-04-2019';
        }
    }

    keys
    {
        key(Key1; "TC No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //Code added for No. Series and  Assign Value in Fields::CSPL-00092::23-04-2019: Start
        AcademicsSetupCS.GET();
        IF "No. Series" = '' THEN BEGIN
            AcademicsSetupCS.TESTFIELD("TC No.");
            NoSeriesManagement.InitSeries(AcademicsSetupCS."TC No.", xRec."No. Series", 0D, "TC No.", "No. Series");
        END;
        "Academic Year" := VerticalEducationCS.CreateSessionYear();
        "User ID" := FORMAT(UserId());
        //Code added for No. Series and  Assign Value in Fields::CSPL-00092::23-04-2019: End
    end;

    var
        AcademicsSetupCS: Record "Academics Setup-CS";

        WithdrawalStudentCS: Record "Withdrawal Student-CS";
        TransferCertDetailCS: Record "Transfer Cert Detail-CS";

        StudentMasterCS: Record "Student Master-CS";
        NoSeriesManagement: Codeunit "NoSeriesManagement";
        VerticalEducationCS: Codeunit "CSLMVerticalEducation-CS";
        Age2: Decimal;
        TempAge: Decimal;
        Text000Lbl: Label 'Record already exists.';

    procedure Assistedit(OldTC: Record "Transfer Cert Detail-CS"): Boolean
    begin
        WITH OldTC DO BEGIN
            OldTC := Rec;
            AcademicsSetupCS.GET();
            AcademicsSetupCS.TESTFIELD("TC No.");
            IF NoSeriesManagement.SelectSeries(AcademicsSetupCS."TC No.", OldTC."No. Series", "No. Series") THEN BEGIN
                NoSeriesManagement.SetSeries("TC No.");
                Rec := OldTC;
                EXIT(TRUE);
            END;
        END;
    end;
}

