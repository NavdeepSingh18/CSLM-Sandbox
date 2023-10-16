report 50137 "Student Batch AllocationCS"
{
    // version V.001-CS

    ProcessingOnly = true;
    ApplicationArea = All;
    UsageCategory = Administration;
    dataset
    {
        dataitem("Student Master-CS"; "Student Master-CS")
        {
            DataItemTableView = SORTING("No.")
                                ORDER(Ascending)
                                WHERE(Year = FILTER('1ST'));

            trigger OnPreDataItem()
            begin
                GroupMasterCS.Reset();
                GroupMasterCS.SETCURRENTKEY(Code);
                IF GroupMasterCS.findset() THEN
                    REPEAT
                        GroupMasterCS.Reset();
                        GroupMasterCS.SETCURRENTKEY(Code);
                        GroupMasterCS.SETRANGE(Code, GroupMasterCS.Code);
                        IF GroupMasterCS.findset() THEN
                            REPEAT
                                "Student Master-CS".Reset();
                                "Student Master-CS".SETRANGE("Student Master-CS".Year, '1ST');
                                "Student Master-CS".SETRANGE("Student Master-CS".Section, GroupMasterCS.Code);
                                IF AcademicYear <> '' THEN
                                    "Student Master-CS".SETRANGE("Student Master-CS"."Academic Year", AcademicYear);
                                IF "Student Master-CS".findset() THEN
                                    REPEAT
                                        A := "Student Master-CS".count();
                                        StudCountDiv := ROUND("Student Master-CS".COUNT() / 2, 1, '>');
                                        EVALUATE(RollNo, "Student Master-CS"."Roll No.");
                                        IF RollNo <= StudCountDiv THEN
                                            "Student Master-CS".VALIDATE(Batch, 'BATCH-1')
                                        ELSE
                                            "Student Master-CS".VALIDATE(Batch, 'BATCH-2');
                                        "Student Master-CS".Modify();

                                    UNTIL "Student Master-CS".NEXT() = 0
                                ELSE
                                    ERROR(Text_10001Lbl);
                            UNTIL GroupMasterCS.NEXT() = 0;
                    UNTIL GroupMasterCS.NEXT() = 0;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Academic Year"; AcademicYear)
                {
                    TableRelation = "Academic Year Master-CS".Code;
                    ApplicationArea = All;
                    Caption = 'Academic Year';
                    ToolTip = 'Academic Year may have a value';
                }
            }
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
        GroupMasterCS: Record "Group Master-CS";
        Text_10001Lbl: Label 'Student Section Not Alloted , First Allot Student Section !!';
        StudCountDiv: Integer;
        A: Integer;
        AcademicYear: Code[10];
        RollNo: Integer;
}

