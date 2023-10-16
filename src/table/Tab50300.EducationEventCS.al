table 50300 "Education Event-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                    Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00114   27/06/2019       OnInsert()                                 Any Record change then Updated field update

    DrillDownPageID = "Event Detail-CS";
    LookupPageID = "Event Detail-CS";

    fields
    {
        field(1; "Event Code"; Code[20])
        {
            Caption = 'Event Code';
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[80])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(3; "Event Day Calculation"; Code[10])
        {
            Caption = 'Event Day Calculation';
            DataClassification = CustomerContent;
        }
        field(4; "Reminder Days"; Code[10])
        {
            Caption = 'Reminder Days';
            DataClassification = CustomerContent;
        }
        field(5; "Portal Menu Name"; Text[50])
        {
            Caption = 'Portal Menu Name';
            DataClassification = CustomerContent;
        }
        field(6; Updated; Boolean)
        {
            Caption = 'Updated';
            DataClassification = CustomerContent;
        }
        field(7; Inserted; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Inserted';
        }
    }

    keys
    {
        key(Key1; "Event Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnModify()
    begin
        //Any Record change then Updated field update::CSPL-00114::27062019: Start
        IF xRec.Updated = Updated THEN
            Updated := TRUE;
        //Any Record change then Updated field update::CSPL-00114::27062019: End
    end;

    trigger OnInsert()
    begin
        Inserted := true;
    end;
}

