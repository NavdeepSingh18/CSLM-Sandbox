report 50099 "Student Year AllotmentCS"
{
    // version V.001-CS

    ProcessingOnly = true;
    ApplicationArea = All;
    UsageCategory = Administration;
    dataset
    {
        dataitem("Student Master-CS"; "Student Master-CS")
        {

            trigger OnAfterGetRecord()
            begin
                IF ("Student Master-CS".Semester = 'I') OR ("Student Master-CS".Semester = 'II') THEN BEGIN
                    "Student Master-CS".Year := '1ST';
                    IF BatchNo < 2 THEN
                        BatchNo += 1
                    ELSE
                        BatchNo := 1;

                    IF BatchNo = 1 THEN
                        "Student Master-CS".Group := 'PHYSICS GROUP'
                    ELSE
                        IF BatchNo = 2 THEN
                            "Student Master-CS".Group := 'CHEMISTRY GROUP';
                END;
                IF ("Student Master-CS".Semester = 'III') OR ("Student Master-CS".Semester = 'IV') THEN BEGIN
                    "Student Master-CS".Year := '2ND';
                    "Student Master-CS".Group := '';
                END;
                IF ("Student Master-CS".Semester = 'V') OR ("Student Master-CS".Semester = 'VI') THEN BEGIN
                    "Student Master-CS".Year := '3RD';
                    "Student Master-CS".Group := '';
                END;
                IF ("Student Master-CS".Semester = 'VII') OR ("Student Master-CS".Semester = 'VIII') THEN BEGIN
                    "Student Master-CS".Year := '4TH';
                    "Student Master-CS".Group := '';
                END;
                "Student Master-CS".Modify();
            end;

            trigger OnPreDataItem()
            begin
                BatchNo := 0;
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
        BatchNo: Integer;
}

