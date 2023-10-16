tableextension 50549 "tableextension50549" extends Relative
{
    // version NAVW17.00-CS

    // Sr.No.    Emp. ID       Date          Trigger                Remarks
    // 1         CSPL-00136    02-05-2019    OnModify               Code added for Assign Value in Field.
    fields
    {
        field(3; Updated; Boolean)
        {
            Description = 'CS Field Added 02-05-2019';
        }
        field(50000; Inserted; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Inserted';
        }
    }

    trigger OnModify()
    begin
        //Code added for Assign Value in Field::CSPL-00136::02-05-2019: Start
        IF xRec.Updated = Updated THEN
            Updated := TRUE;
        //Code added for Assign Value in Field::CSPL-00136::02-05-2019: Start

    end;

    trigger OnInsert()
    begin
        Inserted := true;
    end;
}

