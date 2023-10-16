report 50060 "Update Section on Stu. SubjCS"
{
    // version V.001-CS

    ProcessingOnly = true;
    ApplicationArea = All;
    UsageCategory = Administration;
    dataset
    {
        dataitem("Main Student Subject-CS"; "Main Student Subject-CS")
        {
            DataItemTableView = WHERE(Year = FILTER('1ST|2ND'));

            trigger OnAfterGetRecord()
            begin
                Section := '';
                "Roll No." := '';
                StudentMasterCS.Reset();
                StudentMasterCS.SETRANGE(Year, Year);
                StudentMasterCS.SETRANGE("No.", "Student No.");
                IF StudentMasterCS.findfirst() THEN BEGIN
                    Section := StudentMasterCS.Section;
                    "Roll No." := StudentMasterCS."Roll No.";
                    Modify();
                END;
            end;
        }
        dataitem("Optional Student Subject-CS"; "Optional Student Subject-CS")
        {

            trigger OnAfterGetRecord()
            begin
                Section := '';
                "Roll No." := '';
                StudentMasterCS.Reset();
                StudentMasterCS.SETRANGE(Year, Year);
                StudentMasterCS.SETRANGE("No.", "Student No.");
                IF StudentMasterCS.findfirst() THEN BEGIN
                    Section := StudentMasterCS.Section;
                    Modify();
                END;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPostReport()
    begin
        MESSAGE('Done');
    end;

    var
        StudentMasterCS: Record "Student Master-CS";
}

