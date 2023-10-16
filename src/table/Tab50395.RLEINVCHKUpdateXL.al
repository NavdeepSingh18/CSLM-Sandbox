table 50395 "RLE INV CHK Update XL"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(5; "Rotation ID"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(6; "Student ID"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Student Master-CS";
            trigger OnValidate()
            Var
                StudentMaster: Record "Student Master-CS";
                RLE: Record "Roster Ledger Entry";
            begin
                "Student Name" := '';
                StudentMaster.Reset();
                if StudentMaster.Get("Student ID") then
                    "Student Name" := StudentMaster."Student Name";

                RLE.Reset();
                RLE.SetRange("Rotation ID", "Rotation ID");
                RLE.SetRange("Student ID", "Student ID");
                RLE.SetFilter("Rotation Grade", '<>%1&<>%2&<>%3', 'X', 'SC', 'UC');
                if RLE.FindFirst() then begin
                    "Rotation Entry No." := RLE."Entry No.";
                    "Course Code" := RLE."Course Code";
                    "Course Description" := RLE."Course Description";
                    "Elective Course Code" := RLE."Elective Course Code";
                    "Rotation Description" := RLE."Rotation Description";
                    "No. of Weeks" := RLE."Total No. of Weeks";
                    "Hospital ID" := RLE."Hospital ID";
                    "Hospital Name" := RLE."Hospital Name";
                    if "Weeks to Invoice" = 0 then
                        "Weeks to Invoice" := RLE."Total No. of Weeks" - RLE."Weeks Invoiced";
                    if ("Weeks to Pay" = 0) and ("Check No." <> '') then
                        "Weeks to Pay" := RLE."Total No. of Weeks" - RLE."Weeks Paid";
                end;
            end;
        }
        field(7; "Student Name"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(10; "Invoice No."; Code[100])
        {
            DataClassification = CustomerContent;
        }
        field(11; "Invoice Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(12; "Cost per Week Override"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(14; "Check No."; Code[100])
        {
            DataClassification = CustomerContent;
        }
        field(15; "Check Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(20; "Rotation Entry No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(22; "Course Code"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(23; "Course Description"; Text[200])
        {
            DataClassification = CustomerContent;
        }
        field(25; "Elective Course Code"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(26; "Rotation Description"; Text[200])
        {
            DataClassification = CustomerContent;
        }
        field(27; "No. of Weeks"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(28; "Hospital ID"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(29; "Hospital Name"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(32; "Weeks to Invoice"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(33; "Weeks to Pay"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(40; "Uploaded By"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(41; "Uploaded On"; Date)
        {
            DataClassification = CustomerContent;
        }

        field(45; "Updated By"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(46; "Updated On"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(47; "Updated"; Boolean)
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        "Uploaded By" := UserId;
        "Uploaded On" := Today;
    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}