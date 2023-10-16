table 50048 "Calendar Holiday-CS"
{
    // version V.001-CS

    // Sr.No.    Emp. ID       Date          Trigger                     Remarks
    // 1         CSPL-00092    03-05-2019    OnInsert                    Assign Value in Academic Year Field.
    // 2         CSPL-00092    03-05-2019    Holiday Date - OnValidate   find holiday Day

    Caption = 'Calendar Holiday-CS';
    DrillDownPageID = "Holiday Edu Calendar Setup-CS";
    LookupPageID = "Holiday Edu Calendar Setup-CS";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
        }
        field(2; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS";
        }
        field(3; "Holiday Date"; Date)
        {
            Caption = 'Holiday Date';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code added for find holiday Day::CSPL-00092::03-05-2019: Start
                IF "Holiday Date" <> 0D THEN BEGIN
                    DateRec.RESET();
                    DateRec.SETRANGE(DateRec."Period Type", DateRec."Period Type"::Date);
                    DateRec.SETRANGE(DateRec."Period Start", "Holiday Date");
                    IF DateRec.FINDFIRST() THEN
                        Day := DateRec."Period No."
                    ELSE
                        Day := 0;
                END ELSE
                    Day := 0;

                //Code added for find holiday Day::CSPL-00092::03-05-2019: End
            end;
        }
        field(4; Day; Option)
        {
            Caption = 'Day';
            DataClassification = CustomerContent;
            OptionCaption = ' ,Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday';
            OptionMembers = " ",Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday;
        }
        field(5; Description; Text[30])
        {
            Caption = 'Description';
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
    }

    keys
    {
        key(Key1; "Code", "Academic Year", "Holiday Date")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //Code added for Assign Value in Academic Year Field::CSPL-00092::03-05-2019: Start
        "Academic Year" := VerticalEducationCS.CreateSessionYear();
        //Code added for Assign Value in Academic Year Field::CSPL-00092::03-05-2019:End
    end;

    var
        DateRec: Record "Date";
        VerticalEducationCS: Codeunit "CSLMVerticalEducation-CS";

}

