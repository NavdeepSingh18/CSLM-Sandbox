report 50097 "Group Update In Course WisFaCs"
{
    // version V.001-CS

    ProcessingOnly = true;
    ApplicationArea = All;
    UsageCategory = Administration;
    dataset
    {
        dataitem("Faculty Course Wise-CS"; "Faculty Course Wise-CS")
        {
            DataItemTableView = WHERE("Year Code" = FILTER('1ST'),
                                      Graduation = FILTER('UG'));

            trigger OnAfterGetRecord()
            begin
                SectionMasterCS.Reset();
                SectionMasterCS.SETRANGE(Code, "Faculty Course Wise-CS"."Section Code");
                IF SectionMasterCS.findfirst() THEN BEGIN
                    "Faculty Course Wise-CS".Group := SectionMasterCS.Group;
                    "Faculty Course Wise-CS".Modify();
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
        SectionMasterCS: Record "Section Master-CS";
}

