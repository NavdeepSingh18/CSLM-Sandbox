table 50489 "Problem Solution"
{
    DataClassification = CustomerContent;
    // LookupPageid = "Problem Solution List";
    // DrillDownPageId = "Problem Solution List";

    fields
    {
        field(1; "Entry No"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(2; Problem; Text[100])
        {
            DataClassification = CustomerContent;

        }
        field(3; Solution; Text[2048])
        {
            DataClassification = CustomerContent;

        }
        field(4; "Global Dimension 1 Code"; code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            DataClassification = CustomerContent;

        }
        field(5; Blocked; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(6; "Created By"; Code[50])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(7; "Created On"; Date)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(8; "Modified By"; Code[50])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(9; "Modified On"; Date)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }

        field(10; Inserted; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Inserted';
        }
        field(11; Updated; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Updated';

        }
        field(12; "Department Type"; Option)
        {
            caption = 'Department Type';
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Bursar,Financial Aid,Residential Services,Student Services,Registrar,Admissions,Clinicals,EED Pre-Clinical,EED Clinical,Graduate Affairs,Examination,Graduation,BackOffice,Store';
            OptionMembers = " ","Bursar Department","Financial Aid Department","Residential Services","Student Services","Registrar Department","Admissions","Clinical Details","EED Pre-Clinical","EED Clinical","Graduate Affairs","Examination","Graduation",BackOffice,Store;
        }

    }

    keys
    {
        key(PK; "Entry No")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        ProblemSolution: Record "Problem Solution";
    begin
        "Created By" := Format(UserId());
        "Created On" := WorkDate();

        Inserted := True;

        IF "Entry No" = 0 then begin
            ProblemSolution.Reset();
            ProblemSolution.SetCurrentKey("Entry No");
            IF ProblemSolution.FindLast() then
                "Entry No" := ProblemSolution."Entry No" + 1
            else
                "Entry No" := 1;
        end;
    end;

    trigger OnModify()
    begin
        "Modified By" := Format(UserId());
        "Modified On" := WorkDate();

        If xRec.Updated = Updated then
            Updated := true;
    end;



}