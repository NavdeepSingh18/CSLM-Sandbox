report 50120 "Student RollNo Allotment 1Y CS"
{
    // version V.001-CS

    ProcessingOnly = true;
    ApplicationArea = All;
    UsageCategory = Administration;
    dataset
    {
        dataitem("Section Master-CS"; "Section Master-CS")
        {
            DataItemTableView = SORTING(Code)
                                ORDER(Ascending);
            dataitem("Student Master-CS"; "Student Master-CS")
            {
                DataItemLink = Section = FIELD(Code);
                DataItemTableView = SORTING("Enrollment No.")
                                    ORDER(Ascending)
                                    WHERE(Year = FILTER('1ST'),
                                          Semester = FILTER('I'),
                                          Graduation = FILTER('UG'));

                trigger OnAfterGetRecord()
                begin

                    IF "Student Master-CS"."Academic Year" = AcademicYear1 THEN BEGIN
                        NextRollNo += 1;
                        "Student Master-CS"."Roll No." := FORMAT(NextRollNo);
                        "Student Master-CS"."Section & Roll No." := TRUE;
                        "Student Master-CS".Modify();
                    END;
                end;

                trigger OnPreDataItem()
                begin

                    /*
                    "Section Master-CS".Reset();
                    "Section Master-CS".SETCURRENTKEY("Section Master-CS"."Enrollment No.");
                    "Section Master-CS".SETRANGE("Section Master-CS".Year,'1ST');
                    "Section Master-CS".SETRANGE("Section Master-CS".Section,Section.Code);
                    IF AcademicYear <> '' THEN
                      "Section Master-CS".SETRANGE("Section Master-CS"."Academic Year",AcademicYear)
                    ELSE
                      ERROR('Please Select Academic Year !!');
                      */

                end;
            }

            trigger OnAfterGetRecord()
            begin
                Counter := Counter + 1;
                PROGRESS.UPDATE(1, Counter);
                PROGRESS.UPDATE(2, ROUND(Counter / TotalCount * 10000, 1));

                NextRollNo := 0;
            end;

            trigger OnPostDataItem()
            begin
                PROGRESS.close();
            end;

            trigger OnPreDataItem()
            begin
                TotalCount := COUNT();
                PROGRESS.OPEN(Text_10002Lbl);
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                field("Academic Year"; AcademicYear1)
                {
                    ApplicationArea = All;
                    Caption = 'Academic Year';
                    ToolTip = 'Academic Year may have a value';
                    TableRelation = "Academic Year Master-CS".Code;
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
        StudentInformation.Student1styearBatchAllotmentCS("Student Master-CS".Year, AcademicYear1);

        MESSAGE('Roll No. Alloted For Ist Year');
    end;

    trigger OnPreReport()
    begin
        IF AcademicYear1 = '' THEN
            ERROR('Please Select Academic Year !!');
    end;

    var

        StudentInformation: Codeunit "StudentsInfoCSCSLM";
        NextRollNo: Integer;
        AcademicYear1: Code[10];

        Counter: Integer;
        TotalCount: Integer;
        PROGRESS: Dialog;
        Text_10002Lbl: Label 'PROCESSING #1  Out Of  @2 .', Comment = '#1 = No. of Counts';
}

