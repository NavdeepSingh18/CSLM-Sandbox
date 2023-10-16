table 50159 "Fee Component Master-CS"
{
    // version V.001-CS

    // Sr.No.    Emp. ID     Date          Trigger                             Remarks
    // 1         CSPL-00092    09-05-2019    OnInsert                            Assign Value in User ID Field.
    // 2         CSPL-00092    09-05-2019    OnModify                            Assign Value in Updated Field

    Caption = 'Fee Components';
    DrillDownPageID = "Fee Components Detail-CS";
    LookupPageID = "Fee Components Detail-CS";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
            NotBlank = true;
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(3; "G/L Account"; Code[20])
        {
            Caption = 'G/L Account';
            DataClassification = CustomerContent;
            TableRelation = "G/L Account";
        }
        field(4; "Fee Group Type"; Option)
        {
            Caption = 'Fee Group Type';
            DataClassification = CustomerContent;
            OptionCaption = ' ,Admission,Exam ';
            OptionMembers = " ",Admission,"Exam ";
        }
        field(5; "Check Duplication"; Boolean)
        {
            Caption = 'Check Duplication';
            DataClassification = CustomerContent;
        }
        field(6; "No Of Months"; Integer)
        {
            Caption = 'No Of Months';
            DataClassification = CustomerContent;
        }
        field(50001; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';

            DataClassification = CustomerContent;
            Description = 'CS Field Added 11-05-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(50002; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';

            DataClassification = CustomerContent;
            Description = 'CS Field Added 11-05-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(50003; Updated; Boolean)
        {
            Caption = 'Updated';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 11-05-2019';
        }
        field(50020; "Fee Generation Amount Based"; Boolean)
        {
            Caption = 'Fee Generation Amount Based';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 11-05-2019';
        }
        field(50024; "SAP Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'SAP Code';
            TableRelation = "SAP Fee Code";
            trigger OnValidate()
            begin
                if SapFeeCodeRec.get("SAP Code") then
                    "Fee Group" := SapFeeCodeRec."Fee Group"
                else
                    "Fee Group" := "Fee Group"::" ";
            end;
        }
        field(50025; "Source Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Source Code';
        }
        field(50026; "Fee Category"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Fee Category';
            OptionCaption = 'Regular,Optional';
            OptionMembers = "Regular",Optional;
        }
        field(50027; "Type Of Fee"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Type Of Fee';
            OptionCaption = ' ,HEALTHINS,REPATINS,RENT,BUS-SEMESTER,TUITION,DAMAGEDEP,INSTALMENT FEE,PARKING FEE,RE-REGISTRATION FEE,DUPLICATE ID CARD FEE,OFFICIAL TRANSCRIPT FEE,NON-OFFICIAL TRANSCRIPT FEE,BHHS DEGREE FEE,COURSE COMPLETION CERTIFICATE FEE,NO-OBJECTION CERTIFICATE FEE,SPOUSE ID CARD FEE,GHTSURCHRG,FIU SURCHARGE';
            OptionMembers = " ",HEALTHINS,REPATINS,RENT,"BUS-SEMESTER",TUITION,DAMAGEDEP,"INSTALMENT FEE","PARKING FEE","RE-REGISTRATION FEE","DUPLICATE ID CARD FEE","OFFICIAL TRANSCRIPT FEE","NON-OFFICIAL TRANSCRIPT FEE","BHHS DEGREE FEE","COURSE COMPLETION CERTIFICATE FEE","NO-OBJECTION CERTIFICATE FEE","SPOUSE ID CARD FEE",GHTSURCHRG,"FIU SURCHARGE";
        }
        field(50028; "Fee Group"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Fee Group';
            OptionCaption = ' ,Non-Institutional,Institutional';
            OptionMembers = " ","Non-Institutional",Institutional;
            Editable = false;
        }

        field(50029; Inserted; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Inserted';
        }
        field(50030; "1098-T From"; Boolean)
        {
            DataClassification = CustomerContent;
        }


        field(33048920; "User ID"; Code[50])
        {
            Caption = 'User ID';

            DataClassification = CustomerContent;
            Description = 'CS Field Added 11-05-2019';
        }
        field(33048921; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';

            DataClassification = CustomerContent;
            Description = 'CS Field Added 11-05-2019';
        }
        field(33048922; Block; Boolean)
        {
            Caption = 'Block';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 13-01-2021';
        }

    }

    keys
    {
        key(Key1; "Code")
        {
        }
    }

    var

        SapFeeCodeRec: Record "SAP Fee Code";
        GLEntry: Record "G/L Entry";

    trigger OnInsert()
    begin
        //Code added for Assign Value in User ID Field::CSPL-00092::09-05-2019: Start
        "User ID" := FORMAT(UserId());

        Inserted := True;
        //Code added for Assign Value in User ID Field::CSPL-00092::09-05-2019: End
    end;

    trigger OnModify()
    begin
        //Code added for Assign Value in Updated Field::CSPL-00092::09-05-2019: Start
        IF xRec.Updated = Updated THEN
            Updated := TRUE;
        //Code added for Assign Value in Updated Field::CSPL-00092::09-05-2019: End
    end;

    trigger OnDelete()
    begin
        GLEntry.Reset();
        GLEntry.SetRange(GLEntry."Fee Code", "Code");
        IF GLEntry.FindFirst() then
            Error('You can not delete the record, Ledger Entry already exist');
    end;
}

