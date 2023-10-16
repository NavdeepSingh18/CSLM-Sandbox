page 50841 "Defrd/Declined Bfr List Part"
{
    PageType = ListPart;
    SourceTable = "Deferred/Declined Buffer";
    Caption = 'Student Status Deferred/Declined Buffer List Part';
    Editable = false;
    ModifyAllowed = false;
    SourceTableView = sorting("Student No.");
    UsageCategory = None;

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
                field("Enrolment No."; Rec."Enrolment No.")
                {
                    ApplicationArea = all;
                }
                field(status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field(Term; Rec.Term)
                {
                    ApplicationArea = all;
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
            }
        }
    }
    /*
        trigger OnInsertRecord(BelowxRec: Boolean): Boolean
        var
            RecStudentMaster: Record "Student Master-CS";
            StudentStatus: Record "Student Status";
            StudentStatus2: Record "Student Status";
            DefDecBuffer: Record "Deferred/Declined Buffer";
            Stud: Record "Student Master-CS";
        begin
            TestField("Student No.");

            Stud.Get("Student No.");
            StudentStatus.Reset();
            StudentStatus.Get(Status, Stud."Global Dimension 1 Code");

            DefDecBuffer.Reset();
            DefDecBuffer.SetRange("Student No.", "Student No.");
            if DefDecBuffer.FindLast() then
                "Line No." := DefDecBuffer."Line No." + 10000
            else
                "Line No." := 10000;
            "Entry Date" := Today();
            "Entry Time" := Time();



            RecStudentMaster.Reset();
            RecStudentMaster.SetRange("No.", "Student No.");
            IF RecStudentMaster.FindFirst() then begin
                if StudentStatus.Status IN [StudentStatus.Status::Deferred, StudentStatus.Status::Declined] then begin
                    if StudentStatus.Status = StudentStatus.Status::Deferred then begin
                        TestField("New Academic Year");
                        if Rec."New Term" = Rec."New Term"::" " then
                            Error('New Term cannot be blank');
                        StudentStatus2.Reset();
                        StudentStatus2.Get(RecStudentMaster.Status, RecStudentMaster."Global Dimension 1 Code");
                        if StudentStatus2.Status IN [StudentStatus2.Status::Declined, StudentStatus2.Status::Deposited] then
                            RecStudentMaster.Validate(Status, Status)
                        else
                            Error('Student current status must be "Declined" or "Deposited".');


                        RecStudentMaster.Validate("New Term", "New Term");
                        RecStudentMaster.Validate("New Academic Year", "New Academic Year");
                        RecStudentMaster.Modify(true);
                    end
                    else
                        if StudentStatus.Status = StudentStatus.Status::Declined then begin
                            if Rec."New Term" <> Rec."New Term"::" " then
                                Error('New Term must be blank');
                            StudentStatus2.Reset();
                            StudentStatus2.Get(RecStudentMaster.Status, RecStudentMaster."Global Dimension 1 Code");
                            if StudentStatus2.Status IN [StudentStatus2.Status::Deferred, StudentStatus2.Status::Deposited] then
                                RecStudentMaster.Validate(Status, Status)
                            else
                                Error('Student current status must be "Deferred" or "Deposited".');
                            RecStudentMaster.Modify(true);
                        end;

                end
                else
                    Error('Status is not valid for this process, it must be "Declined" or "Deferred"');
            end;

        end;*/
}