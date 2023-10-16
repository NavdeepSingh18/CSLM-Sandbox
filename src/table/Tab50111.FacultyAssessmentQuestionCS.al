table 50111 "Faculty Assessment Question-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                    Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00114   18/04/2019       OnModify()                                 Any record Update then updated Value Change

    Caption = 'Faculty Assessment Question-CS';

    fields
    {
        field(1; "Code"; Code[10])
        {
        }
        field(2; Question; Text[200])
        {
        }
        field(3; Updated; Boolean)
        {
            Description = 'CS Field Added 18042019';
        }
        field(4; "Type of Question"; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = ' ,Faculty,Course';
            OptionMembers = " ",Faculty,Course;
        }

        field(5; "Rating Type"; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Rating,Text';
            OptionMembers = Rating,Text;
            trigger OnValidate()
            begin
                if "Rating Type" = "Rating Type"::Text then
                    Error('You cannot select the rating type Text');
            end;
        }
        field(6; Inserted; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Inserted';
        }
    }

    keys
    {
        key(Key1; "Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnModify()
    begin
        //Any record Update then updated Value Change::CSPL-00114::18042019: Start
        IF xRec.Updated = Updated THEN
            Updated := TRUE;
        //Any record Update then updated Value Change::CSPL-00114::18042019: End
    end;

    trigger OnInsert()
    begin
        Inserted := true;
    end;
}

