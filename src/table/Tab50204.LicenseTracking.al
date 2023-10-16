table 50204 "License Tracking"
{
    DataClassification = CustomerContent;
    Caption = 'License Tracking';


    fields
    {
        field(1; "Student No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Document No.';
            //Editable = false;
            //TableRelation = "Student Master-CS"."No.";
        }
        field(2; "License ID"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'License ID';
        }
        field(3; "License Type"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'License Type';

        }
        field(4; "State"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'State';

        }
        field(5; "Expiration"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Expiration';

        }
        field(6; "Created On"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Created On';

        }
        field(7; "Created By"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Created by';

        }
        field(8; "SLcM No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Student No.';
            //Editable = false;
            TableRelation = "Student Master-CS"."No.";
        }
    }
    keys
    {
        key(PK; "Student No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        NoSeriesMgmt: Codeunit NoSeriesManagement;
    begin
        "Created By" := UserId();
        "Created On" := Today();

        IF "Student No." = '' then begin
            "Student No." := NoSeriesMgmt.GetNextNo('LT', Today(), true);
        end;
    end;
}
