table 50123 "Time Period-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                    Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00114   09/08/2019       OnModify()                                 Data modification flag.

    Caption = 'Time Period-CS';
    DrillDownPageID = "Time Slot L-CS";
    LookupPageID = "Time Slot L-CS";

    fields
    {
        field(1; "Slot No"; Code[20])
        {
            Caption = 'Slot No.';
            DataClassification = CustomerContent;
        }
        field(2; "Start Time"; Time)
        {
            Caption = 'Start Time';
            DataClassification = CustomerContent;
        }
        field(3; "End Time"; Time)
        {
            Caption = 'End Time';
            DataClassification = CustomerContent;
        }
        field(4; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(5; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(6; Updated; Boolean)
        {
            Caption = 'Updated';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Slot No")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Slot No", "Start Time", "End Time", "Global Dimension 1 Code", "Global Dimension 2 Code")
        {
        }
    }

    trigger OnModify()
    begin
        //Code added for Data modification flag::CSPL-00114::09082019: Start
        IF xRec.Updated = Updated THEN
            Updated := TRUE;
        //Code added for Data modification flag::CSPL-00114::09082019: End
    end;
}

