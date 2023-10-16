page 50237 "Course Wise Faculty Gen-CS"
{
    // version V.001-CS

    // Sr.No    Emp.ID      Date         Trigger                             Remarks
    // -----------------------------------------------------------------------------------------------
    // 01.      CSPL-00174  02-02-19     College Code - OnLookup             Code added for get value of college code & page run.
    // 02.      CSPL-00174  02-02-19     Generate - OnAction()               Code added to function call.
    // 03.      CSPL-00174  02-02-19     AutoupdateCourseWiseFaculty()       Code added to generate course wise faculty.

    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Course Wise Faculty Gen';

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
                    //Code added for get value of college code & run page::CSPL-00174::020219: Start
                    DimensionValue.Reset();
                    DimensionValue.SETRANGE("Dimension Code", 'INSTITUTE');
                    IF PAGE.RUNMODAL(0, DimensionValue) = ACTION::LookupOK THEN
                        CollegeCode := DimensionValue.Code;

                    //Code added for get value of college code & run page::CSPL-00174::020219: End
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
                    //Code added to function call::CSPL-00174::020219: Start
                    IF CONFIRM(Text_10001Lbl, FALSE) THEN
                        AutoupdateCourseWiseFaculty(CollegeCode);
                    CurrPage.Close();
                    //Code added to function call::CSPL-00174::020219: End
                end;
            }
        }
    }

    var

        DimensionValue: Record "Dimension Value";
        BatchCS: Record "Batch-CS";
        GroupMasterCS: Record "Group Master-CS";
        CourseWiseSubjectLineCS: Record "Course Wise Subject Line-CS";
        CourseSubjectLineCS: Record "Course Wise Subject Line-CS";
        FacultyCourseWiseCS: Record "Faculty Course Wise-CS";
        CollegeCode: Code[20];
        Text_10001Lbl: Label 'Do You Want To Generate Course Wise Faculty?';
        LineNo: Integer;


    procedure AutoupdateCourseWiseFaculty(InstituteCode: Code[20])
    var
        EducationSetupCS: Record "Education Setup-CS";
        SectionMasterCS: Record "Section Master-CS";

        CourseSectionMasterCS: Record "Course Section Master-CS";
        CourseMasterCS: Record "Course Section Master-CS";

    begin
        //Code added to generate course wise faculty::CSPL-00174::020219: Start
        IF InstituteCode = '' THEN
            ERROR('Please Select Institute Code !!');
        EducationSetupCS.Reset();
        EducationSetupCS.SETRANGE("Global Dimension 1 Code", InstituteCode);
        IF EducationSetupCS.FINDFIRST() THEN
            EducationSetupCS.TESTFIELD("Academic Year")
        ELSE
            ERROR('Education Setup Not Defined !!');

        GroupMasterCS.Reset();
        GroupMasterCS.SETRANGE("Global Dimension 1 Code", EducationSetupCS."Global Dimension 1 Code");
        IF GroupMasterCS.FINDSET() THEN
            REPEAT
                CourseSubjectLineCS.Reset();
                CourseSubjectLineCS.SETCURRENTKEY("Course Code", "Type Of Course", Semester, Year, "Subject Classification", "Subject Type", "Subject Code");
                CourseSubjectLineCS.SETRANGE("Program", 'UG');
                IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::SPRING THEN
                    CourseSubjectLineCS.SETRANGE(Semester, 'I')
                ELSE
                    IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::FALL THEN
                        CourseSubjectLineCS.SETRANGE(Semester, 'II');
                CourseSubjectLineCS.SETRANGE("Academic Year", EducationSetupCS."Academic Year");
                CourseSubjectLineCS.SETFILTER("Subject Classification", '<>%1', 'LAB');
                CourseSubjectLineCS.SETRANGE("Course Code", EducationSetupCS."Course Code");
                CourseSubjectLineCS.SETRANGE("Student Group", GroupMasterCS.Code);
                CourseSubjectLineCS.SETRANGE("Global Dimension 1 Code", EducationSetupCS."Global Dimension 1 Code");
                CourseSubjectLineCS.SETRANGE(CourseSubjectLineCS."Program/Open Elective Temp", CourseSubjectLineCS."Program/Open Elective Temp"::" ");
                CourseSubjectLineCS.SETRANGE("Course Faculty Generated", FALSE);
                IF CourseSubjectLineCS.FINDFIRST() THEN
                    REPEAT
                        SectionMasterCS.Reset();
                        SectionMasterCS.SETCURRENTKEY(Code);
                        SectionMasterCS.SETRANGE("Global Dimension 1 Code", EducationSetupCS."Global Dimension 1 Code");
                        SectionMasterCS.SETFILTER(Group, '%1', GroupMasterCS.Code);
                        IF SectionMasterCS.FINDSET() THEN
                            REPEAT
                                FacultyCourseWiseCS.Reset();
                                FacultyCourseWiseCS.SETRANGE("Academic Year", CourseSubjectLineCS."Academic Year");
                                FacultyCourseWiseCS.SETRANGE("Semester Code", CourseSubjectLineCS.Semester);
                                FacultyCourseWiseCS.SETRANGE("Section Code", SectionMasterCS.Code);
                                IF FacultyCourseWiseCS.FINDLAST() THEN
                                    LineNo := FacultyCourseWiseCS."Line No" + 10000
                                ELSE
                                    LineNo := 10000;

                                FacultyCourseWiseCS.INIT();
                                FacultyCourseWiseCS."Line No" := LineNo;
                                FacultyCourseWiseCS.Graduation := 'UG';
                                FacultyCourseWiseCS.VALIDATE("Year Code", '1ST');
                                FacultyCourseWiseCS.VALIDATE("Semester Code", CourseSubjectLineCS.Semester);
                                FacultyCourseWiseCS."Section Code" := SectionMasterCS.Code;
                                FacultyCourseWiseCS."Subject Type" := CourseSubjectLineCS."Subject Type";
                                FacultyCourseWiseCS."Subject Class" := CourseSubjectLineCS."Subject Classification";
                                FacultyCourseWiseCS.VALIDATE("Subject Code", CourseSubjectLineCS."Subject Code");
                                FacultyCourseWiseCS."Academic Year" := EducationSetupCS."Academic Year";
                                FacultyCourseWiseCS.Group := CourseSubjectLineCS."Student Group";
                                FacultyCourseWiseCS."Global Dimension 1 Code" := EducationSetupCS."Global Dimension 1 Code";
                                FacultyCourseWiseCS.INSERT();
                                CourseSubjectLineCS."Course Faculty Generated" := TRUE;
                                CourseSubjectLineCS.Modify();
                            UNTIL SectionMasterCS.NEXT() = 0
                        ELSE
                            ERROR('Section Not Defind !!');
                    UNTIL CourseSubjectLineCS.NEXT() = 0;
            UNTIL GroupMasterCS.NEXT() = 0
        ELSE
            ERROR('Group Not Defind !!');

        CourseSubjectLineCS.Reset();
        CourseSubjectLineCS.SETCURRENTKEY("Course Code", "Type Of Course", Semester, Year, "Subject Classification", "Subject Type", "Subject Code");
        CourseSubjectLineCS.SETRANGE("Program", 'UG');
        IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::SPRING THEN
            CourseSubjectLineCS.SETFILTER(Semester, '%1|%2|%3', 'III', 'V', 'VII')
        ELSE
            IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::FALL THEN
                CourseSubjectLineCS.SETFILTER(Semester, '%1|%2|%3', 'IV', 'VI', 'VIII');
        CourseSubjectLineCS.SETRANGE(CourseSubjectLineCS."Academic Year", EducationSetupCS."Academic Year");
        CourseSubjectLineCS.SETFILTER("Subject Classification", '<>%1', 'LAB');
        CourseSubjectLineCS.SETRANGE(CourseSubjectLineCS."Program/Open Elective Temp", CourseSubjectLineCS."Program/Open Elective Temp"::" ");
        CourseSubjectLineCS.SETRANGE("Global Dimension 1 Code", EducationSetupCS."Global Dimension 1 Code");
        CourseSubjectLineCS.SETRANGE("Course Faculty Generated", FALSE);
        IF CourseSubjectLineCS.FINDFIRST() THEN
            REPEAT
                CourseSectionMasterCS.Reset();
                CourseSectionMasterCS.SETCURRENTKEY("Course Code", Semester, "Section Code");
                CourseSectionMasterCS.SETRANGE("Course Code", CourseSubjectLineCS."Course Code");
                CourseSectionMasterCS.SETRANGE(Semester, CourseSubjectLineCS.Semester);
                CourseSectionMasterCS.SETRANGE("Academic Year", EducationSetupCS."Academic Year");
                CourseSectionMasterCS.SETRANGE("Global Dimension 1 Code", EducationSetupCS."Global Dimension 1 Code");
                CourseSectionMasterCS.SETRANGE("Program", CourseSubjectLineCS."Program");
                IF CourseSectionMasterCS.FINDSET() THEN
                    REPEAT
                        FacultyCourseWiseCS.Reset();
                        FacultyCourseWiseCS.SETRANGE("Course Code", CourseSubjectLineCS."Course Code");
                        FacultyCourseWiseCS.SETRANGE("Academic Year", CourseSubjectLineCS."Academic Year");
                        FacultyCourseWiseCS.SETRANGE("Semester Code", CourseSubjectLineCS.Semester);
                        FacultyCourseWiseCS.SETRANGE("Section Code", CourseSectionMasterCS."Section Code");
                        IF FacultyCourseWiseCS.FINDLAST() THEN
                            LineNo := FacultyCourseWiseCS."Line No" + 10000
                        ELSE
                            LineNo := 10000;
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
                        FacultyCourseWiseCS.VALIDATE("Course Code", CourseSectionMasterCS."Course Code");
                        FacultyCourseWiseCS.INSERT();
                        CourseSubjectLineCS."Course Faculty Generated" := TRUE;
                        CourseSubjectLineCS.Modify();
                    UNTIL CourseSectionMasterCS.NEXT() = 0;
            UNTIL CourseSubjectLineCS.NEXT() = 0;

        CourseWiseSubjectLineCS.Reset();
        CourseWiseSubjectLineCS.SETCURRENTKEY("Course Code", "Type Of Course", Semester, Year, "Subject Classification", "Subject Type", "Subject Code");
        CourseWiseSubjectLineCS.SETRANGE("Program", 'PG');
        IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::FALL THEN
            CourseWiseSubjectLineCS.SETFILTER(Semester, '%1|%2|%3|%4', 'II', 'IV', 'VI', 'VIII')
        ELSE
            IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::SPRING THEN
                CourseWiseSubjectLineCS.SETFILTER(Semester, '%1|%2|%3|%4', 'I', 'III', 'V', 'VII');
        CourseWiseSubjectLineCS.SETRANGE("Academic Year", EducationSetupCS."Academic Year");
        CourseWiseSubjectLineCS.SETFILTER("Subject Classification", '<>%1', 'LAB');
        CourseWiseSubjectLineCS.SETRANGE(CourseWiseSubjectLineCS."Program/Open Elective Temp", CourseWiseSubjectLineCS."Program/Open Elective Temp"::" ");
        CourseWiseSubjectLineCS.SETRANGE("Course Faculty Generated", FALSE);
        IF CourseWiseSubjectLineCS.FINDFIRST() THEN
            REPEAT
                CourseMasterCS.Reset();
                CourseMasterCS.SETCURRENTKEY("Course Code", Semester, "Section Code");
                CourseMasterCS.SETRANGE("Course Code", CourseWiseSubjectLineCS."Course Code");
                CourseMasterCS.SETRANGE("Academic Year", EducationSetupCS."Academic Year");
                CourseMasterCS.SETRANGE("Global Dimension 1 Code", EducationSetupCS."Global Dimension 1 Code");
                CourseMasterCS.SETRANGE(Semester, CourseWiseSubjectLineCS.Semester);
                CourseMasterCS.SETRANGE("Program", CourseWiseSubjectLineCS."Program");
                IF CourseMasterCS.FINDSET() THEN
                    REPEAT
                        FacultyCourseWiseCS.Reset();
                        FacultyCourseWiseCS.SETRANGE("Course Code", CourseWiseSubjectLineCS."Course Code");
                        FacultyCourseWiseCS.SETRANGE("Academic Year", CourseWiseSubjectLineCS."Academic Year");
                        FacultyCourseWiseCS.SETRANGE("Semester Code", CourseWiseSubjectLineCS.Semester);
                        FacultyCourseWiseCS.SETRANGE("Section Code", CourseMasterCS."Section Code");
                        IF FacultyCourseWiseCS.FINDLAST() THEN
                            LineNo := FacultyCourseWiseCS."Line No" + 10000
                        ELSE
                            LineNo := 10000;
                        FacultyCourseWiseCS.INIT();
                        FacultyCourseWiseCS."Line No" := LineNo;
                        FacultyCourseWiseCS.Graduation := CourseMasterCS."Program";
                        FacultyCourseWiseCS."Type Of Course" := CourseMasterCS."Type Of Course";
                        FacultyCourseWiseCS.VALIDATE("Year Code", CourseMasterCS.Year);
                        FacultyCourseWiseCS.VALIDATE("Semester Code", CourseMasterCS.Semester);
                        FacultyCourseWiseCS."Section Code" := CourseMasterCS."Section Code";
                        FacultyCourseWiseCS."Subject Type" := CourseWiseSubjectLineCS."Subject Type";
                        FacultyCourseWiseCS."Subject Class" := CourseWiseSubjectLineCS."Subject Classification";
                        FacultyCourseWiseCS.VALIDATE("Subject Code", CourseWiseSubjectLineCS."Subject Code");
                        FacultyCourseWiseCS."Academic Year" := EducationSetupCS."Academic Year";
                        FacultyCourseWiseCS.VALIDATE("Course Code", CourseMasterCS."Course Code");
                        FacultyCourseWiseCS.INSERT();
                        CourseWiseSubjectLineCS."Course Faculty Generated" := TRUE;
                        CourseWiseSubjectLineCS.Modify();
                    UNTIL CourseMasterCS.NEXT() = 0;
            UNTIL CourseWiseSubjectLineCS.NEXT() = 0;
        AutoupdateLab(InstituteCode);
        MESSAGE('Generated');
    end;

    procedure AutoupdateLab(InstituteCode: Code[20])
    var
        EducationSetupCS: Record "Education Setup-CS";
        SectionMasterCS: Record "Section Master-CS";
        CourseSectionMasterCS: Record "Course Section Master-CS";
        CourseSectionMasterCSRec: Record "Course Section Master-CS";

        LineNo2: Integer;
    begin
        IF InstituteCode = '' THEN
            ERROR('Please Select Institute Code !!');
        EducationSetupCS.Reset();
        EducationSetupCS.SETRANGE("Global Dimension 1 Code", InstituteCode);
        IF EducationSetupCS.FINDFIRST() THEN
            EducationSetupCS.TESTFIELD("Academic Year")
        ELSE
            ERROR('Education Setup Not Defined !!');

        GroupMasterCS.Reset();
        GroupMasterCS.SETRANGE("Global Dimension 1 Code", EducationSetupCS."Global Dimension 1 Code");
        IF GroupMasterCS.FINDSET() THEN
            REPEAT
                CourseSubjectLineCS.Reset();
                CourseSubjectLineCS.SETCURRENTKEY("Course Code", "Type Of Course", Semester, Year, "Subject Classification", "Subject Type", "Subject Code");
                CourseSubjectLineCS.SETRANGE("Program", 'UG');
                IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::FALL THEN
                    CourseSubjectLineCS.SETFILTER(Semester, '%1', 'II')
                ELSE
                    IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::SPRING THEN
                        CourseSubjectLineCS.SETFILTER(Semester, '%1', 'I');
                CourseSubjectLineCS.SETRANGE("Academic Year", EducationSetupCS."Academic Year");
                CourseSubjectLineCS.SETRANGE("Course Code", EducationSetupCS."Course Code");
                CourseSubjectLineCS.SETRANGE("Student Group", GroupMasterCS.Code);
                CourseSubjectLineCS.SETRANGE("Subject Classification", 'LAB');
                CourseSubjectLineCS.SETRANGE(CourseSubjectLineCS."Program/Open Elective Temp", CourseSubjectLineCS."Program/Open Elective Temp"::" ");
                CourseSubjectLineCS.SETRANGE("Global Dimension 1 Code", EducationSetupCS."Global Dimension 1 Code");
                CourseSubjectLineCS.SETRANGE("Course Faculty Generated", FALSE);
                IF CourseSubjectLineCS.FINDFIRST() THEN
                    REPEAT
                        SectionMasterCS.Reset();
                        SectionMasterCS.SETCURRENTKEY(Code);
                        SectionMasterCS.SETRANGE("Global Dimension 1 Code", EducationSetupCS."Global Dimension 1 Code");
                        SectionMasterCS.SETFILTER(Group, '%1', GroupMasterCS.Code);
                        IF SectionMasterCS.FINDSET() THEN
                            REPEAT
                                BatchCS.Reset();
                                IF BatchCS.FINDFIRST() THEN
                                    REPEAT
                                        FacultyCourseWiseCS.Reset();
                                        FacultyCourseWiseCS.SETCURRENTKEY("Line No");
                                        FacultyCourseWiseCS.SETRANGE("Academic Year", CourseSubjectLineCS."Academic Year");
                                        FacultyCourseWiseCS.SETRANGE("Semester Code", CourseSubjectLineCS.Semester);
                                        FacultyCourseWiseCS.SETRANGE("Section Code", SectionMasterCS.Code);
                                        IF FacultyCourseWiseCS.FINDLAST() THEN
                                            LineNo2 := FacultyCourseWiseCS."Line No" + 10000
                                        ELSE
                                            LineNo2 := 10000;
                                        FacultyCourseWiseCS.INIT();
                                        FacultyCourseWiseCS."Line No" := LineNo2;
                                        FacultyCourseWiseCS.Graduation := CourseSubjectLineCS."Program";
                                        FacultyCourseWiseCS.VALIDATE("Year Code", CourseSubjectLineCS.Year);
                                        FacultyCourseWiseCS.VALIDATE("Semester Code", CourseSubjectLineCS.Semester);
                                        FacultyCourseWiseCS."Section Code" := SectionMasterCS.Code;
                                        FacultyCourseWiseCS."Subject Type" := CourseSubjectLineCS."Subject Type";
                                        FacultyCourseWiseCS."Subject Class" := CourseSubjectLineCS."Subject Classification";
                                        FacultyCourseWiseCS.VALIDATE("Subject Code", CourseSubjectLineCS."Subject Code");
                                        FacultyCourseWiseCS."Academic Year" := EducationSetupCS."Academic Year";
                                        FacultyCourseWiseCS.Group := CourseSubjectLineCS."Student Group";
                                        FacultyCourseWiseCS.Batch := BatchCS.Code;
                                        FacultyCourseWiseCS."Global Dimension 1 Code" := EducationSetupCS."Global Dimension 1 Code";
                                        FacultyCourseWiseCS.INSERT();
                                        CourseSubjectLineCS."Course Faculty Generated" := TRUE;
                                        CourseSubjectLineCS.Modify();
                                    UNTIL BatchCS.NEXT() = 0
                                ELSE
                                    ERROR('Batch Not Defined !!');
                            UNTIL SectionMasterCS.NEXT() = 0
                        ELSE
                            ERROR('Section Not Defined !!');
                    UNTIL CourseSubjectLineCS.NEXT() = 0;
            UNTIL GroupMasterCS.NEXT() = 0
        ELSE
            ERROR('Group Not Defined !!');

        CourseSubjectLineCS.Reset();
        CourseSubjectLineCS.SETCURRENTKEY("Course Code", "Type Of Course", Semester, Year, "Subject Classification", "Subject Type", "Subject Code");
        CourseSubjectLineCS.SETRANGE("Program", 'UG');
        IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::FALL THEN
            CourseSubjectLineCS.SETFILTER(Semester, '%1|%2|%3', 'IV', 'VI', 'VIII')
        ELSE
            IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::SPRING THEN
                CourseSubjectLineCS.SETFILTER(Semester, '%1|%2|%3', 'III', 'V', 'VII');
        CourseSubjectLineCS.SETRANGE(CourseSubjectLineCS."Academic Year", EducationSetupCS."Academic Year");
        CourseSubjectLineCS.SETRANGE("Subject Classification", 'LAB');
        CourseSubjectLineCS.SETRANGE(CourseSubjectLineCS."Program/Open Elective Temp", CourseSubjectLineCS."Program/Open Elective Temp"::" ");
        CourseSubjectLineCS.SETRANGE("Global Dimension 1 Code", EducationSetupCS."Global Dimension 1 Code");
        CourseSubjectLineCS.SETRANGE("Course Faculty Generated", FALSE);
        IF CourseSubjectLineCS.FINDFIRST() THEN
            REPEAT
                CourseSectionMasterCS.Reset();
                CourseSectionMasterCS.SETCURRENTKEY("Course Code", Semester, "Section Code");
                CourseSectionMasterCS.SETRANGE("Course Code", CourseSubjectLineCS."Course Code");
                CourseSectionMasterCS.SETRANGE("Academic Year", EducationSetupCS."Academic Year");
                CourseSectionMasterCS.SETRANGE("Global Dimension 1 Code", EducationSetupCS."Global Dimension 1 Code");
                CourseSectionMasterCS.SETRANGE(Semester, CourseSubjectLineCS.Semester);
                CourseSectionMasterCS.SETRANGE("Program", CourseSubjectLineCS."Program");
                IF CourseSectionMasterCS.FINDSET() THEN
                    REPEAT
                        BatchCS.Reset();
                        IF BatchCS.FINDFIRST() THEN
                            REPEAT
                                FacultyCourseWiseCS.Reset();
                                FacultyCourseWiseCS.SETCURRENTKEY("Line No");
                                FacultyCourseWiseCS.SETRANGE("Course Code", CourseSubjectLineCS."Course Code");
                                FacultyCourseWiseCS.SETRANGE("Academic Year", CourseSubjectLineCS."Academic Year");
                                FacultyCourseWiseCS.SETRANGE("Semester Code", CourseSubjectLineCS.Semester);
                                FacultyCourseWiseCS.SETRANGE("Section Code", CourseSectionMasterCS."Section Code");
                                IF FacultyCourseWiseCS.FINDLAST() THEN
                                    LineNo2 := FacultyCourseWiseCS."Line No" + 10000
                                ELSE
                                    LineNo2 := 10000;

                                FacultyCourseWiseCS.INIT();
                                FacultyCourseWiseCS."Line No" := LineNo2;
                                FacultyCourseWiseCS.Graduation := CourseSectionMasterCS."Program";
                                FacultyCourseWiseCS.VALIDATE("Year Code", CourseSectionMasterCS.Year);
                                FacultyCourseWiseCS.VALIDATE("Semester Code", CourseSectionMasterCS.Semester);
                                FacultyCourseWiseCS."Section Code" := CourseSectionMasterCS."Section Code";
                                FacultyCourseWiseCS."Academic Year" := EducationSetupCS."Academic Year";
                                FacultyCourseWiseCS."Subject Type" := CourseSubjectLineCS."Subject Type";
                                FacultyCourseWiseCS."Subject Class" := CourseSubjectLineCS."Subject Classification";
                                FacultyCourseWiseCS.VALIDATE("Subject Code", CourseSubjectLineCS."Subject Code");
                                FacultyCourseWiseCS.Batch := BatchCS.Code;
                                FacultyCourseWiseCS.VALIDATE("Course Code", CourseSectionMasterCS."Course Code");
                                FacultyCourseWiseCS."Global Dimension 1 Code" := EducationSetupCS."Global Dimension 1 Code";
                                FacultyCourseWiseCS.INSERT();
                                CourseSubjectLineCS."Course Faculty Generated" := TRUE;
                                CourseSubjectLineCS.Modify();
                            UNTIL BatchCS.NEXT() = 0
                        ELSE
                            ERROR('Batch Not Defined !!');
                    UNTIL CourseSectionMasterCS.NEXT() = 0
                ELSE
                    ERROR('Course Section Not Defined !!');
            UNTIL CourseSubjectLineCS.NEXT() = 0;
        CourseWiseSubjectLineCS.Reset();
        CourseWiseSubjectLineCS.SETCURRENTKEY("Course Code", "Type Of Course", Semester, Year, "Subject Classification", "Subject Type", "Subject Code");
        CourseWiseSubjectLineCS.SETRANGE("Program", 'PG');
        IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::FALL THEN
            CourseWiseSubjectLineCS.SETFILTER(Semester, '%1|%2|%3|%4', 'II', 'IV', 'VI', 'VIII')
        ELSE
            IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::SPRING THEN
                CourseWiseSubjectLineCS.SETFILTER(Semester, '%1|%2|%3|%4', 'I', 'III', 'V', 'VII');
        CourseWiseSubjectLineCS.SETRANGE(CourseWiseSubjectLineCS."Academic Year", EducationSetupCS."Academic Year");
        CourseWiseSubjectLineCS.SETRANGE("Subject Classification", 'LAB');
        CourseWiseSubjectLineCS.SETRANGE(CourseWiseSubjectLineCS."Program/Open Elective Temp", CourseWiseSubjectLineCS."Program/Open Elective Temp"::" ");
        CourseWiseSubjectLineCS.SETRANGE("Global Dimension 1 Code", EducationSetupCS."Global Dimension 1 Code");
        CourseWiseSubjectLineCS.SETRANGE("Course Faculty Generated", FALSE);
        IF CourseWiseSubjectLineCS.FINDFIRST() THEN
            REPEAT
                CourseSectionMasterCSRec.Reset();
                CourseSectionMasterCSRec.SETCURRENTKEY("Course Code", Semester, "Section Code");
                CourseSectionMasterCSRec.SETRANGE("Course Code", CourseWiseSubjectLineCS."Course Code");
                CourseSectionMasterCSRec.SETRANGE("Academic Year", EducationSetupCS."Academic Year");
                CourseSectionMasterCSRec.SETRANGE("Global Dimension 1 Code", EducationSetupCS."Global Dimension 1 Code");
                CourseSectionMasterCSRec.SETRANGE(Semester, CourseWiseSubjectLineCS.Semester);
                CourseSectionMasterCSRec.SETRANGE("Program", CourseWiseSubjectLineCS."Program");
                IF CourseSectionMasterCSRec.FINDSET() THEN
                    REPEAT
                        BatchCS.Reset();
                        IF BatchCS.FINDFIRST() THEN
                            REPEAT
                                FacultyCourseWiseCS.Reset();
                                FacultyCourseWiseCS.SETCURRENTKEY("Line No");
                                FacultyCourseWiseCS.SETRANGE("Course Code", CourseWiseSubjectLineCS."Course Code");
                                FacultyCourseWiseCS.SETRANGE("Academic Year", CourseWiseSubjectLineCS."Academic Year");
                                FacultyCourseWiseCS.SETRANGE("Semester Code", CourseWiseSubjectLineCS.Semester);
                                FacultyCourseWiseCS.SETRANGE("Section Code", CourseSectionMasterCSRec."Section Code");
                                IF FacultyCourseWiseCS.FINDLAST() THEN
                                    LineNo2 := FacultyCourseWiseCS."Line No" + 10000
                                ELSE
                                    LineNo2 := 10000;

                                FacultyCourseWiseCS.INIT();
                                FacultyCourseWiseCS."Line No" := LineNo2;
                                FacultyCourseWiseCS.Graduation := CourseSectionMasterCSRec."Program";
                                FacultyCourseWiseCS.VALIDATE("Year Code", CourseSectionMasterCSRec.Year);
                                FacultyCourseWiseCS.VALIDATE("Semester Code", CourseSectionMasterCSRec.Semester);
                                FacultyCourseWiseCS."Section Code" := CourseSectionMasterCSRec."Section Code";
                                FacultyCourseWiseCS."Subject Type" := CourseSubjectLineCS."Subject Type";
                                FacultyCourseWiseCS."Subject Class" := CourseSubjectLineCS."Subject Classification";
                                FacultyCourseWiseCS.VALIDATE("Subject Code", CourseSubjectLineCS."Subject Code");
                                FacultyCourseWiseCS."Academic Year" := EducationSetupCS."Academic Year";
                                FacultyCourseWiseCS.VALIDATE("Course Code", CourseSectionMasterCSRec."Course Code");
                                FacultyCourseWiseCS.Batch := BatchCS.Code;
                                FacultyCourseWiseCS."Global Dimension 1 Code" := EducationSetupCS."Global Dimension 1 Code";
                                FacultyCourseWiseCS.INSERT();
                                CourseWiseSubjectLineCS."Course Faculty Generated" := TRUE;
                                CourseWiseSubjectLineCS.Modify();
                            UNTIL BatchCS.NEXT() = 0
                        ELSE
                            ERROR('Batch Not Defined !!');
                    UNTIL CourseSectionMasterCSRec.NEXT() = 0
                ELSE
                    ERROR('Course Section Not Defined !!');
            UNTIL CourseWiseSubjectLineCS.NEXT() = 0;
        //Code added to generate course wise faculty::CSPL-00174::020219:End
    end;
}