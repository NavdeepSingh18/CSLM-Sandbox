table 50038 "College Announcement-CS"
{
    // version V.001-CS

    // Sr.No.    Emp. ID       Date          Trigger                            Remarks
    // 1         CSPL-00092    03-05-2019    OnInsert                           No. Series
    // 2         CSPL-00092    03-05-2019    Announcement No. - OnValidate      No. Series
    // 3         CSPL-00092    03-05-2019    Closed - OnValidate                Assign Value in Date Closed Field
    // 4         CSPL-00092    03-05-2019    Canceled - OnValidate              Validate Data

    Caption = 'College Announcement-CS';
    //LookupPageID = 33049652;

    fields
    {
        field(1; "Announcement No."; Code[20])
        {
            Caption = 'Announcement No.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code added for No. Series::CSPL-00092::03-05-2019: Start
                IF "Announcement No." <> xRec."Announcement No." THEN BEGIN
                    EducationSetupCS.GET();
                    NoSeriesManagement.TestManual(EducationSetupCS."Announcement No.");
                    "No. Series" := '';
                END;
                //Code added for No. Series::CSPL-00092::03-05-2019: End
            end;
        }
        field(2; "Announcement Type"; Option)
        {
            Caption = 'Announcement Type';
            DataClassification = CustomerContent;
            OptionCaption = ' ,Staff,Student,Everyone';
            OptionMembers = " ",Staff,Student,Everyone;
        }
        field(3; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
            TableRelation = IF ("Announcement Type" = CONST(Staff)) Employee
            ELSE
            IF ("Announcement Type" = CONST(Student)) "Co-Curricular Activities-CS";
        }
        field(9; "Date Created"; Date)
        {
            Caption = 'Starting Date';
            DataClassification = CustomerContent;
            NotBlank = true;
        }
        field(11; Priority; Option)
        {
            Caption = 'Priority';
            DataClassification = CustomerContent;
            InitValue = Normal;
            OptionCaption = 'Low,Normal,High';
            OptionMembers = Low,Normal,High;
        }
        field(12; Description; Text[250])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(13; Closed; Boolean)
        {
            Caption = 'Closed';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code added for Assign Value in Date Closed Field::CSPL-00092::03-05-2019: Start
                IF Closed THEN
                    "Date Closed" := TODAY();
                //Code added for Assign Value in Date Closed Field::CSPL-00092::03-05-2019: End
            end;
        }
        field(14; "Date Closed"; Date)
        {
            Caption = 'Date Closed';
            DataClassification = CustomerContent;
        }
        field(15; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "No. Series";
        }
        field(17; Canceled; Boolean)
        {
            Caption = 'Canceled';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code added for Validate Data::CSPL-00092::03-05-2019: Start
                IF Canceled AND NOT Closed THEN
                    VALIDATE(Closed, TRUE);

                IF (NOT Canceled) AND Closed THEN
                    VALIDATE(Closed, FALSE);
                //Code added for Validate Data::CSPL-00092::03-05-2019: End
            end;
        }
        field(18; "Start Date"; Date)
        {
            Caption = 'Start Date';
            DataClassification = CustomerContent;
        }
        field(19; "End Date"; Date)
        {
            Caption = 'End Date';
            DataClassification = CustomerContent;
        }
        field(20; "Document Type"; Option)
        {
            Caption = 'Document Type';
            DataClassification = CustomerContent;
            OptionCaption = ' ,Event,Announcement,Circular';
            OptionMembers = " ","Event",Announcement,Circular;
        }
        field(21; Subject; Text[250])
        {
            Caption = 'Subject';
            DataClassification = CustomerContent;
        }
        field(50001; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 07-05-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(50002; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 07-05-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(33048920; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 07-05-2019';
        }
        field(33048921; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 07-05-2019';
        }
    }

    keys
    {
        key(Key1; "Announcement No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //Code added for No. Series::CSPL-00092::03-05-2019: Start
        IF "Announcement No." = '' THEN BEGIN
            EducationSetupCS.GET();
            EducationSetupCS.TESTFIELD("Announcement No.");
            NoSeriesManagement.InitSeries(EducationSetupCS."Announcement No.", xRec."No. Series", 0D, "Announcement No.", "No. Series");
        END;
        //Code added for No. Series::CSPL-00092::03-05-2019: End
    end;

    var
        CollegeAnnouncementCS: Record "College Announcement-CS";
        EducationSetupCS: Record "Education Setup-CS";
        NoSeriesManagement: Codeunit "NoSeriesManagement";

    procedure AssistEdit(OldAnnouncement: Record "College Announcement-CS"): Boolean
    begin
        WITH CollegeAnnouncementCS DO BEGIN
            CollegeAnnouncementCS := Rec;
            EducationSetupCS.GET();
            EducationSetupCS.TESTFIELD("Announcement No.");
            IF NoSeriesManagement.SelectSeries(EducationSetupCS."Announcement No.", OldAnnouncement."No. Series", "No. Series") THEN BEGIN
                EducationSetupCS.GET();
                EducationSetupCS.TESTFIELD("Announcement No.");
                NoSeriesManagement.SetSeries("Announcement No.");
                Rec := CollegeAnnouncementCS;
                EXIT(TRUE);
            END;
        END;
    end;
}

