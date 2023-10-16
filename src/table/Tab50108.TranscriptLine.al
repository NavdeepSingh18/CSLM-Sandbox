table 50108 "Competition L-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                    Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00114   20/06/2019       OnInsert()                                 Auto Assign "User Id" Values
    // 02    CSPL-00114   20/06/2019       Team Size - OnValidate()                   Code Added for validation
    // 03    CSPL-00114   20/06/2019       Substitute - OnValidate()                  Code Added for validation

    Caption = 'Transcript Line';
    // DrillDownPageID = 33049331;
    // LookupPageID = 33049331;
    //CSPL-00307-Transcript
    fields
    {
        field(1; "Document No."; Code[20])
        {   //In-Use
            Caption = 'Document No.';
            DataClassification = CustomerContent;
        }
        field(3; "Student Division"; Code[20])
        {
            //In-Use
            Caption = 'Student Division';
            DataClassification = CustomerContent;
        }
        field(4; "Min Age"; Integer)
        { //In-Use
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(5; "Cut Off Date"; Date)
        {
            Caption = 'Cut Off Date';
            DataClassification = CustomerContent;
        }
        field(6; "Max Age"; Integer)
        {
            Caption = 'Max Age';
            DataClassification = CustomerContent;
        }
        field(7; "Team Size"; Integer)
        {
            Caption = 'Team Size';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code Added for validation::CSPL-00114::20062019: Start
                // CompetitionHCS.GET("Document No.");
                // IF (CompetitionHCS."Event Type" <> CompetitionHCS."Event Type"::Team) AND ("Team Size" <> 0) THEN BEGIN
                //     "Team Size" := 0;
                //     Substitute := 0;
                //     ERROR(Text000Lbl);
                // END;
                //Code Added for validation::CSPL-00114::20062019: End
            end;
        }
        field(8; Substitute; Integer)
        {
            Caption = 'Substitute';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code Added for validation::CSPL-00114::20062019: Start
                CompetitionHCS.GET("Document No.");
                IF (CompetitionHCS."Event Type" <> CompetitionHCS."Event Type"::Team) AND (Substitute <> 0) THEN BEGIN
                    "Team Size" := 0;
                    Substitute := 0;
                    ERROR(Text000Lbl);
                END;
                //Code Added for validation::CSPL-00114::20062019: End
            end;
        }
        field(9; "Student ID"; Code[20])
        {//In-Use
            DataClassification = ToBeClassified;
        }
        field(10; "Student Name"; Text[100])
        {
            //In-Use
            DataClassification = ToBeClassified;
        }
        field(11; "Enrollment No"; Code[20])
        {
            //In-Use
            DataClassification = ToBeClassified;
        }
        field(12; "Print"; Boolean)
        {
            //In-Use
            DataClassification = ToBeClassified;
        }
        field(13; Reprint; boolean)
        {
            //In-Use
            DataClassification = ToBeClassified;
        }
        field(14; "SLcM No"; Code[20])
        {   //In-Use
            DataClassification = ToBeClassified;
        }
        field(15; "File created"; Boolean) //In-Use
        {
            DataClassification = ToBeClassified;
        }

        field(33048920; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 20062019';
        }
        field(33048921; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 20062019';
        }
    }

    keys
    {
        key(Key1; "Document No.", "Student Division")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //Auto Assign "User Id" Values ::CSPL-00114::20062019: Start
        "User ID" := FORMAT(UserId());
        //Auto Assign "User Id" Values ::CSPL-00114::20062019: End

        "Student Division" := Format("Min Age");//Line No
    end;

    var
        CompetitionHCS: Record "Competition H-CS";
        Text000Lbl: Label 'You cannot enter the substitute if event type is not Team.';
}

