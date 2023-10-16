page 50232 "Course Faculty Generation-CS"
{
    // version V.001-CS

    // Sr.No.     Emp.ID           Date          Trigger                        Remarks
    // ----------------------------------------------------------------------------------------------------------------------------
    // 01.       CSPL-00174       06-02-19       College Code - OnLookup       Code added to get College Code & run page.
    // 02.       CSPL-00174       06-02-19       Generate - OnAction()         Code added for function call.
    // 03.       CSPL-00174       06-02-19       AutoupdateCourseWiseFaculty() Code added to insert course wise faculty.

    Caption = 'Course Faculty Generation-CS';
    ApplicationArea = All;
    UsageCategory = Administration;
    layout
    {
        area(content)
        {
            field("College Code"; CollegeCode)
            {
                ApplicationArea = All;
                Caption = 'College Code';
                trigger OnLookup(var Text: Text): Boolean
                begin
                    //Code added to get College Code & run page::CSPL-00174::060219: Start
                    DimensionValue.RESET();
                    DimensionValue.SETRANGE("Dimension Code", 'INSTITUTE');
                    IF PAGE.RUNMODAL(0, DimensionValue) = ACTION::LookupOK THEN
                        CollegeCode := DimensionValue.Code;
                    //Code added to get College Code & run page::CSPL-00174::060219:End
                end;
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(Generate)
            {
                Image = CreateInteraction;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = New;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    //Code added for function call::CSPL-00174::060219: Start
                    IF CONFIRM(Text_10001Lbl, FALSE) THEN
                        AutoupdateCourseWiseFaculty(CollegeCode);
                    CurrPage.Close();

                    LineNo := 0;
                    //Code added for function call::CSPL-00174::060219: End
                end;
            }
        }
    }

    var

        DimensionValue: Record "Dimension Value";
        BatchCS: Record "Batch-CS";
        CourseWiseSubjectLineCS: Record "Course Wise Subject Line-CS";
        CourseSubjectLineCS: Record "Course Wise Subject Line-CS";
        CollegeCode: Code[20];
        Text_10001Lbl: Label 'Do You Want To Generate Course Wise Faculty?';
        LineNo: Integer;


    procedure AutoupdateCourseWiseFaculty(InstituteCode: Code[20])
    var
        EducationSetupCS: Record "Education Setup-CS";
        SectionMasterCS: Record "Section Master-CS";
        FacultyCourseWiseCS: Record "Faculty Course Wise-CS";
        CourseSectionMasterCS: Record "Course Section Master-CS";
        SectionMasterRecCS: Record "Course Section Master-CS";

    begin
        //Code added to insert course wise faculty::CSPL-00174::060219: Start
        IF InstituteCode = '' THEN
            ERROR('Please Select Institute Code !!');
        EducationSetupCS.RESET();
        EducationSetupCS.SETRANGE("Global Dimension 1 Code", InstituteCode);
        IF EducationSetupCS.FINDFIRST() THEN
            EducationSetupCS.TESTFIELD("Academic Year")
        ELSE
            ERROR('Education Setup Not Defined !!');

        IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::SPRING THEN BEGIN
            SectionMasterCS.RESET();
            SectionMasterCS.SETCURRENTKEY(Code);
            SectionMasterCS.SETRANGE("Global Dimension 1 Code", EducationSetupCS."Global Dimension 1 Code");
            SectionMasterCS.SETFILTER(Group, '<>%1', '');
            IF SectionMasterCS.FINDSET() THEN
                REPEAT
                    LineNo := 0;
                    CourseSubjectLineCS.RESET();
                    CourseSubjectLineCS.SETRANGE(Semester, 'I');
                    CourseSubjectLineCS.SETRANGE(Year, '1ST');
                    CourseSubjectLineCS.SETRANGE("Academic Year", EducationSetupCS."Academic Year");
                    CourseSubjectLineCS.SETFILTER("Subject Classification", '<>%1', 'LAB');
                    CourseSubjectLineCS.SETRANGE("Course Code", EducationSetupCS."Course Code");
                    CourseSubjectLineCS.SETRANGE("Student Group", SectionMasterCS.Group);
                    IF CourseSubjectLineCS.FINDFIRST() THEN
                        REPEAT
                            LineNo += 10000;
                            FacultyCourseWiseCS.INIT();
                            FacultyCourseWiseCS."Line No" := LineNo;
                            FacultyCourseWiseCS.Graduation := 'UG';
                            FacultyCourseWiseCS.VALIDATE("Year Code", '1ST');
                            FacultyCourseWiseCS.VALIDATE("Semester Code", 'I');
                            FacultyCourseWiseCS."Section Code" := SectionMasterCS.Code;
                            FacultyCourseWiseCS.Group := CourseSubjectLineCS."Student Group";
                            FacultyCourseWiseCS."Subject Type" := CourseSubjectLineCS."Subject Type";
                            FacultyCourseWiseCS."Subject Class" := CourseSubjectLineCS."Subject Classification";
                            FacultyCourseWiseCS.VALIDATE("Subject Code", CourseSubjectLineCS."Subject Code");
                            FacultyCourseWiseCS."Academic Year" := EducationSetupCS."Academic Year";
                            FacultyCourseWiseCS.Role := 'INSTRUCTOR';
                            FacultyCourseWiseCS."Global Dimension 1 Code" := EducationSetupCS."Global Dimension 1 Code";
                            FacultyCourseWiseCS.INSERT();
                        UNTIL CourseSubjectLineCS.NEXT() = 0;
                    SectionMasterCS.Modify();
                UNTIL SectionMasterCS.NEXT() = 0
            ELSE
                ERROR(Text_10001Lbl);

            CourseSectionMasterCS.RESET();
            CourseSectionMasterCS.SETCURRENTKEY("Course Code", Semester, "Section Code");
            CourseSectionMasterCS.SETRANGE("Academic Year", EducationSetupCS."Academic Year");
            CourseSectionMasterCS.SETRANGE("Global Dimension 1 Code", EducationSetupCS."Global Dimension 1 Code");
            CourseSectionMasterCS.SETFILTER(Semester, '%1|%2|%3', 'III', 'V', 'VII');
            CourseSectionMasterCS.SETRANGE("Program", 'UG');
            IF CourseSectionMasterCS.FINDSET() THEN
                REPEAT
                    LineNo := 0;
                    CourseSubjectLineCS.RESET();
                    CourseSubjectLineCS.SETFILTER(CourseSubjectLineCS.Semester, '%1|%2|%3', 'III', 'V', 'VII');
                    CourseSubjectLineCS.SETRANGE(CourseSubjectLineCS."Academic Year", EducationSetupCS."Academic Year");
                    CourseSubjectLineCS.SETFILTER("Subject Classification", '<>%1', 'LAB');
                    IF CourseSubjectLineCS.FINDFIRST() THEN
                        REPEAT
                            LineNo += 10000;
                            FacultyCourseWiseCS.INIT();
                            FacultyCourseWiseCS."Line No" := LineNo;
                            FacultyCourseWiseCS.Graduation := CourseSectionMasterCS."Program";
                            FacultyCourseWiseCS.VALIDATE("Year Code", CourseSectionMasterCS.Year);
                            FacultyCourseWiseCS.VALIDATE("Semester Code", CourseSectionMasterCS.Semester);
                            FacultyCourseWiseCS."Section Code" := CourseSectionMasterCS."Section Code";
                            FacultyCourseWiseCS."Academic Year" := EducationSetupCS."Academic Year";
                            FacultyCourseWiseCS."Subject Type" := CourseSubjectLineCS."Subject Type";
                            FacultyCourseWiseCS."Subject Class" := CourseSubjectLineCS."Subject Classification";
                            FacultyCourseWiseCS.VALIDATE("Subject Code", CourseSubjectLineCS."Subject Code");
                            FacultyCourseWiseCS.Role := 'INSTRUCTOR';
                            FacultyCourseWiseCS.VALIDATE("Course Code", CourseSectionMasterCS."Course Code");
                            FacultyCourseWiseCS."Global Dimension 1 Code" := EducationSetupCS."Global Dimension 1 Code";
                            FacultyCourseWiseCS.INSERT();
                        UNTIL CourseSubjectLineCS.NEXT() = 0;
                    CourseSectionMasterCS.Modify();
                UNTIL CourseSectionMasterCS.NEXT() = 0
            ELSE
                ERROR(Text_10001Lbl);

            SectionMasterRecCS.RESET();
            SectionMasterRecCS.SETCURRENTKEY("Course Code", Semester, "Section Code");
            SectionMasterRecCS.SETRANGE("Academic Year", EducationSetupCS."Academic Year");
            SectionMasterRecCS.SETRANGE("Global Dimension 1 Code", EducationSetupCS."Global Dimension 1 Code");
            SectionMasterRecCS.SETFILTER(Semester, '%1|%2|%3|%4', 'I', 'III', 'V', 'VII');
            SectionMasterRecCS.SETRANGE("Program", 'PG');
            IF SectionMasterRecCS.FINDSET() THEN
                REPEAT
                    LineNo := 0;
                    CourseWiseSubjectLineCS.RESET();
                    CourseWiseSubjectLineCS.SETRANGE("Course Code", SectionMasterRecCS."Course Code");
                    CourseWiseSubjectLineCS.SETRANGE(Semester, SectionMasterRecCS.Semester);
                    CourseWiseSubjectLineCS.SETRANGE("Academic Year", EducationSetupCS."Academic Year");
                    CourseWiseSubjectLineCS.SETFILTER("Subject Classification", '<>%1', 'LAB');
                    CourseWiseSubjectLineCS.SETRANGE(CourseWiseSubjectLineCS."Program/Open Elective Temp", CourseWiseSubjectLineCS."Program/Open Elective Temp"::" ");
                    IF CourseWiseSubjectLineCS.FINDFIRST() THEN
                        REPEAT
                            LineNo += 10000;
                            FacultyCourseWiseCS.INIT();
                            FacultyCourseWiseCS."Line No" := LineNo;
                            FacultyCourseWiseCS.Graduation := SectionMasterRecCS."Program";
                            FacultyCourseWiseCS."Type Of Course" := SectionMasterRecCS."Type Of Course";
                            FacultyCourseWiseCS.VALIDATE("Year Code", SectionMasterRecCS.Year);
                            FacultyCourseWiseCS.VALIDATE("Semester Code", SectionMasterRecCS.Semester);
                            FacultyCourseWiseCS."Section Code" := SectionMasterRecCS."Section Code";
                            FacultyCourseWiseCS."Subject Type" := CourseWiseSubjectLineCS."Subject Type";
                            FacultyCourseWiseCS."Subject Class" := CourseWiseSubjectLineCS."Subject Classification";
                            FacultyCourseWiseCS.VALIDATE("Subject Code", CourseWiseSubjectLineCS."Subject Code");
                            FacultyCourseWiseCS."Academic Year" := EducationSetupCS."Academic Year";
                            FacultyCourseWiseCS.VALIDATE("Course Code", SectionMasterRecCS."Course Code");
                            FacultyCourseWiseCS.Role := 'INSTRUCTOR';
                            FacultyCourseWiseCS."Global Dimension 1 Code" := EducationSetupCS."Global Dimension 1 Code";
                            FacultyCourseWiseCS.INSERT();
                        UNTIL CourseWiseSubjectLineCS.NEXT() = 0;
                UNTIL SectionMasterRecCS.NEXT() = 0
            ELSE
                ERROR(Text_10001Lbl);

        END ELSE
            IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::FALL THEN BEGIN
                SectionMasterCS.RESET();
                SectionMasterCS.SETCURRENTKEY(Code);
                SectionMasterCS.SETRANGE("Global Dimension 1 Code", EducationSetupCS."Global Dimension 1 Code");
                SectionMasterCS.SETFILTER(Group, '<>%1', '');
                IF SectionMasterCS.FINDSET() THEN
                    REPEAT
                        LineNo := 0;
                        CourseSubjectLineCS.RESET();
                        CourseSubjectLineCS.SETRANGE(CourseSubjectLineCS.Semester, 'II');
                        CourseSubjectLineCS.SETRANGE(CourseSubjectLineCS.Year, '1ST');
                        CourseSubjectLineCS.SETRANGE(CourseSubjectLineCS."Academic Year", EducationSetupCS."Academic Year");
                        CourseSubjectLineCS.SETFILTER("Subject Classification", '<>%1', 'LAB');
                        CourseSubjectLineCS.SETRANGE("Course Code", EducationSetupCS."Course Code");
                        CourseSubjectLineCS.SETRANGE("Student Group", SectionMasterCS.Group);
                        IF CourseSubjectLineCS.FINDFIRST() THEN
                            REPEAT
                                LineNo += 10000;
                                FacultyCourseWiseCS.INIT();
                                FacultyCourseWiseCS."Line No" := LineNo;
                                FacultyCourseWiseCS.Graduation := 'UG';
                                FacultyCourseWiseCS.VALIDATE("Year Code", '1ST');
                                FacultyCourseWiseCS.VALIDATE("Semester Code", 'II');
                                FacultyCourseWiseCS."Section Code" := SectionMasterCS.Code;
                                FacultyCourseWiseCS.Group := CourseSubjectLineCS."Student Group";
                                FacultyCourseWiseCS."Academic Year" := EducationSetupCS."Academic Year";
                                FacultyCourseWiseCS."Subject Type" := CourseSubjectLineCS."Subject Type";
                                FacultyCourseWiseCS."Subject Class" := CourseSubjectLineCS."Subject Classification";
                                FacultyCourseWiseCS.VALIDATE("Subject Code", CourseSubjectLineCS."Subject Code");
                                FacultyCourseWiseCS.Role := 'INSTRUCTOR';
                                FacultyCourseWiseCS."Global Dimension 1 Code" := EducationSetupCS."Global Dimension 1 Code";
                                FacultyCourseWiseCS.INSERT();
                            UNTIL CourseSubjectLineCS.NEXT() = 0;
                        SectionMasterCS.Modify();
                    UNTIL SectionMasterCS.NEXT() = 0
                ELSE
                    ERROR(Text_10001Lbl);

                CourseSectionMasterCS.RESET();
                CourseSectionMasterCS.SETCURRENTKEY("Course Code", Semester, "Section Code");
                CourseSectionMasterCS.SETRANGE("Academic Year", EducationSetupCS."Academic Year");
                CourseSectionMasterCS.SETRANGE("Global Dimension 1 Code", EducationSetupCS."Global Dimension 1 Code");
                CourseSectionMasterCS.SETFILTER(Semester, '%1|%2|%3', 'IV', 'VI', 'VIII');
                CourseSectionMasterCS.SETRANGE("Program", 'UG');
                IF CourseSectionMasterCS.FINDSET() THEN
                    REPEAT
                        LineNo := 0;
                        CourseSubjectLineCS.RESET();
                        CourseSubjectLineCS.SETFILTER(CourseSubjectLineCS.Semester, '%1|%2|%3', 'III', 'V', 'VII');
                        CourseSubjectLineCS.SETRANGE(CourseSubjectLineCS."Academic Year", EducationSetupCS."Academic Year");
                        CourseSubjectLineCS.SETFILTER("Subject Classification", '<>%1', 'LAB');
                        IF CourseSubjectLineCS.FINDFIRST() THEN
                            REPEAT
                                LineNo += 10000;
                                FacultyCourseWiseCS.INIT();
                                FacultyCourseWiseCS."Line No" := LineNo;
                                FacultyCourseWiseCS.Graduation := CourseSectionMasterCS."Program";
                                FacultyCourseWiseCS.VALIDATE("Year Code", CourseSectionMasterCS.Year);
                                FacultyCourseWiseCS.VALIDATE("Semester Code", CourseSectionMasterCS.Semester);
                                FacultyCourseWiseCS."Section Code" := CourseSectionMasterCS."Section Code";
                                FacultyCourseWiseCS."Academic Year" := EducationSetupCS."Academic Year";
                                FacultyCourseWiseCS.VALIDATE("Course Code", CourseSectionMasterCS."Course Code");
                                FacultyCourseWiseCS."Subject Class" := CourseSubjectLineCS."Subject Classification";
                                FacultyCourseWiseCS."Subject Type" := CourseSubjectLineCS."Subject Type";
                                FacultyCourseWiseCS.VALIDATE("Subject Code", CourseSubjectLineCS."Subject Code");
                                FacultyCourseWiseCS.Role := 'INSTRUCTOR';
                                FacultyCourseWiseCS."Global Dimension 1 Code" := EducationSetupCS."Global Dimension 1 Code";
                                FacultyCourseWiseCS.INSERT();
                            UNTIL CourseSubjectLineCS.NEXT() = 0;
                        CourseSectionMasterCS.Modify();
                    UNTIL CourseSectionMasterCS.NEXT() = 0
                ELSE
                    ERROR(Text_10001Lbl);
                SectionMasterRecCS.RESET();
                SectionMasterRecCS.SETCURRENTKEY("Course Code", Semester, "Section Code");
                SectionMasterRecCS.SETRANGE("Academic Year", EducationSetupCS."Academic Year");
                SectionMasterRecCS.SETRANGE("Global Dimension 1 Code", EducationSetupCS."Global Dimension 1 Code");
                SectionMasterRecCS.SETFILTER(Semester, '%1|%2|%3|%4', 'II', 'IV', 'IV', 'VIII');
                SectionMasterRecCS.SETRANGE("Program", 'PG');
                IF SectionMasterRecCS.FINDSET() THEN
                    REPEAT
                        LineNo := 0;
                        CourseSubjectLineCS.RESET();
                        CourseSubjectLineCS.SETRANGE("Course Code", SectionMasterRecCS."Course Code");
                        CourseSubjectLineCS.SETRANGE(Semester, SectionMasterRecCS.Semester);
                        CourseSubjectLineCS.SETRANGE(CourseSubjectLineCS."Academic Year", EducationSetupCS."Academic Year");
                        CourseSubjectLineCS.SETFILTER("Subject Classification", '<>%1', 'LAB');
                        CourseSubjectLineCS.SETRANGE(CourseSubjectLineCS."Program/Open Elective Temp", CourseSubjectLineCS."Program/Open Elective Temp"::" ");
                        IF CourseSubjectLineCS.FINDFIRST() THEN
                            REPEAT
                                LineNo += 10000;
                                FacultyCourseWiseCS.INIT();
                                FacultyCourseWiseCS."Line No" := LineNo;
                                FacultyCourseWiseCS.Graduation := SectionMasterRecCS."Program";
                                FacultyCourseWiseCS."Type Of Course" := SectionMasterRecCS."Type Of Course";
                                FacultyCourseWiseCS.VALIDATE("Year Code", SectionMasterRecCS.Year);
                                FacultyCourseWiseCS.VALIDATE("Semester Code", SectionMasterRecCS.Semester);
                                FacultyCourseWiseCS."Section Code" := SectionMasterRecCS."Section Code";
                                FacultyCourseWiseCS."Academic Year" := EducationSetupCS."Academic Year";
                                FacultyCourseWiseCS."Subject Type" := CourseSubjectLineCS."Subject Type";
                                FacultyCourseWiseCS."Subject Class" := CourseSubjectLineCS."Subject Classification";
                                FacultyCourseWiseCS.VALIDATE("Subject Code", CourseSubjectLineCS."Subject Code");
                                FacultyCourseWiseCS.VALIDATE("Course Code", SectionMasterRecCS."Course Code");
                                FacultyCourseWiseCS.Role := 'INSTRUCTOR';
                                FacultyCourseWiseCS."Global Dimension 1 Code" := EducationSetupCS."Global Dimension 1 Code";
                                FacultyCourseWiseCS.INSERT();
                            UNTIL CourseSubjectLineCS.NEXT() = 0;
                        SectionMasterRecCS.Modify();
                    UNTIL SectionMasterRecCS.NEXT() = 0
                ELSE
                    ERROR(Text_10001Lbl);
            END;

        //AutoCreationforLab-CSPL-00174

        IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::SPRING THEN BEGIN
            SectionMasterCS.RESET();
            SectionMasterCS.SETCURRENTKEY(Code);
            SectionMasterCS.SETRANGE("Global Dimension 1 Code", EducationSetupCS."Global Dimension 1 Code");
            SectionMasterCS.SETFILTER(Group, '<>%1', '');
            IF SectionMasterCS.FINDSET() THEN
                REPEAT
                    LineNo := 0;
                    CourseSubjectLineCS.RESET();
                    CourseSubjectLineCS.SETRANGE(Semester, 'I');
                    CourseSubjectLineCS.SETRANGE(Year, '1ST');
                    CourseSubjectLineCS.SETRANGE("Academic Year", EducationSetupCS."Academic Year");
                    CourseSubjectLineCS.SETRANGE("Course Code", EducationSetupCS."Course Code");
                    CourseSubjectLineCS.SETRANGE("Student Group", SectionMasterCS.Group);
                    CourseSubjectLineCS.SETRANGE("Subject Classification", 'LAB');
                    IF CourseSubjectLineCS.FINDFIRST() THEN
                        REPEAT
                            BatchCS.RESET();
                            IF BatchCS.FINDFIRST() THEN
                                REPEAT
                                    LineNo += 10000;
                                    FacultyCourseWiseCS.INIT();
                                    FacultyCourseWiseCS."Line No" := LineNo;
                                    FacultyCourseWiseCS.Graduation := 'UG';
                                    FacultyCourseWiseCS.VALIDATE("Year Code", '1ST');
                                    FacultyCourseWiseCS.VALIDATE("Semester Code", 'I');
                                    FacultyCourseWiseCS."Section Code" := SectionMasterCS.Code;
                                    FacultyCourseWiseCS.Group := CourseSubjectLineCS."Student Group";
                                    FacultyCourseWiseCS."Subject Type" := CourseSubjectLineCS."Subject Type";
                                    FacultyCourseWiseCS."Subject Class" := CourseSubjectLineCS."Subject Classification";
                                    FacultyCourseWiseCS.VALIDATE("Subject Code", CourseSubjectLineCS."Subject Code");
                                    FacultyCourseWiseCS."Academic Year" := EducationSetupCS."Academic Year";
                                    FacultyCourseWiseCS.Role := 'INSTRUCTOR';
                                    FacultyCourseWiseCS.Batch := BatchCS.Code;
                                    FacultyCourseWiseCS."Global Dimension 1 Code" := EducationSetupCS."Global Dimension 1 Code";
                                    FacultyCourseWiseCS.INSERT();
                                UNTIL BatchCS.NEXT() = 0;
                        UNTIL CourseSubjectLineCS.NEXT() = 0;
                UNTIL SectionMasterCS.NEXT() = 0
            ELSE
                ERROR(Text_10001Lbl);

            CourseSectionMasterCS.RESET();
            CourseSectionMasterCS.SETCURRENTKEY("Course Code", Semester, "Section Code");
            CourseSectionMasterCS.SETRANGE("Academic Year", EducationSetupCS."Academic Year");
            CourseSectionMasterCS.SETRANGE("Global Dimension 1 Code", EducationSetupCS."Global Dimension 1 Code");
            CourseSectionMasterCS.SETFILTER(Semester, '%1|%2|%3', 'III', 'V', 'VII');
            CourseSectionMasterCS.SETRANGE("Program", 'UG');
            IF CourseSectionMasterCS.FINDSET() THEN
                REPEAT
                    LineNo := 0;
                    CourseSubjectLineCS.RESET();
                    CourseSubjectLineCS.SETFILTER(CourseSubjectLineCS.Semester, '%1|%2|%3', 'III', 'V', 'VII');
                    CourseSubjectLineCS.SETRANGE(CourseSubjectLineCS."Academic Year", EducationSetupCS."Academic Year");
                    CourseSubjectLineCS.SETRANGE("Subject Classification", 'LAB');
                    IF CourseSubjectLineCS.FINDFIRST() THEN
                        REPEAT
                            BatchCS.RESET();
                            IF BatchCS.FINDFIRST() THEN
                                REPEAT
                                    LineNo += 10000;
                                    FacultyCourseWiseCS.INIT();
                                    FacultyCourseWiseCS."Line No" := LineNo;
                                    FacultyCourseWiseCS.Graduation := CourseSectionMasterCS."Program";
                                    FacultyCourseWiseCS.VALIDATE("Year Code", CourseSectionMasterCS.Year);
                                    FacultyCourseWiseCS.VALIDATE("Semester Code", CourseSectionMasterCS.Semester);
                                    FacultyCourseWiseCS."Section Code" := CourseSectionMasterCS."Section Code";
                                    FacultyCourseWiseCS."Academic Year" := EducationSetupCS."Academic Year";
                                    FacultyCourseWiseCS."Subject Type" := CourseSubjectLineCS."Subject Type";
                                    FacultyCourseWiseCS."Subject Class" := CourseSubjectLineCS."Subject Classification";
                                    FacultyCourseWiseCS.VALIDATE("Subject Code", CourseSubjectLineCS."Subject Code");
                                    FacultyCourseWiseCS.Role := 'INSTRUCTOR';
                                    FacultyCourseWiseCS.Batch := BatchCS.Code;
                                    FacultyCourseWiseCS.VALIDATE("Course Code", CourseSectionMasterCS."Course Code");
                                    FacultyCourseWiseCS."Global Dimension 1 Code" := EducationSetupCS."Global Dimension 1 Code";
                                    FacultyCourseWiseCS.INSERT();
                                UNTIL BatchCS.NEXT() = 0;
                        UNTIL CourseSubjectLineCS.NEXT() = 0;
                    CourseSectionMasterCS.Modify();
                UNTIL CourseSectionMasterCS.NEXT() = 0
            ELSE
                ERROR(Text_10001Lbl);

            SectionMasterRecCS.RESET();
            SectionMasterRecCS.SETCURRENTKEY("Course Code", Semester, "Section Code");
            SectionMasterRecCS.SETRANGE("Academic Year", EducationSetupCS."Academic Year");
            SectionMasterRecCS.SETRANGE("Global Dimension 1 Code", EducationSetupCS."Global Dimension 1 Code");
            SectionMasterRecCS.SETFILTER(Semester, '%1|%2|%3|%4', 'I', 'III', 'V', 'VII');
            SectionMasterRecCS.SETRANGE("Program", 'PG');
            IF SectionMasterRecCS.FINDSET() THEN
                REPEAT
                    LineNo := 0;
                    CourseSubjectLineCS.RESET();
                    CourseSubjectLineCS.SETRANGE("Course Code", SectionMasterRecCS."Course Code");
                    CourseSubjectLineCS.SETRANGE(Semester, SectionMasterRecCS.Semester);
                    CourseSubjectLineCS.SETRANGE(CourseSubjectLineCS."Academic Year", EducationSetupCS."Academic Year");
                    CourseSubjectLineCS.SETRANGE("Subject Classification", 'LAB');
                    CourseSubjectLineCS.SETRANGE(CourseSubjectLineCS."Program/Open Elective Temp", CourseSubjectLineCS."Program/Open Elective Temp"::" ");
                    IF CourseSubjectLineCS.FINDFIRST() THEN
                        REPEAT
                            BatchCS.RESET();
                            IF BatchCS.FINDFIRST() THEN
                                REPEAT
                                    LineNo += 10000;
                                    FacultyCourseWiseCS.INIT();
                                    FacultyCourseWiseCS."Line No" := LineNo;
                                    FacultyCourseWiseCS.Graduation := SectionMasterRecCS."Program";
                                    FacultyCourseWiseCS."Type Of Course" := SectionMasterRecCS."Type Of Course";
                                    FacultyCourseWiseCS.VALIDATE("Year Code", SectionMasterRecCS.Year);
                                    FacultyCourseWiseCS.VALIDATE("Semester Code", SectionMasterRecCS.Semester);
                                    FacultyCourseWiseCS."Section Code" := SectionMasterRecCS."Section Code";
                                    FacultyCourseWiseCS."Subject Type" := CourseSubjectLineCS."Subject Type";
                                    FacultyCourseWiseCS."Subject Class" := CourseSubjectLineCS."Subject Classification";
                                    FacultyCourseWiseCS.VALIDATE("Subject Code", CourseSubjectLineCS."Subject Code");
                                    FacultyCourseWiseCS."Academic Year" := EducationSetupCS."Academic Year";
                                    FacultyCourseWiseCS.VALIDATE("Course Code", SectionMasterRecCS."Course Code");
                                    FacultyCourseWiseCS.Role := 'INSTRUCTOR';
                                    FacultyCourseWiseCS.Batch := BatchCS.Code;
                                    FacultyCourseWiseCS."Global Dimension 1 Code" := EducationSetupCS."Global Dimension 1 Code";
                                    FacultyCourseWiseCS.INSERT();
                                UNTIL BatchCS.NEXT() = 0;
                        UNTIL CourseSubjectLineCS.NEXT() = 0;
                    SectionMasterRecCS.Modify();
                UNTIL SectionMasterRecCS.NEXT() = 0
            ELSE
                ERROR(Text_10001Lbl);

        END ELSE
            IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::FALL THEN BEGIN
                SectionMasterCS.RESET();
                SectionMasterCS.SETCURRENTKEY(Code);
                SectionMasterCS.SETRANGE("Global Dimension 1 Code", EducationSetupCS."Global Dimension 1 Code");
                SectionMasterCS.SETFILTER(Group, '<>%1', '');
                IF SectionMasterCS.FINDSET() THEN
                    REPEAT
                        LineNo := 0;
                        CourseSubjectLineCS.RESET();
                        CourseSubjectLineCS.SETRANGE(CourseSubjectLineCS.Semester, 'II');
                        CourseSubjectLineCS.SETRANGE(CourseSubjectLineCS.Year, '1ST');
                        CourseSubjectLineCS.SETRANGE(CourseSubjectLineCS."Academic Year", EducationSetupCS."Academic Year");
                        CourseSubjectLineCS.SETRANGE("Subject Classification", 'LAB');
                        CourseSubjectLineCS.SETRANGE("Course Code", EducationSetupCS."Course Code");
                        CourseSubjectLineCS.SETRANGE("Student Group", SectionMasterCS.Group);
                        IF CourseSubjectLineCS.FINDFIRST() THEN
                            REPEAT
                                BatchCS.RESET();
                                IF BatchCS.FINDFIRST() THEN
                                    REPEAT
                                        LineNo += 10000;
                                        FacultyCourseWiseCS.INIT();
                                        FacultyCourseWiseCS."Line No" := LineNo;
                                        FacultyCourseWiseCS.Graduation := 'UG';
                                        FacultyCourseWiseCS.VALIDATE("Year Code", '1ST');
                                        FacultyCourseWiseCS.VALIDATE("Semester Code", 'II');
                                        FacultyCourseWiseCS."Section Code" := SectionMasterCS.Code;
                                        FacultyCourseWiseCS.Group := CourseSubjectLineCS."Student Group";
                                        FacultyCourseWiseCS."Academic Year" := EducationSetupCS."Academic Year";
                                        FacultyCourseWiseCS."Subject Type" := CourseSubjectLineCS."Subject Type";
                                        FacultyCourseWiseCS."Subject Class" := CourseSubjectLineCS."Subject Classification";
                                        FacultyCourseWiseCS.VALIDATE("Subject Code", CourseSubjectLineCS."Subject Code");
                                        FacultyCourseWiseCS.Role := 'INSTRUCTOR';
                                        FacultyCourseWiseCS.Batch := BatchCS.Code;
                                        FacultyCourseWiseCS."Global Dimension 1 Code" := EducationSetupCS."Global Dimension 1 Code";
                                        FacultyCourseWiseCS.INSERT();
                                    UNTIL BatchCS.NEXT() = 0;
                            UNTIL CourseSubjectLineCS.NEXT() = 0;
                    UNTIL SectionMasterCS.NEXT() = 0
                ELSE
                    ERROR(Text_10001Lbl);

                CourseSectionMasterCS.RESET();
                CourseSectionMasterCS.SETCURRENTKEY("Course Code", Semester, "Section Code");
                CourseSectionMasterCS.SETRANGE("Academic Year", EducationSetupCS."Academic Year");
                CourseSectionMasterCS.SETRANGE("Global Dimension 1 Code", EducationSetupCS."Global Dimension 1 Code");
                CourseSectionMasterCS.SETFILTER(Semester, '%1|%2|%3', 'IV', 'VI', 'VIII');
                CourseSectionMasterCS.SETRANGE("Program", 'UG');
                IF CourseSectionMasterCS.FINDSET() THEN
                    REPEAT
                        LineNo := 0;
                        CourseSubjectLineCS.RESET();
                        CourseSubjectLineCS.SETFILTER(CourseSubjectLineCS.Semester, '%1|%2|%3', 'III', 'V', 'VII');
                        CourseSubjectLineCS.SETRANGE(CourseSubjectLineCS."Academic Year", EducationSetupCS."Academic Year");
                        CourseSubjectLineCS.SETRANGE("Subject Classification", 'LAB');
                        CourseSubjectLineCS.SETRANGE(CourseSubjectLineCS."Program/Open Elective Temp", CourseSubjectLineCS."Program/Open Elective Temp"::" ");
                        IF CourseSubjectLineCS.FINDFIRST() THEN
                            REPEAT
                                BatchCS.RESET();
                                IF BatchCS.FINDFIRST() THEN
                                    REPEAT
                                        LineNo += 10000;
                                        FacultyCourseWiseCS.INIT();
                                        FacultyCourseWiseCS."Line No" := LineNo;
                                        FacultyCourseWiseCS.Graduation := CourseSectionMasterCS."Program";
                                        FacultyCourseWiseCS.VALIDATE("Year Code", CourseSectionMasterCS.Year);
                                        FacultyCourseWiseCS.VALIDATE("Semester Code", CourseSectionMasterCS.Semester);
                                        FacultyCourseWiseCS."Section Code" := CourseSectionMasterCS."Section Code";
                                        FacultyCourseWiseCS."Academic Year" := EducationSetupCS."Academic Year";
                                        FacultyCourseWiseCS.VALIDATE("Course Code", CourseSectionMasterCS."Course Code");
                                        FacultyCourseWiseCS."Subject Class" := CourseSubjectLineCS."Subject Classification";
                                        FacultyCourseWiseCS."Subject Type" := CourseSubjectLineCS."Subject Type";
                                        FacultyCourseWiseCS.VALIDATE("Subject Code", CourseSubjectLineCS."Subject Code");
                                        FacultyCourseWiseCS.Role := 'INSTRUCTOR';
                                        FacultyCourseWiseCS.Batch := BatchCS.Code;
                                        FacultyCourseWiseCS."Global Dimension 1 Code" := EducationSetupCS."Global Dimension 1 Code";
                                        FacultyCourseWiseCS.INSERT();
                                    UNTIL BatchCS.NEXT() = 0;
                            UNTIL CourseSubjectLineCS.NEXT() = 0;
                        CourseSectionMasterCS.Modify();
                    UNTIL CourseSectionMasterCS.NEXT() = 0
                ELSE
                    ERROR(Text_10001Lbl);
                SectionMasterRecCS.RESET();
                SectionMasterRecCS.SETCURRENTKEY("Course Code", Semester, "Section Code");
                SectionMasterRecCS.SETRANGE("Academic Year", EducationSetupCS."Academic Year");
                SectionMasterRecCS.SETRANGE("Global Dimension 1 Code", EducationSetupCS."Global Dimension 1 Code");
                SectionMasterRecCS.SETFILTER(Semester, '%1|%2|%3|%4', 'II', 'IV', 'IV', 'VIII');
                SectionMasterRecCS.SETRANGE("Program", 'PG');
                IF SectionMasterRecCS.FINDSET() THEN
                    REPEAT
                        LineNo := 0;
                        CourseSubjectLineCS.RESET();
                        CourseSubjectLineCS.SETRANGE("Course Code", SectionMasterRecCS."Course Code");
                        CourseSubjectLineCS.SETRANGE(Semester, SectionMasterRecCS.Semester);
                        CourseSubjectLineCS.SETRANGE(CourseSubjectLineCS."Academic Year", EducationSetupCS."Academic Year");
                        CourseSubjectLineCS.SETRANGE("Subject Classification", 'LAB');
                        IF CourseSubjectLineCS.FINDFIRST() THEN
                            REPEAT
                                BatchCS.RESET();
                                IF BatchCS.FINDFIRST() THEN
                                    REPEAT
                                        LineNo += 10000;
                                        FacultyCourseWiseCS.INIT();
                                        FacultyCourseWiseCS."Line No" := LineNo;
                                        FacultyCourseWiseCS.Graduation := SectionMasterRecCS."Program";
                                        FacultyCourseWiseCS."Type Of Course" := SectionMasterRecCS."Type Of Course";
                                        FacultyCourseWiseCS.VALIDATE("Year Code", SectionMasterRecCS.Year);
                                        FacultyCourseWiseCS.VALIDATE("Semester Code", SectionMasterRecCS.Semester);
                                        FacultyCourseWiseCS."Section Code" := SectionMasterRecCS."Section Code";
                                        FacultyCourseWiseCS."Academic Year" := EducationSetupCS."Academic Year";
                                        FacultyCourseWiseCS."Subject Type" := CourseSubjectLineCS."Subject Type";
                                        FacultyCourseWiseCS."Subject Class" := CourseSubjectLineCS."Subject Classification";
                                        FacultyCourseWiseCS.VALIDATE("Subject Code", CourseSubjectLineCS."Subject Code");
                                        FacultyCourseWiseCS.VALIDATE("Course Code", SectionMasterRecCS."Course Code");
                                        FacultyCourseWiseCS.Batch := BatchCS.Code;
                                        FacultyCourseWiseCS.Role := 'INSTRUCTOR';
                                        FacultyCourseWiseCS."Global Dimension 1 Code" := EducationSetupCS."Global Dimension 1 Code";
                                        FacultyCourseWiseCS.INSERT();
                                    UNTIL BatchCS.NEXT() = 0;
                            UNTIL CourseSubjectLineCS.NEXT() = 0;
                        SectionMasterRecCS.Modify();
                    UNTIL SectionMasterRecCS.NEXT() = 0
                ELSE
                    ERROR(Text_10001Lbl);
            END;
        MESSAGE('Generated');
        //Code added to insert course wise faculty::CSPL-00174::060219:End
    end;
}