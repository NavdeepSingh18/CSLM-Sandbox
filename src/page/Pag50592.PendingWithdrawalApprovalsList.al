Page 50592 "Pending Withdrawal Approvals"
{

    PageType = List;
    SourceTable = "Withdrawal Approvals";
    SourceTableView = where("Type of Withdrawal" = filter("Course-Withdrawal"), Status = FILTER("Pending for Approval"));
    Caption = 'Pending Course Withdrawal Approvals List';
    ApplicationArea = All;
    UsageCategory = Administration;
    Editable = false;
    // CardPageId = "Withdrawal Approval Card";
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Withdrawal No."; Rec."Withdrawal No.")
                {
                    ApplicationArea = All;
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = All;
                }
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                }
                field("Enrolment No."; Rec."Enrolment No.")
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                field("Withdrawal Date"; Rec."Withdrawal Date")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Course; Rec.Course)
                {
                    ApplicationArea = All;
                }
                field("Reason Code"; Rec."Reason Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Reason for Leaving"; Rec."Reason for Leaving")
                {
                    ApplicationArea = All;
                }
                field("Approved for Department"; Rec."Approved for Department")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Final Approval"; Rec."Final Approval")
                {
                    ApplicationArea = All;
                }
                field("Waiver Calculation Allowed"; Rec."Waiver Calculation Allowed")
                {
                    ApplicationArea = All;
                    visible = false;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Student Card")
            {
                ApplicationArea = All;
                Image = Card;
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Caption = 'Student Card';
                Runobject = page "Student Detail Card-CS";
                RunPageLink = "No." = FIELD("Student No.");
            }
            action("Withdrawal Details")
            {
                ApplicationArea = All;
                Image = ViewDetails;
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Caption = 'Withdrawal Details';
                // trigger OnAction()
                // var
                //     WithdrawalRec: Record "Withdrawal Student-CS";
                //     StudCollegeWithdrawal: Page "Stud. College Withdrawal-CS";
                //     StudCourseWithdrawal: Page "Stud. Withdrawal-CS";
                // begin
                //     WithdrawalRec.Reset();
                //     WithdrawalRec.SetRange("No.", Rec."Withdrawal No.");
                //     IF WithdrawalRec.FindFirst() then
                //         Case Rec."Type of Withdrawal" of
                //             Rec."Type of Withdrawal"::"Course-Withdrawal":
                //                 begin
                //                     StudCourseWithdrawal.SetTableView(WithdrawalRec);
                //                     StudCourseWithdrawal.Editable := False;
                //                     StudCourseWithdrawal.Run();
                //                 end;
                //             Rec."Type of Withdrawal"::"College-Withdrawal":
                //                 begin
                //                     StudCollegeWithdrawal.SetTableView(WithdrawalRec);
                //                     StudCollegeWithdrawal.Editable := false;
                //                     StudCollegeWithdrawal.Run();
                //                 end;
                //         end;
                // end;
            }
            action("&Approve")
            {
                ApplicationArea = All;
                Caption = 'Approve';
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                visible = false;
                trigger OnAction()
                var
                    RecStudent: Record "Student Master-CS";
                    LeavesApprovals: Record "Withdrawal Approvals";
                    WithdrawalDepartment: Record "Withdrawal Department";
                    WithdrawalDepartment1: Record "Withdrawal Department";
                    Int: Integer;
                    Int1: Integer;
                begin
                    IF CONFIRM(Text001Lbl, FALSE, Rec."Withdrawal No.") THEN BEGIN
                        if Rec.Status = Rec.Status::Approved then
                            Error('Status is already Approved');

                        IF Rec."Final Approval" then begin
                            WithdrawalApprovalRec.Reset();
                            WithdrawalApprovalRec.SetRange("Student No.", Rec."Student No.");
                            WithdrawalApprovalRec.SetFilter("Status", '<>%1', WithdrawalApprovalRec.Status::Approved);
                            WithdrawalApprovalRec.SetRange("Final Approval", false);
                            IF WithdrawalApprovalRec.findfirst() then
                                repeat
                                    error('Please check approval status for Department Code: %1', WithdrawalApprovalRec."Approved for Department");
                                until WithdrawalApprovalRec.Next() = 0;
                        end;
                        //Gourav 11.4.22
                        WithdrawalDepartment.Reset();
                        WithdrawalDepartment.SetRange("Department Code", Rec."Approved for Department");
                        WithdrawalDepartment.SetRange("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
                        IF Rec."Type of Withdrawal" IN [Rec."Type of Withdrawal"::"Course-Withdrawal", Rec."Type of Withdrawal"::"College-Withdrawal"] then
                            WithdrawalDepartment.setrange("Document Type", WithdrawalDepartment."Document Type"::Withdrawal);
                        IF WithdrawalDepartment.FindFirst() then begin
                            rec.sequence := WithdrawalDepartment.Sequence;
                            rec.Modify();
                            IF (WithdrawalDepartment.Sequence > 1) then begin
                                Int1 := 1;
                                For Int := WithdrawalDepartment.Sequence Downto Int1 do begin
                                    WithdrawalDepartment1.Reset();
                                    WithdrawalDepartment1.SetRange("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
                                    WithdrawalDepartment1.SetRange("Document Type", WithdrawalDepartment."Document Type");
                                    WithdrawalDepartment1.SetRange(Sequence, Int - 1);
                                    IF WithdrawalDepartment1.FindFirst() then begin
                                        LeavesApprovals.Reset();
                                        LeavesApprovals.SetRange("Approved for Department", WithdrawalDepartment1."Department Code");
                                        LeavesApprovals.SetRange("Type of Withdrawal", Rec."Type of Withdrawal");
                                        LeavesApprovals.SetRange("Withdrawal No.", Rec."Withdrawal No.");
                                        If LeavesApprovals.FindFirst() then
                                            Error('Department approval has been pending from %1', LeavesApprovals."Department Name");
                                    end;
                                end;
                            End;
                            //SendForApproval_gFnc(Rec);

                            //End //GMCS//11//4//2022

                        end;
                        Rec.Status := Rec.Status::Approved;
                        Rec.Modify();
                        WithdrawalApprovalRec.Reset();
                        WithdrawalApprovalRec.SetRange("Withdrawal No.", Rec."Withdrawal No.");
                        WithdrawalApprovalRec.SetFilter(WithdrawalApprovalRec.Status, '<>%1', WithdrawalApprovalRec.Status::Approved);
                        if not WithdrawalApprovalRec.FindFirst() then begin
                            WithdrawalStudentRec.Reset();
                            WithdrawalStudentRec.SetRange("No.", Rec."Withdrawal No.");
                            if WithdrawalStudentRec.FindFirst() then begin
                                WithdrawalStudentRec."Withdrawal Status" := WithdrawalStudentRec."Withdrawal Status"::Approved;
                                WithdrawalStudentRec.Modify();
                            end;
                        end;
                        IF Rec."Final Approval" = true then begin
                            RecStudent.Get(Rec."Student No.");
                            WithdrawalCreditMemoCreation(Rec."Student No.", Rec.Course, RecStudent."Academic Year", RecStudent.Semester);
                        end;
                        Message(Text002Lbl, Rec."Withdrawal No.");
                        StudentTimeLineRec.InsertRecordFun(Rec."Student No.", Rec."Student Name", Format(Rec."Type of Withdrawal") + ' ' + Rec."Withdrawal No." + ' is Approved', USerID(), Today());//CSPL00307-12-10-21




                    end;



                end;
            }
            action("&Reject")
            {
                ApplicationArea = All;
                Caption = 'Reject';
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                visible = false;
                trigger OnAction()
                begin
                    IF CONFIRM(Text003Lbl, FALSE, Rec."Withdrawal No.") THEN BEGIN
                        if Rec.Status = Rec.Status::Approved then
                            Error('Approved Application cannot be Rejected');
                        IF Rec."Final Approval" = true then
                            Error('Final Approval must be false, you cannot reject');
                        Rec.Status := Rec.Status::Rejected;
                        Rec.Modify();
                        WithdrawalStudentRec.Reset();
                        WithdrawalStudentRec.SetRange("No.", Rec."Withdrawal No.");
                        if WithdrawalStudentRec.FindFirst() then begin
                            WithdrawalStudentRec."Withdrawal Status" := WithdrawalStudentRec."Withdrawal Status"::Rejected;
                            WithdrawalStudentRec.Modify();
                            StudentTimeLineRec.InsertRecordFun(Rec."Student No.", Rec."Student Name", Format(Rec."Type of Withdrawal") + ' ' + Rec."Withdrawal No." + ' is Rejected', USerID(), Today());//CSPL00307-12-10-21
                        end;
                        // WithdrawalRejectionMail("Student No.");
                        Message(Text004Lbl, Rec."Withdrawal No.");
                    end;
                end;
            }

        }
    }
    trigger OnOpenPage()
    var
        WithdrawalDepartmentRec: Record "Withdrawal Department";
        UserSetupRec: Record "User Setup";
        EducationSetupRec: Record "Education Setup-CS";
        StudentsInfoCSCSLM: codeunit StudentsInfoCSCSLM;
        DepartmentName: Text;
        PrevDepart: Text;
    begin
        UserSetupRec.Get(UserId());
        /*
        EducationSetupRec.Reset();
        EducationSetupRec.SetRange("Global Dimension 1 Code", UserSetupRec."Global Dimension 1 Code");
        EducationSetupRec.FindFirst();
        if EducationSetupRec."Course Withdrawal Applicable" = false then
            Error('Course withdrawal is not applicable for the Institute %1', UserSetupRec."Global Dimension 1 Code");
        */
        //CSPL-00307-T1-T1516-CR Start
        Clear(DepartmentName);
        WithdrawalDepartmentRec.Reset();
        WithdrawalDepartmentRec.SetFilter("Document Type", '%1|%2', WithdrawalDepartmentRec."Document Type"::Withdrawal, WithdrawalDepartmentRec."Document Type"::"Withdrawal CLN");//CSPL-00307-T1-T1516-CR
        // WithdrawalDepartmentRec.SetRange("Type of Withdrawal", "Type of Withdrawal");
        // WithdrawalDepartmentRec.SetRange("Global Dimension 1 Code", UserSetupRec."Global Dimension 1 Code");
        IF WithdrawalDepartmentRec.GetUserGroup() <> '' then
            WithdrawalDepartmentRec.SetFilter("User Name", WithdrawalDepartmentRec.GetUserGroup())
        else
            WithdrawalDepartmentRec.SetFilter("User Name", '%1', '');
        IF WithdrawalDepartmentRec.FindSet() then begin
            repeat
                if PrevDepart <> WithdrawalDepartmentRec."Department Code" then begin
                    PrevDepart := WithdrawalDepartmentRec."Department Code";
                    IF DepartmentName = '' then
                        DepartmentName := WithdrawalDepartmentRec."Department Code"
                    ELSE
                        DepartmentName += '|' + WithdrawalDepartmentRec."Department Code";
                end;
            Until WithdrawalDepartmentRec.Next() = 0;
        end;

        Rec.FILTERGROUP(2);
        IF DepartmentName <> '' then
            Rec.SetFilter("Approved for Department", DepartmentName)
        else
            Rec.SetFilter("Approved for Department", '%1', '');
        Rec.FILTERGROUP(0);
        //CSPL-00307-T1-T1516-CR ends
        //SD-SN-17-Dec-2020 +
        Rec.FilterGroup(3);
        Rec.SetFilter("Global Dimension 1 Code", StudentsInfoCSCSLM.GetuserSetupInstitudeCode());
        Rec.FilterGroup(5);
        //SD-SN-17-Dec-2020 -
    end;

    procedure WithdrawalCreditMemoCreation(StudentNo: Code[20]; CourseCode: Code[20]; AcademicYear: Code[20]; Semester: Code[10])
    var
        EducationMultiEventCalCS: Record "Education Multi Event Cal-CS";
        EducationSetupCS: Record "Education Setup-CS";
        StudentRec: Record "Student Master-CS";
        RecFeeCourseHdr: Record "Fee Course Head-CS";
        RecFeeCourseLine: Record "Fee Course Line-CS";
        RecSAPFeeCode: Record "SAP Fee Code";
        CourseRec: Record "Course Master-CS";
        recClassAttendanceLine: Record "Class Attendance Line-CS";
        AmountFinalCal: Decimal;
        MultCalenderDayCal: Integer;
        WithdrawalDayCalculation: Integer;
        PerFinal: Decimal;
        FinalDay: Integer;
        AmountSum: Decimal;

    begin
        MultCalenderDayCal := 0;
        WithdrawalDayCalculation := 0;
        PerFinal := 0;
        FinalDay := 0;
        StudentRec.get(StudentNo);
        EducationSetupCS.RESET();
        EducationSetupCS.SETRANGE("Global Dimension 1 Code", StudentRec."Global Dimension 1 Code");
        IF EducationSetupCS.FINDFIRST() THEN
            IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::SPRING THEN BEGIN
                EducationMultiEventCalCS.RESET();
                EducationMultiEventCalCS.Setfilter("Event Code", '%1', Format(EducationSetupCS."Even/Odd Semester"::SPRING));
                EducationMultiEventCalCS.SETRANGE("Academic Year", StudentRec."Academic Year");
                IF EducationMultiEventCalCS.FINDFIRST() THEN BEGIN
                    IF EducationSetupCS."Withdrawal End Date" = EducationSetupCS."Withdrawal End Date"::" " then
                        Error('Withdrawal End Date Calculation must not be blank');
                    EducationSetupCS.TestField(EducationSetupCS."Withdrawal Percentage");
                    IF EducationSetupCS."Withdrawal End Date" = EducationSetupCS."Withdrawal End Date"::"Apply Date" then Begin
                        MultCalenderDayCal := (EducationMultiEventCalCS."Revised End Date") - (EducationMultiEventCalCS."Start Date");
                        WithdrawalDayCalculation := (Rec."Application Date") - (EducationMultiEventCalCS."Start Date");
                    End else
                        IF EducationSetupCS."Withdrawal End Date" = EducationSetupCS."Withdrawal End Date"::"Attendance Date" then begin
                            RecClassAttendanceLine.Reset();
                            RecClassAttendanceLine.SetRange("Student No.", StudentNo);
                            RecClassAttendanceLine.SetRange(Semester, Semester);
                            RecClassAttendanceLine.SetRange("Academic Year", AcademicYear);
                            RecClassAttendanceLine.SetRange("Attendance Type", RecClassAttendanceLine."Attendance Type"::Present);
                            IF recClassAttendanceLine.FindLast() then begin
                                MultCalenderDayCal := (EducationMultiEventCalCS."Revised End Date") - (EducationMultiEventCalCS."Start Date");
                                WithdrawalDayCalculation := (recClassAttendanceLine.Date) - (EducationMultiEventCalCS."Start Date");
                            end;
                        end;
                    FinalDay := MultCalenderDayCal - WithdrawalDayCalculation;
                    PerFinal := (FinalDay * 100) / MultCalenderDayCal;
                    IF PerFinal >= EducationSetupCS."Withdrawal Percentage" then begin
                        RecFeeCourseHdr.reset();
                        RecFeeCourseHdr.Setrange("Course Code", CourseCode);
                        RecFeeCourseHdr.SetRange("Academic Year", AcademicYear);
                        RecFeeCourseHdr.SETRANGE("Global Dimension 1 Code", StudentRec."Global Dimension 1 Code");
                        RecFeeCourseHdr.SETRANGE("Other Fees", false);
                        CourseRec.Get(CourseCode);
                        If CourseRec."Admitted Year Wise Fee" then
                            RecFeeCourseHdr.SETRANGE(RecFeeCourseHdr."Admitted Year", StudentRec."Admitted Year");
                        If CourseRec."Semester Wise Fee" then
                            RecFeeCourseHdr.SETRANGE(RecFeeCourseHdr.Semester, Semester);
                        RecFeeCourseHdr.SETRANGE(Year, StudentRec.Year);
                        IF RecFeeCourseHdr.FindFirst() then begin
                            AmountSum := 0;
                            AmountFinalCal := 0;
                            RecFeeCourseLine.Reset();
                            RecFeeCourseLine.SetRange("Document No.", RecFeeCourseHdr."No.");
                            IF RecFeeCourseLine.FindFirst() then begin
                                Repeat
                                    RecSAPFeeCode.Reset();
                                    RecSAPFeeCode.SetRange("SAP Code", RecFeeCourseLine."Fee Code");
                                    RecSAPFeeCode.SetFilter("Fee Group", '%1', RecSAPFeeCode."Fee Group"::Institutional);
                                    if RecSAPFeeCode.FindFirst() then
                                        AmountSum += RecFeeCourseLine.Amount;
                                until RecFeeCourseLine.Next() = 0;
                                AmountFinalCal := (AmountSum * PerFinal) / 100;
                            end;
                            WithdrawalStudentRec.Reset();
                            WithdrawalStudentRec.SetRange("No.", Rec."Withdrawal No.");
                            if WithdrawalStudentRec.FindFirst() then;
                            IF AmountFinalCal <> 0 then
                                CreditMemoGenJournalLineInsert(StudentNo, AmountFinalCal, WithdrawalStudentRec."Reason for Leaving");
                        end;
                    end;
                END;
            END ELSE
                IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::FALL THEN BEGIN
                    EducationMultiEventCalCS.RESET();
                    EducationMultiEventCalCS.Setfilter("Event Code", '%1', Format(EducationSetupCS."Even/Odd Semester"::FALL));
                    EducationMultiEventCalCS.SETRANGE("Academic Year", StudentRec."Academic Year");
                    IF EducationMultiEventCalCS.FINDFIRST() THEN BEGIN
                        IF EducationSetupCS."Withdrawal End Date" = EducationSetupCS."Withdrawal End Date"::" " then
                            Error('Withdrawal End Date Calculation must not be blank');
                        EducationSetupCS.TestField(EducationSetupCS."Withdrawal Percentage");
                        IF EducationSetupCS."Withdrawal End Date" = EducationSetupCS."Withdrawal End Date"::"Apply Date" then Begin
                            MultCalenderDayCal := (EducationMultiEventCalCS."Revised End Date") - (EducationMultiEventCalCS."Start Date");
                            WithdrawalDayCalculation := (Rec."Application Date") - (EducationMultiEventCalCS."Start Date");
                        End else
                            IF EducationSetupCS."Withdrawal End Date" = EducationSetupCS."Withdrawal End Date"::"Attendance Date" then begin
                                RecClassAttendanceLine.Reset();
                                RecClassAttendanceLine.SetRange("Student No.", StudentNo);
                                RecClassAttendanceLine.SetRange(Semester, Semester);
                                RecClassAttendanceLine.SetRange("Academic Year", AcademicYear);
                                RecClassAttendanceLine.SetRange("Attendance Type", RecClassAttendanceLine."Attendance Type"::Present);
                                IF recClassAttendanceLine.FindLast() then begin
                                    MultCalenderDayCal := (EducationMultiEventCalCS."Revised End Date") - (EducationMultiEventCalCS."Start Date");
                                    WithdrawalDayCalculation := (recClassAttendanceLine.Date) - (EducationMultiEventCalCS."Start Date");
                                end;
                            end;

                        FinalDay := MultCalenderDayCal - WithdrawalDayCalculation;
                        PerFinal := (FinalDay * 100) / MultCalenderDayCal;
                        IF PerFinal >= EducationSetupCS."Withdrawal Percentage" then begin
                            RecFeeCourseHdr.reset();
                            RecFeeCourseHdr.Setrange("Course Code", CourseCode);
                            RecFeeCourseHdr.SetRange("Academic Year", AcademicYear);
                            RecFeeCourseHdr.SETRANGE("Global Dimension 1 Code", StudentRec."Global Dimension 1 Code");
                            RecFeeCourseHdr.SETRANGE("Other Fees", false);
                            CourseRec.Get(CourseCode);
                            If CourseRec."Admitted Year Wise Fee" then
                                RecFeeCourseHdr.SETRANGE(RecFeeCourseHdr."Admitted Year", StudentRec."Admitted Year");
                            If CourseRec."Semester Wise Fee" then
                                RecFeeCourseHdr.SETRANGE(RecFeeCourseHdr.Semester, Semester);
                            RecFeeCourseHdr.SETRANGE(Year, StudentRec.Year);
                            IF RecFeeCourseHdr.FindFirst() then begin
                                AmountSum := 0;
                                AmountFinalCal := 0;
                                RecFeeCourseLine.Reset();
                                RecFeeCourseLine.SetRange("Document No.", RecFeeCourseHdr."No.");
                                IF RecFeeCourseLine.FindFirst() then begin
                                    Repeat
                                        RecSAPFeeCode.Reset();
                                        RecSAPFeeCode.SetRange("SAP Code", RecFeeCourseLine."Fee Code");
                                        RecSAPFeeCode.SetFilter("Fee Group", '%1', RecSAPFeeCode."Fee Group"::Institutional);
                                        if RecSAPFeeCode.FindFirst() then
                                            AmountSum += RecFeeCourseLine.Amount;
                                    until RecFeeCourseLine.Next() = 0;
                                    AmountFinalCal := (AmountSum * PerFinal) / 100;
                                end;
                                WithdrawalStudentRec.Reset();
                                WithdrawalStudentRec.SetRange("No.", Rec."Withdrawal No.");
                                if WithdrawalStudentRec.FindFirst() then;
                                IF AmountFinalCal <> 0 then
                                    CreditMemoGenJournalLineInsert(StudentNo, AmountFinalCal, WithdrawalStudentRec."Reason for Leaving");
                            end;
                        end;
                    end;
                end;
    end;


    procedure CreditMemoGenJournalLineInsert(StudentNo: Code[20]; FinalAmountCal: Decimal; ReasonDesc: Text[100])
    Var
        GenJournalLine: record "Gen. Journal Line";
        GenJournalLine1: record "Gen. Journal Line";
        RecFeeSetup: Record "Fee Setup-CS";
        Customer: Record "Customer";
        RecStudentMaster: Record "Student Master-CS";
        NoSeries: Codeunit NoSeriesManagement;
        DocumentNo: Code[20];
        LineNo: Integer;
    begin
        Customer.GET(StudentNo);
        RecStudentMaster.Get(StudentNo);
        RecFeeSetup.Reset();
        RecFeeSetup.SetRange("Global Dimension 1 Code", RecStudentMaster."Global Dimension 1 Code");
        IF RecFeeSetup.FindFirst() then;
        RecFeeSetup.TESTFIELD(RecFeeSetup."Withdrawal Template Name");
        RecFeeSetup.TESTFIELD(RecFeeSetup."Withdrawal Batch Name");

        DocumentNo := NoSeries.GetNextNo(RecFeeSetup."Withdrawal Document No.", 0D, TRUE);

        LineNo := 0;
        GenJournalLine1.RESET();
        GenJournalLine1.SETRANGE("Journal Template Name", RecFeeSetup."Withdrawal Template Name");
        GenJournalLine1.SETRANGE("Journal Batch Name", RecFeeSetup."Withdrawal Batch Name");
        IF GenJournalLine1.FINDLAST() THEN
            LineNo := GenJournalLine1."Line No." + 10000
        ELSE
            LineNo := 10000;

        GenJournalLine.INIT();
        GenJournalLine.VALIDATE(GenJournalLine."Journal Template Name", RecFeeSetup."Withdrawal Template Name");
        GenJournalLine.VALIDATE(GenJournalLine."Journal Batch Name", RecFeeSetup."Withdrawal Batch Name");
        GenJournalLine.VALIDATE(GenJournalLine."Line No.", LineNo);
        GenJournalLine.VALIDATE(GenJournalLine."Posting Date", WORKDATE());
        GenJournalLine.VALIDATE(GenJournalLine."Document Type", GenJournalLine."Document Type"::"Credit Memo");
        GenJournalLine.VALIDATE(GenJournalLine."Document No.", DocumentNo);
        GenJournalLine.VALIDATE(GenJournalLine."Account Type", GenJournalLine."Account Type"::"G/L Account");
        GenJournalLine.VALIDATE(GenJournalLine."Account No.", RecFeeSetup."Withdrawal G/L Account No.");
        GenJournalLine.Description := ReasonDesc;
        GenJournalLine.VALIDATE(GenJournalLine."Debit Amount", FinalAmountCal);
        GenJournalLine.VALIDATE(GenJournalLine."Bal. Account Type", GenJournalLine."Bal. Account Type"::Customer);
        GenJournalLine.VALIDATE(GenJournalLine."Bal. Account No.", Customer."No.");
        GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code", Customer."Global Dimension 1 Code");
        GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code", Customer."Global Dimension 2 Code");
        GenJournalLine.VALIDATE(GenJournalLine."Currency Code", Customer."Currency Code");
        GenJournalLine.VALIDATE(GenJournalLine.Year, Customer.Year);
        GenJournalLine.VALIDATE(GenJournalLine.Course, Customer."Course Code");
        GenJournalLine.VALIDATE(GenJournalLine."Academic Year", Customer."Academic Year");
        GenJournalLine.VALIDATE(GenJournalLine.Category, Customer.Category);
        // SapRec.Reset();
        // SapRec.SetRange("SAP Code", SapCode);
        // if SapRec.FindFirst() then begin
        //     GenJournalLine."SAP Code" := SapRec."SAP Code";
        //     GenJournalLine."SAP G/L Account" := SapRec."SAP G/L Account";
        //     GenJournalLine."SAP Assignment Code" := SapRec."SAP Assignment Code";
        //     GenJournalLine."SAP Description" := SapRec."SAP Description";
        //     GenJournalLine."SAP Cost Centre" := SapRec."SAP Cost Centre";
        //     GenJournalLine."SAP Profit Centre" := SapRec."SAP Profit Centre";
        //     GenJournalLine."SAP Company Code" := SapRec."SAP Company Code";
        //     GenJournalLine."SAP Bus. Area" := SapRec."SAP Bus. Area";
        //     GenJournalLine."Fee Group" := SapRec."Fee Group";
        // end;
        GenJournalLine.INSERT(TRUE);

    end;


    var
        WithdrawalStudentRec: Record "Withdrawal Student-CS";
        WithdrawalApprovalRec: Record "Withdrawal Approvals";
        StudentTimeLineRec: Record "Student Time Line";
        Text001Lbl: Label 'Do you want to Approve Application No. %1 ?';
        Text002Lbl: Label 'Application No. %1 has been Approved.';
        Text003Lbl: Label 'Do you want to Rejected Application No. %1 ?';
        Text004Lbl: Label 'Application No. %1 has been Rejected.';


    procedure SendForApproval_gFnc(var WithdrawalApprovals_lRec: Record "Withdrawal Approvals")
    var
        WithdrawalDepartment_lRec: Record "Withdrawal Department";
        WithdrawalApprovals_Rec: Record "Withdrawal Approvals";
    begin

        WithdrawalDepartment_lRec.Reset;
        WithdrawalDepartment_lRec.SetCurrentkey("Document Type", Sequence);
        WithdrawalDepartment_lRec.SetRange("Document Type", WithdrawalDepartment_lRec."Document Type"::Withdrawal);
        WithdrawalDepartment_lRec.SetFilter("User E-Mail", '<>%1', '');
        if WithdrawalDepartment_lRec.IsEmpty then
            Error('Leaves Approvals Approver is not define for User ID %1', UserId);

        //LeavesApprovals_vRec.Status := LeavesApprovals_vRec.Status::"Pending for Approval";
        //LeavesApprovals_vRec.Modify;

        WithdrawalApprovals_Rec.Reset;
        WithdrawalApprovals_Rec.SetRange("Withdrawal No.", WithdrawalApprovals_lRec."Withdrawal No.");
        WithdrawalApprovals_Rec.SetRange(Status, WithdrawalApprovals_lRec.Status::Open);
        if WithdrawalApprovals_Rec.FindFirst then begin
            if ApproveEntry_gFnc(WithdrawalApprovals_Rec, false) then begin
                Message(Text013_gCtx);
                exit;
            end;
        end;

        //SendForApprovalEmail_gFnc(LeavesApprovals_vRec);

        Message(Text003_gCtx);
    end;


    procedure ApproveEntry_gFnc(var UserAppEntry_vRec: Record "Withdrawal Approvals"; ShowConfirm_iBln: Boolean): Boolean
    var
        LR_lRec: Record "Leaves Approvals";
    begin
        // if ShowConfirm_iBln then begin
        //     if not Confirm(Text007_gCtx, false) then
        //         exit;
        // end;
        //  UserAppEntry_vRec.Status := UserAppEntry_vRec.Status::Approved;
        if UserAppEntry_vRec.sequence > 0 then begin
            UserAppEntry_vRec.Status := UserAppEntry_vRec.Status::Approved;
            UserAppEntry_vRec.Modify(true);
        end;
        exit;
    end;

    var

        Text000_gCtx: label 'There is nothing to approve.';
        Text003_gCtx: label 'Approval request has been sent.';
        Text004_gCtx: label 'Do you want to send for Approval?';
        Text005_gCtx: label 'Do you want to cancel approval entries?';
        Text006_gCtx: label 'Approval entry cancelled successfully.';
        Text007_gCtx: label 'Do you want to approve request?';
        Text008_gCtx: label 'Do you want to reject request?';
        Text009_gCtx: label 'There is nothing to reject.';
        Text010_gCtx: label 'There is nothing to show.';
        Text011_gCtx: label 'Do you want to re-oepn approval entries?';
        Text012_gCtx: label 'Approval entry opened successfully.';
        Text013_gCtx: label 'Entry is auto-approved.';
        Text016_gCtx: label 'There is nothing to approve.';
        Text017_gCtx: label 'Do you want to approve selected request lines?';
        Text018_gCtx: label 'Do you want to reject selected request lines?';
        Text019_gCtx: label 'There is nothing to reject.';
        //SMTPSetup_gRec: Record "Email Account";
        FixedAsset_gRec: Record "Fixed Asset";
        SalesRecSetup_gRec: Record "Sales & Receivables Setup";
        ApprovalsDelegatedMsg: label 'The selected approval requests have been delegated.';
        DelegateOnlyOpenRequestsErr: label 'You can only delegate open approval requests.';
        ApproverUserIdNotInSetupErr: label 'You must set up an approver for user ID %1 in the Approval User Setup window.', Comment = 'You must set up an approver for user ID NAVUser in the Approval User Setup window.';
}



