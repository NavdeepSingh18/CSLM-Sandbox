report 50093 "Customer Modify from StudentCS"
{
    // version V.001-CS

    ProcessingOnly = true;
    ApplicationArea = All;
    UsageCategory = Administration;
    dataset
    {
        dataitem("Customer"; "Customer")
        {

            trigger OnAfterGetRecord()
            begin
                IF StudentMasterCS.GET(Customer."No.") THEN BEGIN
                    Customer."Enrollment No." := StudentMasterCS."Enrollment No.";
                    Customer."Fee Classification Code" := StudentMasterCS."Fee Classification Code";
                    Customer."Academic Year" := StudentMasterCS."Academic Year";
                    Customer."Application No." := StudentMasterCS."Application No.";
                    Customer."Admitted Year" := StudentMasterCS."Admitted Year";
                    Customer.Category := StudentMasterCS.Category;
                    Customer."Course Code" := StudentMasterCS."Course Code";
                    Customer.Year := StudentMasterCS.Year;
                    Customer."Lateral Student" := StudentMasterCS."Lateral Student";
                    Customer.Modify();
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

