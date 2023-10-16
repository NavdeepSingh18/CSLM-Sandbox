page 50019 StudentGPACalculation
{
    PageType = List;
    ApplicationArea = All;
    Caption = 'Student GPA Calculation';
    UsageCategory = Lists;
    SourceTable = "Student Master-CS";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    Editable = False;
    //CardPageId = "Student Detail Card-CS";

    layout
    {
        area(Content)
        {
            field(StudentFilter; StudentFilter)
            {
                Caption = 'Filter Student No.';
                TableRelation = "Student Master-CS";
                Visible = False;
            }
            repeater(GroupName)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;

                }
                field("Enrollment No."; Rec."Enrollment No.")
                {
                    ApplicationArea = all;
                }
                Field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = all;
                }
                field("Calc. Semester I GPA"; Rec."Calc. Semester I GPA")
                {
                    ApplicationArea = all;
                    Style = Strong;
                }
                field("Semester I GPA"; Rec."Semester I GPA")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Calc. Semester II GPA"; Rec."Calc. Semester II GPA")
                {
                    ApplicationArea = all;
                    Style = Strong;
                }
                field("Semester II GPA"; Rec."Semester II GPA")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Calc. Semester III GPA"; Rec."Calc. Semester III GPA")
                {
                    ApplicationArea = all;
                    Style = Strong;
                }
                field("Semester III GPA"; Rec."Semester III GPA")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Calc. Semester IV GPA"; Rec."Calc. Semester IV GPA")
                {
                    ApplicationArea = all;
                    Style = Strong;
                }
                field("Semester IV GPA"; Rec."Semester IV GPA")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Calc. Semester V GPA"; Rec."Calc. Semester V GPA")
                {
                    ApplicationArea = all;
                    Style = Strong;
                }
                field("Semester V GPA"; Rec."Semester V GPA")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Calc. Semester VI GPA"; Rec."Calc. Semester VI GPA")
                {
                    ApplicationArea = all;
                    Style = Strong;
                }
                field("Semester VI GPA"; Rec."Semester VI GPA")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Calc. Semester VII GPA"; Rec."Calc. Semester VII GPA")
                {
                    ApplicationArea = all;
                    Style = Strong;
                }
                field("Semester VII GPA"; Rec."Semester VII GPA")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Calc. Semester VIII GPA"; Rec."Calc. Semester VIII GPA")
                {
                    ApplicationArea = all;
                    Style = Strong;
                }
                field("Semester VIII GPA"; Rec."Semester VIII GPA")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Calc. Semester IX GPA"; Rec."Calc. Semester IX GPA")
                {
                    ApplicationArea = all;
                    Style = Strong;
                }
                field("Semester IX GPA"; Rec."Semester IX GPA")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                Field("Calc. GPA"; Rec."Calc. GPA")
                {
                    ApplicationArea = all;
                    Editable = False;
                    Style = Strong;
                    Caption = 'Calc. CGPA';

                }
                Field(CGPA; Rec.CGPA)
                {
                    ApplicationArea = all;
                    Editable = False;
                }
                Field("Multiple Enrollment CGPA"; Rec."Multiple Enrollment CGPA")
                {
                    ApplicationArea = all;
                    Editable = False;
                }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action("Student Card")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedOnly = true;
                RunObject = page "Student Detail Card-CS";
                PromotedCategory = Process;
                // RunPageLink = "No." = Field("No.");
            }

            action("Clear Term GPA")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                Visible = False;
                trigger OnAction()
                begin
                    Rec."Calc. Semester I GPA" := 0;
                    Rec."Calc. Semester II GPA" := 0;
                    Rec."Calc. Semester III GPA" := 0;
                    Rec."Calc. Semester IV GPA" := 0;
                    Rec."Calc. Semester V GPA" := 0;
                    Rec."Calc. Semester VI GPA" := 0;
                    Rec."Calc. Semester VII GPA" := 0;
                    Rec."Calc. Semester VIII GPA" := 0;
                    Rec."Calc. Semester IX GPA" := 0;
                    Rec."Calc. GPA" := 0;
                    Rec."Semester I GPA" := 0;
                    Rec."Semester II GPA" := 0;
                    Rec."Semester III GPA" := 0;
                    Rec."Semester IV GPA" := 0;
                    Rec."Semester V GPA" := 0;
                    Rec."Semester VI GPA" := 0;
                    Rec."Semester VII GPA" := 0;
                    Rec."Semester VIII GPA" := 0;
                    Rec."Semester IX GPA" := 0;
                    Rec.CGPA := 0;
                    Rec.Modify();
                    CurrPage.Update();
                end;

            }

            action("Calculate GPA")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedOnly = true;
                Image = Calculate;
                PromotedCategory = Process;
                trigger OnAction();
                var
                    StudSub: Record "Main Student Subject-CS";
                    CSemester: Record "Course Sem. Master-CS";
                    // CSubject: Record "Course Wise Subject Line-CS";
                    CourseMasterRec: Record "Course Master-CS";
                    CourseMasterRec1: Record "Course Master-CS";
                    Stud: Record "Student Master-CS";
                    StudentMaster: Record "Student Master-CS";
                    Grade: Record "Grade Master-CS";
                    UserSetupRec: Record "User Setup";
                    GradePointsArr: Array[9] of Decimal;
                    CreditAttemptArr: array[9] of Decimal;
                    GPA: array[9] of Decimal;
                    Text001Lbl: Label 'Students No.     ############1################\';
                    WindowDialog: Dialog;
                    Ctr: Integer;
                    CtrTot: Integer;
                    SemesterTxt: Code[20];
                    MultipleEnrollmentBool: Boolean;
                    Int: Integer;
                    TotQualityPoint: Decimal;
                    TotCreditAttempt: Decimal;
                    CourseFilter: Text;
                begin
                    UserSetupRec.Reset();
                    UserSetupRec.SetRange("User ID", UserId());
                    IF UserSetupRec.FindFirst() then
                        IF Not UserSetupRec."GPA Calculation Allowed" then
                            Error('You do not have permission to Calculate Student GPA.');

                    If Confirm('Do you want to Calculate GPA?', true) then begin
                        WindowDialog.Open('Updating  GPA\' + Text001Lbl);
                        Stud.Reset();
                        CurrPage.SetSelectionFilter(Stud);
                        CtrTot := Stud.Count();
                        if Stud.FindSet() then begin
                            repeat
                                Int := 0;
                                Ctr += 1;
                                WindowDialog.Update(1, Stud."No." + ' ' + format(Ctr) + ' of ' + Format(CtrTot));
                                MultipleEnrollmentBool := false;
                                CourseMasterRec1.Reset();
                                CourseMasterRec1.SetRange(Code, Stud."Course Code");
                                IF CourseMasterRec1.FindFirst() then
                                    IF CourseMasterRec1."Transcript Data Filter" then
                                        MultipleEnrollmentBool := true;

                                If MultipleEnrollmentBool then begin
                                    CourseFilter := '';
                                    CourseMasterRec.Reset();
                                    CourseMasterRec.SetRange("Transcript Data Filter", true);
                                    IF CourseMasterRec.FindSet() then begin
                                        repeat

                                            IF CourseFilter = '' then
                                                CourseFilter := CourseMasterRec.Code
                                            Else
                                                CourseFilter += '|' + CourseMasterRec.Code;
                                        until CourseMasterRec.Next() = 0;
                                    end;
                                end;
                                if (Stud."Course Code" <> '') and (Stud.Status <> '') then begin
                                    StudentMaster.Reset();
                                    If not MultipleEnrollmentBool then begin
                                        StudentMaster.SetRange("Enrollment No.", Stud."Enrollment No.");
                                        StudentMaster.SetRange("Course Code", Stud."Course Code");
                                    end;
                                    If MultipleEnrollmentBool then begin
                                        StudentMaster.SetRange("Original Student No.", Stud."Original Student No.");
                                        StudentMaster.SetFilter("Course Code", CourseFilter);
                                    end;
                                    StudentMaster.SetRange("Global Dimension 1 Code", Stud."Global Dimension 1 Code");
                                    If StudentMaster.FindSet() then begin
                                        repeat
                                            Clear(GradePointsArr);
                                            Clear(CreditAttemptArr);
                                            Clear(GPA);
                                            SemesterTxt := '';
                                            TotQualityPoint := 0;
                                            TotCreditAttempt := 0;

                                            StudSub.Reset();
                                            StudSub.SetCurrentKey(Semester);
                                            If MultipleEnrollmentBool then begin
                                                StudSub.SetRange("Original Student No.", StudentMaster."Original Student No.");
                                                StudSub.SetFilter(Course, CourseFilter);
                                            end;
                                            If not MultipleEnrollmentBool then begin
                                                StudSub.SetRange(Course, StudentMaster."Course Code");
                                                StudSub.SetRange("Student No.", StudentMaster."No.");
                                            end;
                                            StudSub.SetFilter(Grade, '<>%1&<>%2&<>%3&<>%4&<>%5', '', 'X', 'M', 'UC', 'SC');
                                            Studsub.Setfilter(Semester, '<>%1', '');
                                            StudSub.SetFilter("Level Description", '<>%1&<>%2', StudSub."Level Description"::"Level 2 Clinical Rotation", StudSub."Level Description"::"Level 2 Elective Rotation");
                                            StudSub.SetRange(TC, false);
                                            if StudSub.FindSet() then
                                                repeat
                                                    Int := Studsub.Sequence;
                                                    SemesterTxt := Studsub.Semester;
                                                    IF SemesterTxt = StudSub.Semester then begin
                                                        Grade.Reset();
                                                        Grade.SetRange(Code, StudSub.Grade);
                                                        Grade.SetRange("Global Dimension 1 Code", StudSub."Global Dimension 1 Code");
                                                        if Grade.FindFirst() then begin
                                                            If Grade."Consider for GPA" then begin
                                                                CreditAttemptArr[Int] += StudSub."Credits Attempt"; //for non Clinicals
                                                                TotCreditAttempt += StudSub."Credits Attempt";
                                                            end;
                                                            GradePointsArr[Int] += Grade."Grade Points" * StudSub."Credits Attempt";
                                                            TotQualityPoint += Grade."Grade Points" * StudSub."Credits Attempt";
                                                        end;

                                                        // if ((Grade."Grade Points" * StudSub."Credit Earned") = 0) or (StudSub."Credit Earned" = 0) then
                                                        //     Error('Earned Credits %4..%5...Sequence %6.... not matching Student %1..Semester %2..Grade %3', StudSub."Student No.", StudSub.Semester, StudSub.Grade, StudSub."Credit Earned", Grade.Description,
                                                        //         StudSub.Sequence);

                                                    end;
                                                until StudSub.Next() = 0;

                                            StudSub.Reset();
                                            If MultipleEnrollmentBool then begin
                                                StudSub.SetRange("Original Student No.", StudentMaster."Original Student No.");
                                                StudSub.SetFilter(Course, CourseFilter);
                                            end;
                                            If not MultipleEnrollmentBool then begin
                                                StudSub.SetRange(Course, StudentMaster."Course Code");
                                                StudSub.SetRange("Student No.", StudentMaster."No.");
                                            end;
                                            StudSub.SetFilter(Grade, '<>%1&<>%2&<>%3&<>%4&<>%5', '', 'X', 'M', 'UC', 'SC');
                                            StudSub.SetFilter("Level Description", '%1|%2', StudSub."Level Description"::"Level 2 Clinical Rotation", StudSub."Level Description"::"Level 2 Elective Rotation");
                                            StudSub.SetRange(TC, false);
                                            if StudSub.FindSet() then
                                                repeat
                                                    Int := 9;
                                                    Grade.Reset();
                                                    Grade.SetRange(Code, StudSub.Grade);
                                                    Grade.SetRange("Global Dimension 1 Code", StudSub."Global Dimension 1 Code");
                                                    if Grade.FindFirst() then begin
                                                        If Grade."Consider for GPA" then begin
                                                            CreditAttemptArr[Int] += StudSub."Credits Attempt"; //for Clinicals
                                                            TotCreditAttempt += StudSub."Credits Attempt";
                                                        end;
                                                        GradePointsArr[Int] += Grade."Grade Points" * StudSub."Credits Attempt";
                                                        TotQualityPoint += Grade."Grade Points" * StudSub."Credits Attempt";
                                                    end;
                                                // if ((Grade."Grade Points" * StudSub."Credit Earned") = 0) or (StudSub."Credit Earned" = 0) then
                                                //     Error('Earned Credits %4..%5...Sequence %6.... not matching Student %1..Semester %2..Grade %3', StudSub."Student No.", StudSub.Semester, StudSub.Grade, StudSub."Credit Earned", Grade.Description,
                                                //         StudSub.Sequence);


                                                until StudSub.Next() = 0;
                                            if CreditAttemptArr[1] <> 0 then
                                                StudentMaster."Calc. Semester I GPA" := Round(GradePointsArr[1] / CreditAttemptArr[1]);
                                            if CreditAttemptArr[2] <> 0 then
                                                StudentMaster."Calc. Semester II GPA" := Round(GradePointsArr[2] / CreditAttemptArr[2]);
                                            if CreditAttemptArr[3] <> 0 then
                                                StudentMaster."Calc. Semester III GPA" := Round(GradePointsArr[3] / CreditAttemptArr[3]);
                                            if CreditAttemptArr[4] <> 0 then
                                                StudentMaster."Calc. Semester IV GPA" := Round(GradePointsArr[4] / CreditAttemptArr[4]);
                                            if CreditAttemptArr[5] <> 0 then
                                                StudentMaster."Calc. Semester V GPA" := ROund(GradePointsArr[5] / CreditAttemptArr[5]);
                                            if CreditAttemptArr[6] <> 0 then
                                                StudentMaster."Calc. Semester VI GPA" := Round(GradePointsArr[6] / CreditAttemptArr[6]);
                                            if CreditAttemptArr[7] <> 0 then
                                                StudentMaster."Calc. Semester VII GPA" := Round(GradePointsArr[7] / CreditAttemptArr[7]);
                                            if CreditAttemptArr[8] <> 0 then
                                                StudentMaster."Calc. Semester VIII GPA" := Round(GradePointsArr[8] / CreditAttemptArr[8]);
                                            if CreditAttemptArr[9] <> 0 then
                                                StudentMaster."Calc. Semester IX GPA" := Round(GradePointsArr[9] / CreditAttemptArr[9]);
                                            If TotCreditAttempt <> 0 then
                                                StudentMaster."Calc. GPA" := Round(TotQualityPoint / TotCreditAttempt);
                                            StudentMaster."Multiple Enrollment CGPA" := StudentMaster."Calc. GPA";
                                            StudentMaster.Modify();
                                        until StudentMaster.Next() = 0;
                                    end;

                                end;
                            until Stud.Next() = 0;
                            WindowDialog.Close();
                            Message('GPA is calculated. Please click on Confirm GPA');
                        end
                    end ELse
                        exit;
                end;
            }

            Action("Confirm GPA")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedOnly = true;
                Image = UpdateUnitCost;
                PromotedCategory = Process;
                trigger OnAction()
                Var
                    StudentMaster_lRec: Record "Student Master-CS";
                    UserSetup_lRec: Record "User Setup";
                    Text001Lbl: Label 'Students No.     ############1################\';
                    WindowDialog: Dialog;
                    Ctr: Integer;
                    CtrTot: Integer;
                Begin
                    UserSetup_lRec.Reset();
                    UserSetup_lRec.SetRange("User ID", UserId());
                    IF UserSetup_lRec.FindFirst() then
                        IF Not UserSetup_lRec."GPA Calculation Allowed" then
                            Error('You do not have permission for Calculate Student GPA.');

                    IF Confirm('Do you want to Confirm GPA?', true) then begin

                        WindowDialog.Open('Updating  GPA\' + Text001Lbl);
                        StudentMaster_lRec.Reset();
                        CurrPage.SetSelectionFilter(StudentMaster_lRec);
                        CtrTot := StudentMaster_lRec.Count();
                        If StudentMaster_lRec.FindSet() then begin
                            repeat
                                WindowDialog.Update(1, StudentMaster_lRec."No." + format(Ctr) + ' of ' + Format(CtrTot));
                                Ctr += 1;
                                StudentMaster_lRec."Semester I GPA" := StudentMaster_lRec."Calc. Semester I GPA";
                                StudentMaster_lRec."Semester II GPA" := StudentMaster_lRec."Calc. Semester II GPA";
                                StudentMaster_lRec."Semester III GPA" := StudentMaster_lRec."Calc. Semester III GPA";
                                StudentMaster_lRec."Semester IV GPA" := StudentMaster_lRec."Calc. Semester IV GPA";
                                StudentMaster_lRec."Semester V GPA" := StudentMaster_lRec."Calc. Semester V GPA";
                                StudentMaster_lRec."Semester VI GPA" := StudentMaster_lRec."Calc. Semester VI GPA";
                                StudentMaster_lRec."Semester VII GPA" := StudentMaster_lRec."Calc. Semester VII GPA";
                                StudentMaster_lRec."Semester VIII GPA" := StudentMaster_lRec."Calc. Semester VIII GPA";
                                StudentMaster_lRec."Semester IX GPA" := StudentMaster_lRec."Calc. Semester IX GPA";
                                StudentMaster_lRec.CGPA := StudentMaster_lRec."Calc. GPA";
                                StudentMaster_lRec."Multiple Enrollment CGPA" := StudentMaster_lRec.CGPA;
                                StudentMaster_lRec.Modify();
                            until StudentMaster_lRec.Next() = 0;

                            StudentHonors(Rec."No.");

                            WindowDialog.Close();
                            Message('GPA is confirmed.');
                        end;
                    end ELse
                        exit;
                End;
            }

            action("Student Subject")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedOnly = true;
                RunObject = page "Subject Student-CS";
                PromotedCategory = Process;
                RunPageLink = "Student No." = field("No.");
            }


        }
    }
    Procedure StudentHonors(StudentNo: Code[20])
    Var

        StudentMasterRec: Record "Student Master-CS";
    begin
        StudentMasterRec.Reset();
        StudentMasterRec.Get(StudentNo);
        If StudentMasterRec.CGPA > 0 then begin
            StudentMasterRec.StudentHonorsInsert(StudentMasterRec."No.", StudentMasterRec.CGPA);

        end;// Else
        //Error('CGPA is 0 for this Student No. : %1', StudentNo);


    end;

    var
        StudentFilter: Code[20];
}