page 50580 "Deferred/Declined Buffer List"
{

    PageType = API;
    SourceTable = "Deferred/Declined Buffer";
    Caption = 'Deferred/Declined List';
    EntityName = 'dD';
    EntitySetName = 'dD';
    DelayedInsert = true;
    ApplicationArea = All;
    UsageCategory = Administration;
    APIPublisher = 'dD01';
    APIGroup = 'dD';

    layout
    {
        area(content)
        {
            repeater(GroupName)
            {
                field(digitsStudentID; Rec."18 Digits Student ID")
                {
                    ApplicationArea = All;
                }
                field(studentNo; Rec."Student No.")
                {
                    ApplicationArea = All;
                }
                field(statUs; Rec.Status)
                {
                    ApplicationArea = All;
                }

                field(academicYear; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field(newteRm; Rec."New Term")
                {
                    ApplicationArea = All;
                }
                field(newAcademicYear; Rec."New Academic Year")
                {
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                Field(NewCourseCode; Rec."New Course Code")
                {
                    ApplicationArea = All;
                }
                Field(enrollmentNo; Rec."Enrolment No.")
                {
                    ApplicationArea = All;
                }
                Field(teRm; Rec.Term)
                {
                    ApplicationArea = All;
                }
                field(seM; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                field(suCCesS; Rec.Success)
                {
                    ApplicationArea = All;
                }

            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        RecStudentMaster: Record "Student Master-CS";
        StudentStatus: Record "Student Status";
        StudentStatus2: Record "Student Status";
        DefDecBuffer: Record "Deferred/Declined Buffer";
        Stud: Record "Student Master-CS";
        SemesterMaster_lRec: Record "Semester Master-CS";
        BulkHoldUpload_lCU: Codeunit "Hold Bulk Upload";
    begin
        Rec.TestField("Student No.");
        Rec.TestField(Type);
        Stud.Get(Rec."Student No.");


        IF Rec.Type = Rec.Type::"Def-Dec" then Begin
            StudentStatus.Reset();
            StudentStatus.SetRange(Status, Rec.Status);
            IF StudentStatus.FindFirst() then begin

                DefDecBuffer.Reset();
                DefDecBuffer.SetRange("Student No.", Rec."Student No.");
                if DefDecBuffer.FindLast() then
                    Rec."Line No." := DefDecBuffer."Line No." + 10000
                else
                    Rec."Line No." := 10000;
                Rec."Entry Date" := Today();
                Rec."Entry Time" := Time();
                Rec."Entry From Salesforce" := true;


                RecStudentMaster.Reset();
                RecStudentMaster.SetRange("No.", Rec."Student No.");
                IF RecStudentMaster.FindFirst() then begin
                    if StudentStatus.Status IN [StudentStatus.Status::Deferred, StudentStatus.Status::Declined] then begin
                        if StudentStatus.Status = StudentStatus.Status::Deferred then begin
                            Rec.TestField("New Academic Year");
                            if Rec."New Term" = Rec."New Term"::" " then
                                Error('New Term cannot be blank');
                            StudentStatus2.Reset();
                            StudentStatus2.Get(RecStudentMaster.Status, RecStudentMaster."Global Dimension 1 Code");
                            if StudentStatus2.Status IN [StudentStatus2.Status::Declined, StudentStatus2.Status::Deposited, StudentStatus2.Status::Deferred] then
                                RecStudentMaster.Validate(Status, StudentStatus.Code)
                            else
                                Error('Student current status must be "Declined", "Deposited" or "Deferred"');

                            RecStudentMaster.Validate(Term, Rec."New Term");
                            RecStudentMaster.Validate("Academic Year", Rec."New Academic Year");
                            RecStudentMaster.Validate("Admitted Year", Rec."New Academic Year");
                            RecStudentMaster.Validate("New Term", Rec."New Term");
                            RecStudentMaster.Validate("New Academic Year", Rec."New Academic Year");
                            //CSPL-00307
                            IF RecStudentMaster.Status = 'DCL' then begin
                                RecStudentMaster."OLR Completed" := false;
                                RecStudentMaster."OLR Completed Date" := 0D;
                                If RecStudentMaster."Student Group" = RecStudentMaster."Student Group"::"On-Ground Check-In" then
                                    BulkHoldUpload_lCU.OnGroundCheckInStudentGroupDisable(RecStudentMaster."No.");
                                IF RecStudentMaster."Student Group" = RecStudentMaster."Student Group"::"On-Ground Check-In Completed" then
                                    BulkHoldUpload_lCU.OnGroundCheckInCompletedGroupDisable(RecStudentMaster."No.");
                                RecStudentMaster."Student Group" := Stud."Student Group"::" ";
                                RecStudentMaster."On Ground Check-In By" := '';
                                RecStudentMaster."On Ground Check-In On" := 0D;
                                RecStudentMaster."On Ground Check-In Complete By" := '';
                                RecStudentMaster."On Ground Check-In Complete On" := 0D;
                                RecStudentMaster."OLR Email Sent" := false;
                                RecStudentMaster."OLR Email Sent Date" := 0D;
                            end;
                            //CSPL-00307
                            RecStudentMaster.Modify(true);
                        end
                        else
                            if StudentStatus.Status = StudentStatus.Status::Declined then begin
                                if Rec."New Term" <> Rec."New Term"::" " then
                                    Error('New Term must be blank');
                                StudentStatus2.Reset();
                                StudentStatus2.Get(RecStudentMaster.Status, RecStudentMaster."Global Dimension 1 Code");
                                if StudentStatus2.Status IN [StudentStatus2.Status::Deferred, StudentStatus2.Status::Deposited] then
                                    RecStudentMaster.Validate(Status, StudentStatus.Code)
                                else
                                    Error('Student current status must be "Deferred" or "Deposited".');
                                RecStudentMaster.Modify(true);
                            end;
                    end
                    else
                        Error('Status is not valid for this process, it must be "Declined" or "Deferred"');
                end;
                Rec.Success := true;
            end;
        end;
        IF Rec.Type = Rec.Type::"Course Change" then begin
            Rec.TestField("New Course Code");
            //Stud.TestField("Returning Student", false);
            IF Stud."Student Group" = Stud."Student Group"::"On-Ground Check-In Completed" then
                Error('On Ground Check in Completed for the Student : %1', Rec."Student No.");

            DefDecBuffer.Reset();
            DefDecBuffer.SetRange("Student No.", Rec."Student No.");
            if DefDecBuffer.FindLast() then
                Rec."Line No." := DefDecBuffer."Line No." + 10000
            else
                Rec."Line No." := 10000;
            Rec."Entry Date" := Today();
            Rec."Entry Time" := Time();
            Rec."Entry From Salesforce" := true;

            BulkHoldUpload_lCU.StudentCourseChange(Rec."Student No.", Rec."New Course Code", Stud);
            Rec.Success := true;
        end;
        If Rec.Type = Rec.Type::Readmits then begin
            Rec.TestField("Enrolment No.");
            Rec.TestField(Status);
            Rec.TestField("18 Digits Student ID");
            Rec.TestField("Academic Year");
            IF Stud."Student Group" = Stud."Student Group"::"On-Ground Check-In Completed" then
                Error('On Ground Check in Completed for the Student : %1', Rec."Student No.");

            SemesterMaster_lRec.Reset();
            SemesterMaster_lRec.SetRange(Code, Rec.Semester);
            If SemesterMaster_lRec.FindFirst() then
                IF SemesterMaster_lRec.Sequence > 5 then
                    Error('Semester Sequence must be less then or equal to 5 for semester : %1', Rec.Semester);

            DefDecBuffer.Reset();
            DefDecBuffer.SetRange("Student No.", Rec."Student No.");
            if DefDecBuffer.FindLast() then
                Rec."Line No." := DefDecBuffer."Line No." + 10000
            else
                Rec."Line No." := 10000;
            Rec."Entry Date" := Today();
            Rec."Entry Time" := Time();
            Rec."Entry From Salesforce" := true;

            Rec.Status := Rec.Status::"Re-Admitted";
            BulkHoldUpload_lCU.StudentReadmitProcess(Rec."Student No.", Rec."Enrolment No.", Rec.Status, Rec."18 Digits Student ID", Rec."New Course Code", Rec.Semester, Rec."Academic Year", Rec.Term, Stud);
            Rec.Success := True;


        end;
    end;
}