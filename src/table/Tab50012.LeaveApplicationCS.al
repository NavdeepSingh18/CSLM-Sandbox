table 50012 "Leave Application-CS"
{
    // version V.001-CS

    // Sr.No.    Emp. ID       Date          Trigger                             Remarks
    // 1         CSPL-00092    28-04-2019    OnInsert                            No. Series and Assign Value in User Id Field.
    // 2         CSPL-00092    28-04-2019    No. - OnValidate                No. Series
    // 3         CSPL-00092    28-04-2019    Student No. - OnLookup            Assign Value in Fields
    // 4         CSPL-00092    28-04-2019    From Date - OnValidate            Assign Value in Field
    // 5         CSPL-00092    28-04-2019    To Date - OnValidate            Assign Value in Field

    Caption = 'Leave Application-CS';
    //DrillDownPageID = 33049493;
    //LookupPageID = 33049493;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code added for No. Series::CSPL-00092::28-04-2019: Start
                IF "No." <> xRec."No." THEN BEGIN
                    AcademicsSetupCS.GET();
                    NoSeriesManagement.TestManual(AcademicsSetupCS."Student Leave Application No.");
                    "No. Series" := '';
                END;
                //Code added for No. Series::CSPL-00092::28-04-2019: End
            end;
        }
        field(2; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            DataClassification = CustomerContent;

            trigger OnLookup()
            begin
                //Code added for Assign Value in Fields::CSPL-00092::28-04-2019: Start
                IF EducationSetupCS.Get() THEN;
                StudentMasterCS.SETRANGE("Academic Year", EducationSetupCS."Academic Year");
                IF StudentMasterCS.FINDSET() THEN
                    IF PAGE.RUNMODAL(0, StudentMasterCS) = ACTION::LookupOK THEN BEGIN
                        "Student No." := StudentMasterCS."No.";
                        "Student Name" := StudentMasterCS."Student Name";
                        Course := StudentMasterCS."Course Code";
                        Semester := StudentMasterCS.Semester;
                        Section := StudentMasterCS.Section;
                    END;
                //Code added for Assign Value in Fields::CSPL-00092::28-04-2019: End
            end;
        }
        field(3; "Student Name"; Text[100])
        {
            Caption = 'Student Name';
            DataClassification = CustomerContent;
        }
        field(4; Course; Code[20])
        {
            Caption = 'Course';
            DataClassification = CustomerContent;
            TableRelation = "Category Master-CS";
        }
        field(5; Semester; Code[10])
        {
            Caption = 'Semester';
            DataClassification = CustomerContent;
        }
        field(6; Section; Code[10])
        {
            Caption = 'Section';
            DataClassification = CustomerContent;
        }
        field(7; "From Date"; Date)
        {
            Caption = 'From Date';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code added for Assign Value in Field::CSPL-00092::28-04-2019: Start
                IF "To Date" <> 0D THEN
                    "No. Of Days" := "To Date" - "From Date" + 1;
                //Code added for Assign Value in Field::CSPL-00092::28-04-2019: End
            end;
        }
        field(8; "To Date"; Date)
        {
            Caption = 'To Date';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code added for Assign Value in Field::CSPL-00092::28-04-2019: Start
                IF "From Date" <> 0D THEN
                    "No. Of Days" := "To Date" - "From Date" + 1;
                //Code added for Assign Value in Field::CSPL-00092::28-04-2019: End
            end;
        }
        field(9; Reason; Text[250])
        {
            Caption = 'Reason';
            DataClassification = CustomerContent;
        }
        field(10; "No. Of Days"; Decimal)
        {
            Caption = 'No. Of Days';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(11; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS";
        }
        field(13; "Leave Status"; Option)
        {
            Caption = 'Status';
            DataClassification = CustomerContent;
            Editable = false;
            OptionCaption = ' ,Sanctioned,Cancelled';
            OptionMembers = " ",Sanctioned,Cancelled;
        }
        field(14; "Applicant Type"; Option)
        {
            Caption = 'Applicant Type';
            DataClassification = CustomerContent;
            OptionCaption = ' ,Student,Parent,Guardian';
            OptionMembers = " ",Student,Parent,Guardian;
        }
        field(15; "Leave Taken"; Decimal)
        {
            CalcFormula = Sum ("Leave Application-CS"."No. Of Days" WHERE("Student No." = FIELD("Student No."),
                                                                          "Leave Status" = FILTER('Sanctioned'),
                                                                          "Academic Year" = FIELD("Academic Year")));
            Caption = 'Leave Taken';
            Editable = false;
            FieldClass = FlowField;
        }
        field(16; "Applicant E-Mail ID"; Text[100])
        {
            Caption = 'Applicant E-Mail ID';
            DataClassification = CustomerContent;
        }
        field(17; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(50001; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 30-04-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(50002; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 30-04-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(50013; "Type Of Course"; Option)
        {

            Caption = 'Type Of Course';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 30-04-2019';
            OptionCaption = ' ,Semester,Year';
            OptionMembers = " ",Semester,Year;
        }
        field(50014; "Final Years Course"; Code[10])
        {
            Caption = 'Final Years Course';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 30-04-2019';
        }
        field(33048920; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 30-04-2019';
        }
        field(33048921; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 30-04-2019';
        }
    }

    keys
    {
        key(Key1; "No.")
        {
        }
        key(Key2; "Academic Year", "Leave Status", "Student No.")
        {
            SumIndexFields = "No. Of Days";
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //Code added for No. Series and Assign Value in User Id Field::CSPL-00092::28-04-2019: Start
        IF "No." = '' THEN BEGIN
            AcademicsSetupCS.GET();
            AcademicsSetupCS.TESTFIELD("Student Leave Application No.");
            NoSeriesManagement.InitSeries(AcademicsSetupCS."Student Leave Application No.", xRec."No. Series", 0D, "No.", "No. Series");
        END;
        "User ID" := FORMAT(UserId());
        //Code added for No. Series and Assign Value in User Id Field::CSPL-00092::28-04-2019: End
    end;

    var
        StudentMasterCS: Record "Student Master-CS";
        EducationSetupCS: Record "Education Setup-CS";

        AcademicsSetupCS: Record "Academics Setup-CS";
        NoSeriesManagement: Codeunit "NoSeriesManagement";

    procedure Assistedit(OldRec: Record "Leave Application-CS"): Boolean
    begin
        WITH OldRec DO BEGIN
            OldRec := Rec;
            AcademicsSetupCS.GET();
            AcademicsSetupCS.TESTFIELD("Student Leave Application No.");
            IF NoSeriesManagement.SelectSeries(AcademicsSetupCS."Student Leave Application No.", OldRec."No. Series", OldRec."No. Series") THEN BEGIN
                NoSeriesManagement.SetSeries("No.");
                Rec := OldRec;
                EXIT(TRUE);
            END;
        END;
    end;
}

