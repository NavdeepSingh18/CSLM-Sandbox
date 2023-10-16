tableextension 50546 "tableextensionPostCode" extends "Post Code"
{
    // Sr.No.    Emp. ID       Date          Trigger                       Remarks
    // 1         CSPL-00136    03-05-2019    IState - OnValidate               Code added for Assign Value in State Description Field.
    fields
    {
        field(50000; "State Code"; Code[20])
        {
            Description = 'CS Field Added 03-05-2019';
            //CS-BLOCKEDTableRelation = State;
            Caption = 'State Code';
            DataClassification = CustomerContent;
            TableRelation = "State SLcM CS";

            trigger OnValidate()
            var
                State2: Record "State SLcM CS";
            begin
                //Code added for Assign Value in State Description Field::CSPL-00136::03-05-2019: Start
                State2.GET("State Code", "Country/Region Code");
                County := "State Code";
                "State Description 3" := State2.Description;

                //Code added for Assign Value in State Description Field::CSPL-00136::03-05-2019: End
            end;
        }
        field(50001; Inserted; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Inserted';
        }
        field(50002; Updated; Boolean)
        {
            DataClassification = Customercontent;
            Caption = 'Updated';
        }

        field(50007; "District 3"; Text[30])
        {
            Description = 'CS Field Added 03-05-2019';
            Caption = 'District';
            DataClassification = CustomerContent;

        }
        field(50008; "State Description 3"; Text[30])
        {
            Description = 'CS Field Added 03-05-2019';
            Caption = 'State Description';
            DataClassification = CustomerContent;

        }
    }

    trigger OnInsert()
    begin
        Inserted := true;
    end;

    trigger OnModify()
    begin
        If xRec.Updated = Updated then
            Updated := true;
    end;
}