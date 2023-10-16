report 50133 "Student Subject DeleteCS"
{
    // version V.001-CS

    DefaultLayout = RDLC;
    RDLCLayout = './src/reportrdlc/Student Subject DeleteCS.rdlc';
    ApplicationArea = All;
    UsageCategory = Administration;
    dataset
    {
        dataitem(DataItem1000000000; "Student Master-CS")
        {

            trigger OnAfterGetRecord()
            begin
                MainStudentSubjectCS.Reset();
                MainStudentSubjectCS.SETRANGE(MainStudentSubjectCS."Student No.", "No.");
                MainStudentSubjectCS.SETFILTER(MainStudentSubjectCS.Course, '<>%1', "Course Code");
                IF MainStudentSubjectCS.findset() THEN
                    MainStudentSubjectCS.deleteall();
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
        MainStudentSubjectCS: Record "Main Student Subject-CS";
}

