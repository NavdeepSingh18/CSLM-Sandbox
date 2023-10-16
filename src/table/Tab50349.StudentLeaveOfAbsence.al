table 50349 "Student Leave of Absence"
{
    DataClassification = CustomerContent;
    DataCaptionFields = "Application No.", "Student Name";

    fields
    {
        field(1; "Application No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(2; "Application Date"; Date)
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                if "Start Date" <> 0D then
                    Error('Start Date must be blank.');
            end;
        }
        field(10; "Student No."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Student Master-CS";
            trigger OnValidate()
            var
                StudentMaster_lRec: Record "Student Master-CS";

                Semester_lRec: Record "Semester Master-CS";
            begin
                IF "Student No." <> '' then begin
                    LOA_lRec.Reset();
                    LOA_lRec.SetRange("Student No.", "Student No.");
                    LOA_lRec.SetRange(Semester, Semester);
                    LOA_lRec.SetRange("Academic Year", "Academic Year");
                    LOA_lRec.SetRange(Term, Term);
                    LOA_lRec.Setfilter(Status, '<>%1', Status::Cancelled);
                    LOA_lRec.Setfilter("Leave Types", '<>%1', "Leave Types"::SLOA);
                    IF LOA_lRec.FindFirst() then
                        Error('Student Already Exist');


                    IF StudentMaster_lRec.GET("Student No.") THEN BEGIN
                        StudentStatusRec.Reset();
                        StudentStatusRec.SetRange(code, StudentMaster_lRec.Status);
                        StudentStatusRec.SetRange("Global Dimension 1 Code", StudentMaster_lRec."Global Dimension 1 Code");
                        if StudentStatusRec.findfirst() then begin
                            if (StudentStatusRec.status = StudentStatusRec.status::TWD) or (StudentStatusRec.status = StudentStatusRec.status::Active) or (StudentStatusRec.status = StudentStatusRec.status::Probation) then begin
                                IF "Leave Types" = "Leave Types"::ELOA then begin
                                    Semester_lRec.Reset();
                                    Semester_lRec.SetRange(Code, StudentMaster_lRec.Semester);
                                    IF Semester_lRec.Sequence > 4 then
                                        ERROR('Do not Allow for apply leave Type %1', Format("Leave Types"));
                                end;

                                IF "Leave Types" = "Leave Types"::ELOA then begin
                                    LOA_lRec.Reset();
                                    LOA_lRec.SetRange("Student No.", Rec."Student No.");
                                    LOA_lRec.SetRange("Academic Year", Rec."Academic Year");
                                    LOA_lRec.SetRange(Term, Term);
                                    //LOA_lRec.SetRange(Semester, Rec.Semester);
                                    IF LOA_lRec.FindFirst() then
                                        Error('Already applied for ELOA');
                                end;

                                IF (StudentStatusRec.Status = StudentStatusRec.Status::TWD) and ("Leave Types" = "Leave Types"::CLOA) then
                                    Error('Student status must be either Active or Probation');

                                "Student Name" := StudentMaster_lRec."Student Name";
                                "Enrolment No." := StudentMaster_lRec."Enrollment No.";
                                Semester := StudentMaster_lRec.Semester;
                                "Academic Year" := StudentMaster_lRec."Academic Year";
                                Term := StudentMaster_lRec.Term;
                                "Global Dimension 1 Code" := StudentMaster_lRec."Global Dimension 1 Code";
                                "Global Dimension 2 Code" := StudentMaster_lRec."Global Dimension 2 Code";

                                RecClassAttendanceLine.Reset();
                                RecClassAttendanceLine.SetRange("Student No.", "Student No.");
                                RecClassAttendanceLine.SetRange(Semester, StudentMaster_lRec.Semester);
                                RecClassAttendanceLine.SetRange("Academic Year", StudentMaster_lRec."Academic Year");
                                RecClassAttendanceLine.SetRange("Attendance Type", RecClassAttendanceLine."Attendance Type"::Present);
                                IF recClassAttendanceLine.FindLast() then
                                    "Last Date Of Attendance" := recClassAttendanceLine.Date;

                            end else
                                Error('Please check the student status it must be Active or Probation.');
                        end else
                            Error('Please check the student details.');
                    end;
                end else begin
                    "Student Name" := '';
                    "Enrolment No." := '';
                    Semester := '';
                    "Academic Year" := '';
                    "Global Dimension 1 Code" := '';
                    "Global Dimension 2 Code" := '';
                    "Start Date" := 0D;
                    "End Date" := 0D;
                    Reason := '';
                    "Reason Description" := '';
                end;
            end;

        }
        field(11; "Student Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Editable = False;
        }
        field(12; "Enrolment No."; Code[20])
        {
            DataClassification = CustomerContent;
            Editable = False;
        }
        field(13; "Academic Year"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS".Code;
            Editable = False;
        }
        field(14; "Semester"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "Semester Master-CS".Code;
            Editable = False;
        }
        field(15; "Leave Type"; Code[20])
        {
            DataClassification = CustomerContent;

        }

        field(16; "Start Date"; Date)
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                DateRec: Record Date;
                Text50000Lbl: Label 'Start Date must be greater or equal to %1', Comment = '%1 = Application Date';
            begin
                // "End Date" := 0D;
                If "Start Date" <> 0D then begin

                    if "Application Date" = 0D then
                        Error('Application Date must have value in it.');

                    LOA_lRec.Reset();
                    LOA_lRec.SetFilter("Application No.", '<>%1', "Application No.");
                    LOA_lRec.SetRange("Student No.", "Student No.");
                    LOA_lRec.SetRange(Semester, Semester);
                    LOA_lRec.SetRange("Academic Year", "Academic Year");
                    LOA_lRec.SetRange(Term, Term);
                    LOA_lRec.Setfilter(Status, '<>%1', Status::Cancelled);
                    LOA_lRec.Setfilter("Leave Types", '%1', "Leave Types"::SLOA);
                    LOA_lRec.SetFilter("Start Date", '<=%1', "End Date");
                    LOA_lRec.SetFilter("End Date", '>=%1', "End Date");
                    IF LOA_lRec.FindFirst() then
                        Error('Student is already applied for same dates or within the dates.');

                    If "Start Date" < "Application Date" then
                        Error(Text50000Lbl, "Application Date");



                    // RecEducationCalendarCS.Reset();
                    // RecEducationCalendarCS.SetRange("Academic Year", "Academic Year");
                    // If RecEducationCalendarCS.FindFirst() then
                    //     IF "Start Date" < RecEducationCalendarCS."Start Date" then
                    //         Error(Text1001Lbl);
                end;
                IF "End Date" <> 0D Then
                    IF "Start Date" >= "End Date" then
                        Error(Text0001Lbl);

                If "Leave Types" = "Leave Types"::CLOA then begin
                    RotationSchedulewithinPeriod(Rec);

                end;

            end;
        }
        field(17; "End Date"; Date)
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                LOA_lRec: Record "Student Leave of Absence";
                RecEducationCalendarCS: Record "Education Calendar-CS";
                CourseSemesterRec: Record "Course Sem. Master-CS";
                StudentMasterRec: Record "Student Master-CS";
                DateRec: Record Date;
                DaysCount_lInt: Integer;
                DayCount: Integer;
                Text50000Lbl: Label 'End Date must be greater than  %1', Comment = '%1 = Start Date';
                Text50001Lbl: Label 'Applied leaves must be equal or less than 180 Days';
                Text50002Lbl: Label 'Applied leaves must be equal or less than 5 Days';
                Text1001Lbl: Label 'End Date must not be greater than Academic Year "End Date" in Education Calendar';
                Text50004Lbl: Label 'Applied leaves must be equal or greater than 28 Days';
            begin
                // DaysCount_lInt := 0;
                // IF "End Date" <> 0D then begin
                //     LOA_lRec.Reset();
                //     LOA_lRec.SetFilter("Application No.", '<>%1', "Application No.");
                //     LOA_lRec.SetRange("Student No.", "Student No.");
                //     LOA_lRec.SetRange(Semester, Semester);
                //     LOA_lRec.SetRange("Academic Year", "Academic Year");
                //     LOA_lRec.SetRange(Term, Term);
                //     LOA_lRec.Setfilter(Status, '<>%1', Status::Cancelled);
                //     LOA_lRec.Setfilter("Leave Types", '%1', "Leave Types"::SLOA);
                //     LOA_lRec.SetFilter("Start Date", '>=%1', "Start Date");
                //     LOA_lRec.SetFilter("End Date", '<=%1', "End Date");
                //     IF LOA_lRec.FindFirst() then
                //         Error('Student is already applied for same dates or within the dates.');

                //     IF "Start Date" > "End Date" then
                //         Error(Text50000Lbl, "End Date");

                //     IF "Leave Types" = "Leave Types"::ELOA then
                //         IF ("End Date" - "Start Date" + 1) > 180 then
                //             Error(Text50001Lbl);

                //     If "Leave Types" = "Leave Types"::SLOA then begin
                //         DayCount := 0;
                //         DateRec.Reset();
                //         DateRec.SetCurrentKey("Period Type", "Period Start");
                //         DateRec.Ascending(false);
                //         DateRec.SetRange("Period Type", DateRec."Period Type"::Date);
                //         DateRec.SetFilter("Period Start", '%1..%2', "Start Date", "End Date");
                //         if DateRec.FindSet() then
                //             repeat
                //                 if (DateRec."Period Name" in ['Saturday', 'Sunday']) then
                //                     DayCount := DayCount + 1;
                //             until DateRec.Next() = 0;
                //         IF (("End Date" - "Start Date") - DayCount + 1) > 5 then
                //             Error(Text50002Lbl)
                //         else
                //             "No. of Days" := (("End Date" - "Start Date") - DayCount + 1);
                //     end;


                //     IF "Leave Types" = "Leave Types"::CLOA then begin

                //         If ("End Date" - "Start Date" + 1) < 28 then
                //             Error(Text50004Lbl)
                //         ELSE
                //             If ("End Date" - "Start Date" + 1) >= 180 then begin
                //                 DaysCount_lInt := "End Date" - "Start Date" + 1;
                //                 IF DaysCount_lInt >= 180 then
                //                     Error(Text50001Lbl);
                //                 LOA_lRec.Reset();
                //                 LOA_lRec.SetRange("Student No.", Rec."Student No.");
                //                 LOA_lRec.SetRange("Academic Year", Rec."Academic Year");
                //                 LOA_lRec.SetRange("Leave Types", LOA_lRec."Leave Types"::CLOA);
                //                 IF LOA_lRec.FindFirst() then begin
                //                     DaysCount_lInt += (LOA_lRec."End Date" - LOA_lRec."Start Date" + 1);
                //                     If DaysCount_lInt >= 180 then
                //                         Error(Text50001Lbl);
                //                 end;
                //             end;
                //         RotationSchedulewithinPeriodEnddate(Rec);
                //         RotationScheduleAfterPeriod(Rec);
                //     end;

                //     // StudentMasterRec.RESET();
                //     // StudentMasterRec.Get(Rec."Student No.");

                //     // IF "Leave Types" <> "Leave Types"::CLOA then begin
                //     //     CourseSemesterRec.Reset();
                //     //     CourseSemesterRec.SetRange("Academic Year", StudentMasterRec."Academic Year");
                //     //     CourseSemesterRec.SetRange("Course Code", StudentMasterRec."Course Code");
                //     //     CourseSemesterRec.SetRange("Semester Code", StudentMasterRec.Semester);
                //     //     CourseSemesterRec.SetRange(Term, StudentMasterRec.Term);
                //     //     IF CourseSemesterRec.FindFirst() then
                //     //         IF CourseSemesterRec."End Date" < Rec."End Date" then
                //     //             Error(Text1001Lbl);
                //     // end;
                // end;
                // if "Leave Types" <> "Leave Types"::SLOA then
                //     "No. of Days" := ("End Date" - "Start Date" + 1);

                If "End Date" <> 0D then
                    "No. of Days" := ("End Date" - "Start Date" + 1);

            end;

        }
        field(18; "Reason"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "Reason Code".Code where(Type = filter(Leave));
            trigger OnValidate()
            var
                ReasonCode_lRec: Record "Reason Code";
                StudentMaster: Record "Student Master-CS";
            begin
                IF Reason <> '' then
                    If ReasonCode_lRec.Get(Reason) then
                        IF ReasonCode_lRec.Type = ReasonCode_lRec.Type::Leave then
                            Validate("Reason Description", ReasonCode_lRec.Description)
                        ELSE
                            "Reason Description" := '';

                StudentMaster.Reset();
                StudentMaster.SetRange("No.", "Student No.");
                if StudentMaster.FindFirst() then begin
                    StudentMaster.Reason := "Reason";
                    StudentMaster.Modify();
                end;

            end;
        }
        field(19; "Remarks"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(20; "Status"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = Open,"Pending for Approval",Approved,Cancelled,Rejected;
            Editable = false;
        }
        field(21; "Approved By"; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(22; "Approved On"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(23; "Global Dimension 1 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            Editable = False;
        }
        field(24; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            Description = 'CS Field Added 05-05-2019';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            Editable = False;
        }
        field(25; "Library Department"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = Open,"Pending for Approval",Approved,Rejected;
            trigger OnValidate()
            Var
                RecUserSetup: Record "User Setup";
            begin
                If RecUserSetup.Get(UserId()) then
                    IF StrPos(RecUserSetup."ELOA Approver", 'LIBRARY') > 0 THEN begin
                        IF "Library Department" = "Library Department"::Open THEN
                            ERROR('Status must be "Pending for Approval" or Approved or Rejected');
                        If (xRec."Library Department" = xRec."Library Department"::Rejected) and ("Library Department" = "Library Department"::"Pending for Approval") then
                            Error('Status must be Approved or Rejected');
                        IF (xRec."Library Department" = xRec."Library Department"::Approved) and
                            ("Library Department" IN ["Library Department"::"Pending for Approval", "Library Department"::Rejected, "Library Department"::Open]) then
                            Error('Department status can not be changed');
                        // IF "Library Department" = "Library Department"::Rejected then
                        // RejectMail(Rec);
                    end else
                        Error('you do not have permission to change the department status');

            end;
        }
        field(26; "Bursar Department"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = Open,"Pending for Approval",Approved,Rejected;
            trigger OnValidate()
            Var
                RecUserSetup: Record "User Setup";
            begin
                If RecUserSetup.Get(UserId()) then
                    IF StrPos(RecUserSetup."ELOA Approver", 'BURSAR DEPARTMENT') > 0 then begin
                        IF "Bursar Department" = "Bursar Department"::Open THEN
                            ERROR('Status must be "Pending for Approval" or Approved or Rejected');

                        If (xRec."Bursar Department" = xRec."Bursar Department"::Rejected) and ("Bursar Department" = "Bursar Department"::"Pending for Approval") then
                            Error('Status must be Approved or Rejected');
                        IF (xRec."Bursar Department" = xRec."Bursar Department"::Approved) and
                        ("Bursar Department" IN ["Bursar Department"::"Pending for Approval", "Bursar Department"::Rejected, "Bursar Department"::Open]) then
                            Error('Department status can not be changed');

                        // if "Bursar Department" = "Bursar Department"::Rejected then
                        // RejectMail(Rec);


                    end else
                        Error('you do not have permission to change the department status');

            end;
        }
        field(27; "Financial Aid Department"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = Open,"Pending for Approval",Approved,Rejected;
            trigger OnValidate()
            Var
                RecUserSetup: Record "User Setup";
            begin
                If RecUserSetup.Get(UserId()) then
                    If StrPos(RecUserSetup."ELOA Approver", 'FINANCE') > 0 then begin
                        IF "Financial Aid Department" = "Financial Aid Department"::Open THEN
                            ERROR('Status must be "Pending for Approval" or Approved or Rejected');

                        If (xRec."Financial Aid Department" = xRec."Financial Aid Department"::Rejected) and ("Financial Aid Department" = "Financial Aid Department"::"Pending for Approval") then
                            Error('Status must be Approved or Rejected');
                        IF (xRec."Financial Aid Department" = xRec."Financial Aid Department"::Approved) and
                        ("Financial Aid Department" IN ["Financial Aid Department"::"Pending for Approval", "Financial Aid Department"::Rejected, "Financial Aid Department"::Open]) then
                            Error('Department status can not be changed');

                        // if "Financial Aid Department" = "Financial Aid Department"::Rejected then
                        // RejectMail(Rec);

                    end else
                        Error('you do not have permission to change the department status');

            end;
        }
        field(28; "EED Basic Science Department"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'EED Pre-Clinical Department';
            OptionMembers = Open,"Pending for Approval",Approved,Rejected;
            trigger OnValidate()
            Var
                RecUserSetup: Record "User Setup";
            begin
                If RecUserSetup.Get(UserId()) then
                    If StrPos(RecUserSetup."ELOA Approver", 'EED') > 0 then begin
                        IF "EED Basic Science Department" = "EED Basic Science Department"::Open THEN
                            ERROR('Status must be "Pending for Approval" or Approved or Rejected');

                        If (xRec."EED Basic Science Department" = xRec."EED Basic Science Department"::Rejected) and ("EED Basic Science Department" = "EED Basic Science Department"::"Pending for Approval") then
                            Error('Status must be Approved or Rejected');
                        IF (xRec."EED Basic Science Department" = xRec."EED Basic Science Department"::Approved) and
                        ("EED Basic Science Department" IN ["EED Basic Science Department"::"Pending for Approval", "EED Basic Science Department"::Rejected, "EED Basic Science Department"::Open]) then
                            Error('Department status can not be changed');

                        // if "EED Basic Science Department" = "EED Basic Science Department"::Rejected then
                        // RejectMail(Rec);
                    end else
                        Error('you do not have permission to change the department status');


            end;
        }
        field(29; "Dean of Students affairs"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = Open,"Pending for Approval",Approved,Rejected;
            trigger OnValidate()
            Var
                RecUserSetup: Record "User Setup";
            begin
                If RecUserSetup.Get(UserId()) then
                    If StrPos(RecUserSetup."ELOA Approver", 'STUDENT AFFAIR') > 0 then begin
                        IF "Dean of Students affairs" = "Dean of Students affairs"::Open THEN
                            ERROR('Status must be "Pending for Approval" or Approved or Rejected');

                        If (xRec."Dean of Students affairs" = xRec."Dean of Students affairs"::Rejected) and ("Dean of Students affairs" = "Dean of Students affairs"::"Pending for Approval") then
                            Error('Status must be Approved or Rejected');
                        IF (xRec."Dean of Students affairs" = xRec."Dean of Students affairs"::Approved) and
                        ("Dean of Students affairs" IN ["Dean of Students affairs"::"Pending for Approval", "Dean of Students affairs"::Rejected, "Dean of Students affairs"::Open]) then
                            Error('Department status can not be changed');

                        // if "Dean of Students affairs" = "Dean of Students affairs"::Rejected then
                        // RejectMail(Rec);
                    end else
                        Error('you do not have permission to change the department status');

            end;
        }
        field(30; "Executive Dean"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = Open,"Pending for Approval",Approved,Rejected;
            trigger OnValidate()
            Var
                RecUserSetup: Record "User Setup";
            begin
                IF "Leave Types" = "Leave Types"::ELOA then
                    If RecUserSetup.Get(UserId()) then
                        If StrPos(RecUserSetup."ELOA Approver", 'EXECUTIVE DEAN') > 0 then begin
                            IF "Executive Dean" = "Executive Dean"::Open THEN
                                ERROR('Status must be "Pending for Approval" or Approved or Rejected');

                            If (xRec."Executive Dean" = xRec."Executive Dean"::Rejected) and ("Executive Dean" = "Executive Dean"::"Pending for Approval") then
                                Error('Status must be Approved or Rejected');
                            IF (xRec."Executive Dean" = xRec."Executive Dean"::Approved) and
                            ("Executive Dean" IN ["Executive Dean"::"Pending for Approval", "Executive Dean"::Rejected, "Executive Dean"::Open]) then
                                Error('Department status can not be changed');

                            // if "Executive Dean" = "Executive Dean"::Rejected then
                            // RejectMail(Rec);
                        end else
                            Error('you do not have permission to change the department status');
            end;
        }

        field(31; "Registrar Department"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = Open,"Pending for Approval",Approved,Rejected;
        }
        field(32; "Registrar"; Boolean)
        {
            DataClassification = CustomerContent;

        }
        field(33; "Leave Types"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'ELOA,SLOA,CLOA';
            OptionMembers = "ELOA","SLOA","CLOA";
            Editable = false;
        }
        field(34; "Student Affairs Dept."; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Open,Pending,Approved,Rejected';
            OptionMembers = "Open","Pending","Approved","Rejected";
            Editable = False;
        }
        field(35; "Posting No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(36; "Leave Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Denied,Granted';
            OptionMembers = " ","Denied","Granted";
        }
        field(37; "Document Category"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = " ","Application Form","Passport Biodata","Stamp on Arrival Copy","Visa Copy","Return Ticket Copy","Passport Size Photo";
        }
        field(38; "Document Sub Category"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(39; "Document Name"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(40; "Document Path"; Text[500])
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                FileExtension: Text[500];
                I: Integer;
                Alfa: Text[1];
            begin
                FileExtension := '';

                for I := 1 to StrLen("Document Path") do begin
                    Alfa := CopyStr("Document Path", I, 1);
                    if Alfa = '.' then
                        FileExtension := ''
                    else
                        FileExtension := Format(FileExtension + Alfa);
                end;
                "Document Extension" := FileExtension;
            end;
        }
        field(41; "Document Extension"; Text[500])
        {
            DataClassification = CustomerContent;
        }
        field(42; "Document ID"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(43; "Document Update Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(44; "Created By"; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(45; "Updated"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(46; "Rejected By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(47; "Rejected On"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(48; "Reason Description"; Text[2048])
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                StudentMaster: Record "Student Master-CS";
            begin
                StudentMaster.Reset();
                StudentMaster.SetRange("No.", "Student No.");
                if StudentMaster.FindFirst() then begin
                    StudentMaster."Reason Description" := "Reason Description";
                    StudentMaster.Modify();
                end;
            end;

        }
        field(49; "Rotation No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Rotation No.';
            Editable = false;
        }
        field(50; OnlineLeave; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(51; "Term"; Option)
        {
            Caption = 'Session';
            DataClassification = CustomerContent;
            OptionCaption = 'FALL,SPRING,SUMMER';
            OptionMembers = FALL,SPRING,SUMMER;
            Editable = false;
        }
        field(52; Inserted; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Inserted';
        }
        field(60; "Date Of Determination"; Date)
        {
            Caption = 'Date of Determination';
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                StudentMaster: Record "Student Master-CS";
            begin
                // if "Date of Determination" < "Application Date" then
                //     Error('Date of Determination must be greater then Application Date.');

                StudentMaster.Reset();
                StudentMaster.SetRange("No.", "Student No.");
                if StudentMaster.FindFirst() then begin
                    StudentMaster."Date Of Determination" := "Date Of Determination";
                    StudentMaster.Modify();
                end;
            end;
        }
        field(61; "Last Date Of Attendance"; Date)
        {
            Caption = 'Last Date Of Attendance';
            DataClassification = CustomerContent;
            //Editable = false;
            trigger OnValidate()
            var
                StudentMaster: Record "Student Master-CS";
                DateRec: Record Date;
            begin
                // if "Last Date Of Attendance" < "Application Date" then
                //     Error('Last Date Of Attendance must be greater then Application Date.');

                If "Leave Types" = "Leave Types"::CLOA then begin
                    If "Last Date Of Attendance" <> 0D then begin
                        DateRec.Reset();
                        DateRec.SetRange("Period Type", DateRec."Period Type"::Date);
                        DateRec.SetRange("Period Start", "Last Date Of Attendance");
                        If DateRec.FindFirst() then
                            If DateRec."Period Name" <> 'Friday' then
                                Error('Selected date is incorrect.(LDA should always be a Friday)');

                    end;
                end;

                StudentMaster.Reset();
                StudentMaster.SetRange("No.", "Student No.");
                if StudentMaster.FindFirst() then begin
                    StudentMaster.LDA := "Last Date Of Attendance";
                    StudentMaster.Modify();
                end;
            end;
        }
        field(62; "No. of Days"; Integer)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(63; Reopen; Boolean)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        Field(64; "NSLDS Withdrawal Date"; Date)
        {
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                StudentMaster: Record "Student Master-CS";
            begin
                // if "NSLDS Withdrawal Date" < "Application Date" then
                //     Error('NSLDS Withdrawal Date must be greater then Application Date.');

                StudentMaster.Reset();
                StudentMaster.SetRange("No.", "Student No.");
                if StudentMaster.FindFirst() then begin
                    StudentMaster."NSLDS Withdrawal Date" := "NSLDS Withdrawal Date";
                    StudentMaster.Modify();
                end;
            end;

        }
        field(65; "Last Student Status Updated"; Code[20])
        {
            Caption = 'Last Student Status Updated';
            DataClassification = CustomerContent;
            TableRelation = "Student Status";
        }
        field(66; "SFP-LOA"; Option)
        {
            OptionCaption = ' ,Pending,Complete,Failed';
            OptionMembers = " ",Pending,Complete,Failed;
            caption = 'SFP-LOA';
        }
        field(67; LogComplete; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(68; CLOA_Start_Log_Created; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(69; CLOA_End_Log_Created; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(70; "HelloSign_Confirmed"; Boolean)
        {   //CSPL-00307-HelloSign_BUG
            DataClassification = ToBeClassified;
        }


    }

    keys
    {
        key(PK; "Application No.")
        {
            Clustered = true;
        }
    }
    var
        DepartmentMasterRec: Record "Withdrawal Department";
        StudentStatusRec: Record "Student Status";
        LOA_lRec: Record "Student Leave of Absence";
        //    EducationSetupRec: Record "Education Setup-CS";
        //    UserSetupRec: Record "User Setup";
        recClassAttendanceLine: Record "Class Attendance Line-CS";
        WebServicesFunctionsCod: Codeunit WebServicesFunctionsCSL;
        BodyText: text[2048];
        Text0001Lbl: Label 'Start date must be smaller than End date';

    trigger OnInsert()
    VAR
        GlSetup: Record "General Ledger Setup";
        NoSeriesMgmt_lCU: Codeunit NoSeriesManagement;
    begin
        // UserSetupRec.Get(UserId());
        // EducationSetupRec.Reset();
        // EducationSetupRec.SetRange("Global Dimension 1 Code", UserSetupRec."Global Dimension 1 Code");
        GlSetup.get();
        IF "Application No." = '' then begin
            GlSetup.TestField("Leave Of Absence No.");
            NoSeriesMgmt_lCU.InitSeries(GlSetup."Leave Of Absence No.", xRec."Posting No.", 0D, "Application No.", Rec."Posting No.");
        end;
        "Application Date" := WorkDate();
        "Created By" := Format(UserId());

        Inserted := True;
    end;

    trigger OnModify()
    begin
        If xRec.Updated = Updated then
            Updated := true;

    end;

    trigger OnDelete()
    begin
        if Status <> Status::Open then
            Error('Status must be open.');
    end;

    trigger OnRename()
    begin

    end;

    procedure AssistEdit(OldLOA: Record "Student Leave of Absence"): Boolean
    var
        LOA_lRec: Record "Student Leave of Absence";
        GlSetup: Record "General Ledger Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        with LOA_lRec do begin
            LOA_lRec := Rec;
            // UserSetupRec.Get(UserId());
            // EducationSetupRec.Reset();
            // EducationSetupRec.SetRange("Global Dimension 1 Code", UserSetupRec."Global Dimension 1 Code");
            GlSetup.get();
            GlSetup.TestField("Leave Of Absence No.");
            if NoSeriesMgt.SelectSeries(GlSetup."Leave Of Absence No.", OldLOA."Posting No.", "Posting No.") then begin
                NoSeriesMgt.SetSeries("Application No.");
                Rec := LOA_lRec;
                exit(true);
            end;
        end;
    end;

    // procedure ApprovalMail(_Rec: Record "Student Leave of Absence")
    // var
    //     StudentMaster_lRec: Record "Student Master-CS";
    //     SmtpMailRec: record "Email Account";
    //     SMTPMail: codeunit "Email Message";
    //     Mail_lCU: Codeunit Mail;
    //     SenderName: Text[100];
    //     SenderAddress: Text[250];
    //     Subject: Text[100];
    //     Recipients: List of [Text];
    //     Recipient: Text[100];

    // begin
    //     SmtpMailRec.Get();
    //     StudentMaster_lRec.GET(_Rec."Student No.");
    //     StudentMaster_lRec.TESTFIELD(StudentMaster_lRec."E-Mail Address");
    //     Recipient := StudentMaster_lRec."E-Mail Address";
    //     Recipients := Recipient.Split(';');
    //     SenderName := 'MEA';
    //     SenderAddress := SmtpMailRec."Email Address";
    //     Subject := Format(_Rec."Leave Types") + ' ' + 'Leave has been approved';

    //     SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');

    //     SmtpMail.AppendtoBody('Dear' + ' ' + StudentMaster_lRec."Name as on Certificate");
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('This is to you want that your Request for' + ' ' + _Rec."Reason Description" + ' ' + 'has been approved');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Thanking You');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('<br>');
    //     SmtpMail.AppendtoBody('This Is System Generated Mail.Please Do Not Reply On This E-mail ID');
    //     SmtpMail.AppendtoBody('<br>');
    //     //SmtpMail.AppendtoBody('THIS IS A TEST EMAIL FOR NEW SOFTWARE SYSTEM. PLEASE DISREGARD');
    //     BodyText := SmtpMail.GetBody();
    //     //Mail_lCU.Send();

    //     WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('Leaves', 'MEA', SenderAddress, Format("Student Name"),
    //     "Student No.", Subject, BodyText, 'Leaves', 'Leaves', "Application No.", Format("Application Date", 0, 9),
    //     Recipient, 1, StudentMaster_lRec."Mobile Number", '', 1);

    // end;

    // procedure RejectMail(_Rec: Record "Student Leave of Absence")
    // var
    //     StudentMaster_lRec: Record "Student Master-CS";
    //     SmtpMailRec: Record "Email Account";
    //     SMTPMail: codeunit "Email Message";
    //     Mail_lCU: Codeunit Mail;
    //     SenderName: Text[100];
    //     SenderAddress: Text[250];
    //     Subject: Text[100];
    //     Recipients: List of [Text];
    //     Recipient: Text[100];

    // begin
    //     SmtpMailRec.Get();
    //     StudentMaster_lRec.GET(_Rec."Student No.");
    //     StudentMaster_lRec.TESTFIELD(StudentMaster_lRec."E-Mail Address");
    //     Recipient := StudentMaster_lRec."E-Mail Address";
    //     Recipients := Recipient.Split(';');
    //     SenderName := 'MEA';
    //     SenderAddress := SmtpMailRec."Email Address";
    //     IF _Rec."Leave Types" = _Rec."Leave Types"::SLOA then
    //         Subject := 'SLOA Leave request has been reject';
    //     IF _Rec."Leave Types" = _Rec."Leave Types"::ELOA then begin
    //         IF _Rec."Library Department" = _Rec."Library Department"::Rejected then
    //             Subject := 'ELOA Leave request has been rejected by Library Department';
    //         IF _Rec."Bursar Department" = _Rec."Bursar Department"::Rejected then
    //             Subject := 'ELOA Leave request has been rejected by Bursar Department';
    //         IF _Rec."Financial Aid Department" = _Rec."Financial Aid Department"::Rejected then
    //             Subject := 'ELOA Leave request has been rejected by Financial Aid Department';
    //         IF _Rec."EED Basic Science Department" = _Rec."EED Basic Science Department"::Rejected then
    //             Subject := 'ELOA Leave request has been rejected by EED Pre- Clinical Department';
    //         IF _Rec."Dean of Students affairs" = _Rec."Dean of Students affairs"::Rejected then
    //             Subject := 'ELOA Leave request has been rejected by Dean of Student Affairs';
    //         If _Rec."Executive Dean" = _Rec."Executive Dean"::Rejected then
    //             Subject := 'ELOA Leave request has been rejected by Executive Dean';
    //     end;
    //     IF _Rec."Leave Types" = _Rec."Leave Types"::CLOA then
    //         Subject := 'CLOA Leave request has been reject';


    //     SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');

    //     SmtpMail.AppendtoBody('Dear' + ' ' + StudentMaster_lRec."Name as on Certificate");
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('This is to inform you that your request for ' + Format(_Rec."Leave Types") + ' ' + 'has been rejected');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Thanking You');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('<br>');
    //     SmtpMail.AppendtoBody('This Is System Generated Mail.Please Do Not Reply On This E-mail ID');
    //     SmtpMail.AppendtoBody('<br>');
    //     //SmtpMail.AppendtoBody('THIS IS A TEST EMAIL FOR NEW SOFTWARE SYSTEM. PLEASE DISREGARD');
    //     BodyText := SmtpMail.GetBody();
    //     //Mail_lCU.Send();

    //     WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('Leaves', 'MEA', SenderAddress, Format("Student Name"),
    //     "Student No.", Subject, BodyText, 'Leaves', 'Leaves', "Application No.", Format("Application Date", 0, 9),
    //     Recipient, 1, StudentMaster_lRec."Mobile Number", '', 1);

    // end;

    procedure RotationSchedulewithinPeriod(_LOA: Record "Student Leave of Absence")
    var
        RosterScheduleLine_lRec: Record "Roster Scheduling Line";
        Text50000Lbl: Label 'CLOA Start Date : %1 is exist in the Roster Scheduled Period.', comment = '%1 = Leave of Absence Start Date ';
    begin
        RosterScheduleLine_lRec.Reset();
        RosterScheduleLine_lRec.SetRange("Student No.", _LOA."Student No.");
        RosterScheduleLine_lRec.SetFilter("Start Date", '<=%1', _LOA."Start Date");
        RosterScheduleLine_lRec.SetFilter("End Date", '>=%1', _LOA."Start Date");
        RosterScheduleLine_lRec.SetRange("Academic Year", _LOA."Academic Year");
        RosterScheduleLine_lRec.SetFilter(Status, '%1|%2', RosterScheduleLine_lRec.Status::Scheduled, RosterScheduleLine_lRec.Status::Published);
        If RosterScheduleLine_lRec.FindFirst() then
            ERROR(Text50000Lbl, _LOA."Start Date");

    end;

    procedure RotationScheduleAfterPeriod(_LOA: Record "Student Leave of Absence")
    var
        RosterScheduleLine_lRec: Record "Roster Scheduling Line";
        EndDate_lDate: date;
        Text50000Lbl: Label 'Clinical Rotation schedule for next week does not exist.';
    begin
        EndDate_lDate := 0D;
        EndDate_lDate := GetWeekDay(_LOA."End Date");

        RosterScheduleLine_lRec.Reset();
        RosterScheduleLine_lRec.SetRange("Student No.", _LOA."Student No.");
        RosterScheduleLine_lRec.SetFilter("Start Date", '<=%1', EndDate_lDate);
        RosterScheduleLine_lRec.SetFilter("End Date", '>=%1', EndDate_lDate);
        //        RosterScheduleLine_lRec.SetRange("Academic Year", _LOA."Academic Year");
        RosterScheduleLine_lRec.SetFilter(Status, '%1|%2', RosterScheduleLine_lRec.Status::Scheduled, RosterScheduleLine_lRec.Status::Published);
        IF not RosterScheduleLine_lRec.FindFirst() then
            Error(Text50000Lbl);
    end;

    procedure GetWeekDay(_Date: Date): Date
    var
        DayCount_lInt: Integer;
        NextWeekDate_lDate: Date;
    begin
        DayCount_lInt := 0;
        NextWeekDate_lDate := 0D;
        DayCount_lInt := Date2DWY(_Date, 1);
        If DayCount_lInt = 1 then
            NextWeekDate_lDate := CalcDate('<7D>', _Date);
        IF DayCount_lInt = 2 then
            NextWeekDate_lDate := CalcDate('<6D>', _Date);
        If DayCount_lInt = 3 then
            NextWeekDate_lDate := CalcDate('<5D>', _Date);
        If DayCount_lInt = 4 then
            NextWeekDate_lDate := CalcDate('<4D>', _Date);
        If DayCount_lInt = 5 then
            NextWeekDate_lDate := CalcDate('<3D>', _Date);
        If DayCount_lInt = 6 then
            NextWeekDate_lDate := CalcDate('<2D>', _Date);
        if DayCount_lInt = 7 then
            NextWeekDate_lDate := CalcDate('<1D>', _Date);
        exit(NextWeekDate_lDate);

    end;

    procedure CheckDate(_LOA: Record "Student Leave of Absence")
    var
        LOA_lRec: Record "Student Leave of Absence";
        Text50003Lbl: Label 'Student can not apply for CLOA';
        DaysCount_lInt: Integer;

    begin
        RotationSchedulewithinPeriod(_LOA);
        RotationScheduleAfterPeriod(_LOA);
        If ("End Date" - "Start Date" + 1) < 28 then
            Error(Text50003Lbl)
        ELSE
            If ("End Date" - "Start Date" + 1) >= 180 then begin
                DaysCount_lInt := "End Date" - "Start Date" + 1;
                IF DaysCount_lInt >= 180 then
                    Error(Text50003Lbl);
                LOA_lRec.Reset();
                LOA_lRec.SetRange("Student No.", Rec."Student No.");
                LOA_lRec.SetRange("Academic Year", Rec."Academic Year");
                LOA_lRec.SetRange("Leave Types", LOA_lRec."Leave Types"::CLOA);
                IF LOA_lRec.FindFirst() then begin
                    DaysCount_lInt += (LOA_lRec."End Date" - LOA_lRec."Start Date" + 1);
                    If DaysCount_lInt >= 180 then
                        Error(Text50003Lbl);
                end;

            end;

    end;

    // procedure ADWDStatus(_Rec: Record "Student Leave of Absence")
    // var
    //     StudentMaster_lRec: Record "Student Master-CS";
    //     SmtpMailRec: Record "Email Account";
    //     SMTPMail: codeunit "Email Message";
    //     Mail_lCU: Codeunit Mail;
    //     SenderName: Text[100];
    //     SenderAddress: Text[250];
    //     Subject: Text[100];
    //     Recipients: List of [Text];
    //     Recipient: Text[100];

    // begin
    //     SmtpMailRec.Get();
    //     StudentMaster_lRec.GET(_Rec."Student No.");
    //     StudentMaster_lRec.TESTFIELD(StudentMaster_lRec."E-Mail Address");
    //     Recipient := StudentMaster_lRec."E-Mail Address";
    //     Recipients := Recipient.Split(';');
    //     SenderName := 'MEA';
    //     SenderAddress := SmtpMailRec."Email Address";
    //     Subject := 'Student Status changed ADWD';

    //     SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');

    //     SmtpMail.AppendtoBody('Hi' + ' ' + StudentMaster_lRec."Name as on Certificate");
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Your status is now ADWD. If you want to appeal, then you can contact to appeal Committee');
    //     SmtpMail.AppendtoBody('<br>');
    //     SmtpMail.AppendtoBody('Thanking You');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('<br>');
    //     SmtpMail.AppendtoBody('This Is System Generated Mail.Please Do Not Reply On This E-mail ID');
    //     SmtpMail.AppendtoBody('<br>');
    //     //SmtpMail.AppendtoBody('THIS IS A TEST EMAIL FOR NEW SOFTWARE SYSTEM. PLEASE DISREGARD');
    //     BodyText := SmtpMail.GetBody();
    //     //Mail_lCU.Send();

    //     WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('Student Status Changed', 'MEA', SenderAddress, Format("Student Name"),
    //     "Student No.", Subject, BodyText, 'Student Status Changed', 'Student Status Changed', '', '',
    //     Recipient, 1, StudentMaster_lRec."Mobile Number", '', 1);

    // end;

    procedure UpdateCLOAApplication(_LOA: Record "Student Leave of Absence")
    Var
        RosterSchedulingline_lRec: Record "Roster Scheduling Line";
        EndDate_lDate: Date;
    begin
        EndDate_lDate := 0D;
        EndDate_lDate := GetWeekDay(_LOA."End Date");
        RosterSchedulingline_lRec.Reset();
        RosterSchedulingline_lRec.SetRange("Student No.", _LOA."Student No.");
        RosterSchedulingline_lRec.SetRange("Academic Year", _LOA."Academic Year");
        RosterSchedulingline_lRec.SetFilter("Start Date", '<=%1', EndDate_lDate);
        RosterSchedulingline_lRec.SetFilter("End Date", '>=%1', EndDate_lDate);
        RosterSchedulingline_lRec.SetFilter(Status, '%1|%2', RosterSchedulingline_lRec.Status::Scheduled, RosterSchedulingline_lRec.Status::Published);
        IF RosterSchedulingline_lRec.FindFirst() then begin
            RosterSchedulingline_lRec."CLOA Application No." := _LOA."Application No.";
            RosterSchedulingline_lRec.Modify();
            _LOA."Rotation No." := RosterSchedulingline_lRec."Rotation ID";
            _LOA.Modify();
        end;
    end;

    procedure RotationSchedulewithinPeriodEnddate(_LOA: Record "Student Leave of Absence")
    var
        RosterScheduleLine_lRec: Record "Roster Scheduling Line";
        Text50000Lbl: Label 'CLOA End Date : %1 exists in the Roster Schedule period.', comment = '%1 = Leave of Absence Start Date ';
        Text50001Lbl: Label 'The Roster Scheduled Period is exist between the CLOA Start date & End Date';
    begin
        RosterScheduleLine_lRec.Reset();
        RosterScheduleLine_lRec.SetRange("Student No.", _LOA."Student No.");
        RosterScheduleLine_lRec.SetFilter("Start Date", '<=%1', _LOA."End Date");
        RosterScheduleLine_lRec.SetFilter("End Date", '>=%1', _LOA."End Date");
        RosterScheduleLine_lRec.SetRange("Academic Year", _LOA."Academic Year");
        RosterScheduleLine_lRec.SetFilter(Status, '%1|%2', RosterScheduleLine_lRec.Status::Scheduled, RosterScheduleLine_lRec.Status::Published);
        If RosterScheduleLine_lRec.FindFirst() then
            ERROR(Text50000Lbl, _LOA."End Date");

        RosterScheduleLine_lRec.Reset();
        RosterScheduleLine_lRec.SetRange("Student No.", _LOA."Student No.");
        RosterScheduleLine_lRec.SetFilter("Start Date", '>=%1', _LOA."Start Date");
        RosterScheduleLine_lRec.SetFilter("End Date", '<=%1', _LOA."End Date");
        RosterScheduleLine_lRec.SetRange("Academic Year", _LOA."Academic Year");
        RosterScheduleLine_lRec.SetFilter(Status, '%1|%2', RosterScheduleLine_lRec.Status::Scheduled, RosterScheduleLine_lRec.Status::Published);
        If RosterScheduleLine_lRec.FindFirst() then
            ERROR(Text50001Lbl);

    end;

    procedure PostStudentLeavesApprovalEntries(LeavesType: Option ELOA,SLOA,CLOA);
    var
        LeavesApprovalsRec: Record "Leaves Approvals";
        LeavesApprovalsRec1: Record "Leaves Approvals";
        StudentMaster: Record "Student Master-CS";
        LineNo: Integer;
    begin
        DepartmentMasterRec.Reset();
        DepartmentMasterRec.SetRange("Global Dimension 1 Code", "Global Dimension 1 Code");
        If (LeavesType = LeavesType::SLOA) then
            DepartmentMasterRec.SetFilter(DepartmentMasterRec."Document Type", '%1', DepartmentMasterRec."Document Type"::SLOA);
        If (LeavesType = LeavesType::CLOA) then
            DepartmentMasterRec.SetFilter(DepartmentMasterRec."Document Type", '%1', DepartmentMasterRec."Document Type"::CLOA);
        If (LeavesType = LeavesType::ELOA) then
            DepartmentMasterRec.SetFilter(DepartmentMasterRec."Document Type", '%1', DepartmentMasterRec."Document Type"::ELOA);
        DepartmentMasterRec.SetRange("Final Approval", true);
        if not DepartmentMasterRec.FindFirst() then
            Error('There is no Final Approver in the Leave Approver list.');

        DepartmentMasterRec.Reset();
        DepartmentMasterRec.SetCurrentKey(Sequence);
        DepartmentMasterRec.Ascending(True);
        DepartmentMasterRec.SetRange("Global Dimension 1 Code", "Global Dimension 1 Code");
        If (LeavesType = LeavesType::SLOA) then
            DepartmentMasterRec.SetFilter(DepartmentMasterRec."Document Type", '%1', DepartmentMasterRec."Document Type"::SLOA);
        If (LeavesType = LeavesType::CLOA) then
            DepartmentMasterRec.SetFilter(DepartmentMasterRec."Document Type", '%1', DepartmentMasterRec."Document Type"::CLOA);
        If (LeavesType = LeavesType::ELOA) then
            DepartmentMasterRec.SetFilter(DepartmentMasterRec."Document Type", '%1', DepartmentMasterRec."Document Type"::ELOA);
        if DepartmentMasterRec.findset() then
            repeat
                StudentMaster.Reset();
                StudentMaster.SetRange("No.", Rec."Student No.");
                If StudentMaster.FindFirst() then begin
                    If (DepartmentMasterRec."Department Code" = '8007') and (StudentMaster."FAFSA Received") then begin
                        LineNo := 0;
                        LeavesApprovalsRec1.Reset();
                        LeavesApprovalsRec1.SETRANGE("Application No.", "Application No.");
                        IF LeavesApprovalsRec1.FINDLAST() THEN
                            LineNo := LeavesApprovalsRec1."Line No." + 10000
                        ELSE
                            LineNo := 10000;

                        LeavesApprovalsRec.Init();
                        LeavesApprovalsRec."Application No." := "Application No.";
                        LeavesApprovalsRec."Application Date" := "Application date";
                        LeavesApprovalsRec."Line No." := LineNo;
                        LeavesApprovalsRec."Student No." := "Student No.";
                        LeavesApprovalsRec."Student Name" := "Student Name";
                        LeavesApprovalsRec."Enrolment No." := "Enrolment No.";
                        LeavesApprovalsRec."Approved for Department" := DepartmentMasterRec."Department Code";
                        LeavesApprovalsRec."Department Name" := DepartmentMasterRec."Department Name";
                        LeavesApprovalsRec.Status := LeavesApprovalsRec.Status::"Pending for Approval";
                        LeavesApprovalsRec."Final Approval" := DepartmentMasterRec."Final Approval";
                        LeavesApprovalsRec."Reason Code" := Reason;
                        LeavesApprovalsRec."Reason for Leave" := "Reason Description";
                        LeavesApprovalsRec."Type of Leaves" := LeavesType;
                        LeavesApprovalsRec.Semester := Semester;
                        LeavesApprovalsRec."Academic Year" := "Academic Year";
                        LeavesApprovalsRec."Start Date" := "Start Date";
                        LeavesApprovalsRec."End Date" := "End Date";
                        LeavesApprovalsRec."Global Dimension 1 Code" := "Global Dimension 1 Code";
                        LeavesApprovalsRec."Global Dimension 2 Code" := "Global Dimension 2 Code";
                        LeavesApprovalsRec."Date Of Determination" := "Date Of Determination";
                        LeavesApprovalsRec."Last Date Of Attendance" := "Last Date Of Attendance";
                        LeavesApprovalsRec."NSLDS Withdrawal Date" := "NSLDS Withdrawal Date";
                        LeavesApprovalsRec.Insert(true);
                        // if DepartmentMasterRec."Final Approval" = false then
                        //     LeaveRequestMailtoDepartment("Student No.", DepartmentMasterRec."Department Code", "Global Dimension 1 Code", LeavesType);
                    end;
                    If (DepartmentMasterRec."Department Code" <> '8007') then begin
                        LineNo := 0;
                        LeavesApprovalsRec1.Reset();
                        LeavesApprovalsRec1.SETRANGE("Application No.", "Application No.");
                        IF LeavesApprovalsRec1.FINDLAST() THEN
                            LineNo := LeavesApprovalsRec1."Line No." + 10000
                        ELSE
                            LineNo := 10000;

                        LeavesApprovalsRec.Init();
                        LeavesApprovalsRec."Application No." := "Application No.";
                        LeavesApprovalsRec."Application Date" := "Application date";
                        LeavesApprovalsRec."Line No." := LineNo;
                        LeavesApprovalsRec."Student No." := "Student No.";
                        LeavesApprovalsRec."Student Name" := "Student Name";
                        LeavesApprovalsRec."Enrolment No." := "Enrolment No.";
                        LeavesApprovalsRec."Approved for Department" := DepartmentMasterRec."Department Code";
                        LeavesApprovalsRec."Department Name" := DepartmentMasterRec."Department Name";
                        LeavesApprovalsRec.Status := LeavesApprovalsRec.Status::"Pending for Approval";
                        LeavesApprovalsRec."Final Approval" := DepartmentMasterRec."Final Approval";
                        LeavesApprovalsRec."Reason Code" := Reason;
                        LeavesApprovalsRec."Reason for Leave" := "Reason Description";
                        LeavesApprovalsRec."Type of Leaves" := LeavesType;
                        LeavesApprovalsRec.Semester := Semester;
                        LeavesApprovalsRec."Academic Year" := "Academic Year";
                        LeavesApprovalsRec."Start Date" := "Start Date";
                        LeavesApprovalsRec."End Date" := "End Date";
                        LeavesApprovalsRec."Global Dimension 1 Code" := "Global Dimension 1 Code";
                        LeavesApprovalsRec."Global Dimension 2 Code" := "Global Dimension 2 Code";
                        LeavesApprovalsRec."Date Of Determination" := "Date Of Determination";
                        LeavesApprovalsRec."Last Date Of Attendance" := "Last Date Of Attendance";
                        LeavesApprovalsRec."NSLDS Withdrawal Date" := "NSLDS Withdrawal Date";
                        LeavesApprovalsRec.Insert(true);
                        // if DepartmentMasterRec."Final Approval" = false then
                        //     LeaveRequestMailtoDepartment("Student No.", DepartmentMasterRec."Department Code", "Global Dimension 1 Code", LeavesType);
                    end;

                end;
            Until DepartmentMasterRec.NEXT() = 0;

    end;

    // procedure LeaveRequestMailtoDepartment(StudentNo: Code[20]; Department: Code[20]; GD1: Code[20]; LeavesType: Option ELOA,SLOA,CLOA)
    // var
    //     SmtpMailRec: Record "Email Account";
    //     Studentmaster: Record "Student Master-CS";
    //     WithdrawalDepartmentRec: Record "Withdrawal Department";
    //     SMTPMail: codeunit "Email Message";
    //     Mail_lCU: Codeunit Mail;
    //     SenderName: Text[100];
    //     SenderAddress: Text[250];
    //     Subject: Text[100];
    //     Recipients: List of [Text];
    //     Recipient: Text;
    //     CCRecipient: Text[100];
    //     CCRecipients: List of [Text];

    // begin
    //     SmtpMailRec.Get();
    //     Studentmaster.GET(StudentNo);
    //     Studentmaster.TESTFIELD(Studentmaster."E-Mail Address");
    //     WithdrawalDepartmentRec.Reset();
    //     WithdrawalDepartmentRec.SETCURRENTKEY(Sequence);//GAURAV-1-12-22
    //     WithdrawalDepartmentRec.SetRange("Department Code", Department);
    //     WithdrawalDepartmentRec.SetRange("Global Dimension 1 Code", GD1);
    //     If (LeavesType = LeavesType::SLOA) then
    //         WithdrawalDepartmentRec.SetFilter(WithdrawalDepartmentRec."Document Type", '%1', WithdrawalDepartmentRec."Document Type"::SLOA);
    //     If (LeavesType = LeavesType::CLOA) then
    //         WithdrawalDepartmentRec.SetFilter(WithdrawalDepartmentRec."Document Type", '%1', WithdrawalDepartmentRec."Document Type"::CLOA);
    //     If (LeavesType = LeavesType::ELOA) then
    //         WithdrawalDepartmentRec.SetFilter(WithdrawalDepartmentRec."Document Type", '%1', WithdrawalDepartmentRec."Document Type"::ELOA);
    //     WithdrawalDepartmentRec.SETASCENDING(Sequence, TRUE);
    //     ;//GAURAV-1-12-22
    //     if WithdrawalDepartmentRec.FindFirst() then;
    //     Recipient := WithdrawalDepartmentRec.GetUsersEmailid(WithdrawalDepartmentRec."Department Code");//CSPL-00307-T1-T1516-CR
    //     // Recipient := WithdrawalDepartmentRec."User E-Mail";
    //     Recipients := Recipient.Split(';');
    //     CCRecipient := WithdrawalDepartmentRec."CC E-Mail";
    //     CCRecipients := CCRecipient.Split(';');

    //     SenderName := 'MEA';
    //     SenderAddress := SmtpMailRec."Email Address";
    //     Subject := (Format("Application No.") + ' ' + Format("Leave Types") + 'Leave Request:'
    //                 + ' ' + Format(StudentNo) + ',' + ' ' +
    //                 Format("Student Name") + ',' + ' ' + Format("Enrolment No.") + ',' + ' ' + Format(Semester));

    //     SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');
    //     If CCRecipient <> '' then
    //         SmtpMail.AddCC(CCRecipients);
    //     SmtpMail.AppendtoBody('Dear' + ' ' + Format(WithdrawalDepartmentRec."Department Name") + ',');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('This is to inform you that I would like to take' + ' ' + Format("Leave Types") + ' ' +
    //                         'leave from' + ' ' + Format("Start Date") + ' ' + 'to' + ' ' + Format("End Date")
    //                         + ' ' + 'due to' + ' ' + Format("Reason Description"));

    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('<br>');
    //     SmtpMail.AppendtoBody('Kindly approve my leave request.');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('<br>');
    //     SmtpMail.AppendtoBody('Regards,');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody("Student Name" + ',' + ' ' + "Student No." + ',' + ' ' + Semester);
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('<br>');
    //     SmtpMail.AppendtoBody('This is system generated mail. Please do not reply on this E-mail id.');
    //     BodyText := SmtpMail.GetBody();
    //     SmtpMail.AppendtoBody('<br>');
    //     //SmtpMail.AppendtoBody('THIS IS A TEST EMAIL FOR NEW SOFTWARE SYSTEM. PLEASE DISREGARD');
    //     //Mail_lCU.Send();

    //     // BodyText := 'Dear' + ' ' + Format(WithdrawalDepartmentRec."Department Name") + ' ' + 'This is to inform you that I would like to take'
    //     //  + ' ' + Format("Leave Types") + ' ' + 'leave from' + ' ' + Format("Start Date") + ' ' + 'to' + ' ' +
    //     //    Format("End Date") + ' ' + 'due to' + ' ' + Format("Reason Description") + ' ' + 'Kindly approve my leave request.'
    //     //  + ' ' + 'Regards,' + ' ' + "Student Name" + ',' + ' ' + "Student No." + ',' + ' ' + Semester;

    //     WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('Leave of Absence', 'MEA', SenderAddress, Format("Student Name"),
    //     "Student No.", Subject, BodyText, 'Leave of Absence', 'Leave', Format("Application No."), Format("Application Date"),
    //     SmtpMailRec."Email Address", 1, Studentmaster."Mobile Number", '', 1);

    // end;

    // procedure WithdrawalRequestMailtoFinalApprover(StudentNo: Code[20]; Department: Code[20]; GD1: Code[20])
    // var
    //     SmtpMailRec: Record "Email Account";
    //     Studentmaster: Record "Student Master-CS";
    //     WithdrawalDepartmentRec: Record "Withdrawal Department";

    //     SMTPMail: codeunit "Email Message";
    //     Mail_lCU: Codeunit Mail;
    //     SenderName: Text[100];
    //     SenderAddress: Text[250];
    //     Subject: Text[100];
    //     Recipients: List of [Text];
    //     Recipient: Text;

    // begin
    //     SmtpMailRec.Get();
    //     Studentmaster.GET(StudentNo);
    //     Studentmaster.TESTFIELD(Studentmaster."E-Mail Address");
    //     WithdrawalDepartmentRec.Reset();
    //     WithdrawalDepartmentRec.SetRange("Department Code", Department);
    //     WithdrawalDepartmentRec.SetRange("Global Dimension 1 Code", GD1);
    //     if WithdrawalDepartmentRec.FindFirst() then
    //         Recipient := WithdrawalDepartmentRec.GetUsersEmailid(WithdrawalDepartmentRec."Department Code");//CSPL-00307-T1-T1516-CR

    //     Recipients := Recipient.Split(';');
    //     SenderName := 'MEA';
    //     SenderAddress := SmtpMailRec."Email Address";
    //     Subject := (Format("Application No.") + ' ' + Format("Leave Types") + 'Leave Request:'
    //                 + ' ' + Format(StudentNo) + ',' + ' ' +
    //                 Format("Student Name") + ',' + ' ' + Format("Enrolment No.") + ',' + ' ' + Format(Semester));

    //     SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');

    //     SmtpMail.AppendtoBody('Dear' + ' ' + Format(WithdrawalDepartmentRec."Department Name") + ',');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('This notification is to confirm that Leave Request for' + ' ' +
    //                         Format(StudentNo) + ',' + ' ' + Format("Student Name") + ',' + ' ' + Format("Enrolment No.")
    //                         + ',' + ' ' + Format(Semester) + ' ' + 'has been approved by all departments. Please process the request further.');

    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('<br>');
    //     SmtpMail.AppendtoBody('Regards,');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody("Student Name" + ',' + ' ' + "Student No." + ',' + ' ' + Semester);
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('<br>');
    //     SmtpMail.AppendtoBody('This is system generated mail. Please do not reply on this E-mail id.');

    //     SmtpMail.AppendtoBody('<br>');
    //     //SmtpMail.AppendtoBody('THIS IS A TEST EMAIL FOR NEW SOFTWARE SYSTEM. PLEASE DISREGARD');
    //     BodyText := SmtpMail.GetBody();
    //     //Mail_lCU.Send();

    //     WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('Leave of Absence', 'MEA', SenderAddress, Format("Student Name"),
    //     "Student No.", Subject, BodyText, 'Leave of Absence', 'Leave', Format("Application No."), Format("Application Date"),
    //     SmtpMailRec."Email Address", 1, Studentmaster."Mobile Number", '', 1);

    // end;

    // procedure CLOARequestforApprovalMailtoStudent()
    // var
    //     SmtpMailRec: Record "Email Account";
    //     Studentmaster: Record "Student Master-CS";
    //     SemesterMaster_lRec: Record "Semester Master-CS";
    //     RosterLedgerEntry: Record "Roster Ledger Entry";
    //     SMTPMail: codeunit "Email Message";
    //     Mail_lCU: Codeunit Mail;
    //     WebServicesFunctionsCod: Codeunit WebServicesFunctionsCSL;
    //     BodyText: text[2048];
    //     SenderName: Text[100];
    //     SenderAddress: Text[250];
    //     Subject: Text[100];
    //     Recipients: List of [Text];
    //     Recipient: Text[100];
    // begin
    //     SmtpMailRec.Get();
    //     Studentmaster.GET(Rec."Student No.");
    //     Studentmaster.TESTFIELD(Studentmaster."E-Mail Address");
    //     Recipient := Studentmaster."E-Mail Address";
    //     Recipients := Recipient.Split(';');

    //     SenderName := 'MEA';
    //     SenderAddress := SmtpMailRec."Email Address";
    //     Subject := Rec."Application No." + ' CLOA : ' + Rec."Student Name" + ', ' + Rec."Student No." + ' ' + Rec.Semester;
    //     SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');
    //     SmtpMail.AppendtoBody('Dear ' + Studentmaster."First Name" + ', ');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Thank you for your submission. Your request has been received and recorded on ' + Format(Rec."Application Date") + ' and is under final review by the Dean of Student Affairs.<br><br>');
    //     SmtpMail.AppendtoBody('Typically, you’ll receive the final approval notification from the Office of the Registrar on your on your last date of attendance: ' + Format("Last Date Of Attendance") + ' or sooner if further requirements are necessary.<br><br>');
    //     SmtpMail.AppendtoBody('If you have any questions, please feel free to contact our office.');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Sincerely,<br>');
    //     SmtpMail.AppendtoBody('Office Of Registrar ');
    //     BodyText := SmtpMail.GetBody();
    //     Mail_lCU.Send();
    //     WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('CLOA Submission', 'MEA', SenderAddress, Studentmaster."Student Name",
    //                             Studentmaster."No.", Subject, BodyText, 'CLOA Submission', 'CLOA Submission', '', '',
    //                             Recipient, 1, Studentmaster."Mobile Number", '', 1);
    // end;
}