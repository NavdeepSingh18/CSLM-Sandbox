table 50495 "Documentation Request"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Application No"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(2; "Application Date"; Date)
        {
            DataClassification = CustomerContent;
        }

        field(3; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            DataClassification = CustomerContent;
            TableRelation = "Student Master-CS";

            trigger OnValidate()
            Var
                StudentMasterCS: Record "Student Master-CS";
            begin
                IF StudentMasterCS.GET("Student No.") THEN
                    "Student Name" := StudentMasterCS."Student Name";
            end;
        }
        field(4; "Student Name"; Text[100])
        {
            Caption = 'Student Name';
            DataClassification = CustomerContent;
            Editable = False;
        }
        field(5; "States for  licensure"; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(6; "Type of licensure permit"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(7; "Hospital name"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(8; "Specialty"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(9; "Documents Needed"; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(10; "Other information needed"; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(11; "Recipient Name"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(12; "Recipient Email"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(13; "Recipient Address"; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(14; "Processing Status"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = " ",Pending,Completed,Rejected;
        }
        field(15; "Processed By"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Employee;
        }
        field(16; "Processing Date"; Date)
        {
            DataClassification = CustomerContent;
        }

        field(17; "Created By"; Code[50])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(18; "Created On"; Date)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(19; "Modified By"; Code[50])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(20; "Modified On"; Date)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }

        field(21; Inserted; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Inserted';
        }

        field(22; Updated; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Updated';
        }

    }

    keys
    {
        key(PK; "Application No")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        "Created By" := Format(UserId());
        "Created On" := WorkDate();

        Inserted := true;
    end;

    trigger OnModify()
    begin
        "Modified By" := Format(UserId());
        "Modified On" := WorkDate();
        If xRec.Updated = Updated then
            Updated := true;
    end;



}