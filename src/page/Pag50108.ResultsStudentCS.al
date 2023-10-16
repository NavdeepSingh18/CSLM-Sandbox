page 50108 "Results Student-CS"
{
    // version V.001-CS

    // Sr.No  Emp.ID      Date      Trigger                                          Remarks
    // -----------------------------------------------------------------------------------------------
    // 01.   CSPL-00174  10-05-19   Student No - OnLookup()                          Code added for page run and get value of StudentNo.
    // 02.   CSPL-00174  10-05-19   Semester - OnLookup                              Code added for page run and get value of Semester Code.
    // 03.   CSPL-00174  10-05-19   Function-GetData()                               Code added for get value of Student No.
    // 04.   CSPL-00174  10-05-19   CalculateGPA - OnAction()                        Code added for calculate GPA .
    // 05.   CSPL-00174  10-05-19   CalculateCGPA - OnAction()                       Code added for calculate CGPA .
    // 06.   CSPL-00174  10-05-19   CalculateCreditEarned - OnAction()               Code added to  calculate credit earn.
    // 07.   CSPL-00174  10-05-19   UpdateElectiveSubjectsRollNo - OnAction()        Code added to update elective subject roll no.
    // 08.   CSPL-00174  10-05-19   UpdateRe-RegistrationSubjectsRollNo - OnAction() Code added to update re-registration subject roll no.
    // 09.   CSPL-00174  10-05-19   CalculateSemesterWiseRank - OnAction()           Code added to calculate Semester wise rank .
    // 10.   CSPL-00174  10-05-19   CalculateOverAllRank - OnAction()                Code added to calculate over all rank .
    // 11.   CSPL-00174  10-05-19   RepeaterTickForGradeReport - OnAction()          Code added to update grade report and repeater
    // 12.   CSPL-00174  10-05-19   Elective Pre-Registration - OnAction()           Code added to insert Elective Pre-Registration record .

    PageType = Card;
    UsageCategory = Administration;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group("GPA AND CGPA")
            {
                field("Student No"; StudentNo)
                {
                    ToolTip = 'Student No.';
                    ApplicationArea = All;
                    Caption = 'Student No.';

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        //Code added for Page Run and get value of StudentNo::CSPL-00174::100519: Start
                        StudentMasterCS.Reset();
                        StudentMasterCS.SETCURRENTKEY("No.");
                        IF StudentMasterCS.FINDSET() THEN
                            IF PAGE.RUNMODAL(0, StudentMasterCS) = ACTION::LookupOK THEN
                                StudentNo := StudentMasterCS."No.";
                        //Code added for Page Run and get value of StudentNo::CSPL-00174::100519: End
                    end;
                }
                field(Semester; Sem)
                {
                    ToolTip = 'Semester';
                    ApplicationArea = All;
                    Caption = 'Semester';

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        //Code added for Page run and get value of Semester Code::CSPL-00174::100519: Start
                        SemesterMasterCS.RESET();
                        SemesterMasterCS.SETCURRENTKEY(Code);
                        IF PAGE.RUNMODAL(0, SemesterMasterCS) = ACTION::LookupOK THEN
                            Sem := SemesterMasterCS.Code;
                        //Code added for Page run and get value of Semester Code::CSPL-00174::100519: End
                    end;
                }
            }
            group("Elective Roll No Assign")
            {
                field("Academic Year"; AcademicYear)
                {
                    ToolTip = 'AcademicYear';
                    ApplicationArea = All;
                    Caption = 'Academic Year';
                    TableRelation = "Academic Year Master-CS".Code;
                }
                /* field("Even Odd Semester"; EvenOddSemester)
                 {
                     ToolTip = 'Even Odd Semester';
                     OptionCaption = 'Even Odd Semester';
                     ApplicationArea = All;
                     // Caption = 'Even Odd Semester';
                 }*/
            }
            group("Rank Group")
            {
                field("Admitted Year"; AdmittedYear1)
                {
                    ToolTip = 'Admitted Year';
                    ApplicationArea = All;
                    Caption = 'Admitted Year';
                    TableRelation = "Academic Year Master-CS".Code;
                }
                field("Course Code"; CourseCode1)
                {
                    ToolTip = 'Course Code';
                    ApplicationArea = All;
                    Caption = 'Course Code';
                    TableRelation = "Course Master-CS".Code;
                }
                field(Graduation; Graduation1)
                {
                    ToolTip = 'Graduation1';
                    ApplicationArea = All;
                    Caption = 'Graduation';
                    TableRelation = "Graduation Master-CS".Code;
                }
            }
            group("Grade Report for Repeater")
            {
                field("Academic Year1"; AcademicYear1)
                {
                    ToolTip = 'Academic Year1';
                    ApplicationArea = All;
                    Caption = 'Academic Year1';
                    TableRelation = "Academic Year Master-CS".Code;
                }
                field("Actual Semester"; Semester1)
                {
                    ToolTip = 'Semester1';
                    ApplicationArea = All;
                    Caption = 'Actual Semester';
                    TableRelation = "Semester Master-CS";
                }
                field("Current Session"; CurrentSession1)
                {
                    ToolTip = 'CurrentSession1';
                    ApplicationArea = All;
                    Caption = 'Current Session';
                    TableRelation = "Session Master-CS";
                }
                field(Course; CourseCode1)
                {
                    ToolTip = 'CourseCode1';
                    ApplicationArea = All;
                    Caption = 'Course';
                    TableRelation = "Course Master-CS".Code;
                }
            }
            group("Elective Pre-Registration")
            {
                field("Academic Year For Elective"; AcademicYear1)
                {
                    ToolTip = 'Academic Year For Elective';
                    ApplicationArea = All;
                    Caption = 'Academic Year For Elective';
                    TableRelation = "Academic Year Master-CS".Code;
                }
                field("Graduation For Elective"; Graduation1)
                {
                    ToolTip = 'Graduation For Elective';
                    Caption = 'Graduation For Elective';
                    ApplicationArea = All;
                }
                field("Enrollment No"; EnrollmentNo)
                {
                    ToolTip = 'Enrollment No';
                    Caption = 'Enrollment No';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Semester For Elective "; Sem)
                {
                    ToolTip = 'Semester For Elective';
                    Caption = 'Semester For Elective';
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {

            group("GPA & CGPA")
            {
                Image = Calculator;
                action(CalculateGPA)
                {
                    Caption = 'Calculate GPA';
                    Image = Calculate;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedIsBig = true;
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        //Code added for calculate GPA::CSPL-00174::100519: Start
                        IF CONFIRM(Text_10001Lbl, FALSE) THEN
                            IF (StudentNo <> '') AND (Sem <> '') THEN
                                StudentSubOldRecCS.CalculateGPAProcess(StudentNo, Sem)
                            ELSE
                                ERROR('Please Select Enrollment No. & Semester for GPA');
                        //Code added for calculate GPA ::CSPL-00174::100519: End
                    end;
                }
                action(CalculateCGPA)
                {
                    Caption = 'Calculate CGPA';
                    Image = Calculate;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedIsBig = true;
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        //Code added for calculate CGPA ::CSPL-00174::100519: Start
                        IF CONFIRM(Text_10002Lbl, FALSE) THEN
                            IF (StudentNo <> '') AND (Sem = '') THEN
                                StudentSubOldRecCS.CalculateCGPAProcess(StudentNo)
                            ELSE
                                ERROR('Please Select Student No. & Not Select Semester for CGPA');

                        //Code added for calculate GPA ::CSPL-00174::100519: End
                    end;
                }
                action(CalculateCreditEarned)
                {
                    Caption = 'Calculate Credit Earned';
                    Image = Calculate;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedIsBig = true;
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        // Code added to  calculate credit earn::CSPL-00174::100519: Start
                        IF CONFIRM(Text_10003Lbl, FALSE) THEN
                            IF (StudentNo <> '') AND (Sem <> '') THEN
                                StudentSubOldRecCS.CalculateCreditEarnedProcess(StudentNo, Sem)
                            ELSE
                                ERROR('Please Select Student No. & Semester for Credit Earned');
                        // Code added to calculate credit earn ::CSPL-00174::100519: End
                    end;
                }
            }

            group("Roll No Updation")
            {
                Image = Allocate;
                action(UpdateElectiveSubjectsRollNo)
                {
                    Caption = 'Update Elective Subjects RollNo';
                    Image = Allocate;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedIsBig = true;
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        //Code added to update elective subject roll no.::CSPL-00174::100519: Start
                        StudentSubOldRecCS.UpdateElectiveSubjectRollNo(AcademicYear, EvenOddSemester);
                        //Code added to  update Elective Subject Roll No.::CSPL-00174::100519: End
                    end;
                }
                action("UpdateRe-RegistrationSubjectsRollNo")
                {
                    Caption = 'Update Re-Registration Subjects RollNo';
                    Image = Allocate;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedIsBig = true;
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        //Code added to  to update re-registration rubject roll no.::CSPL-00174::100519: Start
                        StudentSubOldRecCS."UpdateRe-RegistrationSubjectRollNo"(AcademicYear);
                        //Code added to  update re-registration subject roll no.  ::CSPL-00174::100519: End
                    end;
                }
            }

            group("Student Rank Updation")
            {
                Image = Allocations;
                action(CalculateSemesterWiseRank)
                {
                    Caption = 'Calculate Semester Wise Rank';
                    Image = Allocations;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedIsBig = true;
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        //Code added to calculate semester wise rank::CSPL-00174::100519: Start
                        IF CONFIRM(Text_10005Lbl, FALSE) THEN
                            IF (AdmittedYear1 <> '') AND (CourseCode1 <> '') AND (Graduation1 <> '') THEN
                                StudentSubOldRecCS.CalculateRankSemesterWise(AdmittedYear1, CourseCode1, Graduation1)
                            ELSE
                                ERROR('Please Select Admitted Year,Course Code & Graduation for Rank Calculate');

                        MESSAGE('Students Calculate Semester Wise Rank  Successfully !!');
                        //Code added to calculate semester wise rank::CSPL-00174::100519: End
                    end;
                }
                action(CalculateOverAllRank)
                {
                    Caption = 'Calculate Over All Rank';
                    Image = Allocations;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedIsBig = true;
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        //Code added to calculate over all rank::CSPL-00174::100519: Start
                        IF CONFIRM(Text_10006Lbl, FALSE) THEN
                            IF (AdmittedYear1 <> '') AND (CourseCode1 <> '') THEN
                                StudentSubOldRecCS.CalculateOverallRank(AdmittedYear1, CourseCode1)
                            ELSE
                                ERROR('Please Select Admitted Year & Course Code for Rank Calculate');

                        MESSAGE('Students Calculate OverAll Rank Successfully !!');
                        //Code added to calculate over all rank::CSPL-00174::100519: End
                    end;
                }
            }

            group("Repeater Grade Report")
            {
                Image = Change;
                action(RepeaterTickForGradeReport)
                {
                    Caption = 'Repeater Tick For Grade Report';
                    Image = Change;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedIsBig = true;
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        //Code added to update grade report and repeater ::CSPL-00174::100519: Start
                        IF CONFIRM(Text_10007Lbl, FALSE) THEN
                            IF (AcademicYear1 <> '') AND (Semester1 <> '') THEN
                                StudentSubOldRecCS."GradeReportRegular&Repeater"(AcademicYear1, Semester1, CurrentSession1, CourseCode1)
                            ELSE
                                ERROR('Please Select Actual Academic Year,Current Session & Actual Semester for Update Repeater in Grade Report ');
                        MESSAGE('Update Repeater in Grade Report Successfully !!');
                        //Code added to update grade report and repeater::CSPL-00174::100519: End
                    end;
                }
                action("Elective Pre_Registration")
                {
                    Caption = 'Elective Pre-Registration';
                    Image = Allocations;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedIsBig = true;
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        //Code added to insert Elective Pre-Registartion record::CSPL-00174::100519: Start
                        StudentSubOldRecCS."ElectivePre-RegistrationAllocation"(AcademicYear1, Graduation1, Sem);
                        //Code added to insert Elective Pre-Registartion record::CSPL-00174::100519: End
                    end;
                }
            }
        }
    }

    var
        StudentMasterCS: Record "Student Master-CS";
        SemesterMasterCS: Record "Semester Master-CS";
        StudentSubOldRecCS: Codeunit "Student Sub. Old Rec-CS";
        StudentNo: Code[20];

        Sem: Code[10];
        AcademicYear: Code[20];
        EvenOddSemester: Option " ","Even Semester","Odd Semester";

        AdmittedYear1: Code[20];
        CourseCode1: Code[10];
        Graduation1: Code[10];
        AcademicYear1: Code[20];
        Semester1: Code[10];
        CurrentSession1: Code[20];
        EnrollmentNo: Code[20];
        Text_10002Lbl: Label 'Do You Want To Calculate Student CGPA ?';
        Text_10003Lbl: Label 'Do You Want To Calculate Student Credit Earned ?';
        Text_10001Lbl: Label 'Do You Want To Calculate Student GPA ?';

        Text_10005Lbl: Label 'Do You Want To Calculate Student Rank ?';
        Text_10006Lbl: Label 'Do You Want To Calculate OverAll Rank ?';

        Text_10007Lbl: Label 'Do You Want To Update Repeater for Grade Report ?';


    procedure GetData(StudentNoValue: Code[20])
    begin
        //Code added for  get value of StudentNo::CSPL-00174::100519: Start
        StudentNo := StudentNoValue;
        //Code added for  get value of StudentNo::CSPL-00174::100519: End
    end;
}