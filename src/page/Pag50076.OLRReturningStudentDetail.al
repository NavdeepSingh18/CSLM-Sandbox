page 50076 "OLR Returning Student Detail"
{
    PageType = Document;
    UsageCategory = None;
    SourceTable = "OLR Update Header";
    Caption = 'OLR Returning Students Activation';
    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Enabled = FieldEditBool;
                    trigger OnAssistEdit()
                    begin
                        If Rec.AssistEdit(xRec) then
                            CurrPage.Update();

                    end;

                }

                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                    // Enabled = FieldEditBool;
                    Enabled = false;

                }
                field(Term; Rec.Term)
                {
                    ApplicationArea = All;
                    // Enabled = FieldEditBool;
                    Enabled = false;
                }
                // field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                // {
                //     ApplicationArea = All;
                //     Enabled = FieldEditBool;

                // }
                // field("Course Code"; Rec."Course Code")
                // {
                //     ApplicationArea = All;
                //     Enabled = FieldEditBool;

                // }
                // field(Semester; Rec.Semester)
                // {
                //     ApplicationArea = All;
                //     Enabled = FieldEditBool;

                // }

                Group("OLR Details")
                {
                    field("OLR Academic Year"; Rec."OLR Academic Year")
                    {
                        ApplicationArea = All;

                    }
                    field("OLR Term"; Rec."OLR Term")
                    {
                        ApplicationArea = All;

                    }
                    // field("OLR Semester"; Rec."OLR Semester")
                    // {
                    //     ApplicationArea = All;

                    // }
                    // field("OLR Start Date"; Rec."OLR Start Date")
                    // {
                    //     ApplicationArea = All;

                    // }
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;

                }
                field("Confirmed By"; Rec."Confirmed By")
                {
                    ApplicationArea = All;

                }
                field("Confirmed On"; Rec."Confirmed On")
                {
                    ApplicationArea = All;

                }

            }
            part("OLR Returning Student Subform"; "OLR Returning Student Subform")
            {
                SubPageLink = "Document No." = field("No.");
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(GetStudents)
            {
                ApplicationArea = All;
                Image = GetLines;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    IF Confirm('Do you want to continue Get Students process for No. : %1 ?', true, Rec."No.") then
                        REc.GetStudent()
                    Else
                        exit;
                end;
            }
            action(Release)
            {
                ApplicationArea = All;
                Image = ReleaseDoc;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    OLRUpdateLine_lRec: Record "OLR Update Line";
                begin
                    IF Confirm('Do you want to Release the document?', true) then begin
                        Rec.Status := Rec.Status::Released;
                        Rec.Modify();
                        OLRUpdateLine_lRec.Reset();
                        OLRUpdateLine_lRec.SetRange("Document No.", Rec."No.");
                        OLRUpdateLine_lRec.SetRange("Ready to Confirm", false);
                        If OLRUpdateLine_lRec.FindSet() then begin
                            repeat
                                OLRUpdateLine_lRec."OLR Status" := OLRUpdateLine_lRec."OLR Status"::Released;
                                OLRUpdateLine_lRec.Modify();
                            until OLRUpdateLine_lRec.Next() = 0;
                        end;

                        CurrPage.Update();
                    end Else
                        exit;
                end;
            }
            action("Re-Open")
            {
                ApplicationArea = All;
                Image = ReOpen;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    OLRUpdateLine_lRec: Record "OLR Update Line";
                begin
                    IF Confirm('Do you want to Re-Open the document?', true) then begin
                        Rec.Status := Rec.Status::Open;
                        Rec.Modify();
                        OLRUpdateLine_lRec.Reset();
                        OLRUpdateLine_lRec.SetRange("Document No.", Rec."No.");
                        OLRUpdateLine_lRec.SetRange("Ready to Confirm", false);
                        If OLRUpdateLine_lRec.FindSet() then begin
                            repeat
                                OLRUpdateLine_lRec."OLR Status" := OLRUpdateLine_lRec."OLR Status"::Open;
                                OLRUpdateLine_lRec.Modify();
                            until OLRUpdateLine_lRec.Next() = 0;
                        end;
                        CurrPage.Update();
                    end Else
                        Exit;
                end;
            }


            action("Confirm")
            {
                ApplicationArea = All;
                Image = Confirm;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    OLRUpdateLine_lRec: Record "OLR Update Line";
                    OLRUpdateLine_lRec1: Record "OLR Update Line";
                    AcademicYearMaster_lRec: Record "Academic Year Master-CS";
                    AcademicYearMaster_lRec1: Record "Academic Year Master-CS";
                    StudentMaster_lRec: Record "Student Master-CS";
                    StudentGroup_lRec: Record "Student Group";
                    StudentWiseholdRec: Record "Student Wise Holds";
                    StudentHoldRec: Record "Student Hold";
                    EducationSetup_lRec: Record "Education Setup-CS";
                    // WebServiceCodeunit_lCU: Codeunit WebServicesFunctionsC;
                    StudentStatusMgmt: Codeunit "Student Status Mangement";
                    HoldUpdate_lCU: Codeunit "Hold Bulk Upload";
                    HoldType: option " ",Housing,"Financial Aid",Bursar,Registrar,"Registrar Sign-off",Immigration,Clinical,"OLR Finance";
                    ctr: integer;
                begin
                    Rec.TestField(Status, Rec.Status::Released);
                    // CheckValidation(Rec);

                    If not Confirm('Do you want to confirm the document?', false) then
                        Exit;

                    // EducationSetup_lRec.Reset();
                    // IF EducationSetup_lRec.FindSet() then begin
                    //     repeat
                    //         IF EducationSetup_lRec."Even/Odd Semester" <> EducationSetup_lRec."Even/Odd Semester"::SPRING then begin
                    //             AcademicYearMaster_lRec.Reset();
                    //             AcademicYearMaster_lRec.SetRange(Code, Rec."Academic Year");
                    //             IF AcademicYearMaster_lRec.FindFirst() then begin
                    //                 AcademicYearMaster_lRec1.Reset();
                    //                 AcademicYearMaster_lRec1.SetRange(Sequence, AcademicYearMaster_lRec.Sequence + 1);
                    //                 IF AcademicYearMaster_lRec1.FindFirst() then
                    //                     EducationSetup_lRec."Returning OLR Academic Year" := AcademicYearMaster_lRec1.Code;
                    //             end;
                    //         end Else
                    //             EducationSetup_lRec."Returning OLR Academic Year" := "Academic Year";

                    //         If EducationSetup_lRec."Even/Odd Semester" = EducationSetup_lRec."Even/Odd Semester"::FALL then
                    //             EducationSetup_lRec."Returning OLR Term" := EducationSetup_lRec."Returning OLR Term"::SPRING;

                    //         IF EducationSetup_lRec."Even/Odd Semester" = EducationSetup_lRec."Even/Odd Semester"::SPRING then
                    //             EducationSetup_lRec."Returning OLR Term" := EducationSetup_lRec."Returning OLR Term"::FALL;

                    //         EducationSetup_lRec.Modify();
                    //     until EducationSetup_lRec.Next() = 0;
                    // end;
                    ctr := 0;
                    OLRUpdateLine_lRec.Reset();
                    OLRUpdateLine_lRec.SetRange("Document No.", Rec."No.");
                    OLRUpdateLine_lRec.SetRange(Select, true);
                    OLRUpdateLine_lRec.SetRange("Ready to Confirm", false);
                    OLRUpdateLine_lRec.SetRange(Confirmed, false);
                    IF OLRUpdateLine_lRec.FindSet() then begin
                        repeat
                            ctr += 1;
                            CheckValidationLine(OLRUpdateLine_lRec);
                            // if ctr = 1 then begin
                            //     EducationSetup_lRec.Reset();
                            //     IF EducationSetup_lRec.FindSet() then
                            //         repeat
                            //             EducationSetup_lRec."Returning OLR Academic Year" := OLRUpdateLine_lRec."OLR Academic Year";
                            //             EducationSetup_lRec."Returning OLR Term" := OLRUpdateLine_lRec."OLR Term";
                            //             EducationSetup_lRec.Modify();
                            //         until EducationSetup_lRec.Next() = 0;
                            // end;
                            OLRUpdateLine_lRec1.Reset();
                            OLRUpdateLine_lRec1.SetRange("Student No.", OLRUpdateLine_lRec."Student No.");
                            OLRUpdateLine_lRec1.SetRange("OLR Academic Year", OLRUpdateLine_lRec."OLR Academic Year");
                            OLRUpdateLine_lRec1.SetRange("OLR Term", OLRUpdateLine_lRec."OLR Term");
                            If OLRUpdateLine_lRec1.Count() = 1 then begin
                                OLRUpdateLine_lRec."Registrar Sign Off" := false;
                                OLRUpdateLine_lRec."Ready to Confirm" := true;
                                OLRUpdateLine_lRec.Confirmed := true;
                                OLRUpdateLine_lRec.Modify();

                                StudentMaster_lRec.Reset();
                                StudentMaster_lRec.SetRange("No.", OLRUpdateLine_lRec."Student No.");
                                IF StudentMaster_lRec.FindFirst() then begin
                                    StudentMaster_lRec."Registrar Signoff" := false;
                                    StudentMaster_lRec."OLR Completed" := false;
                                    StudentMaster_lRec."OLR Completed Date" := 0D;
                                    If StudentMaster_lRec."Student Group" = StudentMaster_lRec."Student Group"::"On-Ground Check-In" then
                                        HoldUpdate_lCU.OnGroundCheckInStudentGroupDisable(OLRUpdateLine_lRec."Student No.");
                                    IF StudentMaster_lRec."Student Group" = StudentMaster_lRec."Student Group"::"On-Ground Check-In Completed" then
                                        HoldUpdate_lCU.OnGroundCheckInCompletedGroupDisable(OLRUpdateLine_lRec."Student No.");
                                    StudentMaster_lRec."Student Group" := StudentMaster_lRec."Student Group"::" ";
                                    StudentMaster_lRec."On Ground Check-In By" := '';
                                    StudentMaster_lRec."On Ground Check-In On" := 0D;
                                    StudentMaster_lRec."On Ground Check-In Complete By" := '';
                                    StudentMaster_lRec."On Ground Check-In Complete On" := 0D;
                                    StudentMaster_lRec."OLR Email Sent" := false;
                                    StudentMaster_lRec."OLR Email Sent Date" := 0D;
                                    StudentMaster_lRec."Promotion Suggested" := false;
                                    StudentMaster_lRec."FERPA Release" := StudentMaster_lRec."FERPA Release"::" ";
                                    StudentMaster_lRec."Ferpa Release Date" := 0D;
                                    StudentMaster_lRec."Semester Decision" := StudentMaster_lRec."Semester Decision"::" ";
                                    StudentMaster_lRec."Clear OLR Data" := false;
                                    //If StudentMaster_lRec.Status IN ['ATT', 'PROB', 'EXTLOA', 'TWD'] then
                                    IF StudentMaster_lRec.Status = 'ATT' then
                                        StudentMaster_lRec.Validate(Status, 'ENR');


                                    StudentHoldRec.Reset();
                                    StudentHoldRec.SetRange("Global Dimension 1 Code", StudentMaster_lRec."Global Dimension 1 Code");
                                    StudentHoldRec.SetRange(StudentHoldRec."Hold Type", HoldType::Housing);
                                    IF StudentHoldRec.FindFirst() then begin
                                        StudentStatusMgmt.EnableAllHoldOLR1(StudentMaster_lRec, OLRUpdateLine_lRec, HoldType::Housing);
                                        StudentGroup_lRec.Reset();
                                        StudentGroup_lRec.SetRange("Student No.", StudentMaster_lRec."No.");
                                        StudentGroup_lRec.SetRange("Groups Code", StudentHoldRec."Group Code");
                                        IF StudentGroup_lRec.FindFirst() then begin
                                            IF StudentGroup_lRec.Blocked then begin
                                                StudentGroup_lRec.Blocked := false;
                                                StudentGroup_lRec.Modify();
                                            end;
                                        End Else
                                            StudentGroup_lRec.EnableStudentGroupCodeExistingStudent(StudentMaster_lRec, HoldType::Housing);

                                    end;

                                    IF Rec."Global Dimension 1 Code" <> '9100' then begin

                                        StudentHoldRec.Reset();
                                        StudentHoldRec.SetRange("Global Dimension 1 Code", StudentMaster_lRec."Global Dimension 1 Code");
                                        StudentHoldRec.SetRange(StudentHoldRec."Hold Type", HoldType::"Financial Aid");
                                        IF StudentHoldRec.FindFirst() then begin
                                            StudentStatusMgmt.EnableAllHoldOLR1(StudentMaster_lRec, OLRUpdateLine_lRec, HoldType::"Financial Aid");
                                            StudentGroup_lRec.Reset();
                                            StudentGroup_lRec.SetRange("Student No.", StudentMaster_lRec."No.");
                                            StudentGroup_lRec.SetRange("Groups Code", StudentHoldRec."Group Code");
                                            IF StudentGroup_lRec.FindFirst() then begin
                                                IF StudentGroup_lRec.Blocked then begin
                                                    StudentGroup_lRec.Blocked := false;
                                                    StudentGroup_lRec.Modify();
                                                end;
                                            End Else
                                                StudentGroup_lRec.EnableStudentGroupCodeExistingStudent(StudentMaster_lRec, HoldType::"Financial Aid");

                                        end;
                                    end;

                                    //If StudentMaster_lRec.Status IN ['ATT', 'PROB', 'REENTRY', 'EXTLOA'] then
                                    // WebServiceCodeunit_lCU.OLRReturningStudentEmailNotifyFn(OLRUpdateLine_lRec, false);

                                    StudentMaster_lRec.UpdateDummyStudentSubject(StudentMaster_lRec, OLRUpdateLine_lRec."Course Code", OLRUpdateLine_lRec."OLR Semester", OLRUpdateLine_lRec."OLR Academic Year", OLRUpdateLine_lRec."OLR Term");
                                    StudentMaster_lRec.Modify();

                                end;
                            end;
                        until OLRUpdateLine_lRec.Next() = 0;
                        Rec."Confirmed By" := UserId();
                        Rec."Confirmed On" := Today();

                        Rec.Modify();
                        CurrPage.Update();
                    end;

                end;
            }

            action("Send Reminders Email")
            {
                ApplicationArea = All;
                Image = Alerts;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    OLRUpdateLine_lRec: Record "OLR Update Line";
                    StudentMaster_lRec: Record "Student Master-CS";
                // WebServiceCodeunit_lCU: Codeunit WebServicesFunctionsCSL;
                begin
                    Rec.TestField(Status, Rec.Status::Released);

                    If not Confirm('Do you want to sent reminders for selected students?', false) then
                        Exit;

                    OLRUpdateLine_lRec.Reset();
                    OLRUpdateLine_lRec.SetRange("Document No.", Rec."No.");
                    OLRUpdateLine_lRec.SetRange(Select, true);
                    OLRUpdateLine_lRec.SetRange(Confirmed, false);
                    OLRUpdateLine_lRec.SetRange(Reminder, false);
                    IF OLRUpdateLine_lRec.FindSet() then begin
                        repeat
                            Error('Reminders Email send only OLR confirmed students');
                        Until OLRUpdateLine_lRec.Next() = 0;
                    end;

                    OLRUpdateLine_lRec.Reset();
                    OLRUpdateLine_lRec.SetRange("Document No.", Rec."No.");
                    OLRUpdateLine_lRec.SetRange(Select, true);
                    OLRUpdateLine_lRec.SetRange(Confirmed, true);
                    OLRUpdateLine_lRec.SetRange(Reminder, false);
                    IF OLRUpdateLine_lRec.FindSet() then begin
                        repeat
                            StudentMaster_lRec.Reset();
                            StudentMaster_lRec.SetRange("No.", OLRUpdateLine_lRec."Student No.");
                            IF StudentMaster_lRec.FindFirst() then begin
                                OLRUpdateLine_lRec.Reminder := true;
                                OLRUpdateLine_lRec."Reminder No." += 1;
                                OLRUpdateLine_lRec.Modify();
                                // WebServiceCodeunit_lCU.OLRReturningStudentEmailNotifyFn(OLRUpdateLine_lRec, true);
                            end;
                        until OLRUpdateLine_lRec.Next() = 0;
                        CurrPage.Update();
                    end;

                end;
            }

        }
    }

    trigger OnOpenPage()
    begin
        FieldEditBool := true;
        If Rec.Status = Rec.Status::Released then
            FieldEditBool := false;
    end;

    trigger OnAfterGetRecord()
    begin
        FieldEditBool := true;
        IF Rec.Status = Rec.Status::Released then
            FieldEditBool := false;
    end;

    var
        FieldEditBool: Boolean;

    Procedure CheckValidation(OLRUpdateHeader: Record "OLR Update Header")
    var
        AcademicYear_lRec: Record "Academic Year Master-CS";
        EducationSetup_lRec: Record "Education Setup-CS";
        CourseSubjectLine_lRec: Record "Course Wise Subject Line-CS";
        CourseSemester_lRec: REcord "Course Sem. Master-CS";
    Begin
        // AcademicYear_lRec.Reset();
        // AcademicYear_lRec.SetRange(Code, OLRUpdateHeader."OLR Academic Year");
        // If Not AcademicYear_lRec.FindFirst() then
        //     Error('Academic Year : %1 does not exist', OLRUpdateHeader."OLR Academic Year");

        // EducationSetup_lRec.Reset();
        // EducationSetup_lRec.SetRange("Academic Year", OLRUpdateHeader."Academic Year");
        // If not EducationSetup_lRec.FindFirst() then
        //     Error('Education setup does not exist for Academic Year : %1 & Term : %2', OLRUpdateHeader."Academic Year", Format(OLRUpdateHeader.Term));

        // CourseSubjectLine_lRec.Reset();
        // CourseSubjectLine_lRec.SetRange("Course Code", OLRUpdateHeader."Course Code");
        // CourseSubjectLine_lRec.SetRange(Semester, OLRUpdateHeader.Semester);
        // If not CourseSubjectLine_lRec.FindFirst() then
        //     Error('Course Subject does not exist for Course : %1 & Semester : %2', OLRUpdateHeader."Course Code", OLRUpdateHeader.Semester);

        CourseSemester_lRec.Reset();
        CourseSemester_lRec.SetRange("Course Code", OLRUpdateHeader."Course Code");
        CourseSemester_lRec.SetRange("Semester Code", OLRUpdateHeader."OLR Semester");
        CourseSemester_lRec.SetRange("Academic Year", OLRUpdateHeader."OLR Academic Year");
        CourseSemester_lRec.SetRange(Term, OLRUpdateHeader."OLR Term");
        CourseSemester_lRec.SetRange("Global Dimension 1 Code", OLRUpdateHeader."Global Dimension 1 Code");
        IF CourseSemester_lRec.FindFirst() then begin
            CourseSemester_lRec.TestField("Returning OLR Start Date");
            CourseSemester_lRec.TestField("Returning OLR End Date");
        end;
    End;

    Procedure CheckValidationLine(OLRUpdateLine: Record "OLR Update Line")
    var
        AcademicYear_lRec: Record "Academic Year Master-CS";
        EducationSetup_lRec: Record "Education Setup-CS";
        CourseSubjectLine_lRec: Record "Course Wise Subject Line-CS";
        CourseSemester_lRec: REcord "Course Sem. Master-CS";
    Begin
        AcademicYear_lRec.Reset();
        AcademicYear_lRec.SetRange(Code, OLRUpdateLine."OLR Academic Year");
        If Not AcademicYear_lRec.FindFirst() then
            Error('Academic Year : %1 does not exist', OLRUpdateLine."OLR Academic Year");

        // EducationSetup_lRec.Reset();
        // EducationSetup_lRec.SetRange("Academic Year", OLRUpdateLine."Academic Year");
        // If not EducationSetup_lRec.FindFirst() then
        //     Error('Education setup does not exist for Academic Year : %1 & Term : %2', OLRUpdateLine."Academic Year", Format(OLRUpdateLine.Term));

        // CourseSubjectLine_lRec.Reset();
        // CourseSubjectLine_lRec.SetRange("Course Code", OLRUpdateLine."Course Code");
        // CourseSubjectLine_lRec.SetRange(Semester, OLRUpdateLine."OLR Semester");
        // If not CourseSubjectLine_lRec.FindFirst() then
        //     Error('Course Subject does not exist for Course : %1 & Semester : %2', OLRUpdateLine."Course Code", OLRUpdateLine.Semester);

        CourseSemester_lRec.Reset();
        CourseSemester_lRec.SetRange("Course Code", OLRUpdateLine."Course Code");
        CourseSemester_lRec.SetRange("Semester Code", OLRUpdateLine."OLR Semester");
        CourseSemester_lRec.SetRange("Academic Year", OLRUpdateLine."OLR Academic Year");
        CourseSemester_lRec.SetRange(Term, OLRUpdateLine."OLR Term");
        CourseSemester_lRec.SetRange("Global Dimension 1 Code", OLRUpdateLine."Global Dimension 1 Code");
        IF CourseSemester_lRec.FindFirst() then begin
            CourseSemester_lRec.TestField("Returning OLR Start Date");
            CourseSemester_lRec.TestField("Returning OLR End Date");
        end;
    End;
}