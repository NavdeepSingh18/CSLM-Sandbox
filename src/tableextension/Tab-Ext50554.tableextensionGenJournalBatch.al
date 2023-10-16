tableextension 50554 "tableextensionGenJournalBatch" extends "Gen. Journal Batch"
{
    // version NAVW19.00.00.45778,NAVIN9.00.00.45778-CS

    fields
    {
        field(50001; "Pay No.Series"; Code[20])
        {
            Description = 'CS Field Added 02-05-2019';
            TableRelation = "No. Series";
            Caption = 'Pay No.Series';
            DataClassification = CustomerContent;
        }
        field(50002; "User ID 1"; Code[50])
        {
            Description = 'CS Field Added 02-05-2019';
            TableRelation = "User Setup"."User ID";
            Caption = 'User ID 1';
            DataClassification = CustomerContent;
        }
        field(50003; "User ID 2"; Code[50])
        {
            Description = 'CS Field Added 02-05-2019';
            TableRelation = "User Setup"."User ID";
            Caption = 'User ID 2';
            DataClassification = CustomerContent;
        }
        field(50004; "User ID 3"; Code[50])
        {
            Description = 'CS Field Added 02-05-2019';
            TableRelation = "User Setup"."User ID";
            Caption = 'User ID 3';
            DataClassification = CustomerContent;
        }
        field(50005; "User ID 4"; Code[50])
        {
            Description = 'CS Field Added 02-05-2019';
            TableRelation = "User Setup"."User ID";
            Caption = 'User ID 4';
            DataClassification = CustomerContent;
        }
        field(50006; "User ID 5"; Code[50])
        {
            Description = 'CS Field Added 02-05-2019';
            TableRelation = "User Setup"."User ID";
            Caption = 'User ID 5';
            DataClassification = CustomerContent;
        }
        field(50007; "Selected User ID"; Code[50])
        {
            Description = 'CS Field Added 02-05-2019';
            Caption = 'Selected User ID';
            DataClassification = CustomerContent;
        }
    }
}