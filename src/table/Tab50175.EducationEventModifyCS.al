table 50175 "Education Event Modify-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                    Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00114   10/05/2019       Student No. - OnValidate()                 Code added for Student Name & Enroll No
    // 01    CSPL-00114   10/05/2019       Event Code - OnValidate()                  Code added for Event Description Value

    Caption = 'Education Event Modify-CS';
    LookupPageID = 50172;

    fields
    {
        field(1; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            DataClassification = CustomerContent;
            TableRelation = "Student Master-CS";

            trigger OnValidate()
            begin
                //Code added for Student Name & Enroll No::CSPL-00114::10052019: Start
                IF StudentMasterCS.GET("Student No.") THEN BEGIN
                    "Enrollment No." := StudentMasterCS."Enrollment No.";
                    "Student Name" := StudentMasterCS."Student Name";
                END ELSE
                    "Enrollment No." := '';
                "Student Name" := '';
                //Code added for Student Name & Enroll No::CSPL-00114::10052019: End
            end;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(3; "Enrollment No."; Code[20])
        {
            Caption = 'Enrollment No.';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(4; "Student Name"; Text[100])
        {
            Caption = 'Student Name';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(5; "Event Code"; Code[20])
        {
            Caption = 'Event Code';
            DataClassification = CustomerContent;
            TableRelation = "Education Event-CS";

            trigger OnValidate()
            begin
                //Code added for Event Description Value::CSPL-00114::10052019: Start
                IF EducationEventCS.GET() THEN
                    "Event Description" := EducationEventCS.Description
                ELSE
                    "Event Description" := '';
                //Code added for Event Description Value::CSPL-00114::10052019: End
            end;
        }
        field(6; "Event Description"; Text[80])
        {
            Caption = 'Event Description';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(7; Date; Date)
        {
            Caption = 'Date';
            DataClassification = CustomerContent;
        }
        field(8; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(9; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(10; "Created By"; Text[50])
        {
            Caption = 'Created By';
            DataClassification = CustomerContent;
        }
        field(11; "Created On"; Date)
        {
            Caption = 'Created On';
            DataClassification = CustomerContent;
        }
        field(12; "Updated By"; Text[50])
        {
            Caption = 'Updated By';
            DataClassification = CustomerContent;
        }
        field(13; "Updated On"; Date)
        {
            Caption = 'Updated On';
            DataClassification = CustomerContent;
        }
        field(14; "Updated By Name"; Text[50])
        {
            Caption = 'Updated By Name';
            DataClassification = CustomerContent;
        }
        field(15; "Created By Name"; Text[50])
        {
            Caption = 'Created By Name';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Student No.", "Line No.")
        {
        }
    }

    fieldgroups
    {
    }

    var
        StudentMasterCS: Record "Student Master-CS";
        EducationEventCS: Record "Education Event-CS";
}

