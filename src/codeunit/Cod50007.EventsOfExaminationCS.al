// codeunit 50007 "Events Of Examination-CS"
// {
//     // version V.001-CS

//     // Sr.No   Emp.ID     Date            Trigger                                                 Remarks
//     // ----------------------------------------------------------------------------------------------------------------------------------------
//     // 
//     // 1 CSPL-00059   19-02-19  CSHideSemesterYear                                       Code Add For Hide Semester/Year
//     // 2 CSPL-00059   19-02-19CSInternalMarksOnSubjectCard                             Code Add For Internal Marks On Subject Card
//     // 3 CSPL-00059   19-02-19CSExternalMarksOnSubjectCard                             Code Add For External Marks On Subject Card
//     // 4  CSPL-00059   19-02-19CSTypeOfCourseOnStudentInternalMarks                     Code Add For Student Internal Marks
//     // 5  CSPL-00059   19-02-19CSFlowDataOnCourseSubjectExGroupLine                     Code Add For Flow Data On Course Subject ExGroup Line
//     // 6  CSPL-00059   19-02-19CSCheckStudentInternalLineExistsOnExamGroupChange         Code Add For Check Student Internal Line Exists OnExam Group Change
//     // 7  CSPL-00059   19-02-19CSTypeOfCourseOnStudentExternalMarks                     Code Add For Type Of Course On Student External Marks
//     // 8  CSPL-00059   19-02-19CSOnValidateOfSubjectCodeOnStudentInternalExamHeader       Code Add For Validate Of Subject Code On Student Internal Exam Header
//     // 9  CSPL-00059   19-02-19CSOnValidateOfCourseCodeOnStudentInternalExamHeader        Code Add For Validate Of Course Code On Student Internal Exam Header
//     // 10CSPL-00059   19-02-19CSOnValidateOfCourseCodeOnStudentExternalExamHeader        Code Add For Validate Of Course Code On Student External Exam Header
//     // 11CSPL-00059   19-02-19CSValidateExamGroupOnStudentInternalHeader               Code Add For Validate Exam Group On Student Internal Header
//     // 12CSPL-00059   19-02-19CSValidateCourseCodeOnStudentInternalExamAttendanceHeader Code Add For Validate Course Code On Student Internal Exam Attendance Header
//     // 13CSPL-00059   19-02-19CSValidateStudentNoOnStudentInternalExamAttendanceLine   Code Add For Validate Student No On Student Internal Exam Attendance Line
//     // 14CSPL-00059   19-02-19CSGetStudentFor InternalExamAttendanceLine               Code Add For Get Student For  Internal Exam Attendance Line
//     // 15CSPL-00059   19-02-19CSOnDeleteOfStudentInternalExamAttendanceHeader           Code Add For Delete Of Student Internal Exam Attendance Header
//     // 16CSPL-00059   19-02-19CSGetAttdPercentageOnStudentInternalExamAttendanceLine     Code Add For Get Attd Percentage On Student Internal Exam Attendance Line
//     // 17CSPL-00059   19-02-19CSGetAttdPercentageOnStudentExternalExamLine             Code Add For Get Attd Percentage On Student External Exam Line
//     // 18CSPL-00059   19-02-19CSGetStudentFor ExternalExamAttendanceLine               Code Add For Get Student For  External Exam Attendance Line
//     // 19CSPL-00059   19-02-19CSOnDeleteOfStudentExternalExamAttendanceHeader           Code Add For Delete Of Student External Exam Attendance Header
//     // 20CSPL-00059   19-02-19CSValidateCourseCodeOnStudentExternalExamAttendanceHeader Code Add For Validate Course Code On Student External Exam Attendance Header
//     // 21CSPL-00059   19-02-19CSPerFor mManualRelease                                   Code Add For PerFor m Manual Release
//     // 22CSPL-00059   19-02-19CSReleaseInternalExamDocument                             Code Add For Release Internal Exam Document
//     // 23CSPL-00059   19-02-19CSRestrictDocumentAfterRelease                           Code Add For Restrict Document After Release
//     // 24CSPL-00059   19-02-19CSOnInsertOfRoomAllocationLine                           Code Add For Insert Of Room Allocation Line
//     // 25CSPL-00059   19-02-19CSOnValidateCourseCodeOfRoomAllocationHeader             Code Add For Validate Course Code Of Room Allocation Header
//     // 26CSPL-00059   19-02-19CSOnDeleteOfRoomAllocationHeader                         Code Add For Delete Of Room Allocation Header
//     // 27CSPL-00059   19-02-19CSOnValidateOfRoomOnStudentInternalExamAttendanceHeader    Code Add For OnValidateOfRoomOnStudentInternalExamAttendanceHeader
//     // 28CSPL-00059   19-02-19CSOnValidateSubjectCodeOnStudentInternalExamAttendanceHeader  Code Add For Validate Subject Code On Student Internal Exam Attendance Header
//     // 29CSPL-00059   19-02-19CSOnValidateSubjectCodeOnStudentExternalExamAttendanceHeader  Code Add For Validate Subject Code On Student External Exam Attendance Header
//     // 30CSPL-00059   19-02-19CSOnValidate Subject Code On Room Aloocation Line         Code Add For Validate Subject Code On Room Aloocation Line
//     // 31CSPL-00059   19-02-19CSOnValidateOfRoomOnStudentExternalExamAttendanceHeader    Code Add For Validate Of Room On Student External Exam Attendance Header
//     // 32CSPL-00059   19-02-19CSOnReopenOfStudentInternalExamAttendanceHeader           Code Add For Reopen Of Student Internal Exam Attendance Header
//     // 33CSPL-00059   19-02-19CSOnReopenOfStudentExternalExamAttendanceHeader           Code Add For Reopen Of Student External Exam Attendance Header
//     // 34CSPL-00059   19-02-19CSOnValidateOfAnswerSheetOnStudentExternalAttendanceLine   Code Add For Validate Of Answer Sheet On Student External Attendance Line
//     // 35CSPL-00059   19-02-19CSGetVersionNoFor MasterArchiveVersions                   Code Add For Get Version No For  Master Archive Versions
//     // 36CSPL-00059   19-02-19CSInsertToMasterArchiveVersion                           Code Add For Insert To Master Archive Version
//     // 37CSPL-00059   19-02-19CSOnValidateOfReSessionalOnStudentInternalExamLine         Code Add For Validate Of ReSessional On Student Internal Exam Line
//     // 38CSPL-00059   19-02-19CSOnValidateAttendanceTypeOfStudentExternaExamlLine        Code Add For Validate Attendance Type Of Student Externa Examl Line
//     // 39CSPL-00059   19-02-19CSOnGenerationOfGradeOnStudentExternalExamHeader         Code Add For Generation Of Grade On Student External Exam Header
//     // 40CSPL-00059   19-02-19CSOnValidateOnInternalMarksOfStudentExternalExamLine       Code Add For Validate On Internal Marks Of Student External Exam Line
//     // 41CSPL-00059   19-02-19CSCalculateStandardDevationForGradeCalculation           Code Add For Calculate Standard Devation For  Grade Calculation
//     // 42CSPL-00059   19-02-19CSOnReleaseReOpenOfStudentExternalExamHeaderForGradeAllocationMaster Code Add For Release ReOpen Of Student External Exam Header For  Grade Allocation Master
//     // 43CSPL-00059   19-02-19CSReOpenStudentInternalExam                               Code Add For ReOpen Student Internal Exam
//     // 44CSPL-00059   19-02-19CSUpdateCreditGradePointsOnStudentSubjectCollege         Code Add For Update Credit Grade Points On Student Subject College
//     // 45CSPL-00059   19-02-19CSPerFor mExternalExamManualRelease                       Code Add For PerFor m External Exam Manual Release
//     // 46CSPL-00059   19-02-19CSReleaseExternalExamDocument                             Code Add For Release External Exam Document
//     // 47CSPL-00059   19-02-19CSReOpenStudentExternalExam                               Code Add For ReOpen Student External Exam
//     // 48CSPL-00059   19-02-19CSUpdateGPAOnStudentCollege                               Code Add For Update GPA On Student College
//     // 49CSPL-00059   19-02-19CSUpdateGPAOnStudentCollegeFor Semester                   Code Add For Update GPA On Student College For  Semester
//     // 50CSPL-00059   19-02-19CSUpdateGPAOnStudentCollegeFor Year                       Code Add For Update GPA On Student College For  Year
//     // 51CSPL-00059   19-02-19CSGetStudentsFor ReRegistrationOfExternalExam             Code Add For Get Students For  Re Registration Of External Exam
//     // 52CSPL-00059   19-02-19CSGetInternalMarksFor ReRegistrationOfExternalExam         Code Add For Get Internal Marks For  Re Registration Of External Exam
//     // 53CSPL-00059   19-02-19CSOnDeleteOnStudentExternalExamLine                       Code Add For Delete On Student External Exam Line
//     // 54CSPL-00059   19-02-19CSOnDeleteOfRoomAllocation                               Code Add For Delete Of Room Allocation
//     // 55CSPL-00059   19-02-19CSOnValidateStudentAttendanceHeaderFor CourseCode         Code Add For Validate Student Attendance Header For  Course Code
//     // 56CSPL-00059   19-02-19CSCreateAutomateInternalExamGroup                         Code Add For Create Automate Internal Exam Group
//     // 57CSPL-00059   19-02-19CSCreateAutomateInternalExamDetails                       Code Add For Create Automate Internal Exam Details
//     // 58CSPL-00059   19-02-19CSCreateAutomateInternalAssignmentDetails                 Code Add For Create Automate Internal Assignment Details
//     // 59CSPL-00059   19-02-19CSCreateAutomateInternalExamGroupSubjClassWise           Code Add For Create Automate Internal Exam Group Subj Class Wise
//     // 60CSPL-00059   19-02-19CSCreateAutomateTimeTable                                 Code Add For Create Automate Time Table
//     // 61CSPL-00059   19-02-19CSCreateExternalExamDetails                               Code Add For Create External Exam Details


//     trigger OnRun()
//     begin
//     end;

//     var
//         UserSetupRec: Record "User Setup";
//         Text_10001Lbl: Label 'Student Internal Line already exists. You cannot change the exam group.', Comment = '%1 = XML node name ; %2 = Parent XML node name';
//         //Text002Lbl: Label 'This document can only be released when the approval process is complete.', Comment = '%1 = XML node name ; %2 = Parent XML node name';

//         Text_10002Lbl: Label 'The Answer sheet %1 already exists.', Comment = '%1 = XML node name ; %2 = Parent XML node name';
//         Text_10003Lbl: Label 'The student no. %1 was not applicable for Re-Sessional.', Comment = '%1 = XML node name ; %2 = Parent XML node name';
//         Text_10004Lbl: Label 'Calculate Maximum Marks first.';
//         Text_10005Lbl: Label 'Grade already generated.';
//         Text_10006Lbl: Label 'Entry already mapped to a document.';

//     procedure CSHideSemesterYear(var SemesterValue: Boolean; var YearValue: Boolean; TypeOfCourse: Option " ",Semester,Year)
//     begin
//         //Code Add For  Hide Semester/Year::CSPL-00059::19022019: Start
//         YearValue := FALSE;
//         SemesterValue := FALSE;
//         IF TypeOfCourse = TypeOfCourse::Semester THEN BEGIN
//             SemesterValue := TRUE;
//             YearValue := FALSE;
//         END ELSE
//             IF TypeOfCourse = TypeOfCourse::Year THEN BEGIN
//                 YearValue := TRUE;
//                 SemesterValue := FALSE;
//             END;
//         //Code Add For  Hide Semester/Year::CSPL-00059::19022019: End
//     end;

//     [EventSubscriber(ObjectType::Table, 50058, 'OnAfterValidateEvent', 'Internal Maximum', false, false)]
//     local procedure CSInternalMarksOnSubjectCard(var Rec: Record "Subject Master-CS"; var xRec: Record "Subject Master-CS"; CurrFieldNo: Integer)
//     begin
//     end;

//     [EventSubscriber(ObjectType::Table, 50058, 'OnAfterValidateEvent', 'External Maximum', false, false)]
//     local procedure CSExternalMarksOnSubjectCard(var Rec: Record "Subject Master-CS"; var xRec: Record "Subject Master-CS"; CurrFieldNo: Integer)
//     begin
//     end;

//     [EventSubscriber(ObjectType::Table, 50156, 'OnAfterValidateEvent', 'Course Code', false, false)]
//     local procedure CSTypeOfCourseOnStudentInternalMarks(var Rec: Record "Internal Exam Header-CS"; var xRec: Record "Internal Exam Header-CS"; CurrFieldNo: Integer)
//     var
//     begin
//     end;

//     [EventSubscriber(ObjectType::Table, 50002, 'OnAfterInsertEvent', '', false, false)]
//     local procedure CSFlowDataOnCourseSubjectExGroupLine(var Rec: Record "Sessional Exam Group Line-CS"; RunTrigger: Boolean)
//     var
//     // SessionalExamGroupHeadCS: Record "Sessional Exam Group Head-CS";
//     begin
//     end;

//     [EventSubscriber(ObjectType::Table, 50156, 'OnAfterValidateEvent', 'Exam Group', false, false)]
//     local procedure CSCheckStudentInternalLineExistsOnExamGroupChange(var Rec: Record "Internal Exam Header-CS"; var xRec: Record "Internal Exam Header-CS"; CurrFieldNo: Integer)
//     var
//         InternalExamLineCS: Record "Internal Exam Line-CS";
//     begin
//         //Code Add For  Check Student Internal Line Exists OnExam Group Change::CSPL-00059::19022019: Start
//         InternalExamLineCS.Reset();
//         InternalExamLineCS.SETRANGE("Document No.", Rec."No.");
//         IF InternalExamLineCS.Findfirst() THEN
//             ERROR(Text_10001Lbl);
//         //Code Add For  Check Student Internal Line Exists OnExam Group Change::CSPL-00059::19022019: End
//     end;

//     [EventSubscriber(ObjectType::Table, 50156, 'OnAfterValidateEvent', 'Course Code', false, false)]
//     local procedure CSTypeOfCourseOnStudentExternalMarks(var Rec: Record "Internal Exam Header-CS"; var xRec: Record "Internal Exam Header-CS"; CurrFieldNo: Integer)
//     var

//     begin
//     end;

//     [EventSubscriber(ObjectType::Table, 50156, 'OnAfterValidateEvent', 'Subject Code', false, false)]
//     local procedure CSOnValidateOfSubjectCodeOnStudentInternalExamHeader(var Rec: Record "Internal Exam Header-CS"; var xRec: Record "Internal Exam Header-CS"; CurrFieldNo: Integer)
//     var

//     begin
//     end;

//     [EventSubscriber(ObjectType::Table, 50156, 'OnAfterValidateEvent', 'Course Code', false, false)]
//     local procedure CSOnValidateOfCourseCodeOnStudentInternalExamHeader(var Rec: Record "Internal Exam Header-CS"; var xRec: Record "Internal Exam Header-CS"; CurrFieldNo: Integer)
//     var
//         CourseMasterCS: Record "Course Master-CS";

//     begin
//         //Code Add For  Validate Of Course Code On Student Internal Exam Header::CSPL-00059::19022019: Start
//         CourseMasterCS.Reset();
//         IF CourseMasterCS.GET(Rec."Course Code") THEN BEGIN
//             Rec."Course Name" := CourseMasterCS.Description;
//             Rec."Type Of Course" := CourseMasterCS."Type Of Course";
//             Rec."Program" := CourseMasterCS.Graduation;
//             Rec."Global Dimension 1 Code" := CourseMasterCS."Global Dimension 1 Code";
//             Rec."Global Dimension 2 Code" := CourseMasterCS."Global Dimension 2 Code";
//         END;
//         //Code Add For  Validate Of Course Code On Student Internal Exam Header::CSPL-00059::19022019: End
//     end;

//     [EventSubscriber(ObjectType::Table, 50209, 'OnAfterValidateEvent', 'Course Code', false, false)]
//     local procedure CSOnValidateOfCourseCodeOnStudentExternalExamHeader(var Rec: Record "External Exam Header-CS"; var xRec: Record "External Exam Header-CS"; CurrFieldNo: Integer)
//     var
//         CourseMasterCS: Record "Course Master-CS";

//     begin
//         //Code Add For  Validate Of Course Code On Student External Exam Header::CSPL-00059::19022019: Start
//         CourseMasterCS.Reset();
//         IF CourseMasterCS.GET(Rec."Course Code") THEN BEGIN
//             Rec."Type Of Course" := CourseMasterCS."Type Of Course";
//             Rec."Course Name" := CourseMasterCS.Description;
//             Rec."Global Dimension 1 Code" := CourseMasterCS."Global Dimension 1 Code";
//             Rec."Global Dimension 2 Code" := CourseMasterCS."Global Dimension 2 Code";
//             Rec.Modify();
//         END;
//         //Code Add For  Validate Of Course Code On Student External Exam Header::CSPL-00059::19022019: End
//     end;

//     [EventSubscriber(ObjectType::Table, 50156, 'OnAfterValidateEvent', 'Exam Group', false, false)]
//     local procedure CSValidateExamGroupOnStudentInternalHeader(var Rec: Record "Internal Exam Header-CS"; var xRec: Record "Internal Exam Header-CS"; CurrFieldNo: Integer)
//     var
//         SessionalExamGroupHeadCS: Record "Sessional Exam Group Head-CS";
//     begin
//         //Code Add For  Validate Exam Group On Student Internal Header::CSPL-00059::19022019: Start
//         SessionalExamGroupHeadCS.Reset();
//         SessionalExamGroupHeadCS.SETCURRENTKEY("Course Code", Semester, "Subject Type", "Subject Code", Section, "Academic Year", "Exam Group", "Type Of Course");
//         SessionalExamGroupHeadCS.SETRANGE("Course Code", Rec."Course Code");
//         SessionalExamGroupHeadCS.SETRANGE(Semester, Rec.Semester);
//         SessionalExamGroupHeadCS.SETRANGE("Subject Type", Rec."Subject Type");
//         SessionalExamGroupHeadCS.SETRANGE("Subject Code", Rec."Subject Code");
//         SessionalExamGroupHeadCS.SETRANGE(Section, Rec.Section);
//         SessionalExamGroupHeadCS.SETRANGE("Academic Year", Rec."Academic Year");
//         SessionalExamGroupHeadCS.SETRANGE("Exam Group", Rec."Exam Group");
//         SessionalExamGroupHeadCS.SETRANGE(Year, Rec.Year);
//         SessionalExamGroupHeadCS.SETRANGE("Type Of Course", Rec."Type Of Course");
//         IF SessionalExamGroupHeadCS.Findfirst() THEN BEGIN
//             Rec."Maximum Mark" := SessionalExamGroupHeadCS."Internal Maximum";
//             Rec.Modify();
//         END;
//         //Code Add For  Validate Exam Group On Student Internal Header::CSPL-00059::19022019: End
//     end;

//     [EventSubscriber(ObjectType::Table, 50110, 'OnAfterValidateEvent', 'Course Code', false, false)]
//     local procedure CSValidateCourseCodeOnStudentInternalExamAttendanceHeader(var Rec: Record "Internal Attendance Header-CS"; var xRec: Record "Internal Attendance Header-CS"; CurrFieldNo: Integer)
//     var
//         CourseMasterCS: Record "Course Master-CS";
//         CourseWiseSubjectLineCS: Record "Course Wise Subject Line-CS";
//     begin
//         //Code Add For  Validate Course Code On Student Internal Exam Attendance Header::CSPL-00059::19022019: Start
//         CourseMasterCS.Reset();
//         IF CourseMasterCS.GET(Rec."Course Code") THEN
//             Rec."Course Name" := CourseMasterCS.Description;
//         Rec.VALIDATE("Type Of Course", CourseMasterCS."Type Of Course");
//         CourseWiseSubjectLineCS.Reset();
//         CourseWiseSubjectLineCS.SETRANGE("Course Code", Rec."Course Code");
//         IF CourseWiseSubjectLineCS.FindFirst() THEN BEGIN
//             Rec.VALIDATE("Global Dimension 1 Code", CourseWiseSubjectLineCS."Global Dimension 1 Code");
//             Rec.VALIDATE("Global Dimension 2 Code", CourseWiseSubjectLineCS."Global Dimension 2 Code");
//         END;
//         Rec.Modify();
//         //Code Add For  Validate Course Code On Student Internal Exam Attendance Header::CSPL-00059::19022019: End
//     end;

//     [EventSubscriber(ObjectType::Table, 50291, 'OnAfterInsertEvent', '', false, false)]
//     local procedure CSValidateStudentNoOnStudentInternalExamAttendanceLine(var Rec: Record "Internal Attendance Line-CS"; RunTrigger: Boolean)
//     var
//         InternalAttendanceHeaderCS: Record "Internal Attendance Header-CS";
//     begin
//         //Code Add For  Validate Student No On Student Internal Exam Attendance Line::CSPL-00059::19022019: Start
//         InternalAttendanceHeaderCS.Reset();
//         IF InternalAttendanceHeaderCS.GET(Rec."Document No.") THEN BEGIN
//             Rec.VALIDATE(Course, InternalAttendanceHeaderCS."Course Code");
//             Rec.VALIDATE(Semester, InternalAttendanceHeaderCS.Semester);
//             Rec.VALIDATE("Subject Type", InternalAttendanceHeaderCS."Subject Type");
//             Rec.VALIDATE(Section, InternalAttendanceHeaderCS.Section);
//             Rec.VALIDATE("Academic Year", InternalAttendanceHeaderCS."Academic Year");
//             Rec.VALIDATE("Global Dimension 1 Code", InternalAttendanceHeaderCS."Global Dimension 1 Code");
//             Rec.VALIDATE("Global Dimension 2 Code", InternalAttendanceHeaderCS."Global Dimension 2 Code");
//             Rec.VALIDATE("Type Of Course", InternalAttendanceHeaderCS."Type Of Course");
//             Rec.VALIDATE(Year, InternalAttendanceHeaderCS.Year);
//             Rec.VALIDATE("Subject Code", InternalAttendanceHeaderCS."Subject Code");
//             Rec.VALIDATE("Document Type", InternalAttendanceHeaderCS."Document Type");
//             Rec.VALIDATE("Exam Type", InternalAttendanceHeaderCS."Exam Type");
//             Rec.Modify();
//         END;
//         //Code Add For  Validate Student No On Student Internal Exam Attendance Line::CSPL-00059::19022019: End
//     end;

//     //SD-SN-21-Dec-2020 +
//     [EventSubscriber(ObjectType::Codeunit, 12, 'OnBeforePostGenJnlLine', '', false, false)]
//     local procedure CheckGlobalDimebeforePostFee(var GenJournalLine: Record "Gen. Journal Line"; sender: Codeunit "Gen. Jnl.-Post Line"; Balancing: Boolean)
//     var
//         GenJournalLineRec: Record "Gen. Journal Line";
//         FeeSetupCS1: Record "Fee Setup-CS";
//         CustomerRec: Record Customer;
//         GD2: Code[20];
//     begin
//         with GenJournalLine do begin
//             if GenJournalLine."Document Type" = GenJournalLine."Document Type"::Invoice then begin
//                 GD2 := '';
//                 CustomerRec.reset();
//                 CustomerRec.SetRange("Enrollment No.", GenJournalLine."Enrollment No.");
//                 if CustomerRec.FindFirst() then;

//                 FeeSetupCS1.Reset();
//                 FeeSetupCS1.SetRange("Global Dimension 1 Code", CustomerRec."Global Dimension 1 Code");
//                 IF FeeSetupCS1.FindFirst() then;

//                 GenJournalLineRec.Reset();
//                 GenJournalLineRec.SetCurrentKey("Shortcut Dimension 2 Code");
//                 GenJournalLineRec.SetRange("Journal Template Name", FeeSetupCS1."Journal Template Name");
//                 GenJournalLineRec.SetRange("Journal Batch Name", FeeSetupCS1."Journal Batch Name");
//                 GenJournalLineRec.SETRANGE("Document Type", GenJournalLineRec."Document Type"::Invoice);
//                 GenJournalLineRec.SETRANGE("Enrollment No.", CustomerRec."Enrollment No.");
//                 GenJournalLineRec.SETRANGE("Academic Year", CustomerRec."Academic Year");
//                 GenJournalLineRec.SETRANGE(Semester, CustomerRec.Semester);
//                 if GenJournalLineRec.FindSet() then begin
//                     Repeat
//                         if GD2 = '' then
//                             GD2 := GenJournalLineRec."Shortcut Dimension 2 Code"
//                         Else
//                             if GD2 <> GenJournalLineRec."Shortcut Dimension 2 Code" then
//                                 Error('Global Dimension 2 Code must be Sames For All Lines of Journal');
//                     until GenJournalLineRec.Next() = 0
//                 end
//             end;
//         end;
//     end;
//     //SD-SN-21-Dec-2020 -

//     // Sync to Salesforce - Start
//     //SD-SN-22-Dec-2020 +
//     // [EventSubscriber(ObjectType::Table, 50339, 'OnAfterInsertEvent', '', False, false)]
//     // local procedure HousingCreate(var Rec: Record "Housing Master")
//     // var
//     //     SalesForceCodeunit: Codeunit SLcMToSalesforce;
//     // begin
//     //     SalesForceCodeunit.HousingMasterSFInsert(Rec);
//     // end;

//     // [EventSubscriber(ObjectType::Table, 50339, 'OnAfterModifyEvent', '', False, false)]
//     // local procedure HousingModify(var Rec: Record "Housing Master")
//     // var
//     //     SalesForceCodeunit: Codeunit SLcMToSalesforce;
//     // begin
//     //     SalesForceCodeunit.HousingMasterSFModify(Rec);
//     // end;

//     [EventSubscriber(ObjectType::Table, 50177, 'OnAfterInsertEvent', '', False, false)]
//     local procedure ScholarshipMasterCreate(var Rec: Record "Scholarship Header-CS")
//     var
//         SalesForceCodeunit: Codeunit SLcMToSalesforce;
//     begin
//         SalesForceCodeunit.ScholarshipHeaderSFInsert(Rec);
//     end;

//     [EventSubscriber(ObjectType::Table, 50177, 'OnAfterModifyEvent', '', False, false)]
//     local procedure ScholarshipMasterUpdate(var Rec: Record "Scholarship Header-CS")
//     var
//         SalesForceCodeunit: Codeunit SLcMToSalesforce;
//     begin
//         SalesForceCodeunit.ScholarshipHeaderSFModify(Rec);
//     end;
//     //ScholarshipLineCreate
//     [EventSubscriber(ObjectType::Table, 50178, 'OnAfterInsertEvent', '', False, false)]
//     local procedure ScholarshipLineCreate(var Rec: Record "Scholarship Line-CS")
//     var
//         SalesForceCodeunit: Codeunit SLcMToSalesforce;
//     begin
//         SalesForceCodeunit.ScholarshipLineSFInsert(Rec);
//     end;

//     [EventSubscriber(ObjectType::Table, 50178, 'OnAfterModifyEvent', '', False, false)]
//     local procedure ScholarshipLineModify(var Rec: Record "Scholarship Line-CS")
//     var
//         SalesForceCodeunit: Codeunit SLcMToSalesforce;
//     begin
//         SalesForceCodeunit.ScholarshipLinesSFModify(Rec);
//     end;

//     // [EventSubscriber(ObjectType::Table, 50057, 'OnAfterValidateEvent', 'On Ground Check-In Complete On', False, false)]
//     // local procedure OnlineRegistration(var Rec: Record "Student Master-CS"; var xRec: Record "Student Master-CS"; CurrFieldNo: Integer)
//     // var
//     //     SalesForceCodeunit: Codeunit SLcMToSalesforce;
//     // begin
//     //     if Rec."On Ground Check-In Complete On" <> xRec."On Ground Check-In Complete On" then
//     //         if (Rec."On Ground Check-In Complete On" <> 0D) or (Rec."OLR Completed Date" <> 0D) then
//     //             SalesForceCodeunit.OnlineRegistrationInsert(Rec);

//     // end;
//     //arv


//     [EventSubscriber(ObjectType::Table, 50057, 'OnAfterValidateEvent', 'Status', False, false)]
//     procedure EnrolmentStatus(var Rec: Record "Student Master-CS"; var xRec: Record "Student Master-CS"; CurrFieldNo: Integer)
//     var
//         SalesForceCodeunit: Codeunit SLcMToSalesforce;
//     begin
//         if Rec.Status <> xRec.Status then
//             if Rec.status <> '' then
//                 SalesForceCodeunit.StudentStatusSFInsert(Rec);
//     end;
//     //SD-SN-22-Dec-2020 -
//     // Sync to Salesforce - End


//     [EventSubscriber(ObjectType::Page, 50069, 'CallExaminationEventforStudentPercentage', '', false, false)]
//     local procedure CSGetAttdPercentageOnStudentInternalExamAttendanceLine(InternalAttendanceHeaderCS: Record "Internal Attendance Header-CS")
//     var
//         MainStudentSubjectCS: Record "Main Student Subject-CS";
//         InternalAttendanceLineCS: Record "Internal Attendance Line-CS";

//         InternalAttendanceLineCS2: Record "Internal Attendance Line-CS";
//         OptionalStudentSubjectCS: Record "Optional Student Subject-CS";
//         LineNo: Integer;
//     begin
//         //Code Add For  Get Student For  Internal Exam Attendance Line::CSPL-00059::19022019: Start
//         LineNo := 0;
//         WITH InternalAttendanceHeaderCS DO
//             IF Status = Status::Open THEN BEGIN
//                 TESTFIELD("Course Code");
//                 IF "Type Of Course" = "Type Of Course"::Semester THEN
//                     TESTFIELD(Semester)
//                 ELSE
//                     TESTFIELD(Year);
//                 TESTFIELD("Subject Class");
//                 TESTFIELD("Subject Type");
//                 TESTFIELD("Subject Code");
//                 TESTFIELD("Academic Year");
//                 TESTFIELD("Global Dimension 1 Code");
//                 TESTFIELD("Global Dimension 2 Code");
//                 TESTFIELD("Type Of Course");
//                 TESTFIELD("Document Type");
//                 TESTFIELD("Exam Type");
//                 TESTFIELD("Room No.");
//                 IF "Exam Type" = "Exam Type"::"Re-Sessional" THEN BEGIN
//                     InternalAttendanceLineCS2.Reset();
//                     InternalAttendanceLineCS2.SETCURRENTKEY(Course, Semester, "Academic Year", "Subject Code", Section, "Subject Type", "Global Dimension 1 Code",
//                       "Global Dimension 2 Code", "Type Of Course", Year);
//                     InternalAttendanceLineCS2.SETRANGE(Course, "Course Code");
//                     InternalAttendanceLineCS2.SETRANGE(Semester, Semester);
//                     InternalAttendanceLineCS2.SETRANGE("Subject Type", "Subject Type");
//                     InternalAttendanceLineCS2.SETRANGE("Subject Code", "Subject Code");
//                     InternalAttendanceLineCS2.SETRANGE(Section, Section);
//                     InternalAttendanceLineCS2.SETRANGE("Academic Year", "Academic Year");
//                     InternalAttendanceLineCS2.SETRANGE("Global Dimension 1 Code", "Global Dimension 1 Code");
//                     InternalAttendanceLineCS2.SETRANGE("Global Dimension 2 Code", "Global Dimension 2 Code");
//                     InternalAttendanceLineCS2.SETRANGE("Type Of Course", "Type Of Course");
//                     InternalAttendanceLineCS2.SETRANGE(Year, Year);
//                     InternalAttendanceLineCS2.SETRANGE("Applicable for Re-Sessional", TRUE);
//                     InternalAttendanceLineCS2.SETRANGE(Status, InternalAttendanceLineCS2.Status::Released);
//                     IF InternalAttendanceLineCS2.FINDSET() THEN
//                         REPEAT
//                             LineNo += 10000;
//                             InternalAttendanceLineCS.INIT();
//                             InternalAttendanceLineCS.VALIDATE("Document No.", "No.");
//                             InternalAttendanceLineCS.VALIDATE("Line No.", LineNo);
//                             InternalAttendanceLineCS.VALIDATE("Student No.", InternalAttendanceLineCS2."Student No.");
//                             InternalAttendanceLineCS."Enrollment No." := InternalAttendanceLineCS2."Enrollment No.";
//                             InternalAttendanceLineCS."Attendance Type" := InternalAttendanceLineCS."Attendance Type"::Present;
//                             InternalAttendanceLineCS.Insert();
//                         UNTIL InternalAttendanceLineCS2.NEXT() = 0;
//                 END
//                 ELSE
//                     IF "Subject Type" = 'CORE' THEN BEGIN
//                         MainStudentSubjectCS.Reset();
//                         MainStudentSubjectCS.SETCURRENTKEY(Course, Semester, "Academic Year", "Subject Code", Section, "Subject Type", "Global Dimension 1 Code",
//                           "Global Dimension 2 Code", "Type Of Course", Year);
//                         MainStudentSubjectCS.SETRANGE(Course, "Course Code");
//                         MainStudentSubjectCS.SETRANGE(Semester, Semester);
//                         MainStudentSubjectCS.SETRANGE("Academic Year", "Academic Year");
//                         MainStudentSubjectCS.SETRANGE("Subject Type", "Subject Type");
//                         MainStudentSubjectCS.SETRANGE("Subject Code", "Subject Code");
//                         MainStudentSubjectCS.SETRANGE(Section, Section);
//                         MainStudentSubjectCS.SETRANGE("Global Dimension 1 Code", "Global Dimension 1 Code");
//                         MainStudentSubjectCS.SETRANGE("Global Dimension 2 Code", "Global Dimension 2 Code");
//                         MainStudentSubjectCS.SETRANGE("Type Of Course", "Type Of Course");
//                         IF MainStudentSubjectCS.FINDSET() THEN
//                             REPEAT
//                                 LineNo += 10000;
//                                 InternalAttendanceLineCS.INIT();
//                                 InternalAttendanceLineCS.VALIDATE("Document No.", "No.");
//                                 InternalAttendanceLineCS.VALIDATE("Line No.", LineNo);
//                                 InternalAttendanceLineCS.VALIDATE("Student No.", MainStudentSubjectCS."Student No.");
//                                 InternalAttendanceLineCS."Enrollment No." := MainStudentSubjectCS."Enrollment No";
//                                 InternalAttendanceLineCS."Attendance Type" := InternalAttendanceLineCS."Attendance Type"::Present;
//                                 InternalAttendanceLineCS.Insert();
//                             UNTIL MainStudentSubjectCS.NEXT() = 0;
//                     END ELSE BEGIN
//                         OptionalStudentSubjectCS.Reset();
//                         OptionalStudentSubjectCS.SETCURRENTKEY(Course, Semester, "Academic Year", "Subject Code", Section, "Subject Type", "Global Dimension 1 Code",
//                           "Global Dimension 2 Code", "Type Of Course", Year);
//                         OptionalStudentSubjectCS.SETRANGE(Course, "Course Code");
//                         OptionalStudentSubjectCS.SETRANGE(Semester, Semester);
//                         OptionalStudentSubjectCS.SETRANGE("Academic Year", "Academic Year");
//                         OptionalStudentSubjectCS.SETRANGE("Subject Type", "Subject Type");
//                         OptionalStudentSubjectCS.SETRANGE("Subject Code", "Subject Code");
//                         OptionalStudentSubjectCS.SETRANGE(Section, Section);
//                         OptionalStudentSubjectCS.SETRANGE("Global Dimension 1 Code", "Global Dimension 1 Code");
//                         OptionalStudentSubjectCS.SETRANGE("Global Dimension 2 Code", "Global Dimension 2 Code");
//                         OptionalStudentSubjectCS.SETRANGE("Type Of Course", "Type Of Course");
//                         OptionalStudentSubjectCS.SETRANGE(Year, Year);
//                         IF OptionalStudentSubjectCS.FINDSET() THEN
//                             REPEAT
//                                 LineNo += 10000;
//                                 InternalAttendanceLineCS.INIT();
//                                 InternalAttendanceLineCS.VALIDATE("Document No.", "No.");
//                                 InternalAttendanceLineCS.VALIDATE("Line No.", LineNo);
//                                 InternalAttendanceLineCS.VALIDATE("Student No.", OptionalStudentSubjectCS."Student No.");
//                                 InternalAttendanceLineCS."Enrollment No." := OptionalStudentSubjectCS."Enrollment No";
//                                 InternalAttendanceLineCS."Attendance Type" := InternalAttendanceLineCS."Attendance Type"::Present;
//                                 InternalAttendanceLineCS.Insert();
//                             UNTIL OptionalStudentSubjectCS.NEXT() = 0;
//                     END;

//             END
//             ELSE
//                 TESTFIELD(Status, Status::Open);

//         //Code Add For  Get Student For  Internal Exam Attendance Line::CSPL-00059::19022019: End
//     end;

//     [EventSubscriber(ObjectType::Table, 50110, 'OnAfterDeleteEvent', '', false, false)]
//     local procedure CSOnDeleteOfStudentInternalExamAttendanceHeader(var Rec: Record "Internal Attendance Header-CS"; RunTrigger: Boolean)
//     var
//         InternalAttendanceLineCS: Record "Internal Attendance Line-CS";
//     begin
//         //Code Add For Delete Of Student Internal Exam Attendance Header::CSPL-00059::19022019: Start
//         InternalAttendanceLineCS.Reset();
//         InternalAttendanceLineCS.SETRANGE("Document No.", Rec."No.");
//         IF InternalAttendanceLineCS.FINDSET() THEN
//             InternalAttendanceLineCS.DELETEALL();
//         //Code Add For Delete Of Student Internal Exam Attendance Header::CSPL-00059::19022019: End
//     end;

//     [EventSubscriber(ObjectType::Page, 50069, 'CallExaminationEventforStudentPercentage', '', false, false)]
//     local procedure CSGetAttdPercentageOnStudentInternalExamAttendanceLines(InternalAttendanceHeaderCS: Record "Internal Attendance Header-CS")
//     var
//         ClassAttendanceLineCS: Record "Class Attendance Line-CS";
//         InternalAttendanceLineCS: Record "Internal Attendance Line-CS";
//         TotalAttendance: Integer;
//         PresentAttendance: Integer;
//     begin
//         //Code Add For  Get Attd Percentage On Student Internal Exam Attendance Line::CSPL-00059::19022019: Start
//         WITH InternalAttendanceHeaderCS DO BEGIN
//             InternalAttendanceLineCS.Reset();
//             InternalAttendanceLineCS.SETRANGE("Document No.", "No.");
//             IF InternalAttendanceLineCS.FINDSET() THEN
//                 REPEAT
//                     TotalAttendance := 0;
//                     PresentAttendance := 0;
//                     ClassAttendanceLineCS.Reset();
//                     ClassAttendanceLineCS.SETCURRENTKEY("Course Code", Semester, "Subject Code", "Student No.", "Academic Year", "Subject Type",
//                       Section, "Type Of Course", Year);
//                     ClassAttendanceLineCS.SETRANGE("Course Code", InternalAttendanceLineCS.Course);
//                     ClassAttendanceLineCS.SETRANGE(Semester, InternalAttendanceLineCS.Semester);
//                     ClassAttendanceLineCS.SETRANGE("Subject Code", InternalAttendanceLineCS."Subject Code");
//                     ClassAttendanceLineCS.SETRANGE("Subject Type", InternalAttendanceLineCS."Subject Type");
//                     ClassAttendanceLineCS.SETRANGE("Student No.", InternalAttendanceLineCS."Student No.");
//                     ClassAttendanceLineCS.SETRANGE("Academic Year", InternalAttendanceLineCS."Academic Year");
//                     ClassAttendanceLineCS.SETRANGE("Global Dimension 1 Code", InternalAttendanceLineCS."Global Dimension 1 Code");
//                     ClassAttendanceLineCS.SETRANGE("Global Dimension 2 Code", InternalAttendanceLineCS."Global Dimension 2 Code");
//                     ClassAttendanceLineCS.SETRANGE("Type Of Course", InternalAttendanceLineCS."Type Of Course");
//                     IF ClassAttendanceLineCS.FINDSET() THEN
//                         TotalAttendance := ClassAttendanceLineCS.count();
//                     ClassAttendanceLineCS.SETRANGE("Attendance Type", ClassAttendanceLineCS."Attendance Type"::Present);
//                     IF ClassAttendanceLineCS.FINDSET() THEN
//                         PresentAttendance := ClassAttendanceLineCS.count();
//                     IF TotalAttendance <> 0 THEN
//                         InternalAttendanceLineCS."Attendance %" := (PresentAttendance / TotalAttendance) * 100;
//                     InternalAttendanceLineCS.Modify();
//                 UNTIL InternalAttendanceLineCS.NEXT() = 0;
//         END;
//         //Code Add For  Get Attd Percentage On Student Internal Exam Attendance Line::CSPL-00059::19022019: End
//     end;

//     procedure CSGetAttdPercentageOnStudentExternalExamLine(ExternalExamHeaderCS: Record "External Exam Header-CS"; var "Attendance%": Decimal)
//     var
//         ClassAttendanceLineCS: Record "Class Attendance Line-CS";
//         // InternalAttendanceLineCS: Record "Internal Attendance Line-CS";
//         ExternalExamLineCS: Record "External Exam Line-CS";
//         TotalAttendance: Integer;
//         PresentAttendance: Integer;

//     begin
//         //Code Add For  Get Attd Percentage On Student External Exam Line::CSPL-00059::19022019: Start
//         WITH ExternalExamHeaderCS DO BEGIN

//             ExternalExamLineCS.Reset();
//             ExternalExamLineCS.SETRANGE("Document No.", "No.");
//             IF ExternalExamLineCS.FINDSET() THEN
//                 REPEAT
//                     TotalAttendance := 0;
//                     PresentAttendance := 0;
//                     ClassAttendanceLineCS.Reset();
//                     ClassAttendanceLineCS.SETCURRENTKEY("Course Code", Semester, "Subject Code", "Student No.", "Academic Year", "Subject Type",
//                       Section, "Type Of Course", Year);
//                     ClassAttendanceLineCS.SETRANGE("Course Code", ExternalExamLineCS.Course);
//                     ClassAttendanceLineCS.SETRANGE(Semester, ExternalExamLineCS.Semester);
//                     ClassAttendanceLineCS.SETRANGE("Subject Code", ExternalExamLineCS."Subject Code");
//                     ClassAttendanceLineCS.SETRANGE("Subject Type", ExternalExamLineCS."Subject Type");
//                     ClassAttendanceLineCS.SETRANGE("Student No.", ExternalExamLineCS."Student No.");
//                     ClassAttendanceLineCS.SETRANGE("Academic Year", ExternalExamLineCS."Academic year");
//                     ClassAttendanceLineCS.SETRANGE("Global Dimension 1 Code", ExternalExamLineCS."Global Dimension 1 Code");
//                     ClassAttendanceLineCS.SETRANGE("Global Dimension 2 Code", ExternalExamLineCS."Global Dimension 2 Code");
//                     ClassAttendanceLineCS.SETRANGE("Type Of Course", ExternalExamLineCS."Type Of Course");
//                     IF ClassAttendanceLineCS.FINDSET() THEN
//                         TotalAttendance := ClassAttendanceLineCS.count();
//                     ClassAttendanceLineCS.SETRANGE("Attendance Type", ClassAttendanceLineCS."Attendance Type"::Present);
//                     IF ClassAttendanceLineCS.FINDSET() THEN
//                         PresentAttendance := ClassAttendanceLineCS.count();
//                     IF TotalAttendance <> 0 THEN
//                         ExternalExamLineCS."Attendance %" := (PresentAttendance / TotalAttendance) * 100;
//                     ExternalExamLineCS.Modify();
//                 UNTIL ExternalExamLineCS.NEXT() = 0;
//         END;
//         //Code Add For  Get Attd Percentage On Student External Exam Line::CSPL-00059::19022019: End
//     end;

//     // [EventSubscriber(ObjectType::Page, 50133, 'CallExternalExaminationEventforStudentcs', '', false, false)]
//     // local procedure CSGetStudentforExternalExamAttendanceLine(ExternalAttendanceHeaderCS: Record "External Attendance Header-CS")
//     // var
//     //     InternalAttendanceLineCS: Record "Internal Attendance Line-CS";

//     //     SetupExaminationCS: Record "Setup Examination -CS";
//     //     MainStudentSubjectCS: Record "Main Student Subject-CS";
//     //     OptionalStudentSubjectCS: Record "Optional Student Subject-CS";
//     //     ExternalAttendanceLineCS: Record "External Attendance Line-CS";
//     //     ExternalAttendanceLineCS1: Record "External Attendance Line-CS";
//     //     StudentMasterCS: Record "Student Master-CS";
//     //     //ExternalExamLineCS: Record "External Exam Line-CS";
//     //     LineNo: Integer;
//     // begin
//     //     //Code Add For  Get Student For  External Exam Attendance Line::CSPL-00059::19022019: Start
//     //     LineNo := 0;
//     //     WITH ExternalAttendanceHeaderCS DO
//     //         IF Status = Status::Open THEN BEGIN
//     //             IF "Type Of Course" = "Type Of Course"::Semester THEN
//     //                 TESTFIELD(Semester)
//     //             ELSE
//     //                 TESTFIELD(Year);

//     //             TESTFIELD("Subject Class");
//     //             TESTFIELD("Subject Type");
//     //             TESTFIELD("Subject Code");
//     //             TESTFIELD("Academic Year");
//     //             TESTFIELD("Global Dimension 1 Code");
//     //             TESTFIELD("Global Dimension 2 Code");
//     //             TESTFIELD("Type Of Course");
//     //             TESTFIELD("Document Type");
//     //             TESTFIELD("Exam Type");
//     //             SetupExaminationCS.GET();
//     //             "Actual Attendance Per %" := SetupExaminationCS."Min. External Exam Attd. Per.";
//     //             "Attendance Per %" := "Actual Attendance Per %";
//     //             Modify();
//     //             SetupExaminationCS.GET();
//     //             SetupExaminationCS.TESTFIELD("Min. External Exam Attd. Per.");
//     //             IF "Subject Type" = 'CORE' THEN BEGIN
//     //                 MainStudentSubjectCS.Reset();
//     //                 MainStudentSubjectCS.SETCURRENTKEY(Course, Semester, "Academic Year", "Subject Code", Section, "Subject Type", "Global Dimension 1 Code",
//     //                   "Global Dimension 2 Code", "Type Of Course", Year);
//     //                 MainStudentSubjectCS.SETRANGE("Academic Year", "Academic Year");
//     //                 MainStudentSubjectCS.SETRANGE("Subject Type", "Subject Type");
//     //                 MainStudentSubjectCS.SETRANGE("Subject Code", "Subject Code");
//     //                 MainStudentSubjectCS.SETRANGE(Semester, Semester);
//     //                 IF MainStudentSubjectCS.FINDSET() THEN
//     //                     REPEAT
//     //                         LineNo += 10000;
//     //                         ExternalAttendanceLineCS1.INIT();
//     //                         ExternalAttendanceLineCS1."Document No." := "No.";
//     //                         ExternalAttendanceLineCS1."Line No." := LineNo;
//     //                         ExternalAttendanceLineCS1.VALIDATE(Course, MainStudentSubjectCS.Course);
//     //                         ExternalAttendanceLineCS1.VALIDATE(Semester, MainStudentSubjectCS.Semester);
//     //                         ExternalAttendanceLineCS1.VALIDATE("Academic Year", MainStudentSubjectCS."Academic Year");
//     //                         ExternalAttendanceLineCS1.VALIDATE("Type Of Course", MainStudentSubjectCS."Type Of Course");
//     //                         ExternalAttendanceLineCS1.VALIDATE(Year, MainStudentSubjectCS.Year);
//     //                         ExternalAttendanceLineCS1.VALIDATE(Section, MainStudentSubjectCS.Section);
//     //                         ExternalAttendanceLineCS1.VALIDATE("Document Type", ExternalAttendanceHeaderCS."Document Type"::External);
//     //                         ExternalAttendanceLineCS1.VALIDATE("Exam Type", "Exam Type");
//     //                         ExternalAttendanceLineCS1.VALIDATE("Global Dimension 1 Code", MainStudentSubjectCS."Global Dimension 1 Code");
//     //                         ExternalAttendanceLineCS1.VALIDATE("Global Dimension 2 Code", MainStudentSubjectCS."Global Dimension 2 Code");
//     //                         ExternalAttendanceLineCS1.VALIDATE("Subject Code", MainStudentSubjectCS."Subject Code");
//     //                         ExternalAttendanceLineCS1.VALIDATE("Subject Type", MainStudentSubjectCS."Subject Type");
//     //                         ExternalAttendanceLineCS1.VALIDATE("Student No.", MainStudentSubjectCS."Student No.");
//     //                         IF StudentMasterCS.GET(ExternalAttendanceLineCS1."Student No.") THEN;
//     //                         ExternalAttendanceLineCS1.VALIDATE("Enrollment No.", StudentMasterCS."Enrollment No.");
//     //                         ExternalAttendanceLineCS1.VALIDATE("Student Name", MainStudentSubjectCS."Student Name");

//     //                         InternalAttendanceLineCS.Reset();
//     //                         InternalAttendanceLineCS.SETRANGE(InternalAttendanceLineCS."Student No.", MainStudentSubjectCS."Student No.");
//     //                         InternalAttendanceLineCS.SETRANGE("Subject Code", MainStudentSubjectCS."Subject Code");
//     //                         IF InternalAttendanceLineCS.Findfirst() THEN BEGIN
//     //                             ExternalAttendanceLineCS1.VALIDATE("Attendance %", InternalAttendanceLineCS."Attendance %");
//     //                             ExternalAttendanceLineCS1.VALIDATE("Attendance Type", InternalAttendanceLineCS."Attendance Type");
//     //                         END ELSE BEGIN
//     //                             ExternalAttendanceLineCS1."Attendance %" := 0;
//     //                             ExternalAttendanceLineCS1."Attendance Type" := ExternalAttendanceLineCS1."Attendance Type"::Present;
//     //                         END;
//     //                         IF ExternalAttendanceLineCS1."Attendance %" < SetupExaminationCS."Min. External Exam Attd. Per." THEN
//     //                             ExternalAttendanceLineCS1.Detained := TRUE;
//     //                         ExternalAttendanceLineCS1.Insert();
//     //                     UNTIL MainStudentSubjectCS.NEXT() = 0;
//     //             END ELSE BEGIN
//     //                 OptionalStudentSubjectCS.Reset();
//     //                 OptionalStudentSubjectCS.SETCURRENTKEY(Course, Semester, "Academic Year", "Subject Code", Section, "Subject Type", "Global Dimension 1 Code",
//     //                   "Global Dimension 2 Code", "Type Of Course", Year);
//     //                 OptionalStudentSubjectCS.SETRANGE("Academic Year", "Academic Year");
//     //                 OptionalStudentSubjectCS.SETRANGE("Subject Type", "Subject Type");
//     //                 OptionalStudentSubjectCS.SETRANGE("Subject Code", "Subject Code");
//     //                 OptionalStudentSubjectCS.SETRANGE(Semester, Semester);
//     //                 IF OptionalStudentSubjectCS.FINDSET() THEN
//     //                     REPEAT
//     //                         LineNo += 10000;
//     //                         ExternalAttendanceLineCS.INIT();
//     //                         ExternalAttendanceLineCS."Document No." := "No.";
//     //                         ExternalAttendanceLineCS."Line No." := LineNo;
//     //                         ExternalAttendanceLineCS.VALIDATE(Course, OptionalStudentSubjectCS.Course);
//     //                         ExternalAttendanceLineCS.VALIDATE(Semester, OptionalStudentSubjectCS.Semester);
//     //                         ExternalAttendanceLineCS.VALIDATE("Academic Year", OptionalStudentSubjectCS."Academic Year");
//     //                         ExternalAttendanceLineCS.VALIDATE("Type Of Course", OptionalStudentSubjectCS."Type Of Course");
//     //                         ExternalAttendanceLineCS.VALIDATE(Year, OptionalStudentSubjectCS.Year);
//     //                         ExternalAttendanceLineCS.VALIDATE(Section, OptionalStudentSubjectCS.Section);
//     //                         ExternalAttendanceLineCS.VALIDATE("Document Type", ExternalAttendanceHeaderCS."Document Type"::External);
//     //                         ExternalAttendanceLineCS.VALIDATE("Exam Type", "Exam Type");
//     //                         ExternalAttendanceLineCS.VALIDATE("Global Dimension 1 Code", OptionalStudentSubjectCS."Global Dimension 1 Code");
//     //                         ExternalAttendanceLineCS.VALIDATE("Global Dimension 2 Code", OptionalStudentSubjectCS."Global Dimension 2 Code");
//     //                         ExternalAttendanceLineCS.VALIDATE("Subject Code", OptionalStudentSubjectCS."Subject Code");
//     //                         ExternalAttendanceLineCS.VALIDATE("Subject Type", OptionalStudentSubjectCS."Subject Type");
//     //                         ExternalAttendanceLineCS.VALIDATE("Student No.", OptionalStudentSubjectCS."Student No.");
//     //                         IF StudentMasterCS.GET(ExternalAttendanceLineCS."Student No.") THEN;
//     //                         ExternalAttendanceLineCS.VALIDATE("Enrollment No.", StudentMasterCS."Enrollment No.");
//     //                         ExternalAttendanceLineCS.VALIDATE("Student Name", OptionalStudentSubjectCS."Student Name");
//     //                         InternalAttendanceLineCS.Reset();
//     //                         InternalAttendanceLineCS.SETRANGE(InternalAttendanceLineCS."Student No.", OptionalStudentSubjectCS."Student No.");
//     //                         InternalAttendanceLineCS.SETRANGE("Subject Code", MainStudentSubjectCS."Subject Code");
//     //                         IF InternalAttendanceLineCS.Findfirst() THEN BEGIN
//     //                             ExternalAttendanceLineCS.VALIDATE("Attendance %", InternalAttendanceLineCS."Attendance %");
//     //                             ExternalAttendanceLineCS.VALIDATE("Attendance Type", InternalAttendanceLineCS."Attendance Type");
//     //                         END ELSE BEGIN
//     //                             ExternalAttendanceLineCS."Attendance %" := 0;
//     //                             ExternalAttendanceLineCS."Attendance Type" := ExternalAttendanceLineCS."Attendance Type"::Present;
//     //                         END;
//     //                         IF InternalAttendanceLineCS."Attendance %" < SetupExaminationCS."Min. External Exam Attd. Per." THEN
//     //                             ExternalAttendanceLineCS.Detained := TRUE;
//     //                         ExternalAttendanceLineCS.Insert();
//     //                     UNTIL OptionalStudentSubjectCS.NEXT() = 0;
//     //             END;
//     //         END;
//     //     //END;
//     //     //Code Add For  Get Student For  External Exam Attendance Line::CSPL-00059::19022019: End
//     // end;         //Remove page 50133

//     [EventSubscriber(ObjectType::Table, 50293, 'OnAfterDeleteEvent', '', false, false)]
//     local procedure CSOnDeleteOfStudentExternalExamAttendanceHeader(var Rec: Record "External Attendance Header-CS"; RunTrigger: Boolean)
//     var
//         ExternalAttendanceLineCS: Record "External Attendance Line-CS";
//     begin
//         //Code Add For Delete Of Student External Exam Attendance Header::CSPL-00059::19022019: Start
//         ExternalAttendanceLineCS.Reset();
//         ExternalAttendanceLineCS.SETRANGE("Document No.", Rec."No.");
//         IF ExternalAttendanceLineCS.FINDSET() THEN
//             ExternalAttendanceLineCS.DELETEALL();
//         //Code Add For Delete Of Student External Exam Attendance Header::CSPL-00059::19022019: End
//     end;

//     [EventSubscriber(ObjectType::Table, 50293, 'OnAfterValidateEvent', 'Course Code', false, false)]
//     local procedure CSValidateCourseCodeOnStudentExternalExamAttendanceHeader(var Rec: Record "External Attendance Header-CS"; var xRec: Record "External Attendance Header-CS"; CurrFieldNo: Integer)
//     var
//         CourseMasterCS: Record "Course Master-CS";
//         CourseWiseSubjectLineCS: Record "Course Wise Subject Line-CS";
//     begin
//         //Code Add For  Validate Course Code On Student External Exam Attendance Header::CSPL-00059::19022019: Start
//         CourseMasterCS.Reset();
//         IF CourseMasterCS.GET(Rec."Course Code") THEN
//             Rec."Type Of Course" := CourseMasterCS."Type Of Course";
//         Rec."Course Name" := CourseMasterCS.Description;
//         CourseWiseSubjectLineCS.Reset();
//         CourseWiseSubjectLineCS.SETRANGE("Course Code", Rec."Course Code");
//         IF CourseWiseSubjectLineCS.FindFirst() THEN BEGIN
//             Rec.VALIDATE("Global Dimension 1 Code", CourseWiseSubjectLineCS."Global Dimension 1 Code");
//             Rec.VALIDATE("Global Dimension 2 Code", CourseWiseSubjectLineCS."Global Dimension 2 Code");
//         END;
//         Rec.Modify();
//         //Code Add For  Validate Course Code On Student External Exam Attendance Header::CSPL-00059::19022019: End
//     end;

//     procedure CSPerformManualRelease(var InternalExamHeaderCS: Record "Internal Exam Header-CS")
//     var

//     begin
//         //Code Add For Per Form Manual Release::CSPL-00059::19022019: Start
//         //IF ApprovalsMgmt.IsInternalExamApprovalsWorkflowEnabled(InternalExamHeaderCS) AND (InternalExamHeaderCS.Status = InternalExamHeaderCS.Status::Open) THEN
//         //  ERROR(Text002Lbl);

//         CSReleaseInternalExamDocument(InternalExamHeaderCS);
//         //Code Add For Per Form Manual Release::CSPL-00059::19022019: End
//     end;

//     local procedure CSReleaseInternalExamDocument(InternalExamHeaderCS: Record "Internal Exam Header-CS")
//     begin
//         //Code Add For  Release Internal Exam Document::CSPL-00059::19022019: Start
//         WITH InternalExamHeaderCS DO BEGIN
//             IF Status = Status::Released THEN
//                 EXIT;
//             Status := Status::Released;
//             Modify();
//         END;
//         //Code Add For  Release Internal Exam Document::CSPL-00059::19022019: End
//     end;

//     procedure CSRestrictDocumentAfterRelease(RecStatus: Option Open,Released,Published,"Open for Updation","Release For Updation"; var NoChangeAllowed: Boolean)
//     begin
//         //Code Add For  Restrict Document After Release::CSPL-00059::19022019: Start
//         IF (RecStatus = RecStatus::Released) OR (RecStatus = RecStatus::Published) OR (RecStatus = RecStatus::"Release For Updation") THEN
//             NoChangeAllowed := FALSE
//         ELSE
//             NoChangeAllowed := TRUE;
//         //Code Add For  Restrict Document After Release::CSPL-00059::19022019: End
//     end;


//     [EventSubscriber(ObjectType::Table, 50296, 'OnAfterInsertEvent', '', false, false)]
//     local procedure CSOnInsertOfRoomAllocationLine(var Rec: Record "Room Alloted Line-CS"; RunTrigger: Boolean)
//     var
//         RoomAllotedHeadCS: Record "Room Alloted Head-CS";
//     begin
//         //Code Add For  Insert Of Room Allocation Line::CSPL-00059::19022019: Start
//         RoomAllotedHeadCS.Reset();
//         IF RoomAllotedHeadCS.GET(Rec."Document No.") THEN BEGIN
//             Rec.VALIDATE("Exam Type", RoomAllotedHeadCS."Exam Type");
//             Rec.Modify();
//         END;
//         //Code Add For  Insert Of Room Allocation Line::CSPL-00059::19022019: End
//     end;

//     [EventSubscriber(ObjectType::Table, 50296, 'OnAfterValidateEvent', 'Course', false, false)]
//     local procedure CSOnValidateCourseCodeOfRoomAllocationHeader(var Rec: Record "Room Alloted Line-CS"; var xRec: Record "Room Alloted Line-CS"; CurrFieldNo: Integer)
//     var
//         CourseMasterCS: Record "Course Master-CS";
//     begin
//         //Code Add For Validate Course Code Of Room Allocation Header::CSPL-00059::19022019: Start

//         CourseMasterCS.Reset();
//         IF CourseMasterCS.GET(Rec.Course) THEN
//             Rec.VALIDATE("Type Of Course", CourseMasterCS."Type Of Course");
//         //Code Add For Validate Course Code Of Room Allocation Header::CSPL-00059::19022019: End
//     end;

//     [EventSubscriber(ObjectType::Table, 50295, 'OnAfterDeleteEvent', '', false, false)]
//     local procedure CSOnDeleteOfRoomAllocationHeader(var Rec: Record "Room Alloted Head-CS"; RunTrigger: Boolean)
//     var
//         RoomAllotedLineCS: Record "Room Alloted Line-CS";
//     begin
//         //Code Add For Delete Of Room Allocation Header::CSPL-00059::19022019: Start
//         RoomAllotedLineCS.Reset();
//         RoomAllotedLineCS.SETRANGE("Document No.", Rec."No.");
//         IF RoomAllotedLineCS.FINDSET() THEN
//             RoomAllotedLineCS.DELETEALL();
//         //Code Add For Delete Of Room Allocation Header::CSPL-00059::19022019: End
//     end;

//     [EventSubscriber(ObjectType::Table, 50110, 'OnAfterValidateEvent', 'Room No.', false, false)]
//     local procedure CSOnValidateOfRoomOnStudentInternalExamAttendanceHeader(var Rec: Record "Internal Attendance Header-CS"; var xRec: Record "Internal Attendance Header-CS"; CurrFieldNo: Integer)
//     var
//         RoomAllotedLineCS: Record "Room Alloted Line-CS";
//     begin
//         //Code Add For  OnValidateOfRoomOnStudentInternalExamAttendanceHeader::CSPL-00059::19022019: Start
//         IF Rec."Room No." = '' THEN
//             Rec."Room Line No" := 0;
//         RoomAllotedLineCS.Reset();
//         RoomAllotedLineCS.SETRANGE("Document No.", Rec."Room No.");
//         RoomAllotedLineCS.SETRANGE("Exam Type", Rec."Document Type");
//         RoomAllotedLineCS.SETRANGE(Course, Rec."Course Code");
//         RoomAllotedLineCS.SETRANGE(Semester, Rec.Semester);
//         RoomAllotedLineCS.SETRANGE("Subject Type", Rec."Subject Type");
//         RoomAllotedLineCS.SETRANGE("Subject Code", Rec."Subject Code");
//         RoomAllotedLineCS.SETRANGE(Section, Rec.Section);
//         RoomAllotedLineCS.SETRANGE("Academic Year", Rec."Academic Year");
//         RoomAllotedLineCS.SETRANGE("Type Of Course", Rec."Type Of Course");
//         RoomAllotedLineCS.SETRANGE(Year, Rec.Year);
//         RoomAllotedLineCS.SETRANGE("Room Alloted", FALSE);
//         RoomAllotedLineCS.SETRANGE(Status, RoomAllotedLineCS.Status::Released);
//         IF RoomAllotedLineCS.Findfirst() THEN
//             Rec."Room Line No" := RoomAllotedLineCS."Line No.";
//         Rec.Modify();
//         //Code Add For  OnValidateOfRoomOnStudentInternalExamAttendanceHeader::CSPL-00059::19022019: End
//     end;

//     [EventSubscriber(ObjectType::Table, 50110, 'OnAfterValidateEvent', 'Subject Code', false, false)]
//     local procedure CSOnValidateSubjectCodeOnStudentInternalExamAttendanceHeader(var Rec: Record "Internal Attendance Header-CS"; var xRec: Record "Internal Attendance Header-CS"; CurrFieldNo: Integer)
//     var
//         SubjectMasterCS: Record "Subject Master-CS";
//     begin
//         //Code Add For  Validate Subject Code On Student Internal Exam Attendance Header::CSPL-00059::19022019: Start
//         IF Rec."Subject Code" = '' THEN
//             Rec."Subject Type" := '';
//         SubjectMasterCS.Reset();
//         IF SubjectMasterCS.GET(Rec."Subject Code", Rec."Course Code", Rec."Academic Year") THEN
//             Rec."Subject Type" := SubjectMasterCS."Subject Type";
//         Rec.Modify();
//         //Code Add For  Validate Subject Code On Student Internal Exam Attendance Header::CSPL-00059::19022019: End
//     end;

//     [EventSubscriber(ObjectType::Table, 50293, 'OnAfterValidateEvent', 'Subject Code', false, false)]
//     local procedure CSOnValidateSubjectCodeOnStudentExternalExamAttendanceHeader(var Rec: Record "External Attendance Header-CS"; var xRec: Record "External Attendance Header-CS"; CurrFieldNo: Integer)
//     var

//     begin
//     end;

//     [EventSubscriber(ObjectType::Table, 50296, 'OnAfterValidateEvent', 'Subject Code', false, false)]
//     local procedure CSOnValidateSubjectCodeOnRoomAloocationLine(var Rec: Record "Room Alloted Line-CS"; var xRec: Record "Room Alloted Line-CS"; CurrFieldNo: Integer)
//     var
//         SubjectMasterCS: Record "Subject Master-CS";
//     begin
//         //Code Add For Validate Subject Code On Room Aloocation Line::CSPL-00059::19022019: Start
//         IF Rec."Subject Code" = '' THEN
//             Rec."Subject Type" := '';
//         SubjectMasterCS.Reset();
//         IF SubjectMasterCS.GET(Rec."Subject Code", Rec.Course, Rec."Academic Year") THEN
//             Rec."Subject Type" := SubjectMasterCS."Subject Type";
//         //Code Add For Validate Subject Code On Room Aloocation Line::CSPL-00059::19022019: End
//     end;

//     [EventSubscriber(ObjectType::Table, 50293, 'OnAfterValidateEvent', 'Room No.', false, false)]
//     local procedure CSOnValidateOfRoomOnStudentExternalExamAttendanceHeader(var Rec: Record "External Attendance Header-CS"; var xRec: Record "External Attendance Header-CS"; CurrFieldNo: Integer)
//     var
//         RoomAllotedLineCS: Record "Room Alloted Line-CS";
//     begin
//         //Code Add For Validate Of Room On Student External Exam Attendance Header::CSPL-00059::19022019: Start
//         IF Rec."Room No." = '' THEN
//             Rec."Room Line No" := 0;
//         RoomAllotedLineCS.Reset();
//         RoomAllotedLineCS.SETRANGE("Document No.", Rec."Room No.");
//         RoomAllotedLineCS.SETRANGE("Exam Type", Rec."Document Type");
//         RoomAllotedLineCS.SETRANGE(Course, Rec."Course Code");
//         RoomAllotedLineCS.SETRANGE(Semester, Rec.Semester);
//         RoomAllotedLineCS.SETRANGE("Subject Type", Rec."Subject Type");
//         RoomAllotedLineCS.SETRANGE("Subject Code", Rec."Subject Code");
//         RoomAllotedLineCS.SETRANGE(Section, Rec.Section);
//         RoomAllotedLineCS.SETRANGE("Academic Year", Rec."Academic Year");
//         RoomAllotedLineCS.SETRANGE("Type Of Course", Rec."Type Of Course");
//         RoomAllotedLineCS.SETRANGE(Year, Rec.Year);
//         RoomAllotedLineCS.SETRANGE("Room Alloted", FALSE);
//         RoomAllotedLineCS.SETRANGE(Status, RoomAllotedLineCS.Status::Released);
//         IF RoomAllotedLineCS.Findfirst() THEN
//             Rec."Room Line No" := RoomAllotedLineCS."Line No.";
//         Rec.Modify();
//         //Code Add For Validate Of Room On Student External Exam Attendance Header::CSPL-00059::19022019: End
//     end;

//     procedure CSOnReopenOfStudentInternalExamAttendanceHeader(InternalAttendanceHeaderCS: Record "Internal Attendance Header-CS")
//     var
//         InternalAttendanceLineCS: Record "Internal Attendance Line-CS";
//     begin
//         //Code Add For Reopen Of Student Internal Exam Attendance Header::CSPL-00059::19022019: Start
//         InternalAttendanceLineCS.Reset();
//         InternalAttendanceLineCS.SETRANGE("Document No.", InternalAttendanceHeaderCS."No.");
//         IF InternalAttendanceLineCS.FINDSET() THEN
//             InternalAttendanceLineCS.MODIFYALL(Status, InternalAttendanceLineCS.Status::Open);
//         //Code Add For Reopen Of Student Internal Exam Attendance Header::CSPL-00059::19022019: End
//     end;

//     procedure CSOnReopenOfStudentExternalExamAttendanceHeader(ExternalAttendanceHeaderCS: Record "External Attendance Header-CS")
//     var
//         ExternalAttendanceLineCS: Record "External Attendance Line-CS";
//     begin
//         //Code Add For Reopen Of Student External Exam Attendance Header::CSPL-00059::19022019: Start
//         ExternalAttendanceLineCS.Reset();
//         ExternalAttendanceLineCS.SETRANGE("Document No.", ExternalAttendanceHeaderCS."No.");
//         IF ExternalAttendanceLineCS.FINDSET() THEN
//             ExternalAttendanceLineCS.MODIFYALL(Status, ExternalAttendanceLineCS.Status::Open);
//         //Code Add For Reopen Of Student External Exam Attendance Header::CSPL-00059::19022019: End
//     end;

//     [EventSubscriber(ObjectType::Table, 50294, 'OnAfterValidateEvent', 'Answer Sheet', false, false)]
//     local procedure CSOnValidateOfAnswerSheetOnStudentExternalAttendanceLine(var Rec: Record "External Attendance Line-CS"; var xRec: Record "External Attendance Line-CS"; CurrFieldNo: Integer)
//     var
//         ExternalAttendanceLineCS: Record "External Attendance Line-CS";
//     begin
//         //Code Add For Validate Of Answer Sheet On Student External Attendance Line::CSPL-00059::19022019: Start
//         ExternalAttendanceLineCS.Reset();
//         ExternalAttendanceLineCS.SETRANGE("Document No.", Rec."Document No.");
//         ExternalAttendanceLineCS.SETRANGE("Answer Sheet", Rec."Answer Sheet");
//         IF ExternalAttendanceLineCS.Findfirst() THEN
//             ERROR(Text_10002Lbl, ExternalAttendanceLineCS."Answer Sheet");
//         //Code Add For Validate Of Answer Sheet On Student External Attendance Line::CSPL-00059::19022019: End
//     end;

//     procedure CSGetVersionNoForMasterArchiveVersions(TableID: Integer): Integer
//     var
//         MasterLogVersionArchCS: Record "Master Log Version Arch-CS";
//     begin
//         //Code Add For  Get Version No For  Master Archive Versions::CSPL-00059::19022019: Start
//         MasterLogVersionArchCS.Reset();
//         MasterLogVersionArchCS.SETRANGE("Table No.", TableID);
//         IF MasterLogVersionArchCS.FINDLAST() THEN
//             EXIT(MasterLogVersionArchCS."Version No" + 1);
//         EXIT(1);
//         //Code Add For  Get Version No For  Master Archive Versions::CSPL-00059::19022019: End
//     end;

//     procedure CSInsertToMasterArchiveVersion(TableID: Integer; FieldID: Integer; RecOldValue: Text[250]; RecNewValue: Text[250]; RecVersionNo: Integer)
//     var
//         MasterLogVersionArchCS: Record "Master Log Version Arch-CS";
//     begin
//         //Code Add For  Insert To Master Archive Version::CSPL-00059::19022019: Start
//         MasterLogVersionArchCS.INIT();
//         MasterLogVersionArchCS."Table No." := TableID;
//         MasterLogVersionArchCS."Version No" := RecVersionNo;
//         MasterLogVersionArchCS."Field No." := FieldID;
//         MasterLogVersionArchCS."Archived By" := FORMAT(UserId());
//         MasterLogVersionArchCS."Archived On" := TODAY();
//         MasterLogVersionArchCS."Old Value" := RecOldValue;
//         MasterLogVersionArchCS."New Value" := RecNewValue;
//         MasterLogVersionArchCS.Insert();
//         //Code Add For  Insert To Master Archive Version::CSPL-00059::19022019: End
//     end;

//     [EventSubscriber(ObjectType::Table, 50153, 'OnAfterValidateEvent', 'Re-Sessional', false, false)]
//     local procedure CSOnValidateOfReSessionalOnStudentInternalExamLine(var Rec: Record "Internal Exam Line-CS"; var xRec: Record "Internal Exam Line-CS"; CurrFieldNo: Integer)
//     var
//         InternalAttendanceLineCS: Record "Internal Attendance Line-CS";
//     begin
//         //Code Add For Validate Of ReSessional On Student Internal Exam Line::CSPL-00059::19022019: Start
//         InternalAttendanceLineCS.Reset();
//         InternalAttendanceLineCS.SETCURRENTKEY(Course, Semester, "Subject Code", "Subject Type", "Student No.", Section, "Academic Year", "Global Dimension 1 Code",
//           "Global Dimension 2 Code", "Type Of Course", Year, "Applicable for Re-Sessional", Status, "Document Type");
//         InternalAttendanceLineCS.SETRANGE(Course, Rec.Course);
//         InternalAttendanceLineCS.SETRANGE(Semester, Rec.Semester);
//         InternalAttendanceLineCS.SETRANGE("Subject Code", Rec."Subject Code");
//         InternalAttendanceLineCS.SETRANGE("Subject Type", Rec."Subject Type");
//         InternalAttendanceLineCS.SETRANGE("Student No.", Rec."Student No.");
//         InternalAttendanceLineCS.SETRANGE(Section, Rec.Section);
//         InternalAttendanceLineCS.SETRANGE("Academic Year", Rec."Academic Year");
//         InternalAttendanceLineCS.SETRANGE("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
//         InternalAttendanceLineCS.SETRANGE("Global Dimension 2 Code", Rec."Global Dimension 2 Code");
//         InternalAttendanceLineCS.SETRANGE("Type Of Course", Rec."Type Of Course");
//         InternalAttendanceLineCS.SETRANGE(Year, Rec.Year);
//         InternalAttendanceLineCS.SETRANGE("Applicable for Re-Sessional", TRUE);
//         InternalAttendanceLineCS.SETRANGE(Status, InternalAttendanceLineCS.Status::Released);
//         InternalAttendanceLineCS.SETRANGE("Document Type", Rec."Document Type");
//         IF NOT InternalAttendanceLineCS.Findfirst() THEN
//             ERROR(Text_10003Lbl, Rec."Student No.");
//         //Code Add For Validate Of ReSessional On Student Internal Exam Line::CSPL-00059::19022019: End
//     end;

//     [EventSubscriber(ObjectType::Table, 50154, 'OnAfterValidateEvent', 'Attendance Type', false, false)]
//     local procedure CSOnValidateAttendanceTypeOfStudentExternaExamlLine(var Rec: Record "External Exam Line-CS"; var xRec: Record "External Exam Line-CS"; CurrFieldNo: Integer)
//     begin
//         //Code Add For Validate Attendance Type Of Student Externa Examl Line::CSPL-00059::19022019: Start
//         IF Rec."Attendance Type" = Rec."Attendance Type"::Absent THEN
//             Rec.Absent := TRUE
//         ELSE
//             Rec.Absent := FALSE;
//         //Code Add For Validate Attendance Type Of Student Externa Examl Line::CSPL-00059::19022019: End
//     end;

//     // [EventSubscriber(ObjectType::Page, 50101, 'GenerateGrade', '', false, false)]
//     // local procedure CSOnGenerationOfGradeOnStudentExternalExamHeader(StudentExternalHeaderCOL: Record "External Exam Header-CS")
//     // var
//     //     ExternalExamLineCS: Record "External Exam Line-CS";
//     //     GradeCutoffMasterCS: Record "Grade Cutoff Master-CS";
//     //     GradeMasterCS: Record "Grade Master-CS";
//     //     AverageMarks: Decimal;
//     //     LineNo: Integer;
//     //     CountStd: Decimal;
//     //     CountRev: Decimal;
//     // begin
//     //     //Code Add For Generation Of Grade On Student External Exam Header::CSPL-00059::19022019: Start
//     //     WITH StudentExternalHeaderCOL DO BEGIN
//     //         LineNo := 0;
//     //         AverageMarks := 0;

//     //         ExternalExamLineCS.Reset();
//     //         ExternalExamLineCS.SETRANGE("Document No.", StudentExternalHeaderCOL."No.");
//     //         ExternalExamLineCS.SETRANGE("Grade Generated", TRUE);
//     //         IF ExternalExamLineCS.Findfirst() THEN
//     //             ERROR(Text_10005Lbl);

//     //         ExternalExamLineCS.Reset();
//     //         ExternalExamLineCS.SETRANGE("Document No.", StudentExternalHeaderCOL."No.");
//     //         ExternalExamLineCS.SETRANGE(Total, 0);
//     //         IF ExternalExamLineCS.Findfirst() THEN
//     //             ERROR(Text_10004Lbl);

//     //         ExternalExamLineCS.SETRANGE(Total);
//     //         IF ExternalExamLineCS.FINDSET() THEN BEGIN
//     //             ExternalExamLineCS.CALCSUMS(Total);
//     //             AverageMarks := (ExternalExamLineCS.Total) / ExternalExamLineCS.count();
//     //         END;

//     //         IF ExternalExamLineCS.FINDSET() THEN
//     //             REPEAT
//     //                 ExternalExamLineCS.TESTFIELD("Cr Points");
//     //             UNTIL ExternalExamLineCS.NEXT() = 0;

//     //         GradeCutoffMasterCS.Reset();
//     //         GradeCutoffMasterCS.SETRANGE("No.", "No.");
//     //         IF GradeCutoffMasterCS.FINDSET() THEN
//     //             REPEAT
//     //                 GradeCutoffMasterCS.VALIDATE("Revised Value", CSCalculateStandardDevationForGradeCalculation(GradeCutoffMasterCS.Grade, ExternalExamLineCS, AverageMarks, GradeCutoffMasterCS."Standard Calculation Formula"));
//     //                 GradeMasterCS.Reset();
//     //                 IF GradeMasterCS.GET(GradeCutoffMasterCS.Grade) THEN
//     //                     GradeCutoffMasterCS.VALIDATE("Grade Points", GradeMasterCS."Grade Points");
//     //                 GradeCutoffMasterCS.Modify();
//     //             UNTIL GradeCutoffMasterCS.NEXT() = 0
//     //         ELSE BEGIN
//     //             GradeMasterCS.Reset();
//     //             IF GradeMasterCS.FINDSET() THEN
//     //                 REPEAT
//     //                     LineNo += 10000;
//     //                     GradeCutoffMasterCS.INIT();
//     //                     GradeCutoffMasterCS.VALIDATE("No.", "No.");
//     //                     GradeCutoffMasterCS.VALIDATE("Line No", LineNo);
//     //                     GradeCutoffMasterCS.VALIDATE("Course Code", "Course Code");
//     //                     GradeCutoffMasterCS.VALIDATE(Semester, Semester);
//     //                     GradeCutoffMasterCS.VALIDATE("Subject Code", "Subject Code");
//     //                     GradeCutoffMasterCS.VALIDATE("Subject Type", "Subject Type");
//     //                     GradeCutoffMasterCS.VALIDATE("Academic Year", "Academic Year");
//     //                     GradeCutoffMasterCS.VALIDATE(Section, Section);
//     //                     GradeCutoffMasterCS.VALIDATE(Status, Status);
//     //                     GradeCutoffMasterCS.VALIDATE("Global Dimension 1 Code", "Global Dimension 1 Code");
//     //                     GradeCutoffMasterCS.VALIDATE("Global Dimension 2 Code", "Global Dimension 2 Code");
//     //                     GradeCutoffMasterCS.VALIDATE("Type Of Course", "Type Of Course");
//     //                     GradeCutoffMasterCS.VALIDATE(Year, Year);
//     //                     GradeCutoffMasterCS.VALIDATE("Document Type", "Document Type");
//     //                     GradeCutoffMasterCS.VALIDATE("Standard Calculation Formula", GradeMasterCS."Standard Formula");
//     //                     GradeCutoffMasterCS.VALIDATE(Grade, GradeMasterCS.Code);
//     //                     GradeCutoffMasterCS.VALIDATE("Standard Value", CSCalculateStandardDevationForGradeCalculation(GradeMasterCS.Code, ExternalExamLineCS, AverageMarks, GradeMasterCS."Standard Formula"));
//     //                     GradeCutoffMasterCS.VALIDATE("Grade Points", GradeMasterCS."Grade Points");
//     //                     GradeCutoffMasterCS.Insert();
//     //                 UNTIL GradeMasterCS.NEXT() = 0;
//     //         END;
//     //         ExternalExamLineCS.Reset();
//     //         ExternalExamLineCS.SETRANGE("Document No.", "No.");
//     //         ExternalExamLineCS.SETFILTER("Std. Grade", '<>%1', '');
//     //         IF ExternalExamLineCS.FindFirst() THEN BEGIN
//     //             ExternalExamLineCS.Reset();
//     //             ExternalExamLineCS.SETRANGE("Document No.", "No.");
//     //             IF ExternalExamLineCS.FINDSET() THEN
//     //                 REPEAT
//     //                     GradeCutoffMasterCS.Reset();
//     //                     GradeCutoffMasterCS.SETRANGE("No.", "No.");
//     //                     GradeCutoffMasterCS.SETFILTER("Revised Value", '<=%1', ExternalExamLineCS.Total);
//     //                     IF GradeCutoffMasterCS.FindFirst() THEN BEGIN
//     //                         ExternalExamLineCS."Rev. Grade" := GradeCutoffMasterCS.Grade;
//     //                         ExternalExamLineCS."Grade Points" := GradeCutoffMasterCS."Grade Points";
//     //                         ExternalExamLineCS."Credit Grade Points(CGP)" := ExternalExamLineCS."Cr Points" * ExternalExamLineCS."Grade Points";
//     //                         ExternalExamLineCS."Grade Generated" := TRUE;
//     //                         ExternalExamLineCS.Modify();
//     //                     END;
//     //                 UNTIL ExternalExamLineCS.NEXT() = 0;
//     //         END ELSE BEGIN
//     //             ExternalExamLineCS.Reset();
//     //             ExternalExamLineCS.SETRANGE("Document No.", "No.");
//     //             IF ExternalExamLineCS.FINDSET() THEN
//     //                 REPEAT
//     //                     GradeCutoffMasterCS.Reset();
//     //                     GradeCutoffMasterCS.SETRANGE("No.", "No.");
//     //                     GradeCutoffMasterCS.SETFILTER("Standard Value", '<=%1', ExternalExamLineCS.Total);
//     //                     IF GradeCutoffMasterCS.FindFirst() THEN BEGIN
//     //                         ExternalExamLineCS."Std. Grade" := GradeCutoffMasterCS.Grade;
//     //                         ExternalExamLineCS."Grade Points" := GradeCutoffMasterCS."Grade Points";
//     //                         ExternalExamLineCS."Credit Grade Points(CGP)" := ExternalExamLineCS."Cr Points" * ExternalExamLineCS."Grade Points";
//     //                         ExternalExamLineCS."Grade Generated" := TRUE;
//     //                         ExternalExamLineCS.Modify();
//     //                     END;
//     //                 UNTIL ExternalExamLineCS.NEXT() = 0;
//     //         END;
//     //         GradeCutoffMasterCS.Reset();
//     //         GradeCutoffMasterCS.SETRANGE("No.", "No.");
//     //         IF GradeCutoffMasterCS.FINDSET() THEN
//     //             REPEAT
//     //                 ExternalExamLineCS.Reset();
//     //                 ExternalExamLineCS.SETRANGE("Document No.", "No.");
//     //                 ExternalExamLineCS.SETRANGE("Std. Grade", GradeCutoffMasterCS.Grade);
//     //                 IF ExternalExamLineCS.FINDSET() THEN BEGIN
//     //                     GradeCutoffMasterCS."Count Std" := ExternalExamLineCS.count();
//     //                     GradeCutoffMasterCS.Modify();
//     //                 END;
//     //                 ExternalExamLineCS.SETRANGE("Std. Grade");
//     //                 ExternalExamLineCS.SETRANGE("Rev. Grade", GradeCutoffMasterCS.Grade);
//     //                 IF ExternalExamLineCS.FINDSET() THEN BEGIN
//     //                     GradeCutoffMasterCS."Count Revised" := ExternalExamLineCS.count();
//     //                     GradeCutoffMasterCS.Modify();
//     //                 END;
//     //             UNTIL GradeCutoffMasterCS.NEXT() = 0;

//     //         CountStd := 0;
//     //         CountRev := 0;
//     //         GradeCutoffMasterCS.Reset();
//     //         GradeCutoffMasterCS.SETRANGE("No.", "No.");
//     //         IF GradeCutoffMasterCS.FINDSET() THEN BEGIN
//     //             GradeCutoffMasterCS.CALCSUMS("Count Std", "Count Revised");
//     //             CountStd := GradeCutoffMasterCS."Count Std";
//     //             CountRev := GradeCutoffMasterCS."Count Revised";
//     //         END;
//     //         GradeCutoffMasterCS.Reset();
//     //         GradeCutoffMasterCS.SETRANGE("No.", "No.");
//     //         IF GradeCutoffMasterCS.FINDSET() THEN
//     //             REPEAT
//     //                 IF CountStd <> 0 THEN
//     //                     GradeCutoffMasterCS."Count Std Per" := ROUND(((GradeCutoffMasterCS."Count Std" / CountStd) * 100), 1);
//     //                 IF CountRev <> 0 THEN
//     //                     GradeCutoffMasterCS."Count Revised Per" := ROUND(((GradeCutoffMasterCS."Count Revised" / CountRev) * 100), 1);
//     //                 GradeCutoffMasterCS.Modify();
//     //             UNTIL GradeCutoffMasterCS.NEXT() = 0;
//     //     END;
//     //     //Code Add For Generation Of Grade On Student External Exam Header::CSPL-00059::19022019: End
//     // end;

//     [EventSubscriber(ObjectType::Table, 50154, 'OnAfterValidateEvent', 'Internal Mark', false, false)]
//     local procedure CSOnValidateOnInternalMarksOfStudentExternalExamLine(var Rec: Record "External Exam Line-CS"; var xRec: Record "External Exam Line-CS"; CurrFieldNo: Integer)
//     begin
//         //Code Add For Validate On Internal Marks Of Student External Exam Line::CSPL-00059::19022019: Start
//         Rec.Total := Rec."Internal Mark" + Rec."External Mark";
//         //Code Add For Validate On Internal Marks Of Student External Exam Line::CSPL-00059::19022019: End
//     end;

//     local procedure CSCalculateStandardDevationForGradeCalculation(RecGrade: Code[20]; ExternalExamLineCS1: Record "External Exam Line-CS"; AverageValue: Decimal; GradeFormula: Decimal): Integer
//     var
//         ExternalExamLineCS: Record "External Exam Line-CS";
//         Num1: Decimal;
//         Num2: Decimal;
//         Num3: Decimal;
//         Num4: Decimal;
//         FinalNum5: Decimal;

//     begin
//         //Code Add For  Calculate Standard Devation For  Grade Calculation::CSPL-00059::19022019: Start
//         Num2 := 0;
//         Num3 := 0;
//         Num4 := 0;
//         FinalNum5 := 0;
//         ExternalExamLineCS.Reset();
//         ExternalExamLineCS.SETRANGE("Document No.", ExternalExamLineCS1."Document No.");
//         IF ExternalExamLineCS.FINDSET() THEN
//             REPEAT
//                 Num1 := 0;
//                 Num1 := ExternalExamLineCS.Total - AverageValue;
//                 Num2 += POWER(Num1, 2);
//             UNTIL ExternalExamLineCS.NEXT() = 0;
//         Num3 := Num2 / ExternalExamLineCS.count();
//         Num4 := POWER(Num3, 1 / 2);
//         CASE RecGrade OF
//             'A+', 'A', 'B', 'C', 'D', 'E':
//                 FinalNum5 := ROUND((AverageValue + (GradeFormula) * Num4), 1, '=');
//             'F':
//                 FinalNum5 := 0;
//         END;
//         EXIT(FinalNum5);
//         //Code Add For  Calculate Standard Devation For  Grade Calculation::CSPL-00059::19022019: End
//     end;

//     [EventSubscriber(ObjectType::Page, 50101, 'OnReleaseReOpen', '', false, false)]
//     local procedure CSOnReleaseReOpenOfStudentExternalExamHeaderForGradeAllocationMaster(StudentExternalHeaderCOL: Record "External Exam Header-CS")
//     var
//         GradeCutoffMasterCS: Record "Grade Cutoff Master-CS";
//         ExternalExamLineCS: Record "External Exam Line-CS";
//     begin
//         //Code Add For Release ReOpen Of Student External Exam Header For  Grade Allocation Master::CSPL-00059::19022019: Start
//         ExternalExamLineCS.Reset();
//         ExternalExamLineCS.SETRANGE("Document No.", StudentExternalHeaderCOL."No.");
//         IF ExternalExamLineCS.FINDSET() THEN
//             REPEAT
//                 ExternalExamLineCS.VALIDATE(Status, StudentExternalHeaderCOL.Status);
//                 IF StudentExternalHeaderCOL.Status = StudentExternalHeaderCOL.Status::Released THEN
//                     ExternalExamLineCS.VALIDATE("Grade Generated", TRUE);
//                 IF StudentExternalHeaderCOL.Status = StudentExternalHeaderCOL.Status::Open THEN BEGIN
//                     ExternalExamLineCS.VALIDATE("Grade Generated", FALSE);
//                     ExternalExamLineCS.VALIDATE("Rev. Grade", '');
//                     ExternalExamLineCS.VALIDATE("Grade Points", 0);
//                     ExternalExamLineCS.VALIDATE("Credit Grade Points(CGP)", 0);
//                 END;
//                 ExternalExamLineCS.Modify();
//             UNTIL ExternalExamLineCS.NEXT() = 0;

//         GradeCutoffMasterCS.Reset();
//         GradeCutoffMasterCS.SETRANGE("No.", StudentExternalHeaderCOL."No.");
//         IF GradeCutoffMasterCS.FINDSET() THEN
//             REPEAT
//                 GradeCutoffMasterCS.VALIDATE(Status, StudentExternalHeaderCOL.Status);
//                 GradeCutoffMasterCS.Modify();
//             UNTIL GradeCutoffMasterCS.NEXT() = 0;
//         //Code Add For Release ReOpen Of Student External Exam Header For  Grade Allocation Master::CSPL-00059::19022019: End
//     end;

//     procedure CSReOpenStudentInternalExam(InternalExamHeaderCS: Record "Internal Exam Header-CS")
//     begin
//         //Code Add For  ReOpen Student Internal Exam::CSPL-00059::19022019: Start
//         WITH InternalExamHeaderCS DO BEGIN
//             IF Status = Status::Open THEN
//                 EXIT;
//             Status := Status::Open;
//             Modify();
//         END;
//         //Code Add For  ReOpen Student Internal Exam::CSPL-00059::19022019: End
//     end;

//     procedure CSUpdateCreditGradePointsOnStudentSubjectCollege(DocNo: Code[20]; ButtonValue: Code[20])
//     var
//         ExternalExamLineCS: Record "External Exam Line-CS";
//         MainStudentSubjectCS: Record "Main Student Subject-CS";
//     begin
//         //Code Add For  Update Credit Grade Points On Student Subject College::CSPL-00059::19022019: Start
//         ExternalExamLineCS.Reset();
//         ExternalExamLineCS.SETRANGE("Document No.", DocNo);
//         IF ExternalExamLineCS.FINDSET() THEN
//             REPEAT
//                 MainStudentSubjectCS.Reset();
//                 MainStudentSubjectCS.SETCURRENTKEY("Student No.", Course, Semester, "Academic Year", "Subject Code", Section, "Subject Type", "Global Dimension 1 Code", "Global Dimension 2 Code",
//                   "Type Of Course", Year);
//                 MainStudentSubjectCS.SETRANGE("Student No.", ExternalExamLineCS."Student No.");
//                 MainStudentSubjectCS.SETRANGE(Course, ExternalExamLineCS.Course);
//                 MainStudentSubjectCS.SETRANGE(Semester, ExternalExamLineCS.Semester);
//                 MainStudentSubjectCS.SETRANGE("Academic Year", ExternalExamLineCS."Academic year");
//                 MainStudentSubjectCS.SETRANGE("Subject Code", ExternalExamLineCS."Subject Code");
//                 MainStudentSubjectCS.SETRANGE(Section, ExternalExamLineCS.Section);
//                 MainStudentSubjectCS.SETRANGE("Subject Type", ExternalExamLineCS."Subject Type");
//                 MainStudentSubjectCS.SETRANGE("Global Dimension 1 Code", ExternalExamLineCS."Global Dimension 1 Code");
//                 MainStudentSubjectCS.SETRANGE("Global Dimension 2 Code", ExternalExamLineCS."Global Dimension 2 Code");
//                 MainStudentSubjectCS.SETRANGE("Type Of Course", ExternalExamLineCS."Type Of Course");
//                 MainStudentSubjectCS.SETRANGE(Year, ExternalExamLineCS.Year);
//                 IF MainStudentSubjectCS.FindFirst() THEN BEGIN
//                     IF ButtonValue = 'RELEASED' THEN BEGIN
//                         MainStudentSubjectCS."Credit Earned" := ExternalExamLineCS."Cr Points";
//                         MainStudentSubjectCS."Credit Grade Points Earned" := ExternalExamLineCS."Credit Grade Points(CGP)";
//                     END ELSE
//                         IF ButtonValue = 'REOPEN' THEN BEGIN
//                             MainStudentSubjectCS."Credit Earned" := 0;
//                             MainStudentSubjectCS."Credit Grade Points Earned" := 0;
//                         END;
//                     MainStudentSubjectCS.Modify();
//                 END;
//             UNTIL ExternalExamLineCS.NEXT() = 0;
//         CSUpdateGPAOnStudentCollege(ExternalExamLineCS);
//         //Code Add For  Update Credit Grade Points On Student Subject College::CSPL-00059::19022019: End
//     end;

//     procedure CSPerformExternalExamManualRelease(var ExternalExamHeaderCS: Record "External Exam Header-CS")
//     var

//     begin
//         //Code Add For  Per Form External Exam Manual Release::CSPL-00059::19022019: Start
//         // IF ApprovalsMgmt.IsExternalExamApprovalsWorkflowEnabled(ExternalExamHeaderCS) AND (ExternalExamHeaderCS.Status = ExternalExamHeaderCS.Status::Open) THEN
//         //  ERROR(Text002Lbl);

//         CSReleaseExternalExamDocument(ExternalExamHeaderCS);
//         //Code Add For  PerFor m External Exam Manual Release::CSPL-00059::19022019: End
//     end;

//     local procedure CSReleaseExternalExamDocument(ExternalExamHeaderCS: Record "External Exam Header-CS")
//     begin
//         //Code Add For  Release External Exam Document::CSPL-00059::19022019: Start
//         WITH ExternalExamHeaderCS DO BEGIN
//             IF Status = Status::Released THEN
//                 EXIT;
//             Status := Status::Released;
//             Modify();
//         END;
//         //Code Add For  Release External Exam Document::CSPL-00059::19022019: End
//     end;

//     procedure CSReOpenStudentExternalExam(StudentExternalHeaderCOL: Record "External Exam Header-CS")
//     begin
//         //Code Add For  ReOpen Student External Exam::CSPL-00059::19022019: Start
//         WITH StudentExternalHeaderCOL DO BEGIN
//             IF Status = Status::Open THEN
//                 EXIT;
//             Status := Status::Open;
//             Modify();
//         END;
//         //Code Add For  ReOpen Student External Exam::CSPL-00059::19022019: End
//     end;

//     local procedure CSUpdateGPAOnStudentCollege(ExternalExamLineCS: Record "External Exam Line-CS")
//     var
//         MainStudentSubjectCS: Record "Main Student Subject-CS";
//         StudentMasterCS: Record "Student Master-CS";
//         GPA: Integer;
//     begin
//         //Code Add For  Update GPA On Student College::CSPL-00059::19022019: Start
//         WITH ExternalExamLineCS DO
//             IF FINDSET() THEN
//                 REPEAT
//                     MainStudentSubjectCS.Reset();
//                     MainStudentSubjectCS.SETCURRENTKEY("Student No.", Course, Semester, "Academic Year");
//                     MainStudentSubjectCS.SETRANGE("Student No.", "Student No.");
//                     MainStudentSubjectCS.SETRANGE(Course, Course);
//                     MainStudentSubjectCS.SETRANGE(Semester, Semester);
//                     MainStudentSubjectCS.SETRANGE("Academic Year", "Academic year");
//                     IF MainStudentSubjectCS.FINDSET() THEN BEGIN
//                         GPA := 0;
//                         MainStudentSubjectCS.CALCSUMS("Credit Earned");
//                         MainStudentSubjectCS.CALCSUMS("Credit Grade Points Earned");
//                         IF MainStudentSubjectCS."Credit Earned" = 0 THEN
//                             GPA := 0
//                         ELSE
//                             GPA := MainStudentSubjectCS."Credit Grade Points Earned" / MainStudentSubjectCS."Credit Earned";
//                         StudentMasterCS.Reset();
//                         IF StudentMasterCS.GET("Student No.") THEN BEGIN
//                             StudentMasterCS.TESTFIELD("Type Of Course");
//                             IF StudentMasterCS."Type Of Course" = StudentMasterCS."Type Of Course"::Semester THEN
//                                 CSUpdateGPAOnStudentCollegeForSemester(StudentMasterCS, GPA, MainStudentSubjectCS)
//                             ELSE
//                                 CSUpdateGPAOnStudentCollegeForYear(StudentMasterCS, GPA, MainStudentSubjectCS);
//                         END;
//                     END;
//                 UNTIL ExternalExamLineCS.NEXT() = 0;

//         //Code Add For  Update GPA On Student College::CSPL-00059::19022019: End
//     end;

//     local procedure CSUpdateGPAOnStudentCollegeForSemester(StudentMasterCS: Record "Student Master-CS"; GPA: Decimal; MainStudentSubjectCS: Record "Main Student Subject-CS")
//     var
//         TotalCreditEarned: Decimal;
//     begin
//         //Code Add For  Update GPA On Student College For  Semester::CSPL-00059::19022019: Start
//         TotalCreditEarned := 0;
//         CASE StudentMasterCS.Semester OF
//             'I':
//                 BEGIN
//                     StudentMasterCS."Semester I GPA" := GPA;
//                     StudentMasterCS."Semester I Credit Earned" := MainStudentSubjectCS."Credit Earned";
//                 END;
//             'II':
//                 BEGIN
//                     StudentMasterCS."Semester II GPA" := GPA;
//                     StudentMasterCS."Semester II Credit Earned" := MainStudentSubjectCS."Credit Earned";
//                 END;
//             'III':
//                 BEGIN
//                     StudentMasterCS."Semester III GPA" := GPA;
//                     StudentMasterCS."Semester III Credit Earned" := MainStudentSubjectCS."Credit Earned";
//                 END;
//             'IV':
//                 BEGIN
//                     StudentMasterCS."Semester IV GPA" := GPA;
//                     StudentMasterCS."Semester IV Credit Earned" := MainStudentSubjectCS."Credit Earned";
//                 END;
//             'V':
//                 BEGIN
//                     StudentMasterCS."Semester V GPA" := GPA;
//                     StudentMasterCS."Semester V Credit Earned" := MainStudentSubjectCS."Credit Earned";
//                 END;
//             'VI':
//                 BEGIN
//                     StudentMasterCS."Semester VI GPA" := GPA;
//                     StudentMasterCS."Semester VI Credit Earned" := MainStudentSubjectCS."Credit Earned";
//                 END;
//             'VII':
//                 BEGIN
//                     StudentMasterCS."Semester VII GPA" := GPA;
//                     StudentMasterCS."Semester VII Credit Earned" := MainStudentSubjectCS."Credit Earned";
//                 END;
//             'VIII':
//                 BEGIN
//                     StudentMasterCS."Semester VIII GPA" := GPA;
//                     StudentMasterCS."Semester VIII Credit Earned" := MainStudentSubjectCS."Credit Earned";
//                 END;
//         END;
//         StudentMasterCS.Modify();
//         TotalCreditEarned := StudentMasterCS."Semester I Credit Earned" + StudentMasterCS."Semester II Credit Earned" + StudentMasterCS."Semester III Credit Earned" +
//           StudentMasterCS."Semester IV Credit Earned" + StudentMasterCS."Semester V Credit Earned" + StudentMasterCS."Semester VI Credit Earned" + StudentMasterCS."Semester VII Credit Earned" +
//             StudentMasterCS."Semester VIII Credit Earned";
//         IF TotalCreditEarned > 0 THEN
//             StudentMasterCS."Net Semester CGPA" := ((StudentMasterCS."Semester I GPA" * StudentMasterCS."Semester I Credit Earned") + (StudentMasterCS."Semester II GPA" * StudentMasterCS."Semester II Credit Earned") +
//               (StudentMasterCS."Semester III GPA" * StudentMasterCS."Semester III Credit Earned") + (StudentMasterCS."Semester IV GPA" * StudentMasterCS."Semester IV Credit Earned") +
//                 (StudentMasterCS."Semester V GPA" * StudentMasterCS."Semester I Credit Earned") + (StudentMasterCS."Semester VI GPA" * StudentMasterCS."Semester VI Credit Earned") +
//                   (StudentMasterCS."Semester VII GPA" * StudentMasterCS."Semester VII Credit Earned") + (StudentMasterCS."Semester VIII GPA" * StudentMasterCS."Semester VIII Credit Earned")) / TotalCreditEarned
//         ELSE
//             StudentMasterCS."Net Semester CGPA" := 0;
//         StudentMasterCS.Modify();
//         //Code Add For  Update GPA On Student College For  Semester::CSPL-00059::19022019: End
//     end;

//     local procedure CSUpdateGPAOnStudentCollegeForYear(StudentMasterCS: Record "Student Master-CS"; GPA: Decimal; MainStudentSubjectCS: Record "Main Student Subject-CS")
//     var
//         TotalCreditEarned: Decimal;
//     begin
//         //Code Add For  Update GPA On Student College For  Year::CSPL-00059::19022019: Start
//         TotalCreditEarned := 0;
//         CASE StudentMasterCS.Year OF
//             '1ST':
//                 BEGIN
//                     StudentMasterCS."Year 1 GPA" := GPA;
//                     StudentMasterCS."Year 1 Credit Earned" := MainStudentSubjectCS."Credit Earned";
//                 END;
//             '2ND':
//                 BEGIN
//                     StudentMasterCS."Year 2 GPA" := GPA;
//                     StudentMasterCS."Year 2 Credit Earned" := MainStudentSubjectCS."Credit Earned";
//                 END;
//             '3RD':
//                 BEGIN
//                     StudentMasterCS."Year 3 GPA" := GPA;
//                     StudentMasterCS."Year 3 Credit Earned" := MainStudentSubjectCS."Credit Earned";
//                 END;
//             '4TH':
//                 BEGIN
//                     StudentMasterCS."Year 4 GPA" := GPA;
//                     StudentMasterCS."Year 4 Credit Earned" := MainStudentSubjectCS."Credit Earned";
//                 END;
//         END;
//         StudentMasterCS.Modify();
//         TotalCreditEarned := StudentMasterCS."Year 1 Credit Earned" + StudentMasterCS."Year 2 Credit Earned" + StudentMasterCS."Year 3 Credit Earned" +
//           StudentMasterCS."Year 4 Credit Earned";
//         IF TotalCreditEarned > 0 THEN
//             StudentMasterCS."Net Year CGPA" := ((StudentMasterCS."Year 1 GPA" * StudentMasterCS."Year 1 Credit Earned") + (StudentMasterCS."Year 2 GPA" * StudentMasterCS."Year 2 Credit Earned") +
//               (StudentMasterCS."Year 3 GPA" * StudentMasterCS."Year 3 Credit Earned") + (StudentMasterCS."Year 4 GPA" * StudentMasterCS."Year 4 Credit Earned")) / TotalCreditEarned
//         ELSE
//             StudentMasterCS."Net Year CGPA" := 0;
//         StudentMasterCS.Modify();
//         //Code Add For  Update GPA On Student College For  Year::CSPL-00059::19022019: End
//     end;

//     procedure CSGetStudentsForReRegistrationOfExternalExam(ExternalExamHeaderCS: Record "External Exam Header-CS")
//     var
//         ReRegisterExaminationCS: Record "Re-Register Examination-CS";

//         StudentMasterCS: Record "Student Master-CS";
//         ExternalAttendanceLineCS: Record "External Attendance Line-CS";
//         SetupExaminationCS: Record "Setup Examination -CS";
//         ExternalExamLineCS: Record "External Exam Line-CS";
//         LineNo: Integer;
//     begin
//         //Code Add For  Get Students For  Re Registration Of External Exam::CSPL-00059::19022019: Start
//         WITH ExternalExamHeaderCS DO BEGIN
//             ReRegisterExaminationCS.Reset();
//             ReRegisterExaminationCS.SETCURRENTKEY("Course Code", "Subject Type", "Subject Code", "Staff Code", Section, "Global Dimension 1 Code", "Global Dimension 2 Code",
//               "Type Of Course", "Document Type", "Exam Type", "Previous Semester", "Previous Year", "Previous Academic Year", Selected);
//             ReRegisterExaminationCS.SETRANGE("Course Code", "Course Code");
//             ReRegisterExaminationCS.SETRANGE("Subject Type", "Subject Type");
//             ReRegisterExaminationCS.SETRANGE("Subject Code", "Subject Code");
//             ReRegisterExaminationCS.SETRANGE("Staff Code", "Staff Code");
//             ReRegisterExaminationCS.SETRANGE(Section, Section);
//             ReRegisterExaminationCS.SETRANGE("Global Dimension 1 Code", "Global Dimension 1 Code");
//             ReRegisterExaminationCS.SETRANGE("Global Dimension 2 Code", "Global Dimension 2 Code");
//             ReRegisterExaminationCS.SETRANGE("Type Of Course", "Type Of Course");
//             ReRegisterExaminationCS.SETRANGE("Document Type", "Document Type");
//             ReRegisterExaminationCS.SETRANGE("Exam Type", "Exam Type");
//             ReRegisterExaminationCS.SETRANGE("Previous Semester", Semester);
//             ReRegisterExaminationCS.SETRANGE("Previous Year", Year);
//             ReRegisterExaminationCS.SETRANGE("Previous Academic Year", "Academic Year");
//             ReRegisterExaminationCS.SETRANGE(Selected, FALSE);
//             IF ReRegisterExaminationCS.FINDSET() THEN
//                 REPEAT
//                     StudentMasterCS.GET(ReRegisterExaminationCS."Student No.");
//                     IF StudentMasterCS."Student Status" = StudentMasterCS."Student Status"::Student THEN BEGIN
//                         LineNo += 10000;
//                         ExternalExamLineCS.INIT();
//                         ExternalExamLineCS."Document No." := "No.";
//                         ExternalExamLineCS."Line No." := LineNo;
//                         ExternalExamLineCS.Course := StudentMasterCS."Course Code";
//                         ExternalExamLineCS.Semester := StudentMasterCS.Semester;
//                         ExternalExamLineCS."Academic year" := "Academic Year";
//                         ExternalExamLineCS."Exam Type" := "Exam Type";
//                         ExternalExamLineCS.VALIDATE("Global Dimension 1 Code", "Global Dimension 1 Code");
//                         ExternalExamLineCS.VALIDATE("Global Dimension 2 Code", "Global Dimension 2 Code");
//                         ExternalExamLineCS.VALIDATE("Document Type", "Document Type");
//                         ExternalExamLineCS.VALIDATE(Status, Status);
//                         ExternalExamLineCS."Subject Type" := "Subject Type";
//                         ExternalExamLineCS."Subject Code" := "Subject Code";
//                         ExternalExamLineCS."Type Of Course" := "Type Of Course";
//                         ExternalExamLineCS.Year := Year;
//                         ExternalExamLineCS."Apply Type" := ExternalExamLineCS."Apply Type"::Regular;
//                         ExternalExamLineCS.VALIDATE("Student No.", ReRegisterExaminationCS."Student No.");

//                         ExternalAttendanceLineCS.Reset();
//                         ExternalAttendanceLineCS.SETCURRENTKEY(Course, Semester, "Subject Type", "Subject Code", "Student No.", Section, "Academic Year", "Global Dimension 1 Code",
//                           "Global Dimension 2 Code", "Type Of Course", Year, "Document Type", Status);
//                         ExternalAttendanceLineCS.SETRANGE(Course, "Course Code");
//                         ExternalAttendanceLineCS.SETRANGE(Semester, Semester);
//                         ExternalAttendanceLineCS.SETRANGE("Subject Type", "Subject Type");
//                         ExternalAttendanceLineCS.SETRANGE("Subject Code", "Subject Code");
//                         ExternalAttendanceLineCS.SETRANGE("Student No.", ReRegisterExaminationCS."Student No.");
//                         ExternalAttendanceLineCS.SETRANGE(Section, Section);
//                         ExternalAttendanceLineCS.SETRANGE("Academic Year", "Academic Year");
//                         ExternalAttendanceLineCS.SETRANGE("Global Dimension 1 Code", "Global Dimension 1 Code");
//                         ExternalAttendanceLineCS.SETRANGE("Global Dimension 2 Code", "Global Dimension 2 Code");
//                         ExternalAttendanceLineCS.SETRANGE("Type Of Course", "Type Of Course");
//                         ExternalAttendanceLineCS.SETRANGE(Year, Year);
//                         ExternalAttendanceLineCS.SETRANGE("Document Type", "Document Type");
//                         ExternalAttendanceLineCS.SETRANGE(Status, ExternalAttendanceLineCS.Status::Released);
//                         IF ExternalAttendanceLineCS.Findfirst() THEN BEGIN
//                             ExternalExamLineCS."Attendance Type" := ExternalAttendanceLineCS."Attendance Type";
//                             ExternalExamLineCS."Attendance %" := ExternalAttendanceLineCS."Attendance %";
//                         END;
//                         SetupExaminationCS.GET();
//                         IF ExternalExamLineCS."Attendance %" < SetupExaminationCS."Min. External Exam Attd. Per." THEN
//                             ExternalExamLineCS.Detained := TRUE;
//                         ExternalExamLineCS.Section := StudentMasterCS.Section;
//                         ExternalExamLineCS.VALIDATE("Internal Mark", CSGetInternalMarksForReRegistrationOfExternalExam(ExternalExamHeaderCS, ReRegisterExaminationCS."Student No."));
//                         ExternalExamLineCS."Total Maximum" := "Total Maximum";
//                         ExternalExamLineCS.Insert();
//                         ReRegisterExaminationCS.Selected := TRUE;
//                         ReRegisterExaminationCS.Modify();
//                     END;
//                 UNTIL ReRegisterExaminationCS.NEXT() = 0;
//         END;
//         //Code Add For  Get Students For  Re Registration Of External Exam::CSPL-00059::19022019: End
//     end;

//     procedure CSGetInternalMarksForReRegistrationOfExternalExam(ExternalExamHeaderCS: Record "External Exam Header-CS"; StudentNo: Code[20]): Decimal
//     var
//         InternalExamLineCS: Record "Internal Exam Line-CS";
//     begin
//         //Code Add For  Get Internal Marks For  Re Registration Of External Exam::CSPL-00059::19022019: Start
//         WITH ExternalExamHeaderCS DO BEGIN
//             InternalExamLineCS.Reset();
//             InternalExamLineCS.SETCURRENTKEY(Course, Semester, "Subject Type", "Subject Code", "Student No.", Section, "Academic Year", "Global Dimension 1 Code",
//               "Global Dimension 2 Code", "Type Of Course", Year, Status);
//             InternalExamLineCS.SETRANGE(Course, "Course Code");
//             InternalExamLineCS.SETRANGE(Semester, Semester);
//             InternalExamLineCS.SETRANGE("Subject Type", "Subject Type");
//             InternalExamLineCS.SETRANGE("Subject Code", "Subject Code");
//             InternalExamLineCS.SETRANGE("Student No.", StudentNo);
//             InternalExamLineCS.SETRANGE(Section, Section);
//             InternalExamLineCS.SETRANGE("Academic Year", "Academic Year");
//             InternalExamLineCS.SETRANGE("Global Dimension 1 Code", "Global Dimension 1 Code");
//             InternalExamLineCS.SETRANGE("Global Dimension 2 Code", "Global Dimension 2 Code");
//             InternalExamLineCS.SETRANGE("Type Of Course", "Type Of Course");
//             InternalExamLineCS.SETRANGE(Year, Year);
//             InternalExamLineCS.SETRANGE(Status, InternalExamLineCS.Status::Released);
//             IF InternalExamLineCS.FINDLAST() THEN
//                 EXIT(InternalExamLineCS."Marks Obtained");
//             EXIT(0);
//         END;
//         //Code Add For  Get Internal Marks For  Re Registration Of External Exam::CSPL-00059::19022019: End
//     end;

//     [EventSubscriber(ObjectType::Table, 50154, 'OnAfterDeleteEvent', '', false, false)]
//     local procedure CSOnDeleteOnStudentExternalExamLine(var Rec: Record "External Exam Line-CS"; RunTrigger: Boolean)
//     var
//         ReRegisterExaminationCS: Record "Re-Register Examination-CS";
//     begin
//         //Code Add For Delete On Student External Exam Line::CSPL-00059::19022019: Start
//         ReRegisterExaminationCS.Reset();
//         ReRegisterExaminationCS.SETCURRENTKEY("Course Code", "Subject Type", "Subject Code", "Staff Code", Section, "Global Dimension 1 Code", "Global Dimension 2 Code",
//           "Type Of Course", "Document Type", "Exam Type", "Previous Semester", "Previous Year", "Previous Academic Year", Selected);
//         ReRegisterExaminationCS.SETRANGE("Course Code", Rec.Course);
//         ReRegisterExaminationCS.SETRANGE("Subject Type", Rec."Subject Type");
//         ReRegisterExaminationCS.SETRANGE("Subject Code", Rec."Subject Code");
//         ReRegisterExaminationCS.SETRANGE(Section, Rec.Section);
//         ReRegisterExaminationCS.SETRANGE("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
//         ReRegisterExaminationCS.SETRANGE("Global Dimension 2 Code", Rec."Global Dimension 2 Code");
//         ReRegisterExaminationCS.SETRANGE("Type Of Course", Rec."Type Of Course");
//         ReRegisterExaminationCS.SETRANGE("Document Type", Rec."Document Type");
//         ReRegisterExaminationCS.SETRANGE("Exam Type", Rec."Exam Type");
//         ReRegisterExaminationCS.SETRANGE("Previous Semester", Rec.Semester);
//         ReRegisterExaminationCS.SETRANGE("Previous Year", Rec.Year);
//         ReRegisterExaminationCS.SETRANGE("Previous Academic Year", Rec."Academic year");
//         ReRegisterExaminationCS.SETRANGE(Selected, TRUE);
//         IF ReRegisterExaminationCS.FINDLAST() THEN BEGIN
//             ReRegisterExaminationCS.Selected := FALSE;
//             ReRegisterExaminationCS.Modify();
//         END;
//         //Code Add For Delete On Student External Exam Line::CSPL-00059::19022019: End
//     end;

//     [EventSubscriber(ObjectType::Table, 50296, 'OnBeforeDeleteEvent', '', false, false)]
//     local procedure CSOnDeleteOfRoomAllocation(var Rec: Record "Room Alloted Line-CS"; RunTrigger: Boolean)
//     begin
//         //Code Add For Delete Of Room Allocation::CSPL-00059::19022019: Start
//         IF Rec."Room Alloted" THEN
//             ERROR(Text_10006Lbl);
//         //Code Add For Delete Of Room Allocation::CSPL-00059::19022019: End
//     end;

//     [EventSubscriber(ObjectType::Table, 50097, 'OnAfterValidateEvent', 'Course Code', false, false)]
//     local procedure CSOnValidateStudentAttendanceHeaderForCourseCode(var Rec: Record "Class Attendance Header-CS"; var xRec: Record "Class Attendance Header-CS"; CurrFieldNo: Integer)
//     var
//         CourseMasterCS: Record "Course Master-CS";
//     begin
//         //Code Add For Validate Student Attendance Header For  Course Code::CSPL-00059::19022019: Start
//         IF Rec."Course Code" = '' THEN BEGIN
//             Rec."Global Dimension 1 Code" := '';
//             Rec."Global Dimension 2 Code" := '';
//             Rec."Type Of Course" := Rec."Type Of Course"::" ";
//             Rec.Graduation := '';
//             Rec.Semester := '';
//             Rec.Year := '';
//             Rec.Section := '';
//             Rec.Type := Rec.Type::" ";
//             Rec."Group Code" := '';
//             Rec."Batch Code" := '';
//             Rec.Section := '';
//             Rec.Date := 0D;
//             Rec."Subject Type" := '';
//             Rec."Subject Code" := '';
//             Rec.Hour := 0;
//             Rec."Attendance By" := '';
//             Rec."Present All" := FALSE;
//             Rec."Select Unit" := '';
//             Rec."Topic Covered" := '';
//         END;

//         CourseMasterCS.Reset();
//         CourseMasterCS.SETRANGE(Code, Rec."Course Code");
//         IF CourseMasterCS.FindFirst() THEN BEGIN
//             Rec."Course Name" := CourseMasterCS.Description;
//             Rec."Global Dimension 1 Code" := CourseMasterCS."Global Dimension 1 Code";
//             Rec."Global Dimension 2 Code" := CourseMasterCS."Global Dimension 2 Code";
//             Rec."Type Of Course" := CourseMasterCS."Type Of Course";
//             Rec.Graduation := CourseMasterCS.Graduation;
//         END ELSE BEGIN
//             Rec."Course Name" := '';
//             Rec."Global Dimension 1 Code" := '';
//             Rec."Global Dimension 2 Code" := '';
//             Rec."Type Of Course" := Rec."Type Of Course"::" ";
//             Rec.Graduation := '';
//         END;
//         //Code Add For Validate Student Attendance Header For  Course Code::CSPL-00059::19022019: End
//     end;

//     procedure CSCreateAutomateInternalExamGroup()
//     var
//         CourseWiseSubjectLineCS: Record "Course Wise Subject Line-CS";
//         //SubjectMasterCS: Record "Subject Master-CS";
//         SessionalExamGroupCS: Record "Sessional Exam Group-CS";
//         EducationSetupCSCS: Record "Education Setup-CS";
//         CourseSectionMasterCS: Record "Course Section Master-CS";
//         SessionalExamGroupHeadCS: Record "Sessional Exam Group Head-CS";
//         SessionalExamGroupLineCS: Record "Sessional Exam Group Line-CS";

//         ExamGroupCodeCS: Record "Exam Group Code-CS";
//         AcademicsSetupCS: Record "Academics Setup-CS";
//         NoSeriesManagement: Codeunit "NoSeriesManagement";
//         NEXTNo: Code[20];
//         "LocLineNo.": Integer;

//     begin
//         //Code Add For  Create Automate Internal Exam Group::CSPL-00059::19022019: Start
//         AcademicsSetupCS.GET();
//         AcademicsSetupCS.TESTFIELD("Internal Exam Group No.");

//         CourseWiseSubjectLineCS.Reset();
//         CourseWiseSubjectLineCS.SETRANGE("Internal Maximum", 0);
//         IF CourseWiseSubjectLineCS.Findfirst() THEN
//             ERROR(Text_10001Lbl, CourseWiseSubjectLineCS."Course Code", CourseWiseSubjectLineCS.Semester,
//                    CourseWiseSubjectLineCS."Academic Year", CourseWiseSubjectLineCS."Subject Code");


//         UserSetupRec.Get(UserId());
//         EducationSetupCSCS.Reset();
//         EducationSetupCSCS.SetRange("Global Dimension 1 Code", UserSetupRec."Global Dimension 1 Code");
//         If EducationSetupCSCS.FindFirst() Then begin
//             EducationSetupCSCS.TESTFIELD("Academic Year");
//             EducationSetupCSCS.TESTFIELD("Global Dimension 1 Code");
//         end;


//         CourseWiseSubjectLineCS.Reset();
//         CourseWiseSubjectLineCS.SETCURRENTKEY("Course Code", "Type Of Course", Semester, Year, "Subject Classification", "Subject Type", "Subject Code");
//         CourseWiseSubjectLineCS.SETRANGE("Academic Year", EducationSetupCSCS."Academic Year");
//         CourseWiseSubjectLineCS.SETRANGE("Global Dimension 1 Code", EducationSetupCSCS."Global Dimension 1 Code");
//         CourseWiseSubjectLineCS.SETFILTER("Subject Classification", '%1|%2', 'THEORY', 'LAB');
//         IF EducationSetupCSCS."Even/Odd Semester" = EducationSetupCSCS."Even/Odd Semester"::FALL THEN
//             CourseWiseSubjectLineCS.SETFILTER(Semester, '%1|%2|%3|%4', 'II', 'IV', 'VI', 'VIII')
//         ELSE
//             IF EducationSetupCSCS."Even/Odd Semester" = EducationSetupCSCS."Even/Odd Semester"::SPRING THEN
//                 CourseWiseSubjectLineCS.SETFILTER(Semester, '%1|%2|%3|%4', 'I', 'III', 'V', 'VII');
//         CourseWiseSubjectLineCS.SETRANGE("Int. Exam Group Generated", FALSE);
//         IF CourseWiseSubjectLineCS.FINDSET() THEN
//             REPEAT

//                 NEXTNo := NoSeriesManagement.GetNEXTNo(AcademicsSetupCS."Internal Exam Group No.", 0D, TRUE);

//                 "LocLineNo." := 0;
//                 SessionalExamGroupHeadCS.INIT();
//                 SessionalExamGroupHeadCS."No." := NEXTNo;
//                 SessionalExamGroupHeadCS.VALIDATE("Course Code", CourseWiseSubjectLineCS."Course Code");
//                 SessionalExamGroupHeadCS."Type Of Course" := CourseWiseSubjectLineCS."Type Of Course";
//                 SessionalExamGroupHeadCS.Semester := CourseWiseSubjectLineCS.Semester;
//                 SessionalExamGroupHeadCS.Year := CourseWiseSubjectLineCS.Year;
//                 SessionalExamGroupHeadCS.Section := CourseSectionMasterCS."Section Code";
//                 SessionalExamGroupHeadCS."Academic Year" := EducationSetupCSCS."Academic Year";
//                 SessionalExamGroupHeadCS."Subject Class" := CourseWiseSubjectLineCS."Subject Classification";
//                 SessionalExamGroupHeadCS."Subject Type" := CourseWiseSubjectLineCS."Subject Type";
//                 SessionalExamGroupHeadCS.VALIDATE("Subject Code", CourseWiseSubjectLineCS."Subject Code");
//                 IF EducationSetupCSCS."Even/Odd Semester" = EducationSetupCSCS."Even/Odd Semester"::FALL THEN
//                     SessionalExamGroupHeadCS."Exam Group" := 'EVEN'
//                 ELSE
//                     IF EducationSetupCSCS."Even/Odd Semester" = EducationSetupCSCS."Even/Odd Semester"::SPRING THEN
//                         SessionalExamGroupHeadCS."Exam Group" := 'ODD';
//                 SessionalExamGroupHeadCS."Created By" := FORMAT(UserId());
//                 SessionalExamGroupHeadCS."Created On" := TODAY();
//                 SessionalExamGroupHeadCS.Insert();
//                 IF SessionalExamGroupHeadCS."Subject Class" = 'THEORY' THEN BEGIN
//                     SessionalExamGroupCS.Reset();
//                     IF EducationSetupCSCS."Even/Odd Semester" = EducationSetupCSCS."Even/Odd Semester"::FALL THEN
//                         SessionalExamGroupCS.SETRANGE(Group, 'EVEN')
//                     ELSE
//                         IF EducationSetupCSCS."Even/Odd Semester" = EducationSetupCSCS."Even/Odd Semester"::SPRING THEN
//                             SessionalExamGroupCS.SETRANGE(Group, 'ODD');
//                     SessionalExamGroupCS.SETFILTER("Exam Type", '%1|%2', SessionalExamGroupCS."Exam Type"::"Internal Exam", SessionalExamGroupCS."Exam Type"::Assignment);
//                     IF SessionalExamGroupCS.FINDSET() THEN
//                         REPEAT
//                             "LocLineNo." += 10000;
//                             SessionalExamGroupLineCS.INIT();
//                             SessionalExamGroupLineCS."Document No." := NEXTNo;
//                             SessionalExamGroupLineCS."Line No." += "LocLineNo.";
//                             SessionalExamGroupLineCS.Course := SessionalExamGroupHeadCS."Course Code";
//                             SessionalExamGroupLineCS.Semester := SessionalExamGroupHeadCS.Semester;
//                             SessionalExamGroupLineCS.Section := SessionalExamGroupHeadCS.Section;
//                             SessionalExamGroupLineCS."Academic year" := EducationSetupCSCS."Academic Year";
//                             SessionalExamGroupLineCS."Subject Type" := SessionalExamGroupHeadCS."Subject Type";
//                             SessionalExamGroupLineCS."Subject Code" := SessionalExamGroupHeadCS."Subject Code";
//                             SessionalExamGroupLineCS."Exam Group" := SessionalExamGroupCS.Group;
//                             SessionalExamGroupLineCS."Exam Method" := SessionalExamGroupCS."Exam Method Code";
//                             SessionalExamGroupLineCS."Type Of Course" := CourseWiseSubjectLineCS."Type Of Course";
//                             SessionalExamGroupLineCS.Year := CourseSectionMasterCS.Year;
//                             SessionalExamGroupLineCS."Global Dimension 1 Code" := EducationSetupCSCS."Global Dimension 1 Code";
//                             SessionalExamGroupLineCS."Global Dimension 2 Code" := EducationSetupCSCS."Global Dimension 2 Code";
//                             SessionalExamGroupLineCS."Created By" := FORMAT(UserId());
//                             SessionalExamGroupLineCS."Created On" := TODAY();
//                             IF ExamGroupCodeCS.GET(SessionalExamGroupCS."Exam Method Code") THEN
//                                 SessionalExamGroupLineCS."Method Description" := ExamGroupCodeCS.Description;
//                             SessionalExamGroupLineCS.Insert();
//                         UNTIL SessionalExamGroupCS.NEXT() = 0
//                 END ELSE
//                     IF SessionalExamGroupHeadCS."Subject Class" = 'LAB' THEN BEGIN
//                         SessionalExamGroupCS.Reset();
//                         IF EducationSetupCSCS."Even/Odd Semester" = EducationSetupCSCS."Even/Odd Semester"::FALL THEN
//                             SessionalExamGroupCS.SETRANGE(Group, 'EVEN')
//                         ELSE
//                             IF EducationSetupCSCS."Even/Odd Semester" = EducationSetupCSCS."Even/Odd Semester"::SPRING THEN
//                                 SessionalExamGroupCS.SETRANGE(Group, 'ODD');
//                         SessionalExamGroupCS.SETFILTER("Exam Type", '%1', SessionalExamGroupCS."Exam Type"::"Internal Lab");
//                         IF SessionalExamGroupCS.FINDSET() THEN
//                             REPEAT
//                                 "LocLineNo." += 10000;
//                                 SessionalExamGroupLineCS.INIT();
//                                 SessionalExamGroupLineCS."Document No." := NEXTNo;
//                                 SessionalExamGroupLineCS."Line No." += "LocLineNo.";
//                                 SessionalExamGroupLineCS.Course := SessionalExamGroupHeadCS."Course Code";
//                                 SessionalExamGroupLineCS.Semester := SessionalExamGroupHeadCS.Semester;
//                                 SessionalExamGroupLineCS.Section := SessionalExamGroupHeadCS.Section;
//                                 SessionalExamGroupLineCS."Academic year" := EducationSetupCSCS."Academic Year";
//                                 SessionalExamGroupLineCS."Subject Type" := SessionalExamGroupHeadCS."Subject Type";
//                                 SessionalExamGroupLineCS."Subject Code" := SessionalExamGroupHeadCS."Subject Code";
//                                 SessionalExamGroupLineCS."Exam Group" := SessionalExamGroupCS.Group;
//                                 SessionalExamGroupLineCS."Exam Method" := SessionalExamGroupCS."Exam Method Code";
//                                 SessionalExamGroupLineCS."Type Of Course" := CourseWiseSubjectLineCS."Type Of Course";
//                                 SessionalExamGroupLineCS.Year := CourseSectionMasterCS.Year;
//                                 SessionalExamGroupLineCS."Global Dimension 1 Code" := EducationSetupCSCS."Global Dimension 1 Code";
//                                 SessionalExamGroupLineCS."Global Dimension 2 Code" := EducationSetupCSCS."Global Dimension 2 Code";
//                                 SessionalExamGroupLineCS."Created By" := FORMAT(UserId());
//                                 SessionalExamGroupLineCS."Created On" := TODAY();
//                                 IF ExamGroupCodeCS.GET(SessionalExamGroupCS."Exam Method Code") THEN
//                                     SessionalExamGroupLineCS."Method Description" := ExamGroupCodeCS.Description;
//                                 SessionalExamGroupLineCS.Insert();
//                             UNTIL SessionalExamGroupCS.NEXT() = 0;
//                     END ELSE
//                         IF SessionalExamGroupHeadCS."Subject Class" = 'PROJECT' THEN BEGIN
//                             SessionalExamGroupCS.Reset();
//                             IF EducationSetupCSCS."Even/Odd Semester" = EducationSetupCSCS."Even/Odd Semester"::FALL THEN
//                                 SessionalExamGroupCS.SETRANGE(Group, 'EVEN')
//                             ELSE
//                                 IF EducationSetupCSCS."Even/Odd Semester" = EducationSetupCSCS."Even/Odd Semester"::SPRING THEN
//                                     SessionalExamGroupCS.SETRANGE(Group, 'ODD');
//                             SessionalExamGroupCS.SETFILTER("Exam Type", '%1', SessionalExamGroupCS."Exam Type"::Project);
//                             IF SessionalExamGroupCS.FINDSET() THEN
//                                 REPEAT
//                                     "LocLineNo." += 10000;
//                                     SessionalExamGroupLineCS.INIT();
//                                     SessionalExamGroupLineCS."Document No." := NEXTNo;
//                                     SessionalExamGroupLineCS."Line No." += "LocLineNo.";
//                                     SessionalExamGroupLineCS.Course := SessionalExamGroupHeadCS."Course Code";
//                                     SessionalExamGroupLineCS.Semester := SessionalExamGroupHeadCS.Semester;
//                                     SessionalExamGroupLineCS.Section := SessionalExamGroupHeadCS.Section;
//                                     SessionalExamGroupLineCS."Academic year" := EducationSetupCSCS."Academic Year";
//                                     SessionalExamGroupLineCS."Subject Type" := SessionalExamGroupHeadCS."Subject Type";
//                                     SessionalExamGroupLineCS."Subject Code" := SessionalExamGroupHeadCS."Subject Code";
//                                     SessionalExamGroupLineCS."Exam Group" := SessionalExamGroupCS.Group;
//                                     SessionalExamGroupLineCS."Exam Method" := SessionalExamGroupCS."Exam Method Code";
//                                     SessionalExamGroupLineCS."Type Of Course" := CourseWiseSubjectLineCS."Type Of Course";
//                                     SessionalExamGroupLineCS.Year := CourseSectionMasterCS.Year;
//                                     SessionalExamGroupLineCS."Global Dimension 1 Code" := EducationSetupCSCS."Global Dimension 1 Code";
//                                     SessionalExamGroupLineCS."Global Dimension 2 Code" := EducationSetupCSCS."Global Dimension 2 Code";
//                                     SessionalExamGroupLineCS."Created By" := FORMAT(UserId());
//                                     SessionalExamGroupLineCS."Created On" := TODAY();
//                                     IF ExamGroupCodeCS.GET(SessionalExamGroupCS."Exam Method Code") THEN
//                                         SessionalExamGroupLineCS."Method Description" := ExamGroupCodeCS.Description;
//                                     SessionalExamGroupLineCS.Insert();
//                                 UNTIL SessionalExamGroupCS.NEXT() = 0;
//                         END ELSE
//                             IF SessionalExamGroupHeadCS."Subject Class" = 'INDUSTRAINING' THEN BEGIN
//                                 SessionalExamGroupCS.Reset();
//                                 IF EducationSetupCSCS."Even/Odd Semester" = EducationSetupCSCS."Even/Odd Semester"::FALL THEN
//                                     SessionalExamGroupCS.SETRANGE(Group, 'EVEN')
//                                 ELSE
//                                     IF EducationSetupCSCS."Even/Odd Semester" = EducationSetupCSCS."Even/Odd Semester"::SPRING THEN
//                                         SessionalExamGroupCS.SETRANGE(Group, 'ODD');
//                                 SessionalExamGroupCS.SETFILTER("Exam Type", '%1', SessionalExamGroupCS."Exam Type"::"Industrial Training");
//                                 IF SessionalExamGroupCS.FINDSET() THEN
//                                     REPEAT
//                                         "LocLineNo." += 10000;
//                                         SessionalExamGroupLineCS.INIT();
//                                         SessionalExamGroupLineCS."Document No." := NEXTNo;
//                                         SessionalExamGroupLineCS."Line No." += "LocLineNo.";
//                                         SessionalExamGroupLineCS.Course := SessionalExamGroupHeadCS."Course Code";
//                                         SessionalExamGroupLineCS.Semester := SessionalExamGroupHeadCS.Semester;
//                                         SessionalExamGroupLineCS.Section := SessionalExamGroupHeadCS.Section;
//                                         SessionalExamGroupLineCS."Academic year" := EducationSetupCSCS."Academic Year";
//                                         SessionalExamGroupLineCS."Subject Type" := SessionalExamGroupHeadCS."Subject Type";
//                                         SessionalExamGroupLineCS."Subject Code" := SessionalExamGroupHeadCS."Subject Code";
//                                         SessionalExamGroupLineCS."Exam Group" := SessionalExamGroupCS.Group;
//                                         SessionalExamGroupLineCS."Exam Method" := SessionalExamGroupCS."Exam Method Code";
//                                         SessionalExamGroupLineCS."Type Of Course" := CourseWiseSubjectLineCS."Type Of Course";
//                                         SessionalExamGroupLineCS.Year := CourseSectionMasterCS.Year;
//                                         SessionalExamGroupLineCS."Global Dimension 1 Code" := EducationSetupCSCS."Global Dimension 1 Code";
//                                         SessionalExamGroupLineCS."Global Dimension 2 Code" := EducationSetupCSCS."Global Dimension 2 Code";
//                                         SessionalExamGroupLineCS."Created By" := FORMAT(UserId());
//                                         SessionalExamGroupLineCS."Created On" := TODAY();
//                                         IF ExamGroupCodeCS.GET(SessionalExamGroupCS."Exam Method Code") THEN
//                                             SessionalExamGroupLineCS."Method Description" := ExamGroupCodeCS.Description;
//                                         SessionalExamGroupLineCS.Insert();
//                                     UNTIL SessionalExamGroupCS.NEXT() = 0;
//                             END;
//                 CourseWiseSubjectLineCS.Modify();
//             UNTIL CourseWiseSubjectLineCS.NEXT() = 0
//         ELSE
//             ERROR('Internal Exam Group Already Generated !!');

//         //Code Add For  Create Automate Internal Exam Group::CSPL-00059::19022019: End
//     end;

//     procedure CSCreateAutomateInternalExamDetails(InstituteCode: Code[20])
//     var
//         CourseWiseSubjectLineCS: Record "Course Wise Subject Line-CS";
//         SessionalExamGroupCS: Record "Sessional Exam Group-CS";
//         EducationSetupCSCS: Record "Education Setup-CS";
//         InternalExamHeaderCS: Record "Internal Exam Header-CS";
//         AcademicsSetupCS: Record "Academics Setup-CS";
//         FacultyCourseWiseCS: Record "Faculty Course Wise-CS";
//         FacultyCourseWiseCS1: Record "Faculty Course Wise-CS";
//         FacultyCourseWiseCS2: Record "Faculty Course Wise-CS";
//         InternalExamHeaderCS1: Record "Internal Exam Header-CS";
//         GroupMasterCS: Record "Group Master-CS";
//         NoSeriesManagement: Codeunit "NoSeriesManagement";
//         ActionMarkCS: Codeunit "Action Mark -CS";
//         NEXTNo: Code[20];
//         SectionCode: Code[10];


//     begin
//         //Code Add For  Create Automate Internal Exam Details::CSPL-00059::19022019: Start
//         AcademicsSetupCS.GET();
//         AcademicsSetupCS.TESTFIELD("Internal Exam Group No.");


//         IF InstituteCode = '' THEN
//             ERROR('Please Select Institute Code !!');

//         EducationSetupCSCS.Reset();
//         EducationSetupCSCS.SETRANGE("Global Dimension 1 Code", InstituteCode);
//         IF EducationSetupCSCS.Findfirst() THEN BEGIN
//             IF EducationSetupCSCS."Internal Exam Generated" = TRUE THEN
//                 ERROR('Internal Exam Already Generated !!!');
//             EducationSetupCSCS.TESTFIELD("Academic Year")
//         END ELSE
//             ERROR('Education Setup Not Defined !!');


//         CourseWiseSubjectLineCS.Reset();
//         CourseWiseSubjectLineCS.SETRANGE("Academic Year", EducationSetupCSCS."Academic Year");
//         CourseWiseSubjectLineCS.SETRANGE("Global Dimension 1 Code", EducationSetupCSCS."Global Dimension 1 Code");
//         CourseWiseSubjectLineCS.SETFILTER("Subject Classification", '%1', 'THEORY');
//         IF EducationSetupCSCS."Even/Odd Semester" = EducationSetupCSCS."Even/Odd Semester"::FALL THEN
//             CourseWiseSubjectLineCS.SETFILTER(Semester, '%1|%2|%3|%4', 'II', 'IV', 'VI', 'VIII')
//         ELSE
//             IF EducationSetupCSCS."Even/Odd Semester" = EducationSetupCSCS."Even/Odd Semester"::SPRING THEN
//                 CourseWiseSubjectLineCS.SETFILTER(Semester, '%1|%2|%3|%4', 'I', 'III', 'V', 'VII');
//         CourseWiseSubjectLineCS.SETRANGE("Program/Open Elective Temp", CourseWiseSubjectLineCS."Program/Open Elective Temp"::" ");
//         IF CourseWiseSubjectLineCS.FINDSET() THEN
//             CourseWiseSubjectLineCS.MODIFYALL("Int. Exam Generated", FALSE);


//         FacultyCourseWiseCS2.Reset();
//         FacultyCourseWiseCS2.SETRANGE("Academic Year", EducationSetupCSCS."Academic Year");
//         IF EducationSetupCSCS."Even/Odd Semester" = EducationSetupCSCS."Even/Odd Semester"::FALL THEN
//             FacultyCourseWiseCS2.SETFILTER("Semester Code", '%1|%2|%3|%4', 'II', 'IV', 'VI', 'VIII')
//         ELSE
//             IF EducationSetupCSCS."Even/Odd Semester" = EducationSetupCSCS."Even/Odd Semester"::SPRING THEN
//                 FacultyCourseWiseCS2.SETFILTER("Semester Code", '%1|%2|%3|%4', 'I', 'III', 'V', 'VII');
//         IF FacultyCourseWiseCS2.ISEMPTY() then
//             ERROR('Course Wise Faculty Is Not Generated !!');

//         FacultyCourseWiseCS1.Reset();
//         FacultyCourseWiseCS1.SETFILTER("Faculty Code", '%1', '');
//         FacultyCourseWiseCS1.SETRANGE("Academic Year", EducationSetupCSCS."Academic Year");
//         FacultyCourseWiseCS1.SETRANGE("Global Dimension 1 Code", EducationSetupCSCS."Global Dimension 1 Code");
//         IF FacultyCourseWiseCS1.Findfirst() THEN
//             ERROR('Course Wise Faculty Is Not Updated.Faculty Code Is Blank !!');

//         GroupMasterCS.Reset();
//         GroupMasterCS.SETRANGE("Global Dimension 1 Code", EducationSetupCSCS."Global Dimension 1 Code");
//         IF GroupMasterCS.FINDSET() THEN
//             REPEAT
//                 CourseWiseSubjectLineCS.Reset();
//                 CourseWiseSubjectLineCS.SETCURRENTKEY("Course Code", "Type Of Course", Semester, Year, "Subject Classification", "Subject Type", "Subject Code");
//                 CourseWiseSubjectLineCS.SETRANGE("Course Code", EducationSetupCSCS."Course Code");
//                 CourseWiseSubjectLineCS.SETRANGE("Academic Year", EducationSetupCSCS."Academic Year");
//                 CourseWiseSubjectLineCS.SETRANGE("Program", 'UG');
//                 CourseWiseSubjectLineCS.SETRANGE("Global Dimension 1 Code", EducationSetupCSCS."Global Dimension 1 Code");
//                 CourseWiseSubjectLineCS.SETFILTER("Subject Classification", '%1', 'THEORY');
//                 IF EducationSetupCSCS."Even/Odd Semester" = EducationSetupCSCS."Even/Odd Semester"::FALL THEN
//                     CourseWiseSubjectLineCS.SETFILTER(Semester, '%1', 'II')
//                 ELSE
//                     IF EducationSetupCSCS."Even/Odd Semester" = EducationSetupCSCS."Even/Odd Semester"::SPRING THEN
//                         CourseWiseSubjectLineCS.SETFILTER(Semester, '%1', 'I');
//                 CourseWiseSubjectLineCS.SETRANGE("Program/Open Elective Temp", CourseWiseSubjectLineCS."Program/Open Elective Temp"::" ");
//                 CourseWiseSubjectLineCS.SETRANGE("Student Group", GroupMasterCS.Code);
//                 IF CourseWiseSubjectLineCS.FINDSET() THEN
//                     REPEAT
//                         InternalExamHeaderCS1.Reset();
//                         InternalExamHeaderCS1.SETRANGE("Academic Year", CourseWiseSubjectLineCS."Academic Year");
//                         InternalExamHeaderCS1.SETRANGE(Semester, CourseWiseSubjectLineCS.Semester);
//                         InternalExamHeaderCS1.SETFILTER("Subject Type", '<>%1', 'CORE');
//                         InternalExamHeaderCS1.SETRANGE("Subject Code", CourseWiseSubjectLineCS."Subject Code");
//                         IF NOT InternalExamHeaderCS1.Findfirst() THEN BEGIN
//                             SectionCode := '';
//                             FacultyCourseWiseCS.Reset();
//                             FacultyCourseWiseCS.SETCURRENTKEY("Semester Code", "Subject Code", "Section Code");
//                             FacultyCourseWiseCS.SETRANGE("Course Code", '');
//                             IF CourseWiseSubjectLineCS."Type Of Course" = CourseWiseSubjectLineCS."Type Of Course"::Semester THEN
//                                 FacultyCourseWiseCS.SETRANGE("Semester Code", CourseWiseSubjectLineCS.Semester)
//                             ELSE
//                                 FacultyCourseWiseCS.SETRANGE("Year Code", CourseWiseSubjectLineCS.Year);
//                             FacultyCourseWiseCS.SETRANGE(Graduation, CourseWiseSubjectLineCS."Program");
//                             FacultyCourseWiseCS.SETRANGE("Academic Year", CourseWiseSubjectLineCS."Academic Year");
//                             FacultyCourseWiseCS.SETRANGE("Subject Class", CourseWiseSubjectLineCS."Subject Classification");
//                             FacultyCourseWiseCS.SETRANGE("Subject Code", CourseWiseSubjectLineCS."Subject Code");
//                             FacultyCourseWiseCS.SETRANGE(Group, CourseWiseSubjectLineCS."Student Group");
//                             FacultyCourseWiseCS.SETRANGE("Global Dimension 1 Code", CourseWiseSubjectLineCS."Global Dimension 1 Code");
//                             IF FacultyCourseWiseCS.FINDSET() THEN
//                                 REPEAT
//                                     IF SectionCode <> FacultyCourseWiseCS."Section Code" THEN BEGIN
//                                         SessionalExamGroupCS.Reset();
//                                         IF EducationSetupCSCS."Even/Odd Semester" = EducationSetupCSCS."Even/Odd Semester"::FALL THEN
//                                             SessionalExamGroupCS.SETRANGE(Group, 'EVEN')
//                                         ELSE
//                                             IF EducationSetupCSCS."Even/Odd Semester" = EducationSetupCSCS."Even/Odd Semester"::SPRING THEN
//                                                 SessionalExamGroupCS.SETRANGE(Group, 'ODD');
//                                         SessionalExamGroupCS.SETRANGE("Exam Type", SessionalExamGroupCS."Exam Type"::"Internal Exam");
//                                         SessionalExamGroupCS.SETRANGE("Applicable Exam", TRUE);
//                                         IF SessionalExamGroupCS.FINDSET() THEN
//                                             REPEAT

//                                                 NEXTNo := NoSeriesManagement.GetNEXTNo(AcademicsSetupCS."Internal Marks No.", 0D, TRUE);

//                                                 InternalExamHeaderCS.INIT();
//                                                 InternalExamHeaderCS."No." := NEXTNo;
//                                                 InternalExamHeaderCS."Exam Type" := InternalExamHeaderCS."Exam Type"::Regular;
//                                                 InternalExamHeaderCS."Type Of Course" := CourseWiseSubjectLineCS."Type Of Course";
//                                                 InternalExamHeaderCS.Semester := CourseWiseSubjectLineCS.Semester;
//                                                 InternalExamHeaderCS.Year := CourseWiseSubjectLineCS.Year;
//                                                 InternalExamHeaderCS."Program" := CourseWiseSubjectLineCS."Program";
//                                                 InternalExamHeaderCS."Student Group" := GroupMasterCS.Code;
//                                                 InternalExamHeaderCS.Section := FacultyCourseWiseCS."Section Code";
//                                                 InternalExamHeaderCS."Academic Year" := EducationSetupCSCS."Academic Year";
//                                                 InternalExamHeaderCS."Subject Class" := CourseWiseSubjectLineCS."Subject Classification";
//                                                 InternalExamHeaderCS."Subject Type" := CourseWiseSubjectLineCS."Subject Type";
//                                                 InternalExamHeaderCS.VALIDATE("Subject Code", CourseWiseSubjectLineCS."Subject Code");
//                                                 InternalExamHeaderCS."Global Dimension 1 Code" := CourseWiseSubjectLineCS."Global Dimension 1 Code";
//                                                 InternalExamHeaderCS."Global Dimension 2 Code" := CourseWiseSubjectLineCS."Global Dimension 2 Code";
//                                                 IF EducationSetupCSCS."Even/Odd Semester" = EducationSetupCSCS."Even/Odd Semester"::FALL THEN
//                                                     InternalExamHeaderCS."Exam Group" := 'EVEN'
//                                                 ELSE
//                                                     IF EducationSetupCSCS."Even/Odd Semester" = EducationSetupCSCS."Even/Odd Semester"::SPRING THEN
//                                                         InternalExamHeaderCS."Exam Group" := 'ODD';
//                                                 InternalExamHeaderCS.VALIDATE("Exam Method Code", SessionalExamGroupCS."Exam Method Code");
//                                                 InternalExamHeaderCS."Maximum Mark" := SessionalExamGroupCS."Maximum Marks";
//                                                 InternalExamHeaderCS."Maximum Weightage" := SessionalExamGroupCS."Maximum Weightage";
//                                                 InternalExamHeaderCS."Staff Code" := FacultyCourseWiseCS."Faculty Code";
//                                                 InternalExamHeaderCS."Staff Name" := FacultyCourseWiseCS."Faculty Name";
//                                                 InternalExamHeaderCS."Created By" := FORMAT(UserId());
//                                                 InternalExamHeaderCS."Created On" := TODAY();
//                                                 InternalExamHeaderCS.Status := InternalExamHeaderCS.Status::Open;
//                                                 InternalExamHeaderCS.Insert();

//                                                 IF InternalExamHeaderCS.Status = InternalExamHeaderCS.Status::Open THEN BEGIN
//                                                     ActionMarkCS.GetStudentsForInternalsCS(InternalExamHeaderCS);
//                                                     CourseWiseSubjectLineCS."Int. Exam Generated" := TRUE;
//                                                     CourseWiseSubjectLineCS.Modify();
//                                                 END ELSE
//                                                     InternalExamHeaderCS.TESTFIELD(Status, InternalExamHeaderCS.Status::Open);

//                                             UNTIL SessionalExamGroupCS.NEXT() = 0;
//                                         SectionCode := FacultyCourseWiseCS."Section Code";
//                                     END;
//                                 UNTIL FacultyCourseWiseCS.NEXT() = 0;
//                         END;
//                     UNTIL CourseWiseSubjectLineCS.NEXT() = 0;
//             UNTIL GroupMasterCS.NEXT() = 0;



//         CourseWiseSubjectLineCS.Reset();
//         CourseWiseSubjectLineCS.SETCURRENTKEY("Course Code", "Type Of Course", Semester, Year, "Subject Classification", "Subject Type", "Subject Code");
//         CourseWiseSubjectLineCS.SETRANGE("Academic Year", EducationSetupCSCS."Academic Year");
//         CourseWiseSubjectLineCS.SETRANGE("Program", 'UG');
//         CourseWiseSubjectLineCS.SETRANGE("Global Dimension 1 Code", EducationSetupCSCS."Global Dimension 1 Code");
//         CourseWiseSubjectLineCS.SETFILTER("Subject Classification", '%1', 'THEORY');
//         IF EducationSetupCSCS."Even/Odd Semester" = EducationSetupCSCS."Even/Odd Semester"::FALL THEN
//             CourseWiseSubjectLineCS.SETFILTER(Semester, '%1|%2|%3', 'IV', 'VI', 'VIII')
//         ELSE
//             IF EducationSetupCSCS."Even/Odd Semester" = EducationSetupCSCS."Even/Odd Semester"::SPRING THEN
//                 CourseWiseSubjectLineCS.SETFILTER(Semester, '%1|%2|%3', 'III', 'V', 'VII');
//         CourseWiseSubjectLineCS.SETRANGE("Program/Open Elective Temp", CourseWiseSubjectLineCS."Program/Open Elective Temp"::" ");
//         IF CourseWiseSubjectLineCS.FINDSET() THEN
//             REPEAT
//                 InternalExamHeaderCS1.Reset();
//                 InternalExamHeaderCS1.SETRANGE("Academic Year", CourseWiseSubjectLineCS."Academic Year");
//                 InternalExamHeaderCS1.SETRANGE(Semester, CourseWiseSubjectLineCS.Semester);
//                 InternalExamHeaderCS1.SETFILTER("Subject Type", '<>%1', 'CORE');
//                 InternalExamHeaderCS1.SETRANGE("Subject Code", CourseWiseSubjectLineCS."Subject Code");
//                 IF NOT InternalExamHeaderCS1.Findfirst() THEN BEGIN
//                     SectionCode := '';
//                     FacultyCourseWiseCS.Reset();
//                     FacultyCourseWiseCS.SETCURRENTKEY("Semester Code", "Subject Code", "Section Code");
//                     IF CourseWiseSubjectLineCS."Subject Type" = 'CORE' THEN
//                         FacultyCourseWiseCS.SETRANGE("Course Code", CourseWiseSubjectLineCS."Course Code");
//                     IF CourseWiseSubjectLineCS."Type Of Course" = CourseWiseSubjectLineCS."Type Of Course"::Semester THEN
//                         FacultyCourseWiseCS.SETRANGE("Semester Code", CourseWiseSubjectLineCS.Semester)
//                     ELSE
//                         FacultyCourseWiseCS.SETRANGE("Year Code", CourseWiseSubjectLineCS.Year);
//                     FacultyCourseWiseCS.SETRANGE(Graduation, CourseWiseSubjectLineCS."Program");
//                     FacultyCourseWiseCS.SETRANGE("Academic Year", CourseWiseSubjectLineCS."Academic Year");
//                     FacultyCourseWiseCS.SETRANGE("Subject Class", CourseWiseSubjectLineCS."Subject Classification");
//                     FacultyCourseWiseCS.SETRANGE("Subject Code", CourseWiseSubjectLineCS."Subject Code");
//                     FacultyCourseWiseCS.SETRANGE("Global Dimension 1 Code", CourseWiseSubjectLineCS."Global Dimension 1 Code");
//                     IF FacultyCourseWiseCS.FINDSET() THEN
//                         REPEAT
//                             IF SectionCode <> FacultyCourseWiseCS."Section Code" THEN BEGIN
//                                 SessionalExamGroupCS.Reset();
//                                 IF EducationSetupCSCS."Even/Odd Semester" = EducationSetupCSCS."Even/Odd Semester"::FALL THEN
//                                     SessionalExamGroupCS.SETRANGE(Group, 'EVEN')
//                                 ELSE
//                                     IF EducationSetupCSCS."Even/Odd Semester" = EducationSetupCSCS."Even/Odd Semester"::SPRING THEN
//                                         SessionalExamGroupCS.SETRANGE(Group, 'ODD');
//                                 SessionalExamGroupCS.SETRANGE("Exam Type", SessionalExamGroupCS."Exam Type"::"Internal Exam");
//                                 SessionalExamGroupCS.SETRANGE("Applicable Exam", TRUE);
//                                 IF SessionalExamGroupCS.FINDSET() THEN
//                                     REPEAT

//                                         NEXTNo := NoSeriesManagement.GetNEXTNo(AcademicsSetupCS."Internal Marks No.", 0D, TRUE);

//                                         InternalExamHeaderCS.INIT();
//                                         InternalExamHeaderCS."No." := NEXTNo;
//                                         InternalExamHeaderCS."Exam Type" := InternalExamHeaderCS."Exam Type"::Regular;
//                                         InternalExamHeaderCS.VALIDATE("Course Code", CourseWiseSubjectLineCS."Course Code");
//                                         InternalExamHeaderCS.Semester := CourseWiseSubjectLineCS.Semester;
//                                         InternalExamHeaderCS.Year := CourseWiseSubjectLineCS.Year;
//                                         InternalExamHeaderCS."Program" := CourseWiseSubjectLineCS."Program";
//                                         InternalExamHeaderCS.Section := FacultyCourseWiseCS."Section Code";
//                                         InternalExamHeaderCS."Academic Year" := EducationSetupCSCS."Academic Year";
//                                         InternalExamHeaderCS."Subject Class" := CourseWiseSubjectLineCS."Subject Classification";
//                                         InternalExamHeaderCS."Subject Type" := CourseWiseSubjectLineCS."Subject Type";
//                                         InternalExamHeaderCS.VALIDATE("Subject Code", CourseWiseSubjectLineCS."Subject Code");
//                                         InternalExamHeaderCS."Global Dimension 1 Code" := CourseWiseSubjectLineCS."Global Dimension 1 Code";
//                                         InternalExamHeaderCS."Global Dimension 2 Code" := CourseWiseSubjectLineCS."Global Dimension 2 Code";
//                                         IF EducationSetupCSCS."Even/Odd Semester" = EducationSetupCSCS."Even/Odd Semester"::FALL THEN
//                                             InternalExamHeaderCS."Exam Group" := 'EVEN'
//                                         ELSE
//                                             IF EducationSetupCSCS."Even/Odd Semester" = EducationSetupCSCS."Even/Odd Semester"::SPRING THEN
//                                                 InternalExamHeaderCS."Exam Group" := 'ODD';
//                                         InternalExamHeaderCS.VALIDATE("Exam Method Code", SessionalExamGroupCS."Exam Method Code");
//                                         InternalExamHeaderCS."Maximum Mark" := SessionalExamGroupCS."Maximum Marks";
//                                         InternalExamHeaderCS."Maximum Weightage" := SessionalExamGroupCS."Maximum Weightage";
//                                         InternalExamHeaderCS."Staff Code" := FacultyCourseWiseCS."Faculty Code";
//                                         InternalExamHeaderCS."Staff Name" := FacultyCourseWiseCS."Faculty Name";
//                                         InternalExamHeaderCS."Created By" := FORMAT(UserId());
//                                         InternalExamHeaderCS."Created On" := TODAY();
//                                         InternalExamHeaderCS.Status := InternalExamHeaderCS.Status::Open;
//                                         InternalExamHeaderCS.Insert();

//                                         IF InternalExamHeaderCS.Status = InternalExamHeaderCS.Status::Open THEN BEGIN
//                                             ActionMarkCS.GetStudentsForInternalsCS(InternalExamHeaderCS);
//                                             CourseWiseSubjectLineCS."Int. Exam Generated" := TRUE;
//                                             CourseWiseSubjectLineCS.Modify();
//                                         END ELSE
//                                             InternalExamHeaderCS.TESTFIELD(Status, InternalExamHeaderCS.Status::Open);
//                                     UNTIL SessionalExamGroupCS.NEXT() = 0;
//                                 SectionCode := FacultyCourseWiseCS."Section Code";
//                             END;
//                         UNTIL FacultyCourseWiseCS.NEXT() = 0;
//                 END;
//             UNTIL CourseWiseSubjectLineCS.NEXT() = 0;


//         CourseWiseSubjectLineCS.Reset();
//         CourseWiseSubjectLineCS.SETCURRENTKEY("Course Code", "Type Of Course", Semester, Year, "Subject Classification", "Subject Type", "Subject Code");
//         CourseWiseSubjectLineCS.SETRANGE("Academic Year", EducationSetupCSCS."Academic Year");
//         CourseWiseSubjectLineCS.SETRANGE("Program", 'PG');
//         CourseWiseSubjectLineCS.SETRANGE("Global Dimension 1 Code", EducationSetupCSCS."Global Dimension 1 Code");
//         CourseWiseSubjectLineCS.SETFILTER("Subject Classification", '%1', 'THEORY');
//         IF EducationSetupCSCS."Even/Odd Semester" = EducationSetupCSCS."Even/Odd Semester"::FALL THEN
//             CourseWiseSubjectLineCS.SETFILTER(Semester, '%1|%2|%3|%4', 'II', 'IV', 'VI', 'VIII')
//         ELSE
//             IF EducationSetupCSCS."Even/Odd Semester" = EducationSetupCSCS."Even/Odd Semester"::SPRING THEN
//                 CourseWiseSubjectLineCS.SETFILTER(Semester, '%1|%2|%3|%4', 'I', 'III', 'V', 'VII');
//         CourseWiseSubjectLineCS.SETRANGE("Program/Open Elective Temp", CourseWiseSubjectLineCS."Program/Open Elective Temp"::" ");
//         IF CourseWiseSubjectLineCS.FINDSET() THEN
//             REPEAT
//                 InternalExamHeaderCS1.Reset();
//                 InternalExamHeaderCS1.SETRANGE("Academic Year", CourseWiseSubjectLineCS."Academic Year");
//                 InternalExamHeaderCS1.SETRANGE(Semester, CourseWiseSubjectLineCS.Semester);
//                 InternalExamHeaderCS1.SETFILTER("Subject Type", '<>%1', 'CORE');
//                 InternalExamHeaderCS1.SETRANGE("Subject Code", CourseWiseSubjectLineCS."Subject Code");
//                 IF NOT InternalExamHeaderCS1.Findfirst() THEN BEGIN
//                     SectionCode := '';
//                     FacultyCourseWiseCS.Reset();
//                     FacultyCourseWiseCS.SETCURRENTKEY("Semester Code", "Subject Code", "Section Code");
//                     IF CourseWiseSubjectLineCS."Subject Type" = 'CORE' THEN
//                         FacultyCourseWiseCS.SETRANGE("Course Code", CourseWiseSubjectLineCS."Course Code");
//                     IF CourseWiseSubjectLineCS."Type Of Course" = CourseWiseSubjectLineCS."Type Of Course"::Semester THEN
//                         FacultyCourseWiseCS.SETRANGE("Semester Code", CourseWiseSubjectLineCS.Semester)
//                     ELSE
//                         FacultyCourseWiseCS.SETRANGE("Year Code", CourseWiseSubjectLineCS.Year);
//                     FacultyCourseWiseCS.SETRANGE(Graduation, CourseWiseSubjectLineCS."Program");
//                     FacultyCourseWiseCS.SETRANGE("Academic Year", CourseWiseSubjectLineCS."Academic Year");
//                     FacultyCourseWiseCS.SETRANGE("Subject Class", CourseWiseSubjectLineCS."Subject Classification");
//                     FacultyCourseWiseCS.SETRANGE("Subject Code", CourseWiseSubjectLineCS."Subject Code");
//                     FacultyCourseWiseCS.SETRANGE("Global Dimension 1 Code", CourseWiseSubjectLineCS."Global Dimension 1 Code");
//                     IF FacultyCourseWiseCS.FINDSET() THEN
//                         REPEAT
//                             IF SectionCode <> FacultyCourseWiseCS."Section Code" THEN BEGIN
//                                 SessionalExamGroupCS.Reset();
//                                 IF EducationSetupCSCS."Even/Odd Semester" = EducationSetupCSCS."Even/Odd Semester"::FALL THEN
//                                     SessionalExamGroupCS.SETRANGE(Group, 'EVEN')
//                                 ELSE
//                                     IF EducationSetupCSCS."Even/Odd Semester" = EducationSetupCSCS."Even/Odd Semester"::SPRING THEN
//                                         SessionalExamGroupCS.SETRANGE(Group, 'ODD');
//                                 SessionalExamGroupCS.SETRANGE("Exam Type", SessionalExamGroupCS."Exam Type"::"Internal Exam");
//                                 SessionalExamGroupCS.SETRANGE("Applicable Exam", TRUE);
//                                 IF SessionalExamGroupCS.FINDSET() THEN
//                                     REPEAT

//                                         NEXTNo := NoSeriesManagement.GetNEXTNo(AcademicsSetupCS."Internal Marks No.", 0D, TRUE);

//                                         InternalExamHeaderCS.INIT();
//                                         InternalExamHeaderCS."No." := NEXTNo;
//                                         InternalExamHeaderCS."Exam Type" := InternalExamHeaderCS."Exam Type"::Regular;
//                                         InternalExamHeaderCS.VALIDATE("Course Code", CourseWiseSubjectLineCS."Course Code");
//                                         InternalExamHeaderCS.Semester := CourseWiseSubjectLineCS.Semester;
//                                         InternalExamHeaderCS.Year := CourseWiseSubjectLineCS.Year;
//                                         InternalExamHeaderCS."Program" := CourseWiseSubjectLineCS."Program";
//                                         InternalExamHeaderCS.Section := FacultyCourseWiseCS."Section Code";
//                                         InternalExamHeaderCS."Academic Year" := EducationSetupCSCS."Academic Year";
//                                         InternalExamHeaderCS."Subject Class" := CourseWiseSubjectLineCS."Subject Classification";
//                                         InternalExamHeaderCS."Subject Type" := CourseWiseSubjectLineCS."Subject Type";
//                                         InternalExamHeaderCS.VALIDATE("Subject Code", CourseWiseSubjectLineCS."Subject Code");
//                                         IF EducationSetupCSCS."Even/Odd Semester" = EducationSetupCSCS."Even/Odd Semester"::FALL THEN
//                                             InternalExamHeaderCS."Exam Group" := 'EVEN'
//                                         ELSE
//                                             IF EducationSetupCSCS."Even/Odd Semester" = EducationSetupCSCS."Even/Odd Semester"::SPRING THEN
//                                                 InternalExamHeaderCS."Exam Group" := 'ODD';
//                                         InternalExamHeaderCS.VALIDATE("Exam Method Code", SessionalExamGroupCS."Exam Method Code");
//                                         InternalExamHeaderCS."Maximum Mark" := SessionalExamGroupCS."Maximum Marks";
//                                         InternalExamHeaderCS."Global Dimension 1 Code" := CourseWiseSubjectLineCS."Global Dimension 1 Code";
//                                         InternalExamHeaderCS."Maximum Weightage" := SessionalExamGroupCS."Maximum Weightage";
//                                         InternalExamHeaderCS."Staff Code" := FacultyCourseWiseCS."Faculty Code";
//                                         InternalExamHeaderCS."Global Dimension 1 Code" := CourseWiseSubjectLineCS."Global Dimension 1 Code";
//                                         InternalExamHeaderCS."Staff Name" := FacultyCourseWiseCS."Faculty Name";
//                                         InternalExamHeaderCS."Created By" := FORMAT(UserId());
//                                         InternalExamHeaderCS."Created On" := TODAY();
//                                         InternalExamHeaderCS.Status := InternalExamHeaderCS.Status::Open;
//                                         InternalExamHeaderCS.Insert();

//                                         IF InternalExamHeaderCS.Status = InternalExamHeaderCS.Status::Open THEN BEGIN
//                                             ActionMarkCS.GetStudentsForInternalsCS(InternalExamHeaderCS);
//                                             CourseWiseSubjectLineCS."Int. Exam Generated" := TRUE;
//                                             CourseWiseSubjectLineCS.Modify();
//                                         END ELSE
//                                             InternalExamHeaderCS.TESTFIELD(Status, InternalExamHeaderCS.Status::Open);
//                                     UNTIL SessionalExamGroupCS.NEXT() = 0;
//                                 SectionCode := FacultyCourseWiseCS."Section Code";
//                             END;
//                         UNTIL FacultyCourseWiseCS.NEXT() = 0;
//                 END;
//             UNTIL CourseWiseSubjectLineCS.NEXT() = 0;

//         EducationSetupCSCS.Reset();
//         EducationSetupCSCS.SETRANGE("Global Dimension 1 Code", InstituteCode);
//         IF EducationSetupCSCS.Findfirst() THEN BEGIN
//             EducationSetupCSCS."Internal Exam Generated" := TRUE;
//             EducationSetupCSCS.Modify();
//         END;
//         //Code Add For  Create Automate Internal Exam Details::CSPL-00059::19022019: End
//     end;

//     procedure CSCreateAutomateInternalAssignmentDetails(InstituteCode: Code[20])
//     var
//         ClassAssignmentHeaderCS: Record "Class Assignment Header-CS";
//         BatchCS: Record "Batch-CS";
//         ClassAssignmentHeaderCS1: Record "Class Assignment Header-CS";
//         CourseWiseSubjectLineCS: Record "Course Wise Subject Line-CS";
//         SessionalExamGroupCS: Record "Sessional Exam Group-CS";
//         EducationSetupCSCS: Record "Education Setup-CS";
//         AcademicsSetupCS: Record "Academics Setup-CS";
//         FacultyCourseWiseCS: Record "Faculty Course Wise-CS";
//         FacultyCourseWiseCS1: Record "Faculty Course Wise-CS";
//         FacultyCourseWiseCS2: Record "Faculty Course Wise-CS";
//         GroupMasterCS: Record "Group Master-CS";
//         NoSeriesManagement: Codeunit NoSeriesManagement;
//         ActionMarkCS: Codeunit "Action Mark -CS";
//         NEXTNo: Code[20];
//         SectionCode: Code[10];
//     begin
//         //Code Add For  Create Automate Internal Assignment Details::CSPL-00059::19022019: Start
//         AcademicsSetupCS.GET();
//         AcademicsSetupCS.TESTFIELD("Internal Exam Group No.");


//         IF InstituteCode = '' THEN
//             ERROR('Please Select Institute Code !!');
//         EducationSetupCSCS.Reset();
//         EducationSetupCSCS.SETRANGE("Global Dimension 1 Code", InstituteCode);
//         IF EducationSetupCSCS.Findfirst() THEN BEGIN
//             IF EducationSetupCSCS."Assignment  Generated" = TRUE THEN
//                 ERROR('Assignment Already Generated !!!');
//             EducationSetupCSCS.TESTFIELD("Academic Year");
//         END ELSE
//             ERROR('Education Setup Not Defined !!');

//         CourseWiseSubjectLineCS.Reset();
//         CourseWiseSubjectLineCS.SETRANGE("Academic Year", EducationSetupCSCS."Academic Year");
//         CourseWiseSubjectLineCS.SETRANGE("Global Dimension 1 Code", EducationSetupCSCS."Global Dimension 1 Code");
//         CourseWiseSubjectLineCS.SETFILTER("Subject Classification", '%1|%2', 'THEORY', 'LAB');
//         IF EducationSetupCSCS."Even/Odd Semester" = EducationSetupCSCS."Even/Odd Semester"::FALL THEN
//             CourseWiseSubjectLineCS.SETFILTER(Semester, '%1|%2|%3|%4', 'II', 'IV', 'VI', 'VIII')
//         ELSE
//             IF EducationSetupCSCS."Even/Odd Semester" = EducationSetupCSCS."Even/Odd Semester"::SPRING THEN
//                 CourseWiseSubjectLineCS.SETFILTER(Semester, '%1|%2|%3|%4', 'I', 'III', 'V', 'VII');
//         CourseWiseSubjectLineCS.SETRANGE("Program/Open Elective Temp", CourseWiseSubjectLineCS."Program/Open Elective Temp"::" ");
//         IF CourseWiseSubjectLineCS.FINDSET() THEN
//             CourseWiseSubjectLineCS.SETRANGE("Assignment Generated", FALSE);


//         FacultyCourseWiseCS2.Reset();
//         FacultyCourseWiseCS2.SETRANGE("Academic Year", EducationSetupCSCS."Academic Year");
//         IF EducationSetupCSCS."Even/Odd Semester" = EducationSetupCSCS."Even/Odd Semester"::FALL THEN
//             FacultyCourseWiseCS2.SETFILTER("Semester Code", '%1|%2|%3|%4', 'II', 'IV', 'VI', 'VIII')
//         ELSE
//             IF EducationSetupCSCS."Even/Odd Semester" = EducationSetupCSCS."Even/Odd Semester"::SPRING THEN
//                 FacultyCourseWiseCS2.SETFILTER("Semester Code", '%1|%2|%3|%4', 'I', 'III', 'V', 'VII');
//         IF FacultyCourseWiseCS2.ISEMPTY() then
//             ERROR('Course Wise Faculty Is Not Generated !!');

//         FacultyCourseWiseCS1.Reset();
//         FacultyCourseWiseCS1.SETFILTER("Faculty Code", '%1', '');
//         FacultyCourseWiseCS1.SETRANGE("Academic Year", EducationSetupCSCS."Academic Year");
//         FacultyCourseWiseCS1.SETRANGE("Global Dimension 1 Code", EducationSetupCSCS."Global Dimension 1 Code");
//         IF FacultyCourseWiseCS1.Findfirst() THEN
//             ERROR('Course Wise Faculty Is Not Updated.Faculty Code Is Blank !!');

//         GroupMasterCS.Reset();
//         GroupMasterCS.SETRANGE("Global Dimension 1 Code", EducationSetupCSCS."Global Dimension 1 Code");
//         IF GroupMasterCS.FINDSET() THEN BEGIN
//             REPEAT
//                 CourseWiseSubjectLineCS.Reset();
//                 CourseWiseSubjectLineCS.SETCURRENTKEY("Course Code", "Type Of Course", Semester, Year, "Subject Classification", "Subject Type", "Subject Code");
//                 CourseWiseSubjectLineCS.SETRANGE("Course Code", EducationSetupCSCS."Course Code");
//                 CourseWiseSubjectLineCS.SETRANGE("Academic Year", EducationSetupCSCS."Academic Year");
//                 CourseWiseSubjectLineCS.SETRANGE("Program", 'UG');
//                 CourseWiseSubjectLineCS.SETRANGE("Global Dimension 1 Code", EducationSetupCSCS."Global Dimension 1 Code");
//                 CourseWiseSubjectLineCS.SETFILTER("Subject Classification", '%1|%2', 'THEORY', 'LAB');
//                 IF EducationSetupCSCS."Even/Odd Semester" = EducationSetupCSCS."Even/Odd Semester"::FALL THEN
//                     CourseWiseSubjectLineCS.SETFILTER(Semester, '%1', 'II')
//                 ELSE
//                     IF EducationSetupCSCS."Even/Odd Semester" = EducationSetupCSCS."Even/Odd Semester"::SPRING THEN
//                         CourseWiseSubjectLineCS.SETFILTER(Semester, '%1', 'I');
//                 CourseWiseSubjectLineCS.SETRANGE("Program/Open Elective Temp", CourseWiseSubjectLineCS."Program/Open Elective Temp"::" ");
//                 CourseWiseSubjectLineCS.SETRANGE("Student Group", GroupMasterCS.Code);
//                 IF CourseWiseSubjectLineCS.FINDSET() THEN
//                     REPEAT
//                         ClassAssignmentHeaderCS1.Reset();
//                         ClassAssignmentHeaderCS1.SETRANGE("Academic Year", CourseWiseSubjectLineCS."Academic Year");
//                         ClassAssignmentHeaderCS1.SETFILTER("Subject Type", '<>%1', 'CORE');
//                         ClassAssignmentHeaderCS1.SETRANGE(Semester, CourseWiseSubjectLineCS.Semester);
//                         ClassAssignmentHeaderCS1.SETRANGE("Subject Code", CourseWiseSubjectLineCS."Subject Code");
//                         IF NOT ClassAssignmentHeaderCS1.Findfirst() THEN BEGIN
//                             SectionCode := '';
//                             FacultyCourseWiseCS.Reset();
//                             FacultyCourseWiseCS.SETCURRENTKEY("Semester Code", "Subject Code", "Section Code");
//                             FacultyCourseWiseCS.SETRANGE("Course Code", '');
//                             IF CourseWiseSubjectLineCS."Type Of Course" = CourseWiseSubjectLineCS."Type Of Course"::Semester THEN
//                                 FacultyCourseWiseCS.SETRANGE("Semester Code", CourseWiseSubjectLineCS.Semester)
//                             ELSE
//                                 FacultyCourseWiseCS.SETRANGE("Year Code", CourseWiseSubjectLineCS.Year);
//                             FacultyCourseWiseCS.SETRANGE(Graduation, CourseWiseSubjectLineCS."Program");
//                             FacultyCourseWiseCS.SETRANGE("Academic Year", CourseWiseSubjectLineCS."Academic Year");
//                             FacultyCourseWiseCS.SETRANGE("Subject Class", CourseWiseSubjectLineCS."Subject Classification");
//                             FacultyCourseWiseCS.SETRANGE("Subject Code", CourseWiseSubjectLineCS."Subject Code");
//                             FacultyCourseWiseCS.SETRANGE(Group, CourseWiseSubjectLineCS."Student Group");
//                             FacultyCourseWiseCS.SETRANGE("Global Dimension 1 Code", CourseWiseSubjectLineCS."Global Dimension 1 Code");
//                             IF FacultyCourseWiseCS.FINDSET() THEN
//                                 REPEAT
//                                     IF SectionCode <> FacultyCourseWiseCS."Section Code" THEN BEGIN
//                                         IF CourseWiseSubjectLineCS."Subject Classification" = 'THEORY' THEN BEGIN
//                                             SessionalExamGroupCS.Reset();
//                                             IF EducationSetupCSCS."Even/Odd Semester" = EducationSetupCSCS."Even/Odd Semester"::FALL THEN
//                                                 SessionalExamGroupCS.SETRANGE(Group, 'EVEN')
//                                             ELSE
//                                                 IF EducationSetupCSCS."Even/Odd Semester" = EducationSetupCSCS."Even/Odd Semester"::SPRING THEN
//                                                     SessionalExamGroupCS.SETRANGE(Group, 'ODD');
//                                             SessionalExamGroupCS.SETRANGE("Exam Type", SessionalExamGroupCS."Exam Type"::Assignment);
//                                             SessionalExamGroupCS.SETRANGE("Applicable Exam", TRUE);
//                                             IF SessionalExamGroupCS.FINDSET() THEN BEGIN
//                                                 REPEAT

//                                                     NEXTNo := NoSeriesManagement.GetNEXTNo(AcademicsSetupCS."Assignment No.", 0D, TRUE);

//                                                     ClassAssignmentHeaderCS.INIT();
//                                                     ClassAssignmentHeaderCS."Assignment No." := NEXTNo;
//                                                     ClassAssignmentHeaderCS."Type Of Course" := CourseWiseSubjectLineCS."Type Of Course";
//                                                     ClassAssignmentHeaderCS.Semester := CourseWiseSubjectLineCS.Semester;
//                                                     ClassAssignmentHeaderCS.Year := CourseWiseSubjectLineCS.Year;
//                                                     ClassAssignmentHeaderCS.Section := FacultyCourseWiseCS."Section Code";
//                                                     ClassAssignmentHeaderCS."Program" := CourseWiseSubjectLineCS."Program";
//                                                     ClassAssignmentHeaderCS."Student Group" := CourseWiseSubjectLineCS."Student Group";
//                                                     ClassAssignmentHeaderCS."Academic Year" := EducationSetupCSCS."Academic Year";
//                                                     ClassAssignmentHeaderCS."Subject Class" := CourseWiseSubjectLineCS."Subject Classification";
//                                                     ClassAssignmentHeaderCS."Subject Type" := CourseWiseSubjectLineCS."Subject Type";
//                                                     ClassAssignmentHeaderCS.VALIDATE("Subject Code", CourseWiseSubjectLineCS."Subject Code");
//                                                     ClassAssignmentHeaderCS."Faculty Code" := FacultyCourseWiseCS."Faculty Code";
//                                                     ClassAssignmentHeaderCS."Faculty Name" := FacultyCourseWiseCS."Faculty Name";
//                                                     IF EducationSetupCSCS."Even/Odd Semester" = EducationSetupCSCS."Even/Odd Semester"::FALL THEN
//                                                         ClassAssignmentHeaderCS."Exam Group" := 'EVEN'
//                                                     ELSE
//                                                         IF EducationSetupCSCS."Even/Odd Semester" = EducationSetupCSCS."Even/Odd Semester"::SPRING THEN
//                                                             ClassAssignmentHeaderCS."Exam Group" := 'ODD';
//                                                     ClassAssignmentHeaderCS.VALIDATE("Exam Method Code", SessionalExamGroupCS."Exam Method Code");
//                                                     ClassAssignmentHeaderCS."Maximum Mark" := SessionalExamGroupCS."Maximum Marks";
//                                                     ClassAssignmentHeaderCS."Maximum Weightage" := SessionalExamGroupCS."Maximum Weightage";
//                                                     ClassAssignmentHeaderCS."Global Dimension 1 Code" := CourseWiseSubjectLineCS."Global Dimension 1 Code";
//                                                     ClassAssignmentHeaderCS."Created By" := FORMAT(UserId());
//                                                     ClassAssignmentHeaderCS."Created On" := TODAY();
//                                                     ClassAssignmentHeaderCS."Assignment Status" := ClassAssignmentHeaderCS."Assignment Status"::Open;
//                                                     ClassAssignmentHeaderCS.Insert();

//                                                     IF ClassAssignmentHeaderCS."Assignment Status" = ClassAssignmentHeaderCS."Assignment Status"::Open THEN BEGIN
//                                                         ActionMarkCS.GetStudentsCS(ClassAssignmentHeaderCS);
//                                                         CourseWiseSubjectLineCS."Assignment Generated" := TRUE;
//                                                         CourseWiseSubjectLineCS.Modify();
//                                                     END ELSE
//                                                         ClassAssignmentHeaderCS.TESTFIELD("Assignment Status", ClassAssignmentHeaderCS."Assignment Status"::Open);
//                                                 UNTIL SessionalExamGroupCS.NEXT() = 0;
//                                             END ELSE
//                                                 ERROR('Exam Group details Not Defined');

//                                         END ELSE
//                                             IF CourseWiseSubjectLineCS."Subject Classification" = 'LAB' THEN BEGIN
//                                                 SessionalExamGroupCS.Reset();
//                                                 IF EducationSetupCSCS."Even/Odd Semester" = EducationSetupCSCS."Even/Odd Semester"::FALL THEN
//                                                     SessionalExamGroupCS.SETRANGE(Group, 'EVEN')
//                                                 ELSE
//                                                     IF EducationSetupCSCS."Even/Odd Semester" = EducationSetupCSCS."Even/Odd Semester"::SPRING THEN
//                                                         SessionalExamGroupCS.SETRANGE(Group, 'ODD');
//                                                 SessionalExamGroupCS.SETRANGE("Exam Type", SessionalExamGroupCS."Exam Type"::"Internal Lab");
//                                                 IF CourseWiseSubjectLineCS."Number of Lab Component" <> 0 THEN
//                                                     SessionalExamGroupCS.SETRANGE("Exam Order", 1, CourseWiseSubjectLineCS."Number of Lab Component")
//                                                 ELSE
//                                                     SessionalExamGroupCS.SETRANGE("Exam Order", 1, 15);
//                                                 SessionalExamGroupCS.SETRANGE("Applicable Exam", TRUE);
//                                                 IF SessionalExamGroupCS.FINDSET() THEN BEGIN
//                                                     REPEAT
//                                                         BatchCS.Reset();
//                                                         IF CourseWiseSubjectLineCS."Applicable Batch" <> '' THEN
//                                                             BatchCS.SETFILTER(Code, CourseWiseSubjectLineCS."Applicable Batch");
//                                                         BatchCS.SETRANGE("Global Dimension 1 Code", EducationSetupCSCS."Global Dimension 1 Code");
//                                                         IF BatchCS.FINDSET() THEN BEGIN
//                                                             REPEAT

//                                                                 NEXTNo := NoSeriesManagement.GetNEXTNo(AcademicsSetupCS."Assignment No.", 0D, TRUE);

//                                                                 ClassAssignmentHeaderCS.INIT();
//                                                                 ClassAssignmentHeaderCS."Assignment No." := NEXTNo;
//                                                                 ClassAssignmentHeaderCS."Type Of Course" := CourseWiseSubjectLineCS."Type Of Course";
//                                                                 ClassAssignmentHeaderCS.Semester := CourseWiseSubjectLineCS.Semester;
//                                                                 ClassAssignmentHeaderCS.Year := CourseWiseSubjectLineCS.Year;
//                                                                 ClassAssignmentHeaderCS.Section := FacultyCourseWiseCS."Section Code";
//                                                                 ClassAssignmentHeaderCS."Program" := CourseWiseSubjectLineCS."Program";
//                                                                 ClassAssignmentHeaderCS."Student Batch" := BatchCS.Code;
//                                                                 ClassAssignmentHeaderCS."Student Group" := CourseWiseSubjectLineCS."Student Group";
//                                                                 ClassAssignmentHeaderCS."Academic Year" := EducationSetupCSCS."Academic Year";
//                                                                 ClassAssignmentHeaderCS."Subject Class" := CourseWiseSubjectLineCS."Subject Classification";
//                                                                 ClassAssignmentHeaderCS."Subject Type" := CourseWiseSubjectLineCS."Subject Type";
//                                                                 ClassAssignmentHeaderCS.VALIDATE("Subject Code", CourseWiseSubjectLineCS."Subject Code");
//                                                                 ClassAssignmentHeaderCS."Faculty Code" := FacultyCourseWiseCS."Faculty Code";
//                                                                 ClassAssignmentHeaderCS."Faculty Name" := FacultyCourseWiseCS."Faculty Name";
//                                                                 IF EducationSetupCSCS."Even/Odd Semester" = EducationSetupCSCS."Even/Odd Semester"::FALL THEN
//                                                                     ClassAssignmentHeaderCS."Exam Group" := 'EVEN'
//                                                                 ELSE
//                                                                     IF EducationSetupCSCS."Even/Odd Semester" = EducationSetupCSCS."Even/Odd Semester"::SPRING THEN
//                                                                         ClassAssignmentHeaderCS."Exam Group" := 'ODD';
//                                                                 ClassAssignmentHeaderCS.VALIDATE("Exam Method Code", SessionalExamGroupCS."Exam Method Code");
//                                                                 ClassAssignmentHeaderCS."Maximum Mark" := SessionalExamGroupCS."Maximum Marks";
//                                                                 ClassAssignmentHeaderCS."Maximum Weightage" := SessionalExamGroupCS."Maximum Weightage";
//                                                                 ClassAssignmentHeaderCS."Global Dimension 1 Code" := CourseWiseSubjectLineCS."Global Dimension 1 Code";
//                                                                 ClassAssignmentHeaderCS."Created By" := FORMAT(UserId());
//                                                                 ClassAssignmentHeaderCS."Created On" := TODAY();
//                                                                 ClassAssignmentHeaderCS."Assignment Status" := ClassAssignmentHeaderCS."Assignment Status"::Open;
//                                                                 ClassAssignmentHeaderCS.Insert();

//                                                                 IF ClassAssignmentHeaderCS."Assignment Status" = ClassAssignmentHeaderCS."Assignment Status"::Open THEN BEGIN
//                                                                     ActionMarkCS.GetStudentsCS(ClassAssignmentHeaderCS);
//                                                                     CourseWiseSubjectLineCS."Assignment Generated" := TRUE;
//                                                                     CourseWiseSubjectLineCS.Modify();
//                                                                 END ELSE
//                                                                     ClassAssignmentHeaderCS.TESTFIELD("Assignment Status", ClassAssignmentHeaderCS."Assignment Status"::Open);
//                                                             UNTIL BatchCS.NEXT() = 0;
//                                                         END ELSE
//                                                             ERROR('Batch Master Details Not Defined');
//                                                     UNTIL SessionalExamGroupCS.NEXT() = 0;
//                                                 END ELSE
//                                                     ERROR('Exam Group details Not Defined');
//                                             END;
//                                         SectionCode := FacultyCourseWiseCS."Section Code";
//                                     END;
//                                 UNTIL FacultyCourseWiseCS.NEXT() = 0;
//                         END;
//                     UNTIL CourseWiseSubjectLineCS.NEXT() = 0;
//             UNTIL GroupMasterCS.NEXT() = 0;
//         END ELSE
//             ERROR('Group details Not Defined');


//         CourseWiseSubjectLineCS.Reset();
//         CourseWiseSubjectLineCS.SETCURRENTKEY("Course Code", "Type Of Course", Semester, Year, "Subject Classification", "Subject Type", "Subject Code");
//         CourseWiseSubjectLineCS.SETRANGE("Academic Year", EducationSetupCSCS."Academic Year");
//         CourseWiseSubjectLineCS.SETRANGE("Program", 'UG');
//         CourseWiseSubjectLineCS.SETRANGE("Global Dimension 1 Code", EducationSetupCSCS."Global Dimension 1 Code");
//         CourseWiseSubjectLineCS.SETFILTER("Subject Classification", '%1|%2', 'THEORY', 'LAB');
//         IF EducationSetupCSCS."Even/Odd Semester" = EducationSetupCSCS."Even/Odd Semester"::FALL THEN
//             CourseWiseSubjectLineCS.SETFILTER(Semester, '%1|%2|%3', 'IV', 'VI', 'VIII')
//         ELSE
//             IF EducationSetupCSCS."Even/Odd Semester" = EducationSetupCSCS."Even/Odd Semester"::SPRING THEN
//                 CourseWiseSubjectLineCS.SETFILTER(Semester, '%1|%2|%3', 'III', 'V', 'VII');
//         CourseWiseSubjectLineCS.SETRANGE("Program/Open Elective Temp", CourseWiseSubjectLineCS."Program/Open Elective Temp"::" ");
//         IF CourseWiseSubjectLineCS.FINDSET() THEN
//             REPEAT
//                 ClassAssignmentHeaderCS1.Reset();
//                 ClassAssignmentHeaderCS1.SETRANGE("Academic Year", CourseWiseSubjectLineCS."Academic Year");
//                 ClassAssignmentHeaderCS1.SETFILTER("Subject Type", '<>%1', 'CORE');
//                 ClassAssignmentHeaderCS1.SETRANGE(Semester, CourseWiseSubjectLineCS.Semester);
//                 ClassAssignmentHeaderCS1.SETRANGE("Subject Code", CourseWiseSubjectLineCS."Subject Code");
//                 IF NOT ClassAssignmentHeaderCS1.Findfirst() THEN BEGIN
//                     SectionCode := '';
//                     FacultyCourseWiseCS.Reset();
//                     FacultyCourseWiseCS.SETCURRENTKEY("Semester Code", "Subject Code", "Section Code");
//                     IF CourseWiseSubjectLineCS."Subject Type" = 'CORE' THEN
//                         FacultyCourseWiseCS.SETRANGE("Course Code", CourseWiseSubjectLineCS."Course Code");
//                     IF CourseWiseSubjectLineCS."Type Of Course" = CourseWiseSubjectLineCS."Type Of Course"::Semester THEN
//                         FacultyCourseWiseCS.SETRANGE("Semester Code", CourseWiseSubjectLineCS.Semester)
//                     ELSE
//                         FacultyCourseWiseCS.SETRANGE("Year Code", CourseWiseSubjectLineCS.Year);
//                     FacultyCourseWiseCS.SETRANGE(Graduation, CourseWiseSubjectLineCS."Program");
//                     FacultyCourseWiseCS.SETRANGE("Academic Year", CourseWiseSubjectLineCS."Academic Year");
//                     FacultyCourseWiseCS.SETRANGE("Subject Class", CourseWiseSubjectLineCS."Subject Classification");
//                     FacultyCourseWiseCS.SETRANGE("Subject Code", CourseWiseSubjectLineCS."Subject Code");
//                     FacultyCourseWiseCS.SETRANGE("Global Dimension 1 Code", CourseWiseSubjectLineCS."Global Dimension 1 Code");
//                     IF FacultyCourseWiseCS.FINDSET() THEN
//                         REPEAT
//                             IF SectionCode <> FacultyCourseWiseCS."Section Code" THEN BEGIN
//                                 IF CourseWiseSubjectLineCS."Subject Classification" = 'THEORY' THEN BEGIN
//                                     SessionalExamGroupCS.Reset();
//                                     IF EducationSetupCSCS."Even/Odd Semester" = EducationSetupCSCS."Even/Odd Semester"::FALL THEN
//                                         SessionalExamGroupCS.SETRANGE(Group, 'EVEN')
//                                     ELSE
//                                         IF EducationSetupCSCS."Even/Odd Semester" = EducationSetupCSCS."Even/Odd Semester"::SPRING THEN
//                                             SessionalExamGroupCS.SETRANGE(Group, 'ODD');
//                                     SessionalExamGroupCS.SETRANGE("Exam Type", SessionalExamGroupCS."Exam Type"::Assignment);
//                                     SessionalExamGroupCS.SETRANGE("Applicable Exam", TRUE);
//                                     IF SessionalExamGroupCS.FINDSET() THEN BEGIN
//                                         REPEAT

//                                             NEXTNo := NoSeriesManagement.GetNEXTNo(AcademicsSetupCS."Assignment No.", 0D, TRUE);

//                                             ClassAssignmentHeaderCS.INIT();
//                                             ClassAssignmentHeaderCS."Assignment No." := NEXTNo;
//                                             ClassAssignmentHeaderCS.VALIDATE("Course Code", CourseWiseSubjectLineCS."Course Code");
//                                             ClassAssignmentHeaderCS.Semester := CourseWiseSubjectLineCS.Semester;
//                                             ClassAssignmentHeaderCS.Year := CourseWiseSubjectLineCS.Year;
//                                             ClassAssignmentHeaderCS."Program" := CourseWiseSubjectLineCS."Program";
//                                             ClassAssignmentHeaderCS.Section := FacultyCourseWiseCS."Section Code";
//                                             ClassAssignmentHeaderCS."Academic Year" := EducationSetupCSCS."Academic Year";
//                                             ClassAssignmentHeaderCS."Subject Class" := CourseWiseSubjectLineCS."Subject Classification";
//                                             ClassAssignmentHeaderCS."Subject Type" := CourseWiseSubjectLineCS."Subject Type";
//                                             ClassAssignmentHeaderCS.VALIDATE("Subject Code", CourseWiseSubjectLineCS."Subject Code");
//                                             ClassAssignmentHeaderCS."Faculty Code" := FacultyCourseWiseCS."Faculty Code";
//                                             ClassAssignmentHeaderCS."Faculty Name" := FacultyCourseWiseCS."Faculty Name";
//                                             IF EducationSetupCSCS."Even/Odd Semester" = EducationSetupCSCS."Even/Odd Semester"::FALL THEN
//                                                 ClassAssignmentHeaderCS."Exam Group" := 'EVEN'
//                                             ELSE
//                                                 IF EducationSetupCSCS."Even/Odd Semester" = EducationSetupCSCS."Even/Odd Semester"::SPRING THEN
//                                                     ClassAssignmentHeaderCS."Exam Group" := 'ODD';
//                                             ClassAssignmentHeaderCS.VALIDATE("Exam Method Code", SessionalExamGroupCS."Exam Method Code");
//                                             ClassAssignmentHeaderCS."Global Dimension 1 Code" := CourseWiseSubjectLineCS."Global Dimension 1 Code";
//                                             ClassAssignmentHeaderCS."Maximum Mark" := SessionalExamGroupCS."Maximum Marks";
//                                             ClassAssignmentHeaderCS."Maximum Weightage" := SessionalExamGroupCS."Maximum Weightage";
//                                             ClassAssignmentHeaderCS."Created By" := FORMAT(UserId());
//                                             ClassAssignmentHeaderCS."Created On" := TODAY();
//                                             ClassAssignmentHeaderCS."Assignment Status" := ClassAssignmentHeaderCS."Assignment Status"::Open;
//                                             ClassAssignmentHeaderCS.Insert();

//                                             IF ClassAssignmentHeaderCS."Assignment Status" = ClassAssignmentHeaderCS."Assignment Status"::Open THEN BEGIN
//                                                 ActionMarkCS.GetStudentsCS(ClassAssignmentHeaderCS);
//                                                 CourseWiseSubjectLineCS."Assignment Generated" := TRUE;
//                                                 CourseWiseSubjectLineCS.Modify();
//                                             END ELSE
//                                                 ClassAssignmentHeaderCS.TESTFIELD("Assignment Status", ClassAssignmentHeaderCS."Assignment Status"::Open);
//                                         UNTIL SessionalExamGroupCS.NEXT() = 0;
//                                     END ELSE
//                                         ERROR('Exam Group details Not Defined');

//                                 END ELSE
//                                     IF CourseWiseSubjectLineCS."Subject Classification" = 'LAB' THEN BEGIN
//                                         SessionalExamGroupCS.Reset();
//                                         IF EducationSetupCSCS."Even/Odd Semester" = EducationSetupCSCS."Even/Odd Semester"::FALL THEN
//                                             SessionalExamGroupCS.SETRANGE(Group, 'EVEN')
//                                         ELSE
//                                             IF EducationSetupCSCS."Even/Odd Semester" = EducationSetupCSCS."Even/Odd Semester"::SPRING THEN
//                                                 SessionalExamGroupCS.SETRANGE(Group, 'ODD');
//                                         SessionalExamGroupCS.SETRANGE("Exam Type", SessionalExamGroupCS."Exam Type"::"Internal Lab");
//                                         IF CourseWiseSubjectLineCS."Number of Lab Component" <> 0 THEN
//                                             SessionalExamGroupCS.SETRANGE("Exam Order", 1, CourseWiseSubjectLineCS."Number of Lab Component")
//                                         ELSE
//                                             SessionalExamGroupCS.SETRANGE("Exam Order", 1, 15);
//                                         SessionalExamGroupCS.SETRANGE("Applicable Exam", TRUE);
//                                         IF SessionalExamGroupCS.FINDSET() THEN BEGIN
//                                             REPEAT
//                                                 BatchCS.Reset();
//                                                 IF CourseWiseSubjectLineCS."Applicable Batch" <> '' THEN
//                                                     BatchCS.SETFILTER(Code, CourseWiseSubjectLineCS."Applicable Batch");
//                                                 BatchCS.SETRANGE("Global Dimension 1 Code", EducationSetupCSCS."Global Dimension 1 Code");
//                                                 IF BatchCS.FINDSET() THEN BEGIN
//                                                     REPEAT

//                                                         NEXTNo := NoSeriesManagement.GetNEXTNo(AcademicsSetupCS."Assignment No.", 0D, TRUE);

//                                                         ClassAssignmentHeaderCS.INIT();
//                                                         ClassAssignmentHeaderCS."Assignment No." := NEXTNo;
//                                                         ClassAssignmentHeaderCS.VALIDATE("Course Code", CourseWiseSubjectLineCS."Course Code");
//                                                         ClassAssignmentHeaderCS.Semester := CourseWiseSubjectLineCS.Semester;
//                                                         ClassAssignmentHeaderCS.Year := CourseWiseSubjectLineCS.Year;
//                                                         ClassAssignmentHeaderCS.Section := FacultyCourseWiseCS."Section Code";
//                                                         ClassAssignmentHeaderCS."Program" := CourseWiseSubjectLineCS."Program";
//                                                         ClassAssignmentHeaderCS."Student Batch" := BatchCS.Code;
//                                                         ClassAssignmentHeaderCS."Academic Year" := EducationSetupCSCS."Academic Year";
//                                                         ClassAssignmentHeaderCS."Subject Class" := CourseWiseSubjectLineCS."Subject Classification";
//                                                         ClassAssignmentHeaderCS."Subject Type" := CourseWiseSubjectLineCS."Subject Type";
//                                                         ClassAssignmentHeaderCS.VALIDATE("Subject Code", CourseWiseSubjectLineCS."Subject Code");
//                                                         ClassAssignmentHeaderCS."Faculty Code" := FacultyCourseWiseCS."Faculty Code";
//                                                         ClassAssignmentHeaderCS."Faculty Name" := FacultyCourseWiseCS."Faculty Name";
//                                                         IF EducationSetupCSCS."Even/Odd Semester" = EducationSetupCSCS."Even/Odd Semester"::FALL THEN
//                                                             ClassAssignmentHeaderCS."Exam Group" := 'EVEN'
//                                                         ELSE
//                                                             IF EducationSetupCSCS."Even/Odd Semester" = EducationSetupCSCS."Even/Odd Semester"::SPRING THEN
//                                                                 ClassAssignmentHeaderCS."Exam Group" := 'ODD';
//                                                         ClassAssignmentHeaderCS.VALIDATE("Exam Method Code", SessionalExamGroupCS."Exam Method Code");
//                                                         ClassAssignmentHeaderCS."Maximum Mark" := SessionalExamGroupCS."Maximum Marks";
//                                                         ClassAssignmentHeaderCS."Global Dimension 1 Code" := CourseWiseSubjectLineCS."Global Dimension 1 Code";
//                                                         ClassAssignmentHeaderCS."Maximum Weightage" := SessionalExamGroupCS."Maximum Weightage";
//                                                         ClassAssignmentHeaderCS."Created By" := FORMAT(UserId());
//                                                         ClassAssignmentHeaderCS."Created On" := TODAY();
//                                                         ClassAssignmentHeaderCS."Assignment Status" := ClassAssignmentHeaderCS."Assignment Status"::Open;
//                                                         ClassAssignmentHeaderCS.Insert();

//                                                         IF ClassAssignmentHeaderCS."Assignment Status" = ClassAssignmentHeaderCS."Assignment Status"::Open THEN BEGIN
//                                                             ActionMarkCS.GetStudentsCS(ClassAssignmentHeaderCS);
//                                                             CourseWiseSubjectLineCS."Assignment Generated" := TRUE;
//                                                             CourseWiseSubjectLineCS.Modify();
//                                                         END ELSE
//                                                             ClassAssignmentHeaderCS.TESTFIELD("Assignment Status", ClassAssignmentHeaderCS."Assignment Status"::Open);
//                                                     //END;
//                                                     UNTIL BatchCS.NEXT() = 0;
//                                                 END ELSE
//                                                     ERROR('Batch Master Details Not Defined');
//                                             UNTIL SessionalExamGroupCS.NEXT() = 0;
//                                         END ELSE
//                                             ERROR('Exam Group details Not Defined');
//                                     END;
//                                 SectionCode := FacultyCourseWiseCS."Section Code";
//                             END;
//                         UNTIL FacultyCourseWiseCS.NEXT() = 0;
//                 END;
//             UNTIL CourseWiseSubjectLineCS.NEXT() = 0;


//         CourseWiseSubjectLineCS.Reset();
//         CourseWiseSubjectLineCS.SETCURRENTKEY("Course Code", "Type Of Course", Semester, Year, "Subject Classification", "Subject Type", "Subject Code");
//         CourseWiseSubjectLineCS.SETRANGE("Academic Year", EducationSetupCSCS."Academic Year");
//         CourseWiseSubjectLineCS.SETRANGE("Program", 'PG');
//         CourseWiseSubjectLineCS.SETRANGE("Global Dimension 1 Code", EducationSetupCSCS."Global Dimension 1 Code");
//         CourseWiseSubjectLineCS.SETFILTER("Subject Classification", '%1|%2', 'THEORY', 'LAB');
//         IF EducationSetupCSCS."Even/Odd Semester" = EducationSetupCSCS."Even/Odd Semester"::FALL THEN
//             CourseWiseSubjectLineCS.SETFILTER(Semester, '%1|%2|%3|%4', 'II', 'IV', 'VI', 'VIII')
//         ELSE
//             IF EducationSetupCSCS."Even/Odd Semester" = EducationSetupCSCS."Even/Odd Semester"::SPRING THEN
//                 CourseWiseSubjectLineCS.SETFILTER(Semester, '%1|%2|%3|%4', 'I', 'III', 'V', 'VII');
//         CourseWiseSubjectLineCS.SETRANGE("Program/Open Elective Temp", CourseWiseSubjectLineCS."Program/Open Elective Temp"::" ");
//         IF CourseWiseSubjectLineCS.FINDSET() THEN
//             REPEAT
//                 ClassAssignmentHeaderCS1.Reset();
//                 ClassAssignmentHeaderCS1.SETRANGE("Academic Year", CourseWiseSubjectLineCS."Academic Year");
//                 ClassAssignmentHeaderCS1.SETFILTER("Subject Type", '<>%1', 'CORE');
//                 ClassAssignmentHeaderCS1.SETRANGE(Semester, CourseWiseSubjectLineCS.Semester);
//                 ClassAssignmentHeaderCS1.SETRANGE("Subject Code", CourseWiseSubjectLineCS."Subject Code");
//                 IF NOT ClassAssignmentHeaderCS1.Findfirst() THEN BEGIN
//                     SectionCode := '';
//                     FacultyCourseWiseCS.Reset();
//                     FacultyCourseWiseCS.SETCURRENTKEY("Semester Code", "Subject Code", "Section Code");
//                     IF CourseWiseSubjectLineCS."Subject Type" = 'CORE' THEN
//                         FacultyCourseWiseCS.SETRANGE("Course Code", CourseWiseSubjectLineCS."Course Code");
//                     IF CourseWiseSubjectLineCS."Type Of Course" = CourseWiseSubjectLineCS."Type Of Course"::Semester THEN
//                         FacultyCourseWiseCS.SETRANGE("Semester Code", CourseWiseSubjectLineCS.Semester)
//                     ELSE
//                         FacultyCourseWiseCS.SETRANGE("Year Code", CourseWiseSubjectLineCS.Year);
//                     FacultyCourseWiseCS.SETRANGE(Graduation, CourseWiseSubjectLineCS."Program");
//                     FacultyCourseWiseCS.SETRANGE("Academic Year", CourseWiseSubjectLineCS."Academic Year");
//                     FacultyCourseWiseCS.SETRANGE("Subject Class", CourseWiseSubjectLineCS."Subject Classification");
//                     FacultyCourseWiseCS.SETRANGE("Subject Code", CourseWiseSubjectLineCS."Subject Code");
//                     FacultyCourseWiseCS.SETRANGE("Global Dimension 1 Code", CourseWiseSubjectLineCS."Global Dimension 1 Code");
//                     IF FacultyCourseWiseCS.FINDSET() THEN
//                         REPEAT
//                             IF SectionCode <> FacultyCourseWiseCS."Section Code" THEN BEGIN
//                                 IF CourseWiseSubjectLineCS."Subject Classification" = 'THEORY' THEN BEGIN
//                                     SessionalExamGroupCS.Reset();
//                                     IF EducationSetupCSCS."Even/Odd Semester" = EducationSetupCSCS."Even/Odd Semester"::FALL THEN
//                                         SessionalExamGroupCS.SETRANGE(Group, 'EVEN')
//                                     ELSE
//                                         IF EducationSetupCSCS."Even/Odd Semester" = EducationSetupCSCS."Even/Odd Semester"::SPRING THEN
//                                             SessionalExamGroupCS.SETRANGE(Group, 'ODD');
//                                     SessionalExamGroupCS.SETRANGE("Exam Type", SessionalExamGroupCS."Exam Type"::Assignment);
//                                     SessionalExamGroupCS.SETRANGE("Applicable Exam", TRUE);
//                                     IF SessionalExamGroupCS.FINDSET() THEN BEGIN
//                                         REPEAT

//                                             NEXTNo := NoSeriesManagement.GetNEXTNo(AcademicsSetupCS."Assignment No.", 0D, TRUE);

//                                             ClassAssignmentHeaderCS.INIT();
//                                             ClassAssignmentHeaderCS."Assignment No." := NEXTNo;
//                                             ClassAssignmentHeaderCS.VALIDATE("Course Code", CourseWiseSubjectLineCS."Course Code");
//                                             ClassAssignmentHeaderCS.Semester := CourseWiseSubjectLineCS.Semester;
//                                             ClassAssignmentHeaderCS.Year := CourseWiseSubjectLineCS.Year;
//                                             ClassAssignmentHeaderCS.Section := FacultyCourseWiseCS."Section Code";
//                                             ClassAssignmentHeaderCS."Program" := CourseWiseSubjectLineCS."Program";
//                                             ClassAssignmentHeaderCS."Academic Year" := EducationSetupCSCS."Academic Year";
//                                             ClassAssignmentHeaderCS."Subject Class" := CourseWiseSubjectLineCS."Subject Classification";
//                                             ClassAssignmentHeaderCS."Subject Type" := CourseWiseSubjectLineCS."Subject Type";
//                                             ClassAssignmentHeaderCS.VALIDATE("Subject Code", CourseWiseSubjectLineCS."Subject Code");
//                                             ClassAssignmentHeaderCS."Faculty Code" := FacultyCourseWiseCS."Faculty Code";
//                                             ClassAssignmentHeaderCS."Faculty Name" := FacultyCourseWiseCS."Faculty Name";
//                                             IF EducationSetupCSCS."Even/Odd Semester" = EducationSetupCSCS."Even/Odd Semester"::FALL THEN
//                                                 ClassAssignmentHeaderCS."Exam Group" := 'EVEN'
//                                             ELSE
//                                                 IF EducationSetupCSCS."Even/Odd Semester" = EducationSetupCSCS."Even/Odd Semester"::SPRING THEN
//                                                     ClassAssignmentHeaderCS."Exam Group" := 'ODD';
//                                             ClassAssignmentHeaderCS.VALIDATE("Exam Method Code", SessionalExamGroupCS."Exam Method Code");
//                                             ClassAssignmentHeaderCS."Global Dimension 1 Code" := CourseWiseSubjectLineCS."Global Dimension 1 Code";
//                                             ClassAssignmentHeaderCS."Maximum Mark" := SessionalExamGroupCS."Maximum Marks";
//                                             ClassAssignmentHeaderCS."Maximum Weightage" := SessionalExamGroupCS."Maximum Weightage";
//                                             ClassAssignmentHeaderCS."Created By" := FORMAT(UserId());
//                                             ClassAssignmentHeaderCS."Created On" := TODAY();
//                                             ClassAssignmentHeaderCS."Assignment Status" := ClassAssignmentHeaderCS."Assignment Status"::Open;
//                                             ClassAssignmentHeaderCS.Insert();

//                                             IF ClassAssignmentHeaderCS."Assignment Status" = ClassAssignmentHeaderCS."Assignment Status"::Open THEN BEGIN
//                                                 ActionMarkCS.GetStudentsCS(ClassAssignmentHeaderCS);
//                                                 CourseWiseSubjectLineCS."Assignment Generated" := TRUE;
//                                                 CourseWiseSubjectLineCS.Modify();
//                                             END ELSE
//                                                 ClassAssignmentHeaderCS.TESTFIELD("Assignment Status", ClassAssignmentHeaderCS."Assignment Status"::Open);
//                                         //END;
//                                         UNTIL SessionalExamGroupCS.NEXT() = 0;
//                                     END ELSE
//                                         ERROR('Exam Group details Not Defined');
//                                 END ELSE
//                                     IF CourseWiseSubjectLineCS."Subject Classification" = 'LAB' THEN BEGIN
//                                         SessionalExamGroupCS.Reset();
//                                         IF EducationSetupCSCS."Even/Odd Semester" = EducationSetupCSCS."Even/Odd Semester"::FALL THEN
//                                             SessionalExamGroupCS.SETRANGE(Group, 'EVEN')
//                                         ELSE
//                                             IF EducationSetupCSCS."Even/Odd Semester" = EducationSetupCSCS."Even/Odd Semester"::SPRING THEN
//                                                 SessionalExamGroupCS.SETRANGE(Group, 'ODD');
//                                         SessionalExamGroupCS.SETRANGE("Exam Type", SessionalExamGroupCS."Exam Type"::"Internal Lab");
//                                         IF CourseWiseSubjectLineCS."Number of Lab Component" <> 0 THEN
//                                             SessionalExamGroupCS.SETRANGE("Exam Order", 1, CourseWiseSubjectLineCS."Number of Lab Component")
//                                         ELSE
//                                             SessionalExamGroupCS.SETRANGE("Exam Order", 1, 15);
//                                         SessionalExamGroupCS.SETRANGE("Applicable Exam", TRUE);
//                                         IF SessionalExamGroupCS.FINDSET() THEN BEGIN
//                                             REPEAT
//                                                 BatchCS.Reset();
//                                                 IF CourseWiseSubjectLineCS."Applicable Batch" <> '' THEN
//                                                     BatchCS.SETFILTER(Code, CourseWiseSubjectLineCS."Applicable Batch");
//                                                 BatchCS.SETRANGE("Global Dimension 1 Code", EducationSetupCSCS."Global Dimension 1 Code");
//                                                 IF BatchCS.FINDSET() THEN BEGIN
//                                                     REPEAT

//                                                         NEXTNo := NoSeriesManagement.GetNEXTNo(AcademicsSetupCS."Assignment No.", 0D, TRUE);

//                                                         ClassAssignmentHeaderCS.INIT();
//                                                         ClassAssignmentHeaderCS."Assignment No." := NEXTNo;
//                                                         ClassAssignmentHeaderCS.VALIDATE("Course Code", CourseWiseSubjectLineCS."Course Code");
//                                                         ClassAssignmentHeaderCS.Semester := CourseWiseSubjectLineCS.Semester;
//                                                         ClassAssignmentHeaderCS.Year := CourseWiseSubjectLineCS.Year;
//                                                         ClassAssignmentHeaderCS.Section := FacultyCourseWiseCS."Section Code";
//                                                         ClassAssignmentHeaderCS."Program" := CourseWiseSubjectLineCS."Program";
//                                                         ClassAssignmentHeaderCS."Student Batch" := BatchCS.Code;
//                                                         ClassAssignmentHeaderCS."Academic Year" := EducationSetupCSCS."Academic Year";
//                                                         ClassAssignmentHeaderCS."Subject Class" := CourseWiseSubjectLineCS."Subject Classification";
//                                                         ClassAssignmentHeaderCS."Subject Type" := CourseWiseSubjectLineCS."Subject Type";
//                                                         ClassAssignmentHeaderCS.VALIDATE("Subject Code", CourseWiseSubjectLineCS."Subject Code");
//                                                         ClassAssignmentHeaderCS."Faculty Code" := FacultyCourseWiseCS."Faculty Code";
//                                                         ClassAssignmentHeaderCS."Faculty Name" := FacultyCourseWiseCS."Faculty Name";
//                                                         IF EducationSetupCSCS."Even/Odd Semester" = EducationSetupCSCS."Even/Odd Semester"::FALL THEN
//                                                             ClassAssignmentHeaderCS."Exam Group" := 'EVEN'
//                                                         ELSE
//                                                             IF EducationSetupCSCS."Even/Odd Semester" = EducationSetupCSCS."Even/Odd Semester"::SPRING THEN
//                                                                 ClassAssignmentHeaderCS."Exam Group" := 'ODD';
//                                                         ClassAssignmentHeaderCS.VALIDATE("Exam Method Code", SessionalExamGroupCS."Exam Method Code");
//                                                         ClassAssignmentHeaderCS."Maximum Mark" := SessionalExamGroupCS."Maximum Marks";
//                                                         ClassAssignmentHeaderCS."Global Dimension 1 Code" := CourseWiseSubjectLineCS."Global Dimension 1 Code";
//                                                         ClassAssignmentHeaderCS."Maximum Weightage" := SessionalExamGroupCS."Maximum Weightage";
//                                                         ClassAssignmentHeaderCS."Created By" := FORMAT(UserId());
//                                                         ClassAssignmentHeaderCS."Created On" := TODAY();
//                                                         ClassAssignmentHeaderCS."Assignment Status" := ClassAssignmentHeaderCS."Assignment Status"::Open;
//                                                         ClassAssignmentHeaderCS.Insert();

//                                                         IF ClassAssignmentHeaderCS."Assignment Status" = ClassAssignmentHeaderCS."Assignment Status"::Open THEN BEGIN
//                                                             ActionMarkCS.GetStudentsCS(ClassAssignmentHeaderCS);
//                                                             CourseWiseSubjectLineCS."Assignment Generated" := TRUE;
//                                                             CourseWiseSubjectLineCS.Modify();
//                                                         END ELSE
//                                                             ClassAssignmentHeaderCS.TESTFIELD("Assignment Status", ClassAssignmentHeaderCS."Assignment Status"::Open);
//                                                     //END;
//                                                     UNTIL BatchCS.NEXT() = 0;
//                                                 END ELSE
//                                                     ERROR('Batch Master Details Not Defined');
//                                             UNTIL SessionalExamGroupCS.NEXT() = 0;
//                                         END ELSE
//                                             ERROR('Exam Group details Not Defined');
//                                     END;
//                                 SectionCode := FacultyCourseWiseCS."Section Code";
//                             END;
//                         UNTIL FacultyCourseWiseCS.NEXT() = 0;
//                 END;
//             UNTIL CourseWiseSubjectLineCS.NEXT() = 0;

//         EducationSetupCSCS.Reset();
//         EducationSetupCSCS.SETRANGE("Global Dimension 1 Code", InstituteCode);
//         IF EducationSetupCSCS.Findfirst() THEN BEGIN
//             EducationSetupCSCS."Assignment  Generated" := TRUE;
//             EducationSetupCSCS.Modify();
//         END;

//         //Code Add For  Create Automate Internal Assignment Details::CSPL-00059::19022019: End
//     end;

//     procedure CSCreateAutomateInternalExamGroupSubjClassWise(InstituteCode: Code[20])
//     var
//         CourseWiseSubjectHeadCS: Record "Course Wise Subject Head-CS";
//         CourseWiseSubjectLineCS: Record "Course Wise Subject Line-CS";
//         SessionalExamGroupCS: Record "Sessional Exam Group-CS";
//         EducationSetupCSCS: Record "Education Setup-CS";
//         SessionalExamGroupHeadCS: Record "Sessional Exam Group Head-CS";
//         SessionalExamGroupLineCS: Record "Sessional Exam Group Line-CS";
//         SubjectClassificationCS: Record "Subject Classification-CS";
//         ExamGroupCodeCS: Record "Exam Group Code-CS";
//         AcademicsSetupCS: Record "Academics Setup-CS";
//         NoSeriesManagement: Codeunit NoSeriesManagement;
//         "LocLineNo.": Integer;
//         NEXTNo: Code[20];

//     begin
//         //Code Add For  Create Automate Internal Exam Group Subj Class Wise::CSPL-00059::19022019: Start
//         AcademicsSetupCS.GET();
//         AcademicsSetupCS.TESTFIELD("Internal Exam Group No.");

//         IF InstituteCode = '' THEN
//             ERROR('Please Select Institute Code !!');
//         EducationSetupCSCS.Reset();
//         EducationSetupCSCS.SETRANGE("Global Dimension 1 Code", InstituteCode);
//         IF EducationSetupCSCS.Findfirst() THEN
//             EducationSetupCSCS.TESTFIELD("Academic Year")
//         ELSE
//             ERROR('Education Setup Not Defined !!');


//         CourseWiseSubjectHeadCS.Reset();
//         CourseWiseSubjectHeadCS.SETCURRENTKEY(Course, Semester, Year);
//         CourseWiseSubjectHeadCS.SETRANGE(Course, EducationSetupCSCS."Course Code");
//         CourseWiseSubjectHeadCS.SETRANGE("Academic Year", EducationSetupCSCS."Academic Year");
//         CourseWiseSubjectHeadCS.SETRANGE("Global Dimension 1 Code", EducationSetupCSCS."Global Dimension 1 Code");
//         CourseWiseSubjectHeadCS.SETRANGE("Program", 'UG');
//         IF EducationSetupCSCS."Even/Odd Semester" = EducationSetupCSCS."Even/Odd Semester"::FALL THEN
//             CourseWiseSubjectHeadCS.SETFILTER(Semester, '%1', 'II')
//         ELSE
//             IF EducationSetupCSCS."Even/Odd Semester" = EducationSetupCSCS."Even/Odd Semester"::SPRING THEN
//                 CourseWiseSubjectHeadCS.SETFILTER(Semester, '%1', 'I');
//         CourseWiseSubjectHeadCS.SETRANGE("Int. Exam Group Generated", FALSE);
//         IF CourseWiseSubjectHeadCS.FINDSET() THEN
//             REPEAT
//                 SubjectClassificationCS.Reset();
//                 SubjectClassificationCS.SETRANGE("Int. Exam Not Applicable", FALSE);
//                 SubjectClassificationCS.SETCURRENTKEY(Code);
//                 IF SubjectClassificationCS.FINDSET() THEN
//                     REPEAT
//                         CourseWiseSubjectLineCS.Reset();
//                         CourseWiseSubjectLineCS.SETRANGE("Course Code", CourseWiseSubjectHeadCS.Course);
//                         CourseWiseSubjectLineCS.SETRANGE(Semester, CourseWiseSubjectHeadCS.Semester);
//                         CourseWiseSubjectLineCS.SETRANGE("Academic Year", CourseWiseSubjectHeadCS."Academic Year");
//                         CourseWiseSubjectLineCS.SETRANGE("Global Dimension 1 Code", CourseWiseSubjectHeadCS."Global Dimension 1 Code");
//                         CourseWiseSubjectLineCS.SETRANGE("Subject Classification", SubjectClassificationCS.Code);
//                         IF CourseWiseSubjectLineCS.Findfirst() THEN BEGIN

//                             NEXTNo := NoSeriesManagement.GetNEXTNo(AcademicsSetupCS."Internal Exam Group No.", 0D, TRUE);

//                             "LocLineNo." := 0;
//                             SessionalExamGroupHeadCS.INIT();
//                             SessionalExamGroupHeadCS."No." := NEXTNo;
//                             SessionalExamGroupHeadCS.Semester := CourseWiseSubjectLineCS.Semester;
//                             SessionalExamGroupHeadCS.Year := CourseWiseSubjectLineCS.Year;
//                             SessionalExamGroupHeadCS."Academic Year" := EducationSetupCSCS."Academic Year";
//                             SessionalExamGroupHeadCS."Subject Class" := CourseWiseSubjectLineCS."Subject Classification";
//                             SessionalExamGroupHeadCS."Internal Maximum" := CourseWiseSubjectLineCS."Internal Maximum";
//                             SessionalExamGroupHeadCS."Type Of Course" := CourseWiseSubjectHeadCS."Type Of Course";
//                             SessionalExamGroupHeadCS."Program" := CourseWiseSubjectHeadCS."Program";
//                             SessionalExamGroupHeadCS."Global Dimension 1 Code" := CourseWiseSubjectHeadCS."Global Dimension 1 Code";
//                             SessionalExamGroupHeadCS."Global Dimension 2 Code" := CourseWiseSubjectHeadCS."Global Dimension 2 Code";
//                             IF EducationSetupCSCS."Even/Odd Semester" = EducationSetupCSCS."Even/Odd Semester"::FALL THEN
//                                 SessionalExamGroupHeadCS."Exam Group" := 'EVEN'
//                             ELSE
//                                 IF EducationSetupCSCS."Even/Odd Semester" = EducationSetupCSCS."Even/Odd Semester"::SPRING THEN
//                                     SessionalExamGroupHeadCS."Exam Group" := 'ODD';
//                             SessionalExamGroupHeadCS."Created By" := FORMAT(UserId());
//                             SessionalExamGroupHeadCS."Created On" := TODAY();
//                             SessionalExamGroupHeadCS.Insert();
//                             SessionalExamGroupCS.Reset();
//                             IF EducationSetupCSCS."Even/Odd Semester" = EducationSetupCSCS."Even/Odd Semester"::FALL THEN
//                                 SessionalExamGroupCS.SETRANGE(Group, 'EVEN')
//                             ELSE
//                                 IF EducationSetupCSCS."Even/Odd Semester" = EducationSetupCSCS."Even/Odd Semester"::SPRING THEN
//                                     SessionalExamGroupCS.SETRANGE(Group, 'ODD');
//                             SessionalExamGroupCS.SETRANGE("Document Type", SessionalExamGroupCS."Document Type"::Internal);
//                             SessionalExamGroupCS.SETRANGE("Subject Class", SessionalExamGroupHeadCS."Subject Class");
//                             IF SessionalExamGroupCS.FINDSET() THEN
//                                 REPEAT
//                                     "LocLineNo." += 10000;
//                                     SessionalExamGroupLineCS.INIT();
//                                     SessionalExamGroupLineCS."Document No." := NEXTNo;
//                                     SessionalExamGroupLineCS."Line No." += "LocLineNo.";
//                                     SessionalExamGroupLineCS.Semester := SessionalExamGroupHeadCS.Semester;
//                                     SessionalExamGroupLineCS.Section := SessionalExamGroupHeadCS.Section;
//                                     SessionalExamGroupLineCS."Academic year" := EducationSetupCSCS."Academic Year";
//                                     SessionalExamGroupLineCS."Exam Group" := SessionalExamGroupCS.Group;
//                                     SessionalExamGroupLineCS."Exam Method" := SessionalExamGroupCS."Exam Method Code";
//                                     SessionalExamGroupLineCS."Maximum Marks" := SessionalExamGroupCS."Maximum Marks";
//                                     SessionalExamGroupLineCS.Weightage := SessionalExamGroupCS."Maximum Weightage";
//                                     SessionalExamGroupLineCS."Type Of Course" := CourseWiseSubjectLineCS."Type Of Course";
//                                     SessionalExamGroupLineCS.Year := CourseWiseSubjectHeadCS.Year;
//                                     SessionalExamGroupLineCS."Program" := SessionalExamGroupHeadCS."Program";
//                                     SessionalExamGroupLineCS."Global Dimension 1 Code" := SessionalExamGroupHeadCS."Global Dimension 1 Code";
//                                     SessionalExamGroupLineCS."Global Dimension 2 Code" := SessionalExamGroupHeadCS."Global Dimension 2 Code";
//                                     SessionalExamGroupLineCS."Created By" := FORMAT(UserId());
//                                     SessionalExamGroupLineCS."Created On" := TODAY();
//                                     IF ExamGroupCodeCS.GET(SessionalExamGroupCS."Exam Method Code") THEN
//                                         SessionalExamGroupLineCS."Method Description" := ExamGroupCodeCS.Description;
//                                     SessionalExamGroupLineCS.Insert();
//                                 UNTIL SessionalExamGroupCS.NEXT() = 0;
//                         END;
//                     UNTIL SubjectClassificationCS.NEXT() = 0;
//                 CourseWiseSubjectHeadCS."Int. Exam Group Generated" := TRUE;
//                 CourseWiseSubjectHeadCS.Modify();
//             UNTIL CourseWiseSubjectHeadCS.NEXT() = 0;


//         CourseWiseSubjectHeadCS.Reset();
//         CourseWiseSubjectHeadCS.SETCURRENTKEY(Course, Semester, Year);
//         CourseWiseSubjectHeadCS.SETRANGE("Academic Year", EducationSetupCSCS."Academic Year");
//         CourseWiseSubjectHeadCS.SETRANGE("Global Dimension 1 Code", EducationSetupCSCS."Global Dimension 1 Code");
//         CourseWiseSubjectHeadCS.SETRANGE("Program", 'UG');
//         IF EducationSetupCSCS."Even/Odd Semester" = EducationSetupCSCS."Even/Odd Semester"::FALL THEN
//             CourseWiseSubjectHeadCS.SETFILTER(Semester, '%1|%2|%3', 'IV', 'VI', 'VIII')
//         ELSE
//             IF EducationSetupCSCS."Even/Odd Semester" = EducationSetupCSCS."Even/Odd Semester"::SPRING THEN
//                 CourseWiseSubjectHeadCS.SETFILTER(Semester, '%1|%2|%3', 'III', 'V', 'VII');
//         CourseWiseSubjectHeadCS.SETRANGE("Int. Exam Group Generated", FALSE);
//         IF CourseWiseSubjectHeadCS.FINDSET() THEN
//             REPEAT
//                 SubjectClassificationCS.Reset();
//                 SubjectClassificationCS.SETRANGE("Int. Exam Not Applicable", FALSE);
//                 SubjectClassificationCS.SETCURRENTKEY(Code);
//                 IF SubjectClassificationCS.FINDSET() THEN
//                     REPEAT
//                         CourseWiseSubjectLineCS.Reset();
//                         CourseWiseSubjectLineCS.SETRANGE("Course Code", CourseWiseSubjectHeadCS.Course);
//                         CourseWiseSubjectLineCS.SETRANGE(Semester, CourseWiseSubjectHeadCS.Semester);
//                         CourseWiseSubjectLineCS.SETRANGE("Academic Year", CourseWiseSubjectHeadCS."Academic Year");
//                         CourseWiseSubjectLineCS.SETRANGE("Global Dimension 1 Code", CourseWiseSubjectHeadCS."Global Dimension 1 Code");
//                         CourseWiseSubjectLineCS.SETRANGE("Subject Classification", SubjectClassificationCS.Code);
//                         IF CourseWiseSubjectLineCS.Findfirst() THEN BEGIN

//                             NEXTNo := NoSeriesManagement.GetNEXTNo(AcademicsSetupCS."Internal Exam Group No.", 0D, TRUE);

//                             "LocLineNo." := 0;
//                             SessionalExamGroupHeadCS.INIT();
//                             SessionalExamGroupHeadCS."No." := NEXTNo;
//                             SessionalExamGroupHeadCS.VALIDATE("Course Code", CourseWiseSubjectLineCS."Course Code");
//                             SessionalExamGroupHeadCS.Semester := CourseWiseSubjectLineCS.Semester;
//                             SessionalExamGroupHeadCS.Year := CourseWiseSubjectLineCS.Year;
//                             SessionalExamGroupHeadCS."Academic Year" := EducationSetupCSCS."Academic Year";
//                             SessionalExamGroupHeadCS."Subject Class" := CourseWiseSubjectLineCS."Subject Classification";
//                             SessionalExamGroupHeadCS."Internal Maximum" := CourseWiseSubjectLineCS."Internal Maximum";
//                             IF EducationSetupCSCS."Even/Odd Semester" = EducationSetupCSCS."Even/Odd Semester"::FALL THEN
//                                 SessionalExamGroupHeadCS."Exam Group" := 'EVEN'
//                             ELSE
//                                 IF EducationSetupCSCS."Even/Odd Semester" = EducationSetupCSCS."Even/Odd Semester"::SPRING THEN
//                                     SessionalExamGroupHeadCS."Exam Group" := 'ODD';
//                             SessionalExamGroupHeadCS."Created By" := FORMAT(UserId());
//                             SessionalExamGroupHeadCS."Created On" := TODAY();
//                             SessionalExamGroupHeadCS.Insert();
//                             SessionalExamGroupCS.Reset();
//                             IF EducationSetupCSCS."Even/Odd Semester" = EducationSetupCSCS."Even/Odd Semester"::FALL THEN
//                                 SessionalExamGroupCS.SETRANGE(Group, 'EVEN')
//                             ELSE
//                                 IF EducationSetupCSCS."Even/Odd Semester" = EducationSetupCSCS."Even/Odd Semester"::SPRING THEN
//                                     SessionalExamGroupCS.SETRANGE(Group, 'ODD');
//                             //SessionalExamGroupCSSETFILTER("Exam Type",'%1|%2',SessionalExamGroupCS"Exam Type"::Internal,SessionalExamGroupCS"Exam Type"::Assignment);
//                             SessionalExamGroupCS.SETRANGE("Document Type", SessionalExamGroupCS."Document Type"::Internal);
//                             SessionalExamGroupCS.SETRANGE("Subject Class", SessionalExamGroupHeadCS."Subject Class");
//                             IF SessionalExamGroupCS.FINDSET() THEN
//                                 REPEAT
//                                     "LocLineNo." += 10000;
//                                     SessionalExamGroupLineCS.INIT();
//                                     SessionalExamGroupLineCS."Document No." := NEXTNo;
//                                     SessionalExamGroupLineCS."Line No." += "LocLineNo.";
//                                     SessionalExamGroupLineCS.Course := SessionalExamGroupHeadCS."Course Code";
//                                     SessionalExamGroupLineCS.Semester := SessionalExamGroupHeadCS.Semester;
//                                     SessionalExamGroupLineCS.Section := SessionalExamGroupHeadCS.Section;
//                                     SessionalExamGroupLineCS."Academic year" := EducationSetupCSCS."Academic Year";
//                                     SessionalExamGroupLineCS."Subject Type" := SessionalExamGroupHeadCS."Subject Type";
//                                     SessionalExamGroupLineCS."Subject Code" := SessionalExamGroupHeadCS."Subject Code";
//                                     SessionalExamGroupLineCS."Exam Group" := SessionalExamGroupCS.Group;
//                                     SessionalExamGroupLineCS."Exam Method" := SessionalExamGroupCS."Exam Method Code";
//                                     SessionalExamGroupLineCS."Maximum Marks" := SessionalExamGroupCS."Maximum Marks";
//                                     SessionalExamGroupLineCS.Weightage := SessionalExamGroupCS."Maximum Weightage";
//                                     SessionalExamGroupLineCS."Type Of Course" := CourseWiseSubjectLineCS."Type Of Course";
//                                     SessionalExamGroupLineCS.Year := CourseWiseSubjectHeadCS.Year;
//                                     SessionalExamGroupLineCS."Program" := SessionalExamGroupHeadCS."Program";
//                                     SessionalExamGroupLineCS."Global Dimension 1 Code" := SessionalExamGroupHeadCS."Global Dimension 1 Code";
//                                     SessionalExamGroupLineCS."Global Dimension 2 Code" := SessionalExamGroupHeadCS."Global Dimension 2 Code";
//                                     SessionalExamGroupLineCS."Created By" := FORMAT(UserId());
//                                     SessionalExamGroupLineCS."Created On" := TODAY();
//                                     IF ExamGroupCodeCS.GET(SessionalExamGroupCS."Exam Method Code") THEN
//                                         SessionalExamGroupLineCS."Method Description" := ExamGroupCodeCS.Description;
//                                     SessionalExamGroupLineCS.Insert();
//                                 UNTIL SessionalExamGroupCS.NEXT() = 0;
//                         END;
//                     UNTIL SubjectClassificationCS.NEXT() = 0;
//                 CourseWiseSubjectHeadCS."Int. Exam Group Generated" := TRUE;
//                 CourseWiseSubjectHeadCS.Modify();
//             UNTIL CourseWiseSubjectHeadCS.NEXT() = 0;
//         //ELSE
//         //ERROR('Internal Exam Group Already Generated !!');


//         CourseWiseSubjectHeadCS.Reset();
//         CourseWiseSubjectHeadCS.SETCURRENTKEY(Course, Semester, Year);
//         CourseWiseSubjectHeadCS.SETRANGE("Academic Year", EducationSetupCSCS."Academic Year");
//         CourseWiseSubjectHeadCS.SETRANGE("Global Dimension 1 Code", EducationSetupCSCS."Global Dimension 1 Code");
//         CourseWiseSubjectHeadCS.SETRANGE("Program", 'PG');
//         IF EducationSetupCSCS."Even/Odd Semester" = EducationSetupCSCS."Even/Odd Semester"::FALL THEN
//             CourseWiseSubjectHeadCS.SETFILTER(Semester, '%1|%2|%3|%4', 'II', 'IV', 'VI', 'VIII')
//         ELSE
//             IF EducationSetupCSCS."Even/Odd Semester" = EducationSetupCSCS."Even/Odd Semester"::SPRING THEN
//                 CourseWiseSubjectHeadCS.SETFILTER(Semester, '%1|%2|%3|%4', 'I', 'III', 'V', 'VII');
//         CourseWiseSubjectHeadCS.SETRANGE("Int. Exam Group Generated", FALSE);
//         IF CourseWiseSubjectHeadCS.FINDSET() THEN
//             REPEAT
//                 SubjectClassificationCS.Reset();
//                 SubjectClassificationCS.SETRANGE("Int. Exam Not Applicable", FALSE);
//                 SubjectClassificationCS.SETCURRENTKEY(Code);
//                 IF SubjectClassificationCS.FINDSET() THEN
//                     REPEAT
//                         CourseWiseSubjectLineCS.Reset();
//                         CourseWiseSubjectLineCS.SETRANGE("Course Code", CourseWiseSubjectHeadCS.Course);
//                         CourseWiseSubjectLineCS.SETRANGE(Semester, CourseWiseSubjectHeadCS.Semester);
//                         CourseWiseSubjectLineCS.SETRANGE("Academic Year", CourseWiseSubjectHeadCS."Academic Year");
//                         CourseWiseSubjectLineCS.SETRANGE("Global Dimension 1 Code", CourseWiseSubjectHeadCS."Global Dimension 1 Code");
//                         //CourseWiseSubjectLineCS.SETRANGE("Global Dimension 2 Code",CourseWiseSubjectHeadCS."Global Dimension 2 Code");
//                         CourseWiseSubjectLineCS.SETRANGE("Subject Classification", SubjectClassificationCS.Code);
//                         IF CourseWiseSubjectLineCS.Findfirst() THEN BEGIN

//                             NEXTNo := NoSeriesManagement.GetNEXTNo(AcademicsSetupCS."Internal Exam Group No.", 0D, TRUE);

//                             "LocLineNo." := 0;
//                             SessionalExamGroupHeadCS.INIT();
//                             SessionalExamGroupHeadCS."No." := NEXTNo;
//                             SessionalExamGroupHeadCS.VALIDATE("Course Code", CourseWiseSubjectLineCS."Course Code");
//                             SessionalExamGroupHeadCS.Semester := CourseWiseSubjectLineCS.Semester;
//                             SessionalExamGroupHeadCS.Year := CourseWiseSubjectLineCS.Year;
//                             SessionalExamGroupHeadCS."Academic Year" := EducationSetupCSCS."Academic Year";
//                             SessionalExamGroupHeadCS."Subject Class" := CourseWiseSubjectLineCS."Subject Classification";
//                             SessionalExamGroupHeadCS."Internal Maximum" := CourseWiseSubjectLineCS."Internal Maximum";
//                             IF EducationSetupCSCS."Even/Odd Semester" = EducationSetupCSCS."Even/Odd Semester"::FALL THEN
//                                 SessionalExamGroupHeadCS."Exam Group" := 'EVEN'
//                             ELSE
//                                 IF EducationSetupCSCS."Even/Odd Semester" = EducationSetupCSCS."Even/Odd Semester"::SPRING THEN
//                                     SessionalExamGroupHeadCS."Exam Group" := 'ODD';
//                             SessionalExamGroupHeadCS."Created By" := FORMAT(UserId());
//                             SessionalExamGroupHeadCS."Created On" := TODAY();
//                             SessionalExamGroupHeadCS.Insert();
//                             SessionalExamGroupCS.Reset();
//                             IF EducationSetupCSCS."Even/Odd Semester" = EducationSetupCSCS."Even/Odd Semester"::FALL THEN
//                                 SessionalExamGroupCS.SETRANGE(Group, 'EVEN')
//                             ELSE
//                                 IF EducationSetupCSCS."Even/Odd Semester" = EducationSetupCSCS."Even/Odd Semester"::SPRING THEN
//                                     SessionalExamGroupCS.SETRANGE(Group, 'ODD');
//                             //SessionalExamGroupCSSETFILTER("Exam Type",'%1|%2',SessionalExamGroupCS"Exam Type"::Internal,SessionalExamGroupCS"Exam Type"::Assignment);
//                             SessionalExamGroupCS.SETRANGE("Document Type", SessionalExamGroupCS."Document Type"::Internal);
//                             SessionalExamGroupCS.SETRANGE("Subject Class", SessionalExamGroupHeadCS."Subject Class");
//                             IF SessionalExamGroupCS.FINDSET() THEN
//                                 REPEAT
//                                     "LocLineNo." += 10000;
//                                     SessionalExamGroupLineCS.INIT();
//                                     SessionalExamGroupLineCS."Document No." := NEXTNo;
//                                     SessionalExamGroupLineCS."Line No." += "LocLineNo.";
//                                     SessionalExamGroupLineCS.Course := SessionalExamGroupHeadCS."Course Code";
//                                     SessionalExamGroupLineCS.Semester := SessionalExamGroupHeadCS.Semester;
//                                     SessionalExamGroupLineCS.Section := SessionalExamGroupHeadCS.Section;
//                                     SessionalExamGroupLineCS."Academic year" := EducationSetupCSCS."Academic Year";
//                                     SessionalExamGroupLineCS."Subject Type" := SessionalExamGroupHeadCS."Subject Type";
//                                     SessionalExamGroupLineCS."Subject Code" := SessionalExamGroupHeadCS."Subject Code";
//                                     SessionalExamGroupLineCS."Exam Group" := SessionalExamGroupCS.Group;
//                                     SessionalExamGroupLineCS."Exam Method" := SessionalExamGroupCS."Exam Method Code";
//                                     SessionalExamGroupLineCS."Maximum Marks" := SessionalExamGroupCS."Maximum Marks";
//                                     SessionalExamGroupLineCS.Weightage := SessionalExamGroupCS."Maximum Weightage";
//                                     SessionalExamGroupLineCS."Type Of Course" := CourseWiseSubjectLineCS."Type Of Course";
//                                     SessionalExamGroupLineCS.Year := CourseWiseSubjectHeadCS.Year;
//                                     SessionalExamGroupLineCS."Program" := SessionalExamGroupHeadCS."Program";
//                                     SessionalExamGroupLineCS."Global Dimension 1 Code" := SessionalExamGroupHeadCS."Global Dimension 1 Code";
//                                     SessionalExamGroupLineCS."Global Dimension 2 Code" := SessionalExamGroupHeadCS."Global Dimension 2 Code";
//                                     SessionalExamGroupLineCS."Created By" := FORMAT(UserId());
//                                     SessionalExamGroupLineCS."Created On" := TODAY();
//                                     IF ExamGroupCodeCS.GET(SessionalExamGroupCS."Exam Method Code") THEN
//                                         SessionalExamGroupLineCS."Method Description" := ExamGroupCodeCS.Description;
//                                     SessionalExamGroupLineCS.Insert();
//                                 UNTIL SessionalExamGroupCS.NEXT() = 0;
//                         END;
//                     UNTIL SubjectClassificationCS.NEXT() = 0;
//                 CourseWiseSubjectHeadCS."Int. Exam Group Generated" := TRUE;
//                 CourseWiseSubjectHeadCS.Modify();
//             UNTIL CourseWiseSubjectHeadCS.NEXT() = 0;
//         //Code Add For  Create Automate Internal Exam Group Subj Class Wise::CSPL-00059::19022019: End
//     end;

//     procedure CSCreateAutomateTimeTable(InstituteCode: Code[20])
//     var
//         EducationSetupCSCS: Record "Education Setup-CS";
//         CourseSectionMasterCS: Record "Course Section Master-CS";
//         CourseSectionMasterCS1: Record "Course Section Master-CS";
//         ClassTimeTableHeaderCS: Record "Class Time Table Header-CS";
//         SectionMasterCS: Record "Section Master-CS";
//         AdmissionSetupCS: Record "Admission Setup-CS";
//         EducationMultiEventCalCS: Record "Education Multi Event Cal-CS";
//         NoSeriesManagement: Codeunit "NoSeriesManagement";
//         NEXTNo: Code[20];

//     begin
//         //Code Add For  Create Automate Time Table::CSPL-00059::19022019: Start
//         AdmissionSetupCS.GET();
//         AdmissionSetupCS.TESTFIELD("Time Table No.");

//         IF InstituteCode = '' THEN
//             ERROR('Please Select Institute Code !!');
//         EducationSetupCSCS.Reset();
//         EducationSetupCSCS.SETRANGE("Global Dimension 1 Code", InstituteCode);
//         IF EducationSetupCSCS.Findfirst() THEN
//             EducationSetupCSCS.TESTFIELD("Academic Year")
//         ELSE
//             ERROR('Education Setup Not Defined !!');


//         IF EducationSetupCSCS."Even/Odd Semester" = EducationSetupCSCS."Even/Odd Semester"::SPRING THEN BEGIN

//             EducationMultiEventCalCS.Reset();
//             EducationMultiEventCalCS.SETRANGE("Event Code", 'ODD SEM CLASS START');
//             EducationMultiEventCalCS.SETRANGE("Academic Year", EducationSetupCSCS."Academic Year");
//             IF EducationMultiEventCalCS.Findfirst() THEN BEGIN
//                 SectionMasterCS.Reset();
//                 SectionMasterCS.SETCURRENTKEY(Code);
//                 SectionMasterCS.SETRANGE("Global Dimension 1 Code", EducationSetupCSCS."Global Dimension 1 Code");
//                 SectionMasterCS.SETFILTER(Group, '<>%1', '');
//                 SectionMasterCS.SETRANGE("Time Table Generated", FALSE);
//                 IF SectionMasterCS.FINDSET() THEN
//                     REPEAT
//                         NEXTNo := NoSeriesManagement.GetNEXTNo(AdmissionSetupCS."Time Table No.", 0D, TRUE);

//                         ClassTimeTableHeaderCS.INIT();
//                         ClassTimeTableHeaderCS."No." := NEXTNo;
//                         ClassTimeTableHeaderCS."Program" := 'UG';
//                         ClassTimeTableHeaderCS.VALIDATE(Year, '1ST');
//                         ClassTimeTableHeaderCS.VALIDATE(Semester, 'I');
//                         ClassTimeTableHeaderCS.Section := SectionMasterCS.Code;
//                         ClassTimeTableHeaderCS."Academic Year" := EducationSetupCSCS."Academic Year";
//                         ClassTimeTableHeaderCS.Group := SectionMasterCS.Group;
//                         ClassTimeTableHeaderCS."Global Dimension 1 Code" := EducationSetupCSCS."Global Dimension 1 Code";
//                         ClassTimeTableHeaderCS.VALIDATE("Template Code", SectionMasterCS."Template No.");
//                         ClassTimeTableHeaderCS."Time Table Status" := ClassTimeTableHeaderCS."Time Table Status"::Open;
//                         ClassTimeTableHeaderCS.Insert();
//                         //SectionMasterCS."Time Table Generated" := TRUE;
//                         SectionMasterCS.Modify();
//                     UNTIL SectionMasterCS.NEXT() = 0
//                 ELSE
//                     ERROR(Text_10001Lbl);

//                 CourseSectionMasterCS.Reset();
//                 CourseSectionMasterCS.SETCURRENTKEY("Course Code", Semester, "Section Code");
//                 CourseSectionMasterCS.SETRANGE("Academic Year", EducationSetupCSCS."Academic Year");
//                 CourseSectionMasterCS.SETRANGE("Global Dimension 1 Code", EducationSetupCSCS."Global Dimension 1 Code");
//                 CourseSectionMasterCS.SETFILTER(Semester, '%1|%2|%3', 'III', 'V', 'VII');
//                 CourseSectionMasterCS.SETRANGE("Program", 'UG');
//                 CourseSectionMasterCS.SETRANGE("Time Table Generated", FALSE);
//                 IF CourseSectionMasterCS.FINDSET() THEN
//                     REPEAT
//                         NEXTNo := NoSeriesManagement.GetNEXTNo(AdmissionSetupCS."Time Table No.", 0D, TRUE);

//                         ClassTimeTableHeaderCS.INIT();
//                         ClassTimeTableHeaderCS."No." := NEXTNo;
//                         ClassTimeTableHeaderCS."Program" := CourseSectionMasterCS."Program";
//                         ClassTimeTableHeaderCS.VALIDATE(Year, CourseSectionMasterCS.Year);
//                         ClassTimeTableHeaderCS.VALIDATE(Semester, CourseSectionMasterCS.Semester);
//                         ClassTimeTableHeaderCS.Section := CourseSectionMasterCS."Section Code";
//                         ClassTimeTableHeaderCS."Academic Year" := EducationSetupCSCS."Academic Year";
//                         ClassTimeTableHeaderCS.VALIDATE(Course, CourseSectionMasterCS."Course Code");
//                         ClassTimeTableHeaderCS.VALIDATE("Template Code", CourseSectionMasterCS."Template No.");
//                         ClassTimeTableHeaderCS."Time Table Status" := ClassTimeTableHeaderCS."Time Table Status"::Open;
//                         ClassTimeTableHeaderCS.Insert();
//                         CourseSectionMasterCS.Modify();
//                     UNTIL CourseSectionMasterCS.NEXT() = 0
//                 ELSE
//                     ERROR(Text_10001Lbl);

//                 CourseSectionMasterCS1.Reset();
//                 CourseSectionMasterCS1.SETCURRENTKEY("Course Code", Semester, "Section Code");
//                 CourseSectionMasterCS1.SETRANGE("Academic Year", EducationSetupCSCS."Academic Year");
//                 CourseSectionMasterCS1.SETRANGE("Global Dimension 1 Code", EducationSetupCSCS."Global Dimension 1 Code");
//                 CourseSectionMasterCS1.SETFILTER(Semester, '%1|%2|%3|%4', 'I', 'III', 'V', 'VII');
//                 CourseSectionMasterCS1.SETRANGE("Program", 'PG');
//                 CourseSectionMasterCS1.SETRANGE("Time Table Generated", FALSE);
//                 IF CourseSectionMasterCS1.FINDSET() THEN
//                     REPEAT
//                         NEXTNo := NoSeriesManagement.GetNEXTNo(AdmissionSetupCS."Time Table No.", 0D, TRUE);

//                         ClassTimeTableHeaderCS.INIT();
//                         ClassTimeTableHeaderCS."No." := NEXTNo;
//                         ClassTimeTableHeaderCS."Program" := CourseSectionMasterCS1."Program";
//                         ClassTimeTableHeaderCS."Type Of Course" := CourseSectionMasterCS1."Type Of Course";
//                         ClassTimeTableHeaderCS.VALIDATE(Year, CourseSectionMasterCS1.Year);
//                         ClassTimeTableHeaderCS.VALIDATE(Semester, CourseSectionMasterCS1.Semester);
//                         ClassTimeTableHeaderCS.Section := CourseSectionMasterCS1."Section Code";
//                         ClassTimeTableHeaderCS."Academic Year" := EducationSetupCSCS."Academic Year";
//                         ClassTimeTableHeaderCS.VALIDATE(Course, CourseSectionMasterCS1."Course Code");
//                         ClassTimeTableHeaderCS.VALIDATE("Template Code", CourseSectionMasterCS1."Template No.");
//                         ClassTimeTableHeaderCS."Time Table Status" := ClassTimeTableHeaderCS."Time Table Status"::Open;
//                         ClassTimeTableHeaderCS.Insert();
//                         CourseSectionMasterCS1.Modify();
//                     UNTIL CourseSectionMasterCS1.NEXT() = 0
//                 ELSE
//                     ERROR(Text_10001Lbl);
//             END;

//         END ELSE
//             IF EducationSetupCSCS."Even/Odd Semester" = EducationSetupCSCS."Even/Odd Semester"::FALL THEN BEGIN
//                 EducationMultiEventCalCS.Reset();
//                 EducationMultiEventCalCS.SETRANGE("Event Code", 'EVENSEMCLASSSTART');
//                 EducationMultiEventCalCS.SETRANGE("Academic Year", EducationSetupCSCS."Academic Year");
//                 IF EducationMultiEventCalCS.Findfirst() THEN BEGIN
//                     SectionMasterCS.Reset();
//                     SectionMasterCS.SETCURRENTKEY(Code);
//                     SectionMasterCS.SETRANGE("Global Dimension 1 Code", EducationSetupCSCS."Global Dimension 1 Code");
//                     SectionMasterCS.SETFILTER(Group, '<>%1', '');
//                     SectionMasterCS.SETRANGE("Time Table Generated", FALSE);
//                     IF SectionMasterCS.FINDSET() THEN
//                         REPEAT
//                             NEXTNo := NoSeriesManagement.GetNEXTNo(AdmissionSetupCS."Time Table No.", 0D, TRUE);

//                             ClassTimeTableHeaderCS.INIT();
//                             ClassTimeTableHeaderCS."No." := NEXTNo;
//                             ClassTimeTableHeaderCS."Program" := 'UG';
//                             ClassTimeTableHeaderCS.VALIDATE(Year, '1ST');
//                             ClassTimeTableHeaderCS.VALIDATE(Semester, 'II');
//                             ClassTimeTableHeaderCS.Section := SectionMasterCS.Code;
//                             ClassTimeTableHeaderCS."Academic Year" := EducationSetupCSCS."Academic Year";
//                             ClassTimeTableHeaderCS.Group := SectionMasterCS.Group;
//                             ClassTimeTableHeaderCS."Global Dimension 1 Code" := EducationSetupCSCS."Global Dimension 1 Code";
//                             ClassTimeTableHeaderCS.VALIDATE("Template Code", SectionMasterCS."Template No.");
//                             ClassTimeTableHeaderCS."Time Table Status" := ClassTimeTableHeaderCS."Time Table Status"::Open;
//                             ClassTimeTableHeaderCS.Insert();
//                             //SectionMasterCS."Time Table Generated" := TRUE;
//                             SectionMasterCS.Modify();
//                         UNTIL SectionMasterCS.NEXT() = 0
//                     ELSE
//                         ERROR(Text_10001Lbl);

//                     CourseSectionMasterCS.Reset();
//                     CourseSectionMasterCS.SETCURRENTKEY("Course Code", Semester, "Section Code");
//                     CourseSectionMasterCS.SETRANGE("Academic Year", EducationSetupCSCS."Academic Year");
//                     CourseSectionMasterCS.SETRANGE("Global Dimension 1 Code", EducationSetupCSCS."Global Dimension 1 Code");
//                     CourseSectionMasterCS.SETFILTER(Semester, '%1|%2|%3', 'IV', 'VI', 'VIII');
//                     CourseSectionMasterCS.SETRANGE("Program", 'UG');
//                     CourseSectionMasterCS.SETRANGE("Time Table Generated", FALSE);
//                     IF CourseSectionMasterCS.FINDSET() THEN
//                         REPEAT
//                             NEXTNo := NoSeriesManagement.GetNEXTNo(AdmissionSetupCS."Time Table No.", 0D, TRUE);

//                             ClassTimeTableHeaderCS.INIT();
//                             ClassTimeTableHeaderCS."No." := NEXTNo;
//                             ClassTimeTableHeaderCS."Program" := CourseSectionMasterCS."Program";
//                             ClassTimeTableHeaderCS.VALIDATE(Year, CourseSectionMasterCS.Year);
//                             ClassTimeTableHeaderCS.VALIDATE(Semester, CourseSectionMasterCS.Semester);
//                             ClassTimeTableHeaderCS.Section := CourseSectionMasterCS."Section Code";
//                             ClassTimeTableHeaderCS."Academic Year" := EducationSetupCSCS."Academic Year";
//                             ClassTimeTableHeaderCS.VALIDATE(Course, CourseSectionMasterCS."Course Code");
//                             //ClassTimeTableHeaderCS."Global Dimension 1 Code" := EducationSetupCSCS."Global Dimension 1 Code";
//                             ClassTimeTableHeaderCS.VALIDATE("Template Code", CourseSectionMasterCS."Template No.");
//                             ClassTimeTableHeaderCS."Time Table Status" := ClassTimeTableHeaderCS."Time Table Status"::Open;
//                             ClassTimeTableHeaderCS.Insert();
//                             //CourseSectionMasterCS."Time Table Generated" := TRUE;
//                             CourseSectionMasterCS.Modify();
//                         UNTIL CourseSectionMasterCS.NEXT() = 0
//                     ELSE
//                         ERROR(Text_10001Lbl);

//                     CourseSectionMasterCS1.Reset();
//                     CourseSectionMasterCS1.SETCURRENTKEY("Course Code", Semester, "Section Code");
//                     CourseSectionMasterCS1.SETRANGE("Academic Year", EducationSetupCSCS."Academic Year");
//                     CourseSectionMasterCS1.SETRANGE("Global Dimension 1 Code", EducationSetupCSCS."Global Dimension 1 Code");
//                     CourseSectionMasterCS1.SETFILTER(Semester, '%1|%2|%3|%4', 'II', 'IV', 'IV', 'VIII');
//                     CourseSectionMasterCS1.SETRANGE("Program", 'PG');
//                     CourseSectionMasterCS1.SETRANGE("Time Table Generated", FALSE);
//                     IF CourseSectionMasterCS1.FINDSET() THEN
//                         REPEAT
//                             NEXTNo := NoSeriesManagement.GetNEXTNo(AdmissionSetupCS."Time Table No.", 0D, TRUE);

//                             ClassTimeTableHeaderCS.INIT();
//                             ClassTimeTableHeaderCS."No." := NEXTNo;
//                             ClassTimeTableHeaderCS."Program" := CourseSectionMasterCS1."Program";
//                             ClassTimeTableHeaderCS."Type Of Course" := CourseSectionMasterCS1."Type Of Course";
//                             ClassTimeTableHeaderCS.VALIDATE(Year, CourseSectionMasterCS1.Year);
//                             ClassTimeTableHeaderCS.VALIDATE(Semester, CourseSectionMasterCS1.Semester);
//                             ClassTimeTableHeaderCS.Section := CourseSectionMasterCS1."Section Code";
//                             ClassTimeTableHeaderCS."Academic Year" := EducationSetupCSCS."Academic Year";
//                             ClassTimeTableHeaderCS.VALIDATE(Course, CourseSectionMasterCS1."Course Code");
//                             ClassTimeTableHeaderCS.VALIDATE("Template Code", CourseSectionMasterCS1."Template No.");
//                             ClassTimeTableHeaderCS."Time Table Status" := ClassTimeTableHeaderCS."Time Table Status"::Open;
//                             ClassTimeTableHeaderCS.Insert();
//                             CourseSectionMasterCS1.Modify();
//                         UNTIL CourseSectionMasterCS1.NEXT() = 0;
//                 END;
//             END;

//         //Code Add For  Create Automate Time Table::CSPL-00059::19022019: End
//     end;

//     procedure CSCreateExternalExamDetails(InstituteCode: Code[20]; ScheduleNo: Code[20]; ExamClassification: Code[20])
//     var
//         ExamTimeTableLineCS: Record "Exam Time Table Line-CS";
//         EducationSetupCSCS: Record "Education Setup-CS";
//         CourseWiseSubjectLineCS: Record "Course Wise Subject Line-CS";
//         ExternalExamHeaderCS: Record "External Exam Header-CS";
//         AcademicsSetupCS: Record "Academics Setup-CS";
//         AttendanceActionCS: Codeunit "Attendance Action-CS";
//         NoSeriesManagement: Codeunit "NoSeriesManagement";
//         NEXTNo: Code[20];
//         Counter: Integer;
//         TotalCount: Integer;
//         PROGRESS: Dialog;

//     begin
//         //Code Add For  Create External Exam Details::CSPL-00059::19022019: Start
//         AcademicsSetupCS.GET();

//         EducationSetupCSCS.Reset();
//         EducationSetupCSCS.SETRANGE("Global Dimension 1 Code", InstituteCode);
//         IF EducationSetupCSCS.Findfirst() THEN BEGIN
//             IF ExamClassification = 'REGULAR' THEN BEGIN
//                 IF EducationSetupCSCS."External Exam Generated" = TRUE THEN
//                     ERROR('Regular External Exam Already Generated !!');
//             END ELSE
//                 IF ExamClassification = 'MAKE-UP' THEN BEGIN
//                     IF EducationSetupCSCS."MakeUp External Exam Generated" = TRUE THEN
//                         ERROR('MakeaUp External Exam Already Generated !!');
//                 END;
//             EducationSetupCSCS.TESTFIELD("Academic Year");
//         END;

//         ExamTimeTableLineCS.Reset();
//         ExamTimeTableLineCS.SETRANGE("Document No.", ScheduleNo);
//         ExamTimeTableLineCS.SETRANGE("Global Dimension 1 Code", EducationSetupCSCS."Global Dimension 1 Code");
//         ExamTimeTableLineCS.SETRANGE("Academic Year", EducationSetupCSCS."Academic Year");
//         IF ExamTimeTableLineCS.FINDSET() THEN BEGIN
//             TotalCount := ExamTimeTableLineCS.count();
//             PROGRESS.OPEN(Text_10001Lbl);
//             REPEAT
//                 Counter := Counter + 1;
//                 PROGRESS.UPDATE(1, Counter);
//                 PROGRESS.UPDATE(2, ROUND(Counter / TotalCount * 10000, 1));

//                 CourseWiseSubjectLineCS.Reset();
//                 CourseWiseSubjectLineCS.SETRANGE("Course Code", EducationSetupCSCS."Course Code");
//                 CourseWiseSubjectLineCS.SETRANGE("Program", 'UG');
//                 IF (ExamClassification = 'SPECIAL') OR (ExamClassification = 'MAKE-UP') OR (ExamClassification = 'WINTER') OR (ExamClassification = 'SUMMER') THEN
//                     CourseWiseSubjectLineCS.SETFILTER(Semester, '%1|%2', 'I', 'II')
//                 ELSE
//                     IF (ExamClassification = 'REGULAR') THEN BEGIN
//                         IF EducationSetupCSCS."Even/Odd Semester" = EducationSetupCSCS."Even/Odd Semester"::FALL THEN
//                             CourseWiseSubjectLineCS.SETFILTER(Semester, '%1', 'II')
//                         ELSE
//                             IF EducationSetupCSCS."Even/Odd Semester" = EducationSetupCSCS."Even/Odd Semester"::SPRING THEN
//                                 CourseWiseSubjectLineCS.SETFILTER(Semester, '%1', 'I');
//                     END;
//                 CourseWiseSubjectLineCS.SETRANGE("Academic Year", ExamTimeTableLineCS."Academic Year");
//                 CourseWiseSubjectLineCS.SETRANGE("Subject Classification", ExamTimeTableLineCS."Subject Class");
//                 CourseWiseSubjectLineCS.SETRANGE("Subject Type", ExamTimeTableLineCS."Subject Type");
//                 CourseWiseSubjectLineCS.SETRANGE("Subject Code", ExamTimeTableLineCS."Subject Code");
//                 CourseWiseSubjectLineCS.SETRANGE("Global Dimension 1 Code", ExamTimeTableLineCS."Global Dimension 1 Code");
//                 IF CourseWiseSubjectLineCS.FINDSET() THEN
//                     REPEAT

//                         NEXTNo := NoSeriesManagement.GetNEXTNo(AcademicsSetupCS."External Marks No.", 0D, TRUE);

//                         ExternalExamHeaderCS.INIT();
//                         ExternalExamHeaderCS."No." := NEXTNo;
//                         ExternalExamHeaderCS."Exam Schedule Code" := ExamTimeTableLineCS."Document No.";
//                         ExternalExamHeaderCS."Exam Classification" := ExamTimeTableLineCS."Exam Classification";
//                         ExternalExamHeaderCS."Student Group" := CourseWiseSubjectLineCS."Student Group";
//                         ExternalExamHeaderCS."Program" := CourseWiseSubjectLineCS."Program";
//                         ExternalExamHeaderCS."Type Of Course" := CourseWiseSubjectLineCS."Type Of Course";
//                         ExternalExamHeaderCS."Academic Year" := CourseWiseSubjectLineCS."Academic Year";
//                         ExternalExamHeaderCS.Semester := CourseWiseSubjectLineCS.Semester;
//                         ExternalExamHeaderCS.Year := CourseWiseSubjectLineCS.Year;
//                         ExternalExamHeaderCS."Document Type" := ExternalExamHeaderCS."Document Type"::External;
//                         ExternalExamHeaderCS."Global Dimension 1 Code" := CourseWiseSubjectLineCS."Global Dimension 1 Code";
//                         ExternalExamHeaderCS."Global Dimension 2 Code" := COPYSTR(CourseWiseSubjectLineCS."Subject Code", 1, 3);
//                         ExternalExamHeaderCS."Subject Class" := CourseWiseSubjectLineCS."Subject Classification";
//                         ExternalExamHeaderCS."Subject Type" := CourseWiseSubjectLineCS."Subject Type";
//                         ExternalExamHeaderCS.VALIDATE("Subject Code", CourseWiseSubjectLineCS."Subject Code");
//                         ExternalExamHeaderCS."Minimum Credit Points Required" := CourseWiseSubjectLineCS.Credit;
//                         ExternalExamHeaderCS."Internal Maximum" := CourseWiseSubjectLineCS."Internal Maximum";
//                         ExternalExamHeaderCS."External Maximum" := CourseWiseSubjectLineCS."External Maximum";
//                         ExternalExamHeaderCS."Total Maximum" := CourseWiseSubjectLineCS."Total Maximum";
//                         ExternalExamHeaderCS.Status := ExternalExamHeaderCS.Status::Open;
//                         ExternalExamHeaderCS."Exam Date" := ExamTimeTableLineCS."Exam Date";
//                         ExternalExamHeaderCS."Created By" := FORMAT(UserId());
//                         ExternalExamHeaderCS."Created On" := TODAY();
//                         ExternalExamHeaderCS.Insert();

//                         IF ExternalExamHeaderCS."Exam Classification" = 'REGULAR' THEN
//                             AttendanceActionCS.StudentsForExternalAttendanceAndSessionalMarks(ExternalExamHeaderCS)
//                         ELSE
//                             IF ExternalExamHeaderCS."Exam Classification" = 'MAKE-UP' THEN
//                                 AttendanceActionCS.GetStudentsForMakeUpExternalAttendanceAndSessionalMarks(ExternalExamHeaderCS)
//                             ELSE
//                                 IF ExternalExamHeaderCS."Exam Classification" = 'SPECIAL' THEN
//                                     AttendanceActionCS.GetStudentsForMakeUpExternalAttendanceAndSessionalMarks(ExternalExamHeaderCS)
//                                 ELSE
//                                     IF ExternalExamHeaderCS."Exam Classification" = 'WINTER' THEN
//                                         AttendanceActionCS.GetStudentsForWinterExternalAttendanceAndSessionaMarks(ExternalExamHeaderCS)
//                                     ELSE
//                                         IF ExternalExamHeaderCS."Exam Classification" = 'SUMMER' THEN
//                                             AttendanceActionCS.GetStudentsForSummerExternalAttendanceAndSessionalMarks(ExternalExamHeaderCS);

//                         CourseWiseSubjectLineCS."External Exam Generated" := TRUE;
//                         CourseWiseSubjectLineCS.Modify();
//                     UNTIL CourseWiseSubjectLineCS.NEXT() = 0;


//                 CourseWiseSubjectLineCS.Reset();
//                 CourseWiseSubjectLineCS.SETRANGE("Program", 'UG');
//                 IF ExamClassification = 'SPECIAL' THEN
//                     CourseWiseSubjectLineCS.SETFILTER(Semester, '%1|%2|%3|%4|%5|%6', 'III', 'IV', 'V', 'VI', 'VII', 'VIII')
//                 ELSE
//                     IF (ExamClassification = 'REGULAR') OR (ExamClassification = 'SUMMER') THEN BEGIN
//                         IF EducationSetupCSCS."Even/Odd Semester" = EducationSetupCSCS."Even/Odd Semester"::FALL THEN
//                             CourseWiseSubjectLineCS.SETFILTER(Semester, '%1|%2|%3', 'IV', 'VI', 'VIII')
//                         ELSE
//                             IF EducationSetupCSCS."Even/Odd Semester" = EducationSetupCSCS."Even/Odd Semester"::SPRING THEN
//                                 CourseWiseSubjectLineCS.SETFILTER(Semester, '%1|%2|%3', 'III', 'V', 'VII');
//                     END ELSE
//                         IF (ExamClassification = 'MAKE-UP') OR (ExamClassification = 'WINTER') THEN BEGIN
//                             IF EducationSetupCSCS."Even/Odd Semester" = EducationSetupCSCS."Even/Odd Semester"::FALL THEN BEGIN
//                                 IF EducationSetupCSCS."Same Session" THEN
//                                     CourseWiseSubjectLineCS.SETFILTER(Semester, '%1|%2|%3', 'IV', 'VI', 'VIII')
//                                 ELSE
//                                     CourseWiseSubjectLineCS.SETFILTER(Semester, '%1|%2|%3', 'III', 'V', 'VII');
//                             END ELSE
//                                 IF EducationSetupCSCS."Even/Odd Semester" = EducationSetupCSCS."Even/Odd Semester"::SPRING THEN BEGIN
//                                     IF EducationSetupCSCS."Same Session" THEN
//                                         CourseWiseSubjectLineCS.SETFILTER(Semester, '%1|%2|%3', 'III', 'V', 'VII')
//                                     ELSE
//                                         CourseWiseSubjectLineCS.SETFILTER(Semester, '%1|%2|%3', 'IV', 'VI', 'VIII');
//                                 END;
//                         END;
//                 CourseWiseSubjectLineCS.SETRANGE("Academic Year", ExamTimeTableLineCS."Academic Year");
//                 CourseWiseSubjectLineCS.SETRANGE("Subject Classification", ExamTimeTableLineCS."Subject Class");
//                 CourseWiseSubjectLineCS.SETRANGE("Subject Type", ExamTimeTableLineCS."Subject Type");
//                 CourseWiseSubjectLineCS.SETRANGE("Subject Code", ExamTimeTableLineCS."Subject Code");
//                 CourseWiseSubjectLineCS.SETRANGE("Global Dimension 1 Code", ExamTimeTableLineCS."Global Dimension 1 Code");
//                 //CourseWiseSubjectLineCS.SETRANGE("External Exam Generated",FALSE);
//                 IF CourseWiseSubjectLineCS.FINDSET() THEN
//                     REPEAT

//                         NEXTNo := NoSeriesManagement.GetNEXTNo(AcademicsSetupCS."External Marks No.", 0D, TRUE);

//                         ExternalExamHeaderCS.INIT();
//                         ExternalExamHeaderCS."No." := NEXTNo;
//                         ExternalExamHeaderCS."Exam Schedule Code" := ExamTimeTableLineCS."Document No.";
//                         ExternalExamHeaderCS."Exam Classification" := ExamTimeTableLineCS."Exam Classification";
//                         ExternalExamHeaderCS."Course Code" := CourseWiseSubjectLineCS."Course Code";
//                         ExternalExamHeaderCS."Course Name" := CourseWiseSubjectLineCS.Description;
//                         ExternalExamHeaderCS."Program" := CourseWiseSubjectLineCS."Program";
//                         ExternalExamHeaderCS."Type Of Course" := CourseWiseSubjectLineCS."Type Of Course";
//                         ExternalExamHeaderCS."Academic Year" := CourseWiseSubjectLineCS."Academic Year";
//                         ExternalExamHeaderCS.Semester := CourseWiseSubjectLineCS.Semester;
//                         ExternalExamHeaderCS.Year := CourseWiseSubjectLineCS.Year;
//                         ExternalExamHeaderCS."Document Type" := ExternalExamHeaderCS."Document Type"::External;
//                         ExternalExamHeaderCS."Global Dimension 1 Code" := CourseWiseSubjectLineCS."Global Dimension 1 Code";
//                         ExternalExamHeaderCS."Global Dimension 2 Code" := COPYSTR(CourseWiseSubjectLineCS."Subject Code", 1, 3);
//                         ExternalExamHeaderCS."Subject Class" := CourseWiseSubjectLineCS."Subject Classification";
//                         ExternalExamHeaderCS."Subject Type" := CourseWiseSubjectLineCS."Subject Type";
//                         ExternalExamHeaderCS.VALIDATE("Subject Code", CourseWiseSubjectLineCS."Subject Code");
//                         //ExternalExamHeaderCS."Staff Code" :=
//                         ExternalExamHeaderCS."Minimum Credit Points Required" := CourseWiseSubjectLineCS.Credit;
//                         ExternalExamHeaderCS."Internal Maximum" := CourseWiseSubjectLineCS."Internal Maximum";
//                         ExternalExamHeaderCS."External Maximum" := CourseWiseSubjectLineCS."External Maximum";
//                         ExternalExamHeaderCS."Total Maximum" := CourseWiseSubjectLineCS."Total Maximum";
//                         ExternalExamHeaderCS.Status := ExternalExamHeaderCS.Status::Open;
//                         ExternalExamHeaderCS."Exam Date" := ExamTimeTableLineCS."Exam Date";
//                         ExternalExamHeaderCS."Created By" := FORMAT(UserId());
//                         ExternalExamHeaderCS."Created On" := TODAY();
//                         ExternalExamHeaderCS.Insert();

//                         IF ExternalExamHeaderCS."Exam Classification" = 'REGULAR' THEN
//                             AttendanceActionCS.StudentsForExternalAttendanceAndSessionalMarks(ExternalExamHeaderCS)
//                         ELSE
//                             IF ExternalExamHeaderCS."Exam Classification" = 'MAKE-UP' THEN
//                                 AttendanceActionCS.GetStudentsForMakeUpExternalAttendanceAndSessionalMarks(ExternalExamHeaderCS)
//                             ELSE
//                                 IF ExternalExamHeaderCS."Exam Classification" = 'SPECIAL' THEN
//                                     AttendanceActionCS.GetStudentsForMakeUpExternalAttendanceAndSessionalMarks(ExternalExamHeaderCS)
//                                 ELSE
//                                     IF ExternalExamHeaderCS."Exam Classification" = 'WINTER' THEN
//                                         AttendanceActionCS.GetStudentsForWinterExternalAttendanceAndSessionaMarks(ExternalExamHeaderCS)
//                                     ELSE
//                                         IF ExternalExamHeaderCS."Exam Classification" = 'SUMMER' THEN
//                                             AttendanceActionCS.GetStudentsForWinterExternalAttendanceAndSessionaMarks(ExternalExamHeaderCS);

//                         CourseWiseSubjectLineCS."External Exam Generated" := TRUE;
//                         CourseWiseSubjectLineCS.Modify();
//                     UNTIL CourseWiseSubjectLineCS.NEXT() = 0;


//                 CourseWiseSubjectLineCS.Reset();
//                 CourseWiseSubjectLineCS.SETRANGE("Program", 'PG');
//                 IF ExamClassification = 'SPECIAL' THEN
//                     CourseWiseSubjectLineCS.SETFILTER(Semester, '%1|%2|%3|%4|%5|%6|%7|%8', 'I', 'II', 'III', 'IV', 'V', 'VI', 'VII', 'VIII')
//                 ELSE
//                     IF (ExamClassification = 'REGULAR') OR (ExamClassification = 'SUMMER') THEN BEGIN
//                         IF EducationSetupCSCS."Even/Odd Semester" = EducationSetupCSCS."Even/Odd Semester"::FALL THEN
//                             CourseWiseSubjectLineCS.SETFILTER(Semester, '%1|%2|%3|%4', 'II', 'IV', 'VI', 'VIII')
//                         ELSE
//                             IF EducationSetupCSCS."Even/Odd Semester" = EducationSetupCSCS."Even/Odd Semester"::SPRING THEN
//                                 CourseWiseSubjectLineCS.SETFILTER(Semester, '%1|%2|%3|%4', 'I', 'III', 'V', 'VII');
//                     END ELSE
//                         IF (ExamClassification = 'MAKE-UP') OR (ExamClassification = 'WINTER') THEN BEGIN
//                             IF EducationSetupCSCS."Even/Odd Semester" = EducationSetupCSCS."Even/Odd Semester"::FALL THEN BEGIN
//                                 IF EducationSetupCSCS."Same Session" THEN
//                                     CourseWiseSubjectLineCS.SETFILTER(Semester, '%1|%2|%3|%4', 'II', 'IV', 'VI', 'VIII')
//                                 ELSE
//                                     CourseWiseSubjectLineCS.SETFILTER(Semester, '%1|%2|%3|%4', 'I', 'III', 'V', 'VII');
//                             END ELSE
//                                 IF EducationSetupCSCS."Even/Odd Semester" = EducationSetupCSCS."Even/Odd Semester"::SPRING THEN BEGIN
//                                     IF EducationSetupCSCS."Same Session" THEN
//                                         CourseWiseSubjectLineCS.SETFILTER(Semester, '%1|%2|%3|%4', 'I', 'III', 'V', 'VII')
//                                     ELSE
//                                         CourseWiseSubjectLineCS.SETFILTER(Semester, '%1|%2|%3|%4', 'II', 'IV', 'VI', 'VIII');
//                                 END;
//                         END;
//                 CourseWiseSubjectLineCS.SETRANGE("Academic Year", ExamTimeTableLineCS."Academic Year");
//                 CourseWiseSubjectLineCS.SETRANGE("Subject Classification", ExamTimeTableLineCS."Subject Class");
//                 CourseWiseSubjectLineCS.SETRANGE("Subject Type", ExamTimeTableLineCS."Subject Type");
//                 CourseWiseSubjectLineCS.SETRANGE("Subject Code", ExamTimeTableLineCS."Subject Code");
//                 CourseWiseSubjectLineCS.SETRANGE("Global Dimension 1 Code", ExamTimeTableLineCS."Global Dimension 1 Code");
//                 //CourseWiseSubjectLineCS.SETRANGE("External Exam Generated",FALSE);
//                 IF CourseWiseSubjectLineCS.FINDSET() THEN
//                     REPEAT

//                         NEXTNo := NoSeriesManagement.GetNEXTNo(AcademicsSetupCS."External Marks No.", 0D, TRUE);

//                         ExternalExamHeaderCS.INIT();
//                         ExternalExamHeaderCS."No." := NEXTNo;
//                         ExternalExamHeaderCS."Exam Schedule Code" := ExamTimeTableLineCS."Document No.";
//                         ExternalExamHeaderCS."Exam Classification" := ExamTimeTableLineCS."Exam Classification";
//                         ExternalExamHeaderCS."Course Code" := CourseWiseSubjectLineCS."Course Code";
//                         ExternalExamHeaderCS."Course Name" := CourseWiseSubjectLineCS.Description;
//                         ExternalExamHeaderCS."Program" := CourseWiseSubjectLineCS."Program";
//                         ExternalExamHeaderCS."Type Of Course" := CourseWiseSubjectLineCS."Type Of Course";
//                         ExternalExamHeaderCS."Academic Year" := CourseWiseSubjectLineCS."Academic Year";
//                         ExternalExamHeaderCS.Semester := CourseWiseSubjectLineCS.Semester;
//                         ExternalExamHeaderCS.Year := CourseWiseSubjectLineCS.Year;
//                         ExternalExamHeaderCS."Document Type" := ExternalExamHeaderCS."Document Type"::External;
//                         ExternalExamHeaderCS."Global Dimension 1 Code" := CourseWiseSubjectLineCS."Global Dimension 1 Code";
//                         ExternalExamHeaderCS."Global Dimension 2 Code" := COPYSTR(CourseWiseSubjectLineCS."Subject Code", 1, 3);
//                         ExternalExamHeaderCS."Subject Class" := CourseWiseSubjectLineCS."Subject Classification";
//                         ExternalExamHeaderCS."Subject Type" := CourseWiseSubjectLineCS."Subject Type";
//                         ExternalExamHeaderCS.VALIDATE("Subject Code", CourseWiseSubjectLineCS."Subject Code");
//                         //ExternalExamHeaderCS."Staff Code" :=
//                         ExternalExamHeaderCS."Minimum Credit Points Required" := CourseWiseSubjectLineCS.Credit;
//                         ExternalExamHeaderCS."Internal Maximum" := CourseWiseSubjectLineCS."Internal Maximum";
//                         ExternalExamHeaderCS."External Maximum" := CourseWiseSubjectLineCS."External Maximum";
//                         ExternalExamHeaderCS."Total Maximum" := CourseWiseSubjectLineCS."Total Maximum";
//                         ExternalExamHeaderCS.Status := ExternalExamHeaderCS.Status::Open;
//                         ExternalExamHeaderCS."Exam Date" := ExamTimeTableLineCS."Exam Date";
//                         ExternalExamHeaderCS."Created By" := FORMAT(UserId());
//                         ExternalExamHeaderCS."Created On" := TODAY();
//                         ExternalExamHeaderCS.Insert();

//                         IF ExternalExamHeaderCS."Exam Classification" = 'REGULAR' THEN
//                             AttendanceActionCS.StudentsForExternalAttendanceAndSessionalMarks(ExternalExamHeaderCS)
//                         ELSE
//                             IF ExternalExamHeaderCS."Exam Classification" = 'MAKE-UP' THEN
//                                 AttendanceActionCS.GetStudentsForMakeUpExternalAttendanceAndSessionalMarks(ExternalExamHeaderCS)
//                             ELSE
//                                 IF ExternalExamHeaderCS."Exam Classification" = 'SPECIAL' THEN
//                                     AttendanceActionCS.GetStudentsForMakeUpExternalAttendanceAndSessionalMarks(ExternalExamHeaderCS)
//                                 ELSE
//                                     IF ExternalExamHeaderCS."Exam Classification" = 'WINTER' THEN
//                                         AttendanceActionCS.GetStudentsForWinterExternalAttendanceAndSessionaMarks(ExternalExamHeaderCS)
//                                     ELSE
//                                         IF ExternalExamHeaderCS."Exam Classification" = 'SUMMER' THEN
//                                             AttendanceActionCS.GetStudentsForWinterExternalAttendanceAndSessionaMarks(ExternalExamHeaderCS);

//                         CourseWiseSubjectLineCS."External Exam Generated" := TRUE;
//                         CourseWiseSubjectLineCS.Modify();
//                     UNTIL CourseWiseSubjectLineCS.NEXT() = 0;

//                 EducationSetupCSCS.Reset();
//                 EducationSetupCSCS.SETRANGE("Global Dimension 1 Code", InstituteCode);
//                 IF EducationSetupCSCS.Findfirst() THEN BEGIN
//                     IF ExamClassification = 'REGULAR' THEN
//                         EducationSetupCSCS."External Exam Generated" := TRUE
//                     ELSE
//                         IF ExamClassification = 'MAKE-UP' THEN
//                             EducationSetupCSCS."MakeUp External Exam Generated" := TRUE;
//                 END;

//             UNTIL ExamTimeTableLineCS.NEXT() = 0;
//         END;
//         PROGRESS.Close();
//         MESSAGE('External Exam Details Generated !!');
//         //Code Add For  Create External Exam Details::CSPL-00059::19022019: End
//     end;


//     [EventSubscriber(ObjectType::Table, 50288, 'OnAfterInsertEvent', '', false, false)]
//     local procedure ScheduleHdrInsert(var Rec: Record "Exam Time Table Head-CS"; RunTrigger: Boolean)
//     begin
//         Rec."Created By" := userid();
//         Rec."Created On" := Today();
//     end;

//     [EventSubscriber(ObjectType::Table, 50288, 'OnAfterModifyEvent', '', false, false)]
//     local procedure ScheduleHdrModify(var Rec: Record "Exam Time Table Head-CS"; var xRec: Record "Exam Time Table Head-CS"; RunTrigger: Boolean)
//     begin
//         Rec."Updated By" := userid();
//         Rec."Updated On" := Today();
//     end;

//     [EventSubscriber(ObjectType::Table, 50289, 'OnAfterInsertEvent', '', false, false)]
//     local procedure ScheduleLnInsert(var Rec: Record "Exam Time Table Line-CS"; RunTrigger: Boolean)
//     begin
//         Rec."Created By" := userid();
//         Rec."Created On" := Today();
//     end;

//     [EventSubscriber(ObjectType::Table, 50289, 'OnAfterModifyEvent', '', false, false)]
//     local procedure ScheduleLnModify(var Rec: Record "Exam Time Table Line-CS"; var xRec: Record "Exam Time Table Line-CS"; RunTrigger: Boolean)
//     begin
//         Rec."Updated By" := userid();
//         Rec."Updated On" := Today();
//     end;

//     [EventSubscriber(ObjectType::Table, 50154, 'OnAfterInsertEvent', '', false, false)]
//     local procedure ExtExamLnInsert(var Rec: Record "External Exam Line-CS"; RunTrigger: Boolean)
//     begin
//         Rec."Created By" := userid();
//         Rec."Created On" := Today();
//     end;

//     [EventSubscriber(ObjectType::Table, 50154, 'OnAfterModifyEvent', '', false, false)]
//     local procedure ExtEamLnModify(var Rec: Record "External Exam Line-CS"; var xRec: Record "External Exam Line-CS"; RunTrigger: Boolean)
//     begin
//         Rec."Updated By" := userid();
//         Rec."Updated On" := Today();
//     end;

//     [EventSubscriber(ObjectType::Table, 50209, 'OnAfterInsertEvent', '', false, false)]
//     local procedure ExtExamHdrInsert(var Rec: Record "External Exam Header-CS"; RunTrigger: Boolean)
//     begin
//         Rec."Created By" := userid();
//         Rec."Created On" := Today();
//     end;

//     [EventSubscriber(ObjectType::Table, 50209, 'OnAfterModifyEvent', '', false, false)]
//     local procedure ExtEamHdrModify(var Rec: Record "External Exam Header-CS"; var xRec: Record "External Exam Header-CS"; RunTrigger: Boolean)
//     begin
//         Rec."Updated By" := userid();
//         Rec."Updated On" := Today();
//     end;

//     [EventSubscriber(ObjectType::Table, 50372, 'OnAfterInsertEvent', '', false, false)]
//     local procedure GradeBookInsert(var Rec: Record "Grade Book"; RunTrigger: Boolean)
//     begin
//         Rec."Created By" := userid();
//         Rec."Created On" := Today();
//     end;

//     [EventSubscriber(ObjectType::Table, 50372, 'OnAfterModifyEvent', '', false, false)]
//     local procedure GradeBookModify(var Rec: Record "Grade Book"; var xRec: Record "Grade Book"; RunTrigger: Boolean)
//     begin
//         Rec."Updated By" := userid();
//         Rec."Updated On" := Today();
//     end;

//     [EventSubscriber(ObjectType::Table, 50425, 'OnAfterInsertEvent', '', false, false)]
//     local procedure GradeBookHdrInsert(var Rec: Record "Grade Book Header"; RunTrigger: Boolean)
//     begin
//         Rec."Created By" := userid();
//         Rec."Created On" := Today();
//     end;

//     [EventSubscriber(ObjectType::Table, 50425, 'OnAfterModifyEvent', '', false, false)]
//     local procedure GradeBookHdrModify(var Rec: Record "Grade Book Header"; var xRec: Record "Grade Book Header"; RunTrigger: Boolean)
//     begin
//         Rec."Updated By" := userid();
//         Rec."Updated On" := Today();
//     end;

//     [EventSubscriber(ObjectType::Table, 50498, 'OnAfterInsertEvent', '', false, false)]
//     local procedure StudExamInsert(var Rec: Record "Student Subject Exam"; RunTrigger: Boolean)
//     begin
//         Rec."User ID" := userid();
//         Rec."Creation Date" := Today();
//     end;

//     [EventSubscriber(ObjectType::Table, 50498, 'OnAfterModifyEvent', '', false, false)]
//     local procedure StudExamModify(var Rec: Record "Student Subject Exam"; var xRec: Record "Student Subject Exam"; RunTrigger: Boolean)
//     begin
//         Rec."Modified By" := userid();
//         Rec."Modification Date" := Today();
//     end;

//     [EventSubscriber(ObjectType::Table, 50156, 'OnAfterInsertEvent', '', false, false)]
//     local procedure IntExamHdrInsert(var Rec: Record "Internal Exam Header-CS"; RunTrigger: Boolean)
//     begin
//         Rec."Created By" := userid();
//         Rec."Created On" := Today();
//     end;

//     [EventSubscriber(ObjectType::Table, 50156, 'OnAfterModifyEvent', '', false, false)]
//     local procedure IntEamHdrModify(var Rec: Record "Internal Exam Header-CS"; var xRec: Record "Internal Exam Header-CS"; RunTrigger: Boolean)
//     begin
//         Rec."Modified By" := userid();
//         Rec."Modified On" := Today();
//     end;

//     [EventSubscriber(ObjectType::Table, 50153, 'OnAfterInsertEvent', '', false, false)]
//     local procedure IntExamLnInsert(var Rec: Record "Internal Exam Line-CS"; RunTrigger: Boolean)
//     begin
//         Rec."Created By" := userid();
//         Rec."Created On" := Today();
//     end;

//     [EventSubscriber(ObjectType::Table, 50153, 'OnAfterModifyEvent', '', false, false)]
//     local procedure IntEamLnModify(var Rec: Record "Internal Exam Line-CS"; var xRec: Record "Internal Exam Line-CS"; RunTrigger: Boolean)
//     begin
//         Rec."Modified By" := userid();
//         Rec."Modified On" := Today();
//     end;


// }
