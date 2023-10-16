table 50488 "Advising Topics"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Code"; code[20])
        {
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[100])
        {
            DataClassification = CustomerContent;

        }
        field(3; "Global Dimension 1 Code"; code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            DataClassification = CustomerContent;

        }
        field(4; Blocked; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(5; "Created By"; Code[50])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(6; "Created On"; Date)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(7; "Modified By"; Code[50])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(8; "Modified On"; Date)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }

        field(9; Inserted; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Inserted';
        }

        field(10; Updated; Boolean)
        {
            DataClassification = Customercontent;
            Caption = 'Updated';
        }
        field(11; "Department Type"; Option)
        {
            DataClassification = Customercontent;
            Caption = 'Department Type';
            OptionCaption = ' ,Bursar,Financial Aid,Residential Services,Student Services,Registrar,Admissions,Clinicals,EED Pre-Clinical,EED Clinical,Graduate Affairs,Examination,Graduation,BackOffice,Store';
            OptionMembers = " ","Bursar Department","Financial Aid Department","Residential Services","Student Services","Registrar Department","Admissions","Clinical Details","EED Pre-Clinical","EED Clinical","Graduate Affairs","Examination","Graduation",BackOffice,Store;

        }


    }

    keys
    {
        key(PK; Code)
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