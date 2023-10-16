table 50286 "Confrance Hall-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                     Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00114   09/03/2019       OnInsert()                                 Get"Academic Year",Date & "User Id" Values

    Caption = 'Confrance Hall-CS';
    // DrillDownPageID = "Hall Masterly List-CS";
    // LookupPageID = "Hall Masterly List-CS";

    fields
    {
        field(1; "Hall Code"; Code[20])
        {
            Caption = 'Hall Code';
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[30])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(3; Floor; Integer)
        {
            Caption = 'Floor';
            DataClassification = CustomerContent;
        }
        field(4; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS";
        }
        field(5; Capacity; Integer)
        {
            Caption = 'Capacity';
            DataClassification = CustomerContent;
        }
        field(6; Filled; Boolean)
        {
            Caption = 'Filled';
            DataClassification = CustomerContent;
        }
        field(7; "Seat Allotment"; Option)
        {
            Caption = 'Seat Allotment';
            DataClassification = CustomerContent;
            OptionCaption = ' ,One,Two,Three';
            OptionMembers = " ",One,Two,Three;
        }
        field(33048920; "User ID"; Code[20])
        {
            Caption = 'User ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 09042019';
        }
        field(33048921; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 09042019';
        }
    }

    keys
    {
        key(Key1; "Hall Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //Code added for Get"Academic Year",Date & "User Id" Values::CSPL-00114::09032019: Start
        "Academic Year" := VerticalEducationCS.CreateSessionYear();
        "User ID" := FORMAT(UserId());
        //Code added for Get"Academic Year",Date & "User Id" Values::CSPL-00114::09032019: End
    end;

    var
        VerticalEducationCS: Codeunit "CSLMVerticalEducation-CS";
}

