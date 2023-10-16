Page 50856 "Approved Withdrawal Approvals"
{

    PageType = List;
    SourceTable = "Withdrawal Approvals";
    Caption = 'Approved Withdrawal Approvals List';
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTableView = WHERE(Status = FILTER(Approved));
    Editable = false;
    CardPageId = "Withdrawal Approval Card";
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
                trigger OnAction()
                var
                    WithdrawalRec: Record "Withdrawal Student-CS";
                    StudCollegeWithdrawal: Page "Stud. College Withdrawal-CS";
                    StudCourseWithdrawal: Page "Stud. Withdrawal-CS";
                begin
                    WithdrawalRec.Reset();
                    WithdrawalRec.SetRange("No.", Rec."Withdrawal No.");
                    IF WithdrawalRec.FindFirst() then
                        Case Rec."Type of Withdrawal" of
                            Rec."Type of Withdrawal"::"Course-Withdrawal":
                                begin
                                    StudCourseWithdrawal.SetTableView(WithdrawalRec);
                                    StudCourseWithdrawal.Editable := False;
                                    StudCourseWithdrawal.Run();
                                end;
                            Rec."Type of Withdrawal"::"College-Withdrawal":
                                begin
                                    StudCollegeWithdrawal.SetTableView(WithdrawalRec);
                                    StudCollegeWithdrawal.Editable := false;
                                    StudCollegeWithdrawal.Run();
                                end;
                        end;
                end;
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
                        end;
                        //WithdrawalRejectionMail("Student No.");GMCSCOM
                        Message(Text004Lbl, Rec."Withdrawal No.");
                    end;
                end;
            }

        }
    }
    trigger OnOpenPage()
    var
        WithdrawalDepartmentRec: Record "Withdrawal Department";
        StudentsInfoCSCSLM: codeunit StudentsInfoCSCSLM;
    begin
        WithdrawalDepartmentRec.Reset();
        WithdrawalDepartmentRec.SetRange("User Name", USERID());
        IF WithdrawalDepartmentRec.FindFirst() then begin
            Rec.FILTERGROUP(2);
            Rec.SetFilter("Approved for Department", WithdrawalDepartmentRec."Department Code");
            Rec.FILTERGROUP(0);
        END;
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
                                //WithdrawalStudentRec.SetRange(Rec."No., "Withdrawal No.");
                                //if WithdrawalStudentRec.FindFirst() then;\\GMCSCOM
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
        Text001Lbl: Label 'Do you want to Approve Application No. %1 ?';
        Text002Lbl: Label 'Application No. %1 has been Approved.';
        Text003Lbl: Label 'Do you want to Rejected Application No. %1 ?';
        Text004Lbl: Label 'Application No. %1 has been Rejected.';



}
