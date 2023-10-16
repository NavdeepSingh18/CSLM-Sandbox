report 50134 "Student name updateCS"
{
    // version V.001-CS

    DefaultLayout = RDLC;
    RDLCLayout = './src/reportrdlc/Student name updateCS.rdlc';
    ApplicationArea = All;
    UsageCategory = Administration;
    dataset
    {
        dataitem(DataItem1000000000; "Main Student Subject-CS")
        {

            trigger OnAfterGetRecord()
            begin
                StudentMasterCS.Reset();
                StudentMasterCS.SETRANGE(StudentMasterCS."No.", "Student No.");
                IF StudentMasterCS.findfirst() THEN
                    "Student Name" := StudentMasterCS."Student Name";
                Modify();
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
        MESSAGE('done');
    end;

    var
        StudentMasterCS: Record "Student Master-CS";
}

