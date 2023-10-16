table 50037 "Student Task-CS"
{
    // version V.001-CS

    // Sr.No.    Emp. ID       Date          Trigger                   Remarks
    // 1         CSPL-00092    03-05-2019    OnInsert                  No. Series and  Assign Value in Fields
    // 2         CSPL-00092    03-05-2019    Task No. - OnValidate   No. Series
    // 3         CSPL-00092    03-05-2019    Task Status - OnValidateValidate data
    // 4         CSPL-00092    03-05-2019    Closed - OnValidate   Assign Value in Fields
    // 5         CSPL-00092    03-05-2019    Canceled - OnValidate Validate Data

    Caption = 'Student Task-CS';
    //LookupPageID = 33049651;

    fields
    {
        field(1; "Task No."; Code[20])
        {
            Caption = 'Task No.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code added for No. Series::CSPL-00092::03-05-2019: Start
                IF "Task No." <> xRec."Task No." THEN BEGIN
                    EducationSetupCS.GET();
                    //NoSeriesManagement.TestManual(EducationSetupCS."Task No.");
                    "No. Series" := '';
                END;
                //Code added for No. Series::CSPL-00092::03-05-2019: End
            end;
        }
        field(2; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = ' ,Staff,Student';
            OptionMembers = " ",Staff,Student;
            DataClassification = CustomerContent;
        }
        field(3; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
            TableRelation = IF (Type = CONST(Staff)) Employee;
        }
        field(9; Date; Date)
        {
            Caption = 'Starting Date';
            DataClassification = CustomerContent;
            NotBlank = true;
        }
        field(10; "Task Status"; Option)
        {
            Caption = 'Status';
            DataClassification = CustomerContent;
            OptionCaption = 'Not Started,In Progress,Completed,Waiting,Postponed';
            OptionMembers = "Not Started","In Progress",Completed,Waiting,Postponed;

            trigger OnValidate()
            begin
                //Code added for Validate data::CSPL-00092::03-05-2019: Start
                IF "Task Status" = "Task Status"::Completed THEN
                    VALIDATE(Closed, TRUE)
                ELSE
                    VALIDATE(Closed, FALSE);
                //Code added for Validate data::CSPL-00092::03-05-2019: End
            end;
        }
        field(11; Priority; Option)
        {
            Caption = 'Priority';
            DataClassification = CustomerContent;
            InitValue = Normal;
            OptionCaption = 'Low,Normal,High';
            OptionMembers = Low,Normal,High;
        }
        field(12; Description; Text[50])
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
                //Code added for Assign Value in Fields::CSPL-00092::03-05-2019: Start
                IF Closed THEN BEGIN
                    "Date Closed" := TODAY();
                    "Task Status" := "Task Status"::Completed;
                END;
                //Code added for Assign Value in Fields::CSPL-00092::03-05-2019: End
            end;
        }
        field(14; "Date Closed"; Date)
        {
            Caption = 'Date Closed';
            DataClassification = CustomerContent;
            Editable = false;
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
        field(19; "Assinged To"; Code[20])
        {
            Caption = 'Assinged To';
            DataClassification = CustomerContent;
        }
        field(20; "Start Date"; Date)
        {
            Caption = 'Start Date';
            DataClassification = CustomerContent;
        }
        field(21; "End Date"; Date)
        {
            Caption = 'End Date';
            DataClassification = CustomerContent;
        }
        field(50001; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 06-05-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(50002; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 06-05-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(33048920; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 06-05-2019';
        }
        field(33048921; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 06-05-2019';
        }
    }

    keys
    {
        key(Key1; "Task No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //Code added for No. Series and  Assign Value in Fields::CSPL-00092::03-05-2019: Start
        "User ID" := FORMAT(UserId());
        Date := TODAY();
        IF "Task No." = '' THEN BEGIN
            EducationSetupCS.GET();
            EducationSetupCS.TESTFIELD(EducationSetupCS."Task No.");
            //NoSeriesManagement.InitSeries(EducationSetupCS."Task No.", xRec."No. Series", 0D, "Task No.", "No. Series");
        END;
        //Code added for No. Series and  Assign Value in Fields::CSPL-00092::03-05-2019: End
    end;

    var
        StudentTaskCS: Record "Student Task-CS";
        EducationSetupCS: Record "Education Setup-CS";
    //NoSeriesManagement: Codeunit "NoSeriesManagement";

    procedure AssistEdit(OldTaskno: Record "Student Task-CS"): Boolean
    begin
        WITH StudentTaskCS DO BEGIN
            StudentTaskCS := Rec;
            EducationSetupCS.GET();
            EducationSetupCS.TESTFIELD(EducationSetupCS."Task No.");
            //IF NoSeriesManagement.SelectSeries(EducationSetupCS."Task No.", OldTaskno."No. Series", "No. Series") THEN BEGIN
            //EducationSetupCS.GET();
            EducationSetupCS.TESTFIELD(EducationSetupCS."Task No.");
            //NoSeriesManagement.SetSeries("Task No.");
            //Rec := StudentTaskCS;
            //EXIT(TRUE);
            //END;
        END;
    end;
}

