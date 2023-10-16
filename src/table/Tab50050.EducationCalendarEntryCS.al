table 50050 "Education Calendar Entry-CS"
{
    // version V.001-CS

    // Sr.No.    Emp. ID       Date          Trigger                                 Remarks
    // 1         CSPL-00092    03-05-2019    OnInsert                                Assign Value in Academic Year and Mobile Insert Field.
    // 2         CSPL-00092    03-05-2019    Global Dimension 1 Code - OnValidate    Call function to Validate Dimension
    // 3         CSPL-00092    03-05-2019    Global Dimension 2 Code - OnValidate    Call function to Validate Dimension
    // 4         CSPL-00092    03-05-2019    ValidateShortcutDimCode                 Function For Validate Dimension

    Caption = 'Education Calendar Entry-CS';

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
            TableRelation = "Education Calendar-CS".Code;
        }
        field(2; Date; Date)
        {
            Caption = 'Date';
            DataClassification = CustomerContent;
        }
        field(3; Day; Option)
        {
            Caption = 'Day';
            DataClassification = CustomerContent;
            OptionCaption = ' ,Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday';
            OptionMembers = " ",Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday;
        }
        field(4; "Off Day"; Boolean)
        {
            Caption = 'Off Day';
            DataClassification = CustomerContent;
        }
        field(5; Holiday; Boolean)
        {
            Caption = 'Holiday';
            DataClassification = CustomerContent;
        }
        field(6; Description; Text[30])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;

        }
        field(7; "Day Order"; Integer)
        {
            Caption = 'Day Order';
            DataClassification = CustomerContent;
        }
        field(8; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS";
        }
        field(50001; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 07-05-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin
                //Code added for Call function to Validate Dimension::CSPL-00092::03-05-2019: Start
                ValidateShortcutDimCode(1, "Global Dimension 1 Code");
                //Code added for Call function to Validate Dimension::CSPL-00092::03-05-2019: End
            end;
        }
        field(50002; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 07-05-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                //Code added for Call function to Validate Dimension::CSPL-00092::03-05-2019: Start
                ValidateShortcutDimCode(2, "Global Dimension 2 Code");
                //Code added for Call function to Validate Dimension::CSPL-00092::03-05-2019: End
            end;
        }
        field(50003; "Multi Event Exist"; Boolean)
        {
            Caption = 'Multi Event Exist';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 07-05-2019';
            Editable = false;
        }
        field(50004; Updated; Boolean)
        {
            Caption = 'Updated';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 07-05-2019';
        }
        field(50005; "Mobile Insert"; Boolean)
        {
            Caption = 'Mobile Insert';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 07-05-2019';
        }
        field(50006; "Mobile Update"; Boolean)
        {
            Caption = 'Mobile Update';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 07-05-2019';
        }
        field(50007; Inserted; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Inserted';
        }
    }

    keys
    {
        key(Key1; "Code", Date)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //Code added for Assign Value in Academic Year and Mobile Insert Field::CSPL-00092::03-05-2019: Start
        "Academic Year" := VerticalEducationCS.CreateSessionYear();
        "Mobile Insert" := TRUE;
        Inserted := true;
        //Code added for Assign Value in Academic Year and Mobile Insert Field::CSPL-00092::03-05-2019: End
    end;

    trigger OnModify()
    begin
        //Code added for Stop Modification::CSPL-00092::03-05-2019: Start
        //ERROR('You Cannot modify The Calender Entrys');
        //Code added for Stop Modification::CSPL-00092::03-05-2019: End

        If xRec.Updated = Updated then
            Updated := true;
    end;

    var
        VerticalEducationCS: Codeunit "CSLMVerticalEducation-CS";
        DimensionManagement: Codeunit "DimensionManagement";

    local procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        //Code added for Validate Dimension::CSPL-00092::03-05-2019: Start
        DimensionManagement.ValidateDimValueCode(FieldNumber, ShortcutDimCode);
        DimensionManagement.SaveDefaultDim(DATABASE::"Education Calendar Entry-CS", Code, FieldNumber, ShortcutDimCode);
        Modify();
        //Code added for Validate Dimension::CSPL-00092::03-05-2019: End
    end;
}

