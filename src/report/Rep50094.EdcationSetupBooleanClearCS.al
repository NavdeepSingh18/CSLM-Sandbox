report 50094 "EdcationSetup Boolean ClearCS"
{
    // version V.001-CS

    ProcessingOnly = true;
    ApplicationArea = All;
    UsageCategory = Administration;
    dataset
    {
        dataitem("Education Setup-CS"; "Education Setup-CS")
        {

            trigger OnAfterGetRecord()
            begin
                "Education Setup-CS"."Assignment  Generated" := FALSE;
                "Education Setup-CS".Modify();
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
