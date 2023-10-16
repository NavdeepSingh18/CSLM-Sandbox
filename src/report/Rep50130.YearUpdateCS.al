report 50130 "Year UpdateCS"
{
    // version V.001-CS

    ProcessingOnly = true;
    ApplicationArea = All;
    UsageCategory = Administration;
    dataset
    {
        dataitem(DataItem1000000000; "Optional Student Subject-CS")
        {

            trigger OnAfterGetRecord()
            begin
                CourseMasterCS.Reset();
                CourseMasterCS.SETRANGE(CourseMasterCS.Code, Course);
                IF CourseMasterCS.findfirst() THEN
                    Graduation := CourseMasterCS.Graduation;

                IF Semester = 'V' THEN
                    VALIDATE(Year, '3RD')
                ELSE
                    IF Semester = 'VII' THEN
                        VALIDATE(Year, '4TH');

                VALIDATE("Academic Year");
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
        MESSAGE('Done');
    end;

    var
        CourseMasterCS: Record "Course Master-CS";
}

