table 50118 "Student Hostel-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                    Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00114   16/05/2019       OnModify()                                 Data Modification Flag


    fields
    {
        field(1; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            DataClassification = CustomerContent;
            TableRelation = "Student Master-CS";
        }
        field(2; "Hostel Block"; Text[30])
        {
            Caption = 'Hostel Block';
            DataClassification = CustomerContent;
        }
        field(3; "Hostel Room No."; Text[30])
        {
            Caption = 'Hostel Room No.';
            DataClassification = CustomerContent;
        }
        field(4; "Hostel Allotted On"; Date)
        {
            Caption = 'Hostel Alloted';
            DataClassification = CustomerContent;
        }
        field(5; "Hostel Vacated On"; Date)
        {
            Caption = 'Hostel Vacated';
            DataClassification = CustomerContent;
        }
        field(6; "Type of Room"; Text[40])
        {
            Caption = 'Type Of Room';
            DataClassification = CustomerContent;
        }
        field(7; "Hostel Contact Number"; Code[20])
        {
            Caption = 'Hostel Contact Number';
            DataClassification = CustomerContent;
        }
        field(50001; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 16052019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(50002; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 16052019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(50003; Updated; Boolean)
        {
            Caption = 'Updated';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 16052019';
        }
    }

    keys
    {
        key(Key1; "Student No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnModify()
    begin
        //Data Modification Flag::CSPL-00114::16052019: Start
        IF xRec.Updated = Updated THEN
            Updated := TRUE;
        //Data Modification Flag::CSPL-00114::16052019: End
    end;
}

