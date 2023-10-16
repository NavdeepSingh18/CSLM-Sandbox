table 50391 "Student Status"
{
    Caption = 'Status';
    DataClassification = ToBeClassified;
    LookupPageId = "Student Status List";
    DrillDownPageId = "Student Status List";
    DataCaptionFields = Code, Description;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
        }
        field(2; "Description"; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(3; "Status"; Option)
        {
            Caption = 'Status';
            OptionCaption = ' ,ROL,Active,Probation,Declined,Deferred,Deposited,Dismissed,Enrolled,Promoted,Compeleted,Graduated,Re-Admitted,Re-Entry,SLOA,ELOA,CLOA,Suspension,Withdrawn,Deceased,ADWD,TWD,Pending Graduation,TOPROG';
            OptionMembers = " ",ROL,Active,Probation,Declined,Deferred,Deposited,Dismissed,Enrolled,Promoted,Compeleted,Graduated,"Re-Admitted","Re-Entry",SLOA,ELOA,CLOA,Suspension,Withdrawn,Deceased,ADWD,TWD,"Pending Graduation",TOPROG;
            DataClassification = CustomerContent;
        }
        field(4; "Global Dimension 1 Code"; Code[20])
        {
            Caption = 'Global Dimension 1 Code';
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            DataClassification = CustomerContent;
        }
        field(5; "Global Dimension 2 Code"; Code[20])
        {
            Caption = 'Global Dimension 2 Code';
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            DataClassification = CustomerContent;
        }
        field(6; Blocked; Boolean)
        {
            Caption = 'Blocked';
            DataClassification = CustomerContent;
        }

        field(7; Inserted; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Inserted';
        }
        field(8; Updated; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Updated';
        }

    }
    keys
    {
        key(PK; "Code", "Global Dimension 1 Code")
        {
            Clustered = true;
        }
        key(Key2; "Global Dimension 1 Code", Status)
        {

        }
    }

    trigger OnInsert()
    begin
        Inserted := True;
    end;

    Trigger OnModify()
    begin
        If xRec.Updated = Updated then
            Updated := true;
    end;
}
