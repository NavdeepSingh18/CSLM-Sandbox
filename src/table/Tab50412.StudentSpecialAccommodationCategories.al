table 50412 "Std Spl Accommodation Category"
{
    DataClassification = CustomerContent;
    Caption = 'Student Special Accommodation Category';
    fields
    {
        field(1; "Student ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Student ID';
        }
        field(2; "Application No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Application No.';
        }
        field(3; "Accommodation Category Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Accommodation Category Code';
            TableRelation = "Special Accommodation Category".Code where(Status = filter(Allowed));
            trigger OnValidate()
            var
                SpecialAccommodationCategory: Record "Special Accommodation Category";
                StudentMaster: Record "Student Master-CS";
            begin
                "Category Description" := '';
                Category := Category::" ";
                SpecialAccommodationCategory.Reset();
                if SpecialAccommodationCategory.Get("Accommodation Category Code") then begin
                    "Category Description" := SpecialAccommodationCategory."Reason Description";
                    Category := SpecialAccommodationCategory.Category;
                end;

                "Student Name" := '';
                StudentMaster.Reset();
                if StudentMaster.Get("Student ID") then
                    "Student Name" := StudentMaster."Student Name";
            end;
        }
        field(4; "Category Description"; Text[150])
        {
            DataClassification = CustomerContent;
            Caption = 'Accommodation Category Description';
            Editable = false;
        }
        field(5; Category; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Category';
            OptionMembers = " ","Non-Health","Health";
            Editable = false;
        }
        field(6; "Student Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Student Name';
            Editable = false;
        }
        field(7; "Reason"; Text[2048])
        {
            DataClassification = CustomerContent;
            Caption = 'Reason';
        }
        field(8; "Attachment Description"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Attachment Description';
        }
        field(9; "File Path"; Text[2048])
        {
            DataClassification = CustomerContent;
            Caption = 'File Path';
            trigger OnValidate()
            var
                FileExtension: Text;
                I: Integer;
                Alfa: Text;
            begin
                FileExtension := '';

                for I := 1 to StrLen("File Path") do begin
                    Alfa := CopyStr("File Path", I, 1);
                    if Alfa = '.' then
                        FileExtension := ''
                    else
                        FileExtension := FileExtension + Alfa;
                end;
                "File Extension" := FileExtension;
            end;
        }
        field(10; "File Extension"; Text[20])
        {
            DataClassification = CustomerContent;
            Caption = 'File Extension';
        }
        field(11; "Attachment ID"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Attachment ID';
        }
        field(12; "Attachment Category"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Attachment Category';
        }
        field(13; "Clinical Reference No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Clinical Reference No.';
        }

        field(20; "Created By"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Created By';
            Editable = false;
        }
        field(21; "Created On"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Created On';
            Editable = false;
        }
        field(35; "Approval Status"; Option)
        {
            DataClassification = CustomerContent;
            Editable = false;
            OptionMembers = " ","Pending for Approval","Approved","Rejected";
            Caption = 'Approval Status';
        }

        field(36; Inserted; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Inserted';
        }

        field(37; Updated; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Updated';
        }
    }
    keys
    {
        key(PK; "Student ID", "Application No.", "Accommodation Category Code")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        "Created By" := UserId;
        "Created On" := Today;

        Inserted := true;
    end;

    trigger OnModify()
    begin
        If xRec.Updated = Updated then
            Updated := true;
    end;
}