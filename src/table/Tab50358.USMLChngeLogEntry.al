table 50358 "USMLE Log Entry"
{
    DataClassification = CustomerContent;

    fields
    {

        field(1; "Entry No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(2; USMLEStepNumber; Code[20])
        {
            // OptionMembers = " ","1",CK,CS;
            DataClassification = CustomerContent;

        }
        field(3; USMLEAttempt; Code[20])
        {
            // OptionMembers = " ","1","2","3","4","5","6";
            DataClassification = CustomerContent;
        }
        field(4; USMLEExtention; Code[20])
        {
            // OptionMembers = " ","1","2","3","4","5";
            DataClassification = CustomerContent;
        }
        field(5; USMLECancle; Code[20])
        {
            DataClassification = CustomerContent;
        }

        field(6; USMLEOrigin; Code[20])
        {
            DataClassification = CustomerContent;
        }

        field(7; USMLEExtended; Integer)
        {
            DataClassification = CustomerContent;
        }

        field(8; USMLESentDate; Date)
        {
            DataClassification = CustomerContent;
        }
        field(9; "USMLETestWindow"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(10; USMLEWindowStartDate; Date)
        {
            DataClassification = CustomerContent;
        }
        field(11; USMLEWindowEndDate; Date)
        {
            DataClassification = CustomerContent;
        }

        field(12; USMLETestDate; Date)
        {
            DataClassification = CustomerContent;
        }
        field(13; "Status"; Option)
        {
            Caption = 'Status';
            OptionMembers = " ",Passed,Expired,"Can/Req",Extended,Wating,Failed;

        }
        field(14; Score; Code[20])
        {
            DataClassification = CustomerContent;
        }

        field(15; "Student ID"; code[20])
        {
            DataClassification = CustomerContent;
        }
        field(16; "Creation Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(17; Block; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(18; "Step Att. Ext."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(19; UsmleID; Text[8])
        {
            DataClassification = CustomerContent;
        }
        field(20; "Transcript Recrd"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(21; "USMLE Ref Code"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(22; "Certification Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(23; "USMLE Consent Release Date"; Date)
        {
            DataClassification = CustomerContent;
        }

        field(24; AAMICD; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(25; "Log Entry No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(26; "Delete Rec"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(27; "Modify Rec"; Boolean)
        {
            DataClassification = CustomerContent;
        }

        field(28; CreationDateTime; DateTime)
        {
            DataClassification = CustomerContent;
        }


    }

    keys
    {
        key(PK1; "Log Entry No.")
        {
        }
        key(Pk2; "Student ID")
        {
        }
    }

    var

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    var
    // StudentRec: Record "Student Master-CS";
    begin


    end;

    trigger OnRename()
    begin

    end;

}