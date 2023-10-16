report 50116 "Section Allotment 1Y CS"
{
    // version V.001-CS
    ApplicationArea = All;
    UsageCategory = Administration;
    ProcessingOnly = true;

    dataset
    {
        dataitem("Student Master-CS"; "Student Master-CS")
        {
            DataItemTableView = WHERE(Year = FILTER('1ST'),
                                      Semester = FILTER('I'),
                                      Graduation = FILTER('UG'));

            trigger OnAfterGetRecord()
            begin
                Counter := Counter + 1;
                PROGRESS.UPDATE(1, Counter);
                PROGRESS.UPDATE(2, ROUND(Counter / TotalCount * 10000, 1));

                IF "Student Master-CS".Group = 'PHYSICS GROUP' THEN BEGIN
                    //RecStudent.Reset();
                    //RecStudent.SETRANGE("No.","Student Master-CS"."No.");
                    //IF RecStudent.findfirst() THEN BEGIN
                    IF LastSection < SectionMasterCS1.COUNT() THEN
                        LastSection += 1
                    ELSE
                        LastSection := 1;

                    IF SectionMasterCS1.COUNT() > 0 THEN BEGIN
                        SectionMasterCS.Reset();
                        SectionMasterCS.SETRANGE(Group, "Student Master-CS".Group);
                        SectionMasterCS.SETRANGE(SectionMasterCS."Sequence No", LastSection);
                        IF SectionMasterCS.findfirst() THEN BEGIN
                            "Student Master-CS".VALIDATE(Section, SectionMasterCS.Code);
                            "Student Master-CS".Modify();
                            //RecStudent.VALIDATE(Section,SectionMasterCS.Code);
                            //RecStudent.Modify();
                        END;
                    END ELSE BEGIN
                        "Student Master-CS".VALIDATE(Section, '');
                        "Student Master-CS".Modify();
                        //RecStudent.VALIDATE(Section,'');
                        //RecStudent.Modify();
                    END;
                    //END;
                END;

                IF "Student Master-CS".Group = 'CHEMISTRY GROUP' THEN
                    //RecStudent.Reset();
                    //RecStudent.SETRANGE("No.","Student Master-CS"."No.");
                    IF StudentMasterCS.findfirst() THEN begin
                        IF LastSection1 < SectionMasterCS2.COUNT() THEN
                            LastSection1 += 1
                        ELSE
                            LastSection1 := 1;


                        IF SectionMasterCS2.COUNT() > 0 THEN BEGIN
                            SectionMasterCS3.Reset();
                            SectionMasterCS3.SETRANGE(Group, "Student Master-CS".Group);
                            SectionMasterCS3.SETRANGE(SectionMasterCS3."Sequence No", LastSection1);
                            IF SectionMasterCS3.findfirst() THEN BEGIN
                                "Student Master-CS".VALIDATE(Section, SectionMasterCS3.Code);
                                "Student Master-CS".Modify();
                            END;
                            //StudentMasterCS.VALIDATE(Section,SectionMasterCS3.Code);
                            //StudentMasterCS.Modify();
                        END ELSE BEGIN
                            "Student Master-CS".VALIDATE(Section, '');
                            "Student Master-CS".Modify();
                            //StudentMasterCS.VALIDATE(Section,'');
                            //StudentMasterCS.Modify();
                        END;
                    END;


                MainStudentSubjectCS.Reset();
                MainStudentSubjectCS.SETRANGE(MainStudentSubjectCS.Year, "Student Master-CS".Year);
                MainStudentSubjectCS.SETRANGE("Student No.", "Student Master-CS"."No.");
                IF MainStudentSubjectCS.findset() THEN
                    REPEAT
                        MainStudentSubjectCS.RENAME(MainStudentSubjectCS."Student No.", MainStudentSubjectCS.Course, MainStudentSubjectCS.Semester,
                                              MainStudentSubjectCS."Academic Year", MainStudentSubjectCS."Subject Code", StudentMasterCS.Section);
                        MainStudentSubjectCS.Modify();
                    UNTIL MainStudentSubjectCS.NEXT() = 0;

                OptionalStudentSubjectCS.Reset();
                OptionalStudentSubjectCS.SETRANGE(OptionalStudentSubjectCS.Year, "Student Master-CS".Year);
                OptionalStudentSubjectCS.SETRANGE("Student No.", "Student Master-CS"."No.");
                IF OptionalStudentSubjectCS.findset() THEN
                    REPEAT
                        OptionalStudentSubjectCS.RENAME(OptionalStudentSubjectCS."Student No.", OptionalStudentSubjectCS.Course, OptionalStudentSubjectCS.Semester,
                                              OptionalStudentSubjectCS."Academic Year", OptionalStudentSubjectCS."Subject Code", StudentMasterCS.Section);  //StudentMasterCS.Section
                    UNTIL MainStudentSubjectCS.NEXT() = 0;
            end;

            trigger OnPostDataItem()
            begin
                PROGRESS.close();
            end;

            trigger OnPreDataItem()
            begin

                TotalCount := "Student Master-CS".count();
                PROGRESS.OPEN(Text_10002Lbl);
                AcademicYear := '';
                SectionMasterCS1.Reset();
                SectionMasterCS1.SETRANGE(Group, 'PHYSICS GROUP');
                IF SectionMasterCS1.findset() THEN
                    SectionMasterCS2.Reset();
                SectionMasterCS2.SETRANGE(Group, 'CHEMISTRY GROUP');
                IF SectionMasterCS2.findset() THEN BEGIN
                    "Student Master-CS".Reset();
                    "Student Master-CS".SETCURRENTKEY("Course Code", "Fee Classification Code", Gender, "Enrollment No.");
                    "Student Master-CS".SETRANGE("Student Master-CS".Year, '1ST');
                    //IF StudGroup <> '' THEN BEGIN
                    //  "Student Master-CS".SETRANGE("Student Master-CS".Group,StudGroup);
                    //END;
                    IF AcademicYear <> '' THEN
                        "Student Master-CS".SETRANGE("Student Master-CS"."Academic Year", AcademicYear)
                    ELSE
                        ERROR('Please Select Academic Year');
                END;
                SectionRec.Reset();
                SectionRec.SETFILTER(Group, '%1|%2', 'PHYSICS GROUP', 'CHEMISTRY GROUP');
                IF SectionRec.findset() THEN
                    SectionCount := SectionRec.count();
                SectionRec.SETRANGE(Code, 'A');  // To Get Capacity
                IF SectionRec.findfirst() THEN
                    Student.Reset();
                IF "Student Master-CS"."Type Of Course" = "Student Master-CS"."Type Of Course"::Semester THEN
                    Student.SETFILTER(Semester, '%1|%2', 'I', 'II')
                ELSE
                    Student.SETRANGE(Year, '1ST');
                Student.SETRANGE("Academic Year", AcademicYear);
                IF Student.findset() THEN
                    A := Student.count();
                B := SectionCount * SectionRec.Capacity;
                IF Student.COUNT() > SectionCount * SectionRec.Capacity THEN
                    ERROR(Text_10001Lbl);
                //MESSAGE('%1,%2',Student.COUNT(),SectionCapacity * SectionRec.Capacity);

                LastSection := 0;
                LastSection1 := 0;
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
                field("Academic Year"; 'AcademicYear')
                {
                    ApplicationArea = All;
                    Caption = 'Academic Year';
                    ToolTip = 'Academic Year may have a value';
                    TableRelation = "Academic Year Master-CS".Code;
                }
                field(Group; 'StudGroup')
                {
                    TableRelation = "Group-CS".Code;
                    Visible = false;
                    ApplicationArea = All;
                    Caption = 'Group';
                    ToolTip = 'Group may have a value';
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

        //REPORT.RUN(50082,FALSE,FALSE,"Student - COLLEGE");
        //REPORT.RUN(50081,FALSE,FALSE,"Student - COLLEGE");
        MESSAGE('Section Alloted For Ist Year');
        //REPORT.RUNMODAL(REPORT::"Student Roll No Allotment 1Y",FALSE,FALSE,RecSection);
    end;

    trigger OnPreReport()
    begin
        BatchNo := 0;
    end;

    var
        StudentMasterCS: Record "Student Master-CS";
        SectionMasterCS1: Record "Section Master-CS";
        SectionMasterCS2: Record "Section Master-CS";
        SectionMasterCS3: Record "Section Master-CS";
        Student: Record "Student Master-CS";
        SectionRec: Record "Section Master-CS";
        MainStudentSubjectCS: Record "Main Student Subject-CS";
        OptionalStudentSubjectCS: Record "Optional Student Subject-CS";
        SectionMasterCS: Record "Section Master-CS";
        LastSection: Integer;
        LastSection1: Integer;
        SectionCount: Integer;
        Text_10001Lbl: Label 'Student Capacity Is More Than Section Capacity !!';
        BatchNo: Integer;
        AcademicYear: Code[20];
        A: Integer;
        B: Integer;
        Counter: Integer;
        TotalCount: Integer;
        PROGRESS: Dialog;
        Text_10002Lbl: Label 'PROCESSING #1  Out Of  @2 .', Comment = '#1 = No. of Counts';
}

