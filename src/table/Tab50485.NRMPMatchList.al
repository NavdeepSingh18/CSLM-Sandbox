table 50485 "NRMP Match List"
{
    DataClassification = CustomerContent;
    Caption = 'NRMP Match List';

    fields
    {
        field(1; "ECFMG_ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'USMLE ID';
        }
        field(2; "SCHOOL_NAME"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Institute Name';
            //Editable = false;
        }
        field(3; "FNAME"; Text[35])
        {
            DataClassification = CustomerContent;
            Caption = 'First Name';
            //Editable = false;
        }
        field(4; "MNAME"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Middle Name';
            //Editable = false;
        }
        field(5; "LNAME"; Text[35])
        {
            DataClassification = CustomerContent;
            Caption = 'Last Name';
            //Editable = false;
        }
        field(6; "MATCH_STATUS_CD"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Match Status';
            OptionCaption = ' ,REGISTERED,CERTIFIED,INITIAL,WITHDRAWN';
            OptionMembers = " ",REGISTERED,CERTIFIED,INITIAL,WITHDRAWN;
            //Editable = false;
        }
        field(7; "PGY1_INST_NAME"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Post-Graduate Year 1 Hospital Name';
        }
        field(8; "PGY1_PGM_NAME"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Post-Graduate Year 1 Speciality';
        }
        field(9; "PGY1_PGM_CD"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'PGY1-PGM-CD';
            //Editable = false;
        }
        field(10; "PGY2_INST_NAME"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Post-Graduate Year 2 Hospital Name';
        }
        field(11; "PGY2_PGM_NAME"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Post-Graduate Year 2 Speciality';
        }
        field(12; "PGY2_PGM_CD"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'PGY2-PGM-CD';
            //Editable = false;
        }
        field(13; "MATCH_YR"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Match Year';
        }
        field(14; "SCHOOL_CD"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Institute ID';
            //Editable = false;
        }
        field(15; "USER_TYPE_CD"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'User Type';
            //Editable = false;
        }
        field(17; "Creation On"; Date)
        {
            DataClassification = CustomerContent;
            //Editable = false;
        }
        field(18; "Created By"; Code[50])
        {
            DataClassification = CustomerContent;
            //Editable = false;
        }
        field(19; "Modified On"; Date)
        {
            DataClassification = CustomerContent;
            //Editable = false;
        }
        field(20; "Modified By"; Text[50])
        {
            DataClassification = CustomerContent;
            //Editable = false;
        }
        field(21; "Hospital State 1"; Text[30])
        {
            DataClassification = CustomerContent;
            //Editable = false;
        }
        field(22; "Hospital State 2"; Text[30])
        {
            DataClassification = CustomerContent;
            //Editable = false;
        }
        field(23; "Generated"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(24; Inserted; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Inserted';
        }
        field(25; Updated; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Updated';
        }
    }

    keys
    {
        key(PK; ECFMG_ID)
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin

        "Creation On" := Today();
        "Created By" := Userid();
        "Modified On" := TODAY();
        "Modified By" := FORMAT(UserId());

        Inserted := true;
        //InsertGraduateAffairs(Rec);
    end;

    trigger OnModify()
    begin
        "Modified On" := TODAY();
        "Modified By" := FORMAT(UserId());

        If xRec.Updated = Updated then
            Updated := true;
    end;

}
