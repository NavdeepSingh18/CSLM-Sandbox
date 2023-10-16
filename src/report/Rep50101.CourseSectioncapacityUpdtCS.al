report 50101 "Course Section capacity UpdtCS"
{
    // version V.001-CS

    ProcessingOnly = true;
    ApplicationArea = All;
    UsageCategory = Administration;
    dataset
    {
        dataitem("Course Section Master-CS"; "Course Section Master-CS")
        {

            trigger OnAfterGetRecord()
            begin
                "Course Section Master-CS".VALIDATE("Course Section Master-CS"."Course Code");
                "Course Section Master-CS".Modify();
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
}

