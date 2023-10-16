table 50478 "Student Group"
{
    Caption = 'Student Group';


    fields
    {
        field(1; "Student No."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Student Master-CS"."No.";
            Editable = false;
            trigger OnValidate();
            begin
                if StudentMasterRec.Get("Student No.") then begin
                    "Student Name" := StudentMasterRec."Student Name";
                    "Course Code" := StudentMasterRec."Course Code";
                    "Course Description" := StudentMasterRec."Course Name";
                    Semester := StudentMasterRec.Semester;
                    "Academic Year" := StudentMasterRec."Academic Year";
                    "Global Dimension 1 Code" := StudentMasterRec."Global Dimension 1 Code";
                    "Enrollment No." := StudentMasterRec."Enrollment No.";
                end else begin
                    "Student Name" := '';
                    "Course Code" := '';
                    "Course Description" := '';
                    Semester := '';
                    "Academic Year" := '';
                    "Global Dimension 1 Code" := '';
                    "Enrollment No." := '';
                end;
            end;
        }
        field(2; "Groups Code"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Group.code;
            Editable = false;
            trigger Onvalidate()
            var
                GroupRec: Record Group;
            begin
                if GroupRec.Get("Groups Code") then
                    Description := GroupRec.Description;
            end;
        }

        field(4; "Blocked"; Boolean)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(5; "Creation Date"; Date)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(6; "Created By"; Code[50])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(7; "Modified On"; Date)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(8; "Modified By"; Text[50])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(9; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS";
            Editable = false;
        }
        field(10; "Semester"; Code[10])
        {
            Caption = 'Semester';
            TableRelation = "Semester Master-CS";
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(11; "Term"; Option)
        {
            Caption = 'Term';
            DataClassification = CustomerContent;
            OptionCaption = 'FALL,SPRING,SUMMER';
            OptionMembers = FALL,SPRING,SUMMER;
            Editable = false;
        }
        field(12; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(13; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(14; "OLR Hold Group"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = exist("Student Hold" where("Group Code" = field("Groups Code"), "Hold Type" = filter(<> '')));
            Editable = false;
        }
        field(15; "Enrollment No."; Code[20])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(16; "Group Type"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = " ",Clinical,"Clinical Hold";
        }

        field(17; "Description"; Text[60])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(18; "Student Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(19; "Course Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(20; "Course Description"; Text[100])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(21; "Hold Exists"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = exist("Student Hold" where("Group Code" = field("Groups Code")));
            Editable = false;
        }
        field(22; "Blackboard Synch Status"; Option)
        {
            OptionMembers = " ",Pending,Completed,Error;
            OptionCaption = ' ,Pending,Completed,Error';
        }

    }

    keys
    {
        key(Key1; "Student No.", "Groups Code")
        {

        }
        key(Key2; "Creation Date")
        {

        }
    }


    trigger OnInsert()
    begin

        "Creation Date" := Today();
        "Created By" := Userid();
        "Modified On" := TODAY();
        "Modified By" := FORMAT(UserId());
        EnableDisableGroupCode(Rec, 1);
    end;

    trigger OnModify()
    begin
        "Modified On" := TODAY();
        "Modified By" := FORMAT(UserId());
    end;

    trigger OnDelete()
    begin
        EnableDisableGroupCode(Rec, 2);
    end;

    trigger OnRename()
    begin
        if Rec."Groups Code" <> xRec."Groups Code" then begin
            EnableDisableGroupCode(xRec, 2);
            EnableDisableGroupCode(Rec, 1);
        end;
    end;

    var
        StudentMasterRec: Record "Student Master-CS";

    procedure EnableDisableGroupCode(StuGroup: Record "Student Group"; EnableDis: Integer)
    var
        StudentGroupLedger: Record "Student Group Ledger";
        StudentGroupLedger1: Record "Student Group Ledger";
        StudentMaster: Record "Student Master-CS";
        LastNo: Integer;
    begin
        StudentMaster.Get(StuGroup."Student No.");
        StudentGroupLedger1.Reset();
        if StudentGroupLedger1.FINDLAST() then
            LastNo := StudentGroupLedger1."Entry No." + 1
        else
            LastNo := 1;

        StudentGroupLedger1.Init();
        StudentGroupLedger1."Entry No." := LastNo;
        StudentGroupLedger1.Validate("Student No.", StuGroup."Student No.");
        StudentGroupLedger1."Student Name" := StudentMaster."Student Name";
        StudentGroupLedger1."Academic Year" := StudentMaster."Academic Year";
        StudentGroupLedger1.Semester := StudentMaster.Semester;
        StudentGroupLedger1."Entry Date" := Today();
        StudentGroupLedger1."Entry Time" := Time();
        StudentGroupLedger1."Global Dimension 1 Code" := StudentMaster."Global Dimension 1 Code";
        StudentGroupLedger1."Global Dimension 2 Code" := StudentMaster."Global Dimension 2 Code";
        StudentGroupLedger1."User ID" := FORMAT(UserId());
        StudentGroupLedger1."Group Code" := StuGroup."Groups Code";
        StudentGroupLedger1."Group Type" := StuGroup."Group Type";
        if EnableDis = 1 then
            StudentGroupLedger1.Status := StudentGroupLedger.Status::Enable;
        if EnableDis = 2 then
            StudentGroupLedger1.Status := StudentGroupLedger.Status::Disable;
        StudentGroupLedger1.Insert();
    end;

    procedure EnableDisableGroupCodeHold(StuGroup: Record "Student Wise Holds"; EnableDis: Integer)
    var
        StudentGroupLedger: Record "Student Group Ledger";
        StudentGroupLedger1: Record "Student Group Ledger";
        StudentMaster: Record "Student Master-CS";
        StudentHold: Record "Student Hold";
        LGroup: Record Group;
        LastNo: Integer;
    begin
        StudentMaster.Get(StuGroup."Student No.");
        StudentHold.Get(StuGroup."Hold Code", StuGroup."Global Dimension 1 Code");

        LGroup.Reset();
        if LGroup.Get(StuGroup."Group Code") then;

        StudentGroupLedger.Reset();
        if StudentGroupLedger.FINDLAST() then
            LastNo := StudentGroupLedger."Entry No." + 1
        else
            LastNo := 1;

        StudentGroupLedger1.Init();
        StudentGroupLedger1."Entry No." := LastNo;
        StudentGroupLedger1.Validate("Student No.", StuGroup."Student No.");
        StudentGroupLedger1."Student Name" := StuGroup."Student Name";
        StudentGroupLedger1."Academic Year" := StuGroup."Academic Year";
        StudentGroupLedger1.Semester := StuGroup.Semester;
        StudentGroupLedger1."Entry Date" := Today();
        StudentGroupLedger1."Entry Time" := Time();
        StudentGroupLedger1."Global Dimension 1 Code" := StuGroup."Global Dimension 1 Code";
        StudentGroupLedger1."Global Dimension 2 Code" := StuGroup."Global Dimension 2 Code";
        StudentGroupLedger1."User ID" := FORMAT(UserId());
        StudentGroupLedger1."Group Code" := StudentHold."Group Code";
        StudentGroupLedger1."Group Type" := LGroup."Group Type";
        if EnableDis = 1 then
            StudentGroupLedger1.Status := StudentGroupLedger.Status::Enable;
        if EnableDis = 2 then
            StudentGroupLedger1.Status := StudentGroupLedger.Status::Disable;
        StudentGroupLedger1."Modified By" := UserId();
        StudentGroupLedger1."Modified On" := Today();
        StudentGroupLedger1.Insert();
    end;

    procedure EnableStudentGroupCodeHoldWise(StudWiseHold: Record "Student Wise Holds");
    var
        StudentHoldRec: Record "Student Hold";
        StudentGroup: Record "Student Group";
        StudentMasterRec1: Record "Student Master-CS";
        LGroup: Record Group;
    begin
        StudentHoldRec.Reset();
        StudentHoldRec.SetRange("Global Dimension 1 Code", StudWiseHold."Global Dimension 1 Code");
        StudentHoldRec.SetRange("Hold Code", StudWiseHold."Hold Code");
        StudentHoldRec.SetFilter(StudentHoldRec."Group Code", '%1', '');
        if StudentHoldRec.findfirst() then
            Error('Group must have value in Student Hold List');

        LGroup.Reset();
        if LGroup.Get(StudWiseHold."Group Code") then;

        StudentGroup.Reset();
        StudentGroup.SetRange("Student No.", StudWiseHold."Student No.");
        StudentGroup.SetRange(StudentGroup."Groups Code", StudWiseHold."Group Code");
        StudentGroup.SetRange("Global Dimension 1 Code", StudWiseHold."Global Dimension 1 Code");
        if not StudentGroup.findfirst() then begin
            StudentGroup.Init();
            StudentGroup.Validate("Student No.", StudWiseHold."Student No.");
            StudentGroup."Academic Year" := StudWiseHold."Academic Year";
            StudentGroup.Semester := StudWiseHold.Semester;
            StudentMasterRec1.Get(StudWiseHold."Student No.");
            StudentGroup.Term := StudentMasterRec1.Term;
            StudentGroup."Enrollment No." := StudentMasterRec1."Enrollment No.";
            StudentGroup.Validate("Groups Code", StudWiseHold."Group Code");
            StudentGroup."Created By" := FORMAT(UserId());
            StudentGroup."Creation Date" := Today();
            StudentGroup.Validate("Global Dimension 1 Code", StudWiseHold."Global Dimension 1 Code");
            StudentGroup."Group Type" := LGroup."Group Type";
            StudentGroup.Insert();
        end;
    end;

    procedure DeleteStudentGroupCodeHoldWise(StudWiseHold: Record "Student Wise Holds");
    var
        StudentHoldRec: Record "Student Hold";
        StudentGroup: Record "Student Group";
    begin

        StudentHoldRec.Get(StudWiseHold."Hold Code", StudWiseHold."Global Dimension 1 Code");
        StudentGroup.Reset();
        StudentGroup.SetRange("Student No.", StudWiseHold."Student No.");
        StudentGroup.SetRange("Groups Code", StudentHoldRec."Group Code");
        //StudentGroup.SetRange("Global Dimension 1 Code", StudWiseHold."Global Dimension 1 Code");
        If StudentGroup.FindFirst() then
            StudentGroup.Delete();
    end;

    procedure AddStudentGroupCodeHoldWise(StudWiseHold: Record "Student Wise Holds");
    var
        StudentHoldRec: Record "Student Hold";
        StudentGroup: Record "Student Group";
        StudentMasterRec1: Record "Student Master-CS";
        LGroup: Record Group;
    begin
        StudentMasterRec1.Get(StudWiseHold."Student No.");
        StudentHoldRec.Get(StudWiseHold."Hold Code", StudWiseHold."Global Dimension 1 Code");
        LGroup.Reset();
        if LGroup.Get(StudWiseHold."Group Code") then;

        StudentGroup.Reset();
        StudentGroup.SetRange("Student No.", StudWiseHold."Student No.");
        StudentGroup.SetRange(StudentGroup."Groups Code", StudentHoldRec."Group Code");
        // StudentGroup.SetRange("Global Dimension 1 Code", StudentHoldRec."Global Dimension 1 Code");
        if not StudentGroup.findfirst() then begin
            StudentGroup.Init();
            StudentGroup.Validate("Student No.", StudWiseHold."Student No.");
            StudentGroup."Academic Year" := StudWiseHold."Academic Year";
            StudentGroup.Semester := StudWiseHold.Semester;
            StudentMasterRec1.Get(StudWiseHold."Student No.");
            StudentGroup.Term := StudentMasterRec1.Term;
            StudentGroup."Enrollment No." := StudentMasterRec1."Enrollment No.";
            StudentGroup.Validate("Groups Code", StudentHoldRec."Group Code");
            StudentGroup."Created By" := FORMAT(UserId());
            StudentGroup."Creation Date" := Today();
            StudentGroup.Validate("Global Dimension 1 Code", StudWiseHold."Global Dimension 1 Code");
            StudentGroup."Group Type" := LGroup."Group Type";
            StudentGroup."Modified On" := Today();
            StudentGroup."Modified By" := UserId();
            StudentGroup.Insert();
        end else begin
            StudentGroup."Academic Year" := StudWiseHold."Academic Year";
            StudentGroup.Semester := StudWiseHold.Semester;
            StudentMasterRec1.Get(StudWiseHold."Student No.");
            StudentGroup.Term := StudentMasterRec1.Term;
            StudentGroup."Enrollment No." := StudentMasterRec1."Enrollment No.";
            //StudentGroup.Validate("Groups Code", StudentHoldRec."Group Code");
            StudentGroup."Created By" := FORMAT(UserId());
            StudentGroup."Creation Date" := Today();
            StudentGroup.Validate("Global Dimension 1 Code", StudWiseHold."Global Dimension 1 Code");
            StudentGroup."Group Type" := LGroup."Group Type";
            StudentGroup."Modified On" := Today();
            StudentGroup."Modified By" := UserId();
            StudentGroup.Modify();
        end;
    end;

    procedure AssignStudentGroup(StudGroup: Record "Student Group"; GroupCode: Code[20]);
    var
        StudentGroup: Record "Student Group";
        StudentGroup2: Record "Student Group";
        StudentMasterRec1: Record "Student Master-CS";
        StudentMaster_lRec: Record "Student Master-CS";
    begin

        StudentMasterRec1.Get(StudGroup."Student No.");
        StudentMaster_lRec.Reset();
        StudentMaster_lRec.SetRange("Original Student No.", StudentMasterRec1."Original Student No.");
        If StudentMaster_lRec.FindSet() then begin
            repeat
                StudentGroup.Reset();
                StudentGroup.SetRange("Student No.", StudentMaster_lRec."No.");
                StudentGroup.SetRange(StudentGroup."Groups Code", GroupCode);
                //StudentGroup.SetRange("Global Dimension 1 Code", StudentMasterRec1."Global Dimension 1 Code");
                if StudentGroup.findfirst() then begin
                    Error('You can not Assign Group %1, it already exists', GroupCode);
                end;
                StudentGroup2.Reset();
                StudentGroup2.SetRange("Student No.", StudentMaster_lRec."No.");
                StudentGroup2.SetRange("Groups Code", GroupCode);
                // StudentGroup.SetRange("Global Dimension 1 Code", StudentMasterRec1."Global Dimension 1 Code");
                if not StudentGroup2.findfirst() then begin
                    StudentGroup.Init();
                    StudentGroup."Academic Year" := StudentMaster_lRec."Academic Year";
                    StudentGroup.Validate("Student No.", StudentMaster_lRec."No.");
                    StudentGroup.Semester := StudentMaster_lRec.Semester;
                    StudentGroup.Term := StudentMaster_lRec.Term;
                    StudentGroup."Enrollment No." := StudentMaster_lRec."Enrollment No.";
                    StudentGroup.Validate("Groups Code", GroupCode);
                    StudentGroup."Created By" := FORMAT(UserId());
                    StudentGroup."Creation Date" := Today();
                    StudentGroup.Validate("Global Dimension 1 Code", StudentMaster_lRec."Global Dimension 1 Code");
                    StudentGroup."Group Type" := StudGroup."Group Type";
                    StudentGroup.Insert(true);
                end;
            until StudentMaster_lRec.Next() = 0;
        end;
    end;

    procedure UnassignStudentGroup(StudGroup: Record "Student Group"; GroupCode: Code[20]);
    var
        StudentGroup: Record "Student Group";
        StudentMaster_lRec: Record "Student Master-CS";
        StudentMaster_lRec1: Record "Student Master-CS";
    begin
        StudentMaster_lRec.Reset();
        StudentMaster_lRec.Get(StudGroup."Student No.");

        StudentMaster_lRec1.Reset();
        StudentMaster_lRec1.SetRange("Original Student No.", StudentMaster_lRec."Original Student No.");
        If StudentMaster_lRec1.FindSet() then begin
            repeat
                StudentGroup.Reset();
                StudentGroup.SetRange("Student No.", StudentMaster_lRec1."No.");
                StudentGroup.SetRange(StudentGroup."Groups Code", GroupCode);
                //StudentGroup.SetRange("Global Dimension 1 Code", StudentGroup."Global Dimension 1 Code");
                if StudentGroup.findfirst() then
                    StudentGroup.Delete(true)
                else
                    Error('You can not unassign any Group which is not yet already assigned');
            until StudentMaster_lRec1.Next() = 0;
        end;
    end;

    procedure AssignStudentWiseHold(StudGroup: Record "Student Group"; GroupCode: Code[20]);
    var
        StudentHoldRec: Record "Student Hold";
        StudentWiseHoldRec: Record "Student Wise Holds";
        RecHoldStatusLedger: Record "Hold Status Ledger";
        StudentRec: Record "Student Master-CS";
        StudentMaster_lRec: Record "Student Master-CS";
        LastNo: Integer;
    begin
        StudentRec.Get(StudGroup."Student No.");

        StudentMaster_lRec.Reset();
        StudentMaster_lRec.Setrange("Original Student No.", StudentRec."Original Student No.");
        If StudentMaster_lRec.FindSet() then begin
            repeat
                StudentHoldRec.Reset();
                StudentHoldRec.SetRange("Group Code", GroupCode);
                StudentHoldRec.SetRange("Global Dimension 1 Code", StudentMaster_lRec."Global Dimension 1 Code");
                if StudentHoldRec.findfirst() then begin
                    StudentWiseHoldRec.Reset();
                    StudentWiseHoldRec.SetRange("Student No.", StudentMaster_lRec."No.");
                    StudentWiseHoldRec.SetRange("Hold Code", StudentHoldRec."Hold Code");
                    StudentWiseHoldRec.SetRange("Global Dimension 1 Code", StudentMaster_lRec."Global Dimension 1 Code");
                    StudentWiseHoldRec.SetRange(Status, StudentWiseHoldRec.Status::Enable);
                    if StudentWiseHoldRec.findfirst() then begin
                        Error('There is already enable entry exist in Student Wise Hold');
                    end;
                end;

                StudentHoldRec.Reset();
                StudentHoldRec.SetRange("Group Code", GroupCode);
                StudentHoldRec.SetRange("Global Dimension 1 Code", StudentMaster_lRec."Global Dimension 1 Code");
                if StudentHoldRec.findfirst() then begin
                    StudentWiseHoldRec.Reset();
                    StudentWiseHoldRec.SetRange("Student No.", StudentMaster_lRec."No.");
                    StudentWiseHoldRec.SetRange("Hold Code", StudentHoldRec."Hold Code");
                    StudentWiseHoldRec.SetRange("Global Dimension 1 Code", StudentMaster_lRec."Global Dimension 1 Code");
                    StudentWiseHoldRec.SetRange(Status, StudentWiseHoldRec.Status::Disable);
                    if StudentWiseHoldRec.findfirst() then begin
                        StudentWiseHoldRec.Status := StudentWiseHoldRec.Status::Enable;
                        StudentWiseHoldRec.Modify();
                    end
                    else begin
                        StudentWiseHoldRec.Init();
                        StudentWiseHoldRec.Validate("Student No.", StudentMaster_lRec."No.");
                        StudentWiseHoldRec."Student Name" := StudentMaster_lRec."Student Name";
                        StudentWiseHoldRec."Academic Year" := StudentMaster_lRec."Academic Year";
                        StudentWiseHoldRec."Admitted Year" := StudentMaster_lRec."Admitted Year";
                        StudentWiseHoldRec.Semester := StudentMaster_lRec.Semester;

                        StudentWiseHoldRec.Status := StudentWiseHoldRec.Status::Enable;
                        StudentWiseHoldRec."Hold Code" := StudentHoldRec."Hold Code";
                        StudentWiseHoldRec."Hold Description" := StudentHoldRec."Hold Description";
                        StudentWiseHoldRec."Hold Type" := StudentHoldRec."Hold Type";
                        StudentWiseHoldRec."Potal Login Restriction" := StudentHoldRec."Potal Login Restriction";
                        StudentWiseHoldRec."Clinical Rotation" := StudentHoldRec."Clinical Rotation";
                        StudentWiseHoldRec."Transcript Print" := StudentHoldRec."Transcript Print";
                        StudentWiseHoldRec.Progression := StudentHoldRec.Progression;
                        StudentWiseHoldRec.Billing := StudentHoldRec.Billing;
                        StudentWiseHoldRec."Sign-off" := StudentHoldRec."Sign-off";
                        StudentWiseHoldRec.Validate("Global Dimension 1 Code", StudentMaster_lRec."Global Dimension 1 Code");
                        StudentWiseHoldRec.Insert();
                    end;
                    RecHoldStatusLedger.Reset();
                    if RecHoldStatusLedger.FINDLAST() then
                        LastNo := RecHoldStatusLedger."Entry No." + 1
                    else
                        LastNo := 1;

                    RecHoldStatusLedger.Init();
                    RecHoldStatusLedger."Entry No." := LastNo;
                    RecHoldStatusLedger.Validate("Student No.", StudentMaster_lRec."No.");
                    RecHoldStatusLedger."Student Name" := StudentMaster_lRec."Student Name";
                    RecHoldStatusLedger."Academic Year" := StudentMaster_lRec."Academic Year";
                    RecHoldStatusLedger."Admitted Year" := StudentMaster_lRec."Admitted Year";
                    RecHoldStatusLedger.Semester := StudentMaster_lRec.Semester;
                    RecHoldStatusLedger."Entry Date" := Today();
                    RecHoldStatusLedger."Entry Time" := Time();
                    RecHoldStatusLedger."Global Dimension 1 Code" := StudentMaster_lRec."Global Dimension 1 Code";
                    RecHoldStatusLedger."Global Dimension 2 Code" := StudentMaster_lRec."Global Dimension 2 Code";
                    RecHoldStatusLedger."User ID" := FORMAT(UserId());
                    RecHoldStatusLedger."Hold Code" := StudentWiseHoldRec."Hold Code";
                    RecHoldStatusLedger."Hold Description" := StudentWiseHoldRec."Hold Description";
                    RecHoldStatusLedger."Hold Type" := StudentHoldRec."Hold Type";
                    RecHoldStatusLedger.Status := StudentWiseHoldRec.Status::Enable;
                    RecHoldStatusLedger.Insert();
                end;
            until StudentMaster_lRec.Next() = 0;
        end;

    end;

    procedure UnassignStudentWiseHold(StudGroup: Record "Student Group"; GroupCode: Code[20]);
    var
        StudentHoldRec: Record "Student Hold";
        StudentWiseHoldRec: Record "Student Wise Holds";
        RecHoldStatusLedger: Record "Hold Status Ledger";
        StudentRec: Record "Student Master-CS";
        StudentMaster_lRec: Record "Student Master-CS";
        RSL: Record "Roster Scheduling Line";
        LastNo: Integer;
    begin
        StudentRec.Get(StudGroup."Student No.");

        StudentMaster_lRec.Reset();
        StudentMaster_lRec.SetRange("Original Student No.", StudentRec."Original Student No.");
        IF StudentMaster_lRec.FindSet() then begin
            repeat
                StudentHoldRec.Reset();
                StudentHoldRec.SetRange("Group Code", GroupCode);
                StudentHoldRec.SetRange("Global Dimension 1 Code", StudentMaster_lRec."Global Dimension 1 Code");
                if StudentHoldRec.findfirst() then begin
                    StudentWiseHoldRec.Reset();
                    StudentWiseHoldRec.SetRange("Student No.", StudentMaster_lRec."No.");
                    StudentWiseHoldRec.SetRange("Hold Code", StudentHoldRec."Hold Code");
                    StudentWiseHoldRec.SetRange("Global Dimension 1 Code", StudentMaster_lRec."Global Dimension 1 Code");
                    StudentWiseHoldRec.SetRange(Status, StudentWiseHoldRec.Status::Disable);
                    if StudentWiseHoldRec.findfirst() then
                        Error('You can not unassign any Group which is already disable in Student Wise Hold');

                end;


                StudentHoldRec.Reset();
                StudentHoldRec.SetRange("Group Code", GroupCode);
                StudentHoldRec.SetRange("Global Dimension 1 Code", StudentMaster_lRec."Global Dimension 1 Code");
                if StudentHoldRec.findfirst() then begin
                    StudentWiseHoldRec.Reset();
                    StudentWiseHoldRec.SetRange("Student No.", StudentMaster_lRec."No.");
                    StudentWiseHoldRec.SetRange("Hold Code", StudentHoldRec."Hold Code");
                    StudentWiseHoldRec.SetRange("Global Dimension 1 Code", StudentMaster_lRec."Global Dimension 1 Code");
                    StudentWiseHoldRec.SetRange(Status, StudentWiseHoldRec.Status::Enable);
                    if StudentWiseHoldRec.findfirst() then begin
                        // StudentWiseHoldRec.Status := StudentWiseHoldRec.Status::Disable;
                        // StudentWiseHoldRec.Modify();
                        // Changed to Delete, code is in the last


                        RecHoldStatusLedger.Reset();
                        if RecHoldStatusLedger.FINDLAST() then
                            LastNo := RecHoldStatusLedger."Entry No." + 1
                        else
                            LastNo := 1;

                        RecHoldStatusLedger.Init();
                        RecHoldStatusLedger."Entry No." := LastNo;
                        RecHoldStatusLedger.Validate("Student No.", StudentMaster_lRec."No.");
                        RecHoldStatusLedger."Student Name" := StudentMaster_lRec."Student Name";
                        RecHoldStatusLedger."Academic Year" := StudentMaster_lRec."Academic Year";
                        RecHoldStatusLedger."Admitted Year" := StudentMaster_lRec."Admitted Year";
                        RecHoldStatusLedger.Semester := StudentMaster_lRec.Semester;
                        RecHoldStatusLedger."Entry Date" := Today();
                        RecHoldStatusLedger."Entry Time" := Time();
                        RecHoldStatusLedger."Global Dimension 1 Code" := StudentMaster_lRec."Global Dimension 1 Code";
                        RecHoldStatusLedger."Global Dimension 2 Code" := StudentMaster_lRec."Global Dimension 2 Code";
                        RecHoldStatusLedger."User ID" := FORMAT(UserId());
                        RecHoldStatusLedger."Hold Code" := StudentWiseHoldRec."Hold Code";
                        RecHoldStatusLedger."Hold Description" := StudentWiseHoldRec."Hold Description";
                        RecHoldStatusLedger."Hold Type" := StudentHoldRec."Hold Type";
                        RecHoldStatusLedger.Status := StudentWiseHoldRec.Status::Disable;
                        RecHoldStatusLedger.Insert();

                        StudentWiseHoldRec.Delete();
                    end
                    else
                        Error('Group Code %1 is not enabled in Student Wise Hold', GroupCode);
                end;
                RSL.AutoPublishedRotation_On_CLN_Hold_Removed(StudentMaster_lRec);//CSPL-00307-RTP
            until StudentMaster_lRec.Next() = 0;
        end;
    end;

    procedure EnableStudentGroupCode(RecStudent: Record "Student Master-CS");
    var
        StudentHoldRec: Record "Student Hold";
        StudentGroup: Record "Student Group";
        StudentGroupLedger: Record "Student Group Ledger";
        StudentGroupLedger1: Record "Student Group Ledger";
        LGroup: Record Group;
        LastNo: Integer;
    begin
        // StudentHoldRec.Reset();
        // StudentHoldRec.SetRange("Global Dimension 1 Code", RecStudent."Global Dimension 1 Code");
        // StudentHoldRec.SetFilter(StudentHoldRec."Group Code", '%1', '');
        // if StudentHoldRec.findfirst() then
        //     Error('Group must have value in Student Hold List');

        StudentHoldRec.Reset();
        StudentHoldRec.SetRange("Global Dimension 1 Code", RecStudent."Global Dimension 1 Code");
        //StudentHoldRec.SetFilter(StudentHoldRec."Hold Type", '<>%1&<>%2&<>%3&<>%4', StudentHoldRec."Hold Type"::Registrar, StudentHoldRec."Hold Type"::"Registrar Sign-off", StudentHoldRec."Hold Type"::Immigration, StudentHoldRec."Hold Type"::" ");
        // StudentHoldRec.SetFilter(StudentHoldRec."Hold Type", '%1|%2',
        // StudentHoldRec."Hold Type"::Housing, StudentHoldRec."Hold Type"::"Financial Aid");
        StudentHoldRec.SetRange("Hold Type", StudentHoldRec."Hold Type"::"Financial Aid");      //FALL 2023 OLR Changes
        if StudentHoldRec.findSet() then
            repeat
                LGroup.Reset();
                if LGroup.Get(StudentHoldRec."Group Code") then begin
                    StudentGroup.Reset();
                    StudentGroup.SetRange("Student No.", RecStudent."No.");
                    StudentGroup.SetRange("Groups Code", StudentHoldRec."Group Code");
                    //StudentGroup.SetRange("Global Dimension 1 Code", RecStudent."Global Dimension 1 Code");
                    if not StudentGroup.findfirst() then begin
                        StudentGroup.Init();
                        StudentGroup.Validate("Student No.", RecStudent."No.");
                        StudentGroup."Academic Year" := RecStudent."Academic Year";
                        StudentGroup.Semester := RecStudent.Semester;
                        //StudentMasterRec1.Get(StudWiseHold."Student No.");
                        StudentGroup.Term := RecStudent.Term;
                        StudentGroup."Enrollment No." := RecStudent."Enrollment No.";
                        StudentGroup.Validate("Groups Code", StudentHoldRec."Group Code");
                        StudentGroup."Created By" := FORMAT(UserId());
                        StudentGroup."Creation Date" := Today();
                        StudentGroup.Validate("Global Dimension 1 Code", RecStudent."Global Dimension 1 Code");
                        StudentGroup."Group Type" := LGroup."Group Type";
                        StudentGroup.Insert();


                        StudentGroupLedger.Reset();
                        if StudentGroupLedger.FINDLAST() then
                            LastNo := StudentGroupLedger."Entry No." + 1
                        else
                            LastNo := 1;

                        StudentGroupLedger1.Init();
                        StudentGroupLedger1."Entry No." := LastNo;
                        StudentGroupLedger1.Validate("Student No.", RecStudent."No.");
                        StudentGroupLedger1."Student Name" := RecStudent."Student Name";
                        StudentGroupLedger1."Academic Year" := RecStudent."Academic Year";
                        StudentGroupLedger1.Semester := RecStudent.Semester;
                        StudentGroupLedger1."Entry Date" := Today();
                        StudentGroupLedger1."Entry Time" := Time();
                        StudentGroupLedger1."Global Dimension 1 Code" := RecStudent."Global Dimension 1 Code";
                        StudentGroupLedger1."Global Dimension 2 Code" := RecStudent."Global Dimension 2 Code";
                        StudentGroupLedger1."User ID" := FORMAT(UserId());
                        StudentGroupLedger1."Group Code" := StudentHoldRec."Group Code";
                        StudentGroupLedger1."Group Type" := LGroup."Group Type";
                        StudentGroupLedger1.Status := StudentGroupLedger.Status::Enable;
                        StudentGroupLedger1.Insert();
                    end;
                end;
            Until StudentHoldRec.NEXT() = 0;
    end;

    procedure EnableStudentGroupCodeExistingStudent(RecStudent: Record "Student Master-CS"; HoldType: option " ",Housing,"Financial Aid",Bursar,Registrar,"Registrar Sign-off",Immigration,Clinical,"OLR Finance");
    var
        StudentHoldRec: Record "Student Hold";
        StudentGroup: Record "Student Group";
        StudentGroupLedger: Record "Student Group Ledger";
        StudentGroupLedger1: Record "Student Group Ledger";
        StudentStatusMgmt: Codeunit "Student Status Mangement";
        LGroup: Record Group;
        LastNo: Integer;
    begin
        // StudentHoldRec.Reset();
        // StudentHoldRec.SetRange("Global Dimension 1 Code", RecStudent."Global Dimension 1 Code");
        // StudentHoldRec.SetFilter(StudentHoldRec."Group Code", '%1', '');
        // if StudentHoldRec.findfirst() then
        //     Error('Group must have value in Student Hold List');

        // StudentStatusMgmt.EnableAllHoldOLR(RecStudent, HoldType);

        StudentHoldRec.Reset();
        StudentHoldRec.SetRange("Global Dimension 1 Code", RecStudent."Global Dimension 1 Code");
        //StudentHoldRec.SetFilter(StudentHoldRec."Hold Type", '<>%1&<>%2&<>%3&<>%4', StudentHoldRec."Hold Type"::Registrar, StudentHoldRec."Hold Type"::"Registrar Sign-off", StudentHoldRec."Hold Type"::Immigration, StudentHoldRec."Hold Type"::" ");
        StudentHoldRec.SetRange(StudentHoldRec."Hold Type", HoldType);
        IF StudentHoldRec.FindFirst() then begin
            LGroup.Reset();
            if LGroup.Get(StudentHoldRec."Group Code") then;
            StudentGroup.Reset();
            StudentGroup.SetRange("Student No.", RecStudent."No.");
            StudentGroup.SetRange("Groups Code", StudentHoldRec."Group Code");
            StudentGroup.SetRange("Global Dimension 1 Code", RecStudent."Global Dimension 1 Code");
            if not StudentGroup.findfirst() then begin
                StudentGroup.Init();
                StudentGroup.Validate("Student No.", RecStudent."No.");
                StudentGroup."Academic Year" := RecStudent."Academic Year";
                StudentGroup.Semester := RecStudent.Semester;
                //StudentMasterRec1.Get(StudWiseHold."Student No.");
                StudentGroup.Term := RecStudent.Term;
                StudentGroup."Enrollment No." := RecStudent."Enrollment No.";
                StudentGroup.Validate("Groups Code", StudentHoldRec."Group Code");
                StudentGroup."Created By" := FORMAT(UserId());
                StudentGroup."Creation Date" := Today();
                StudentGroup.Validate("Global Dimension 1 Code", RecStudent."Global Dimension 1 Code");
                StudentGroup."Group Type" := LGroup."Group Type";
                StudentGroup.Insert();
            end;

            StudentGroupLedger.Reset();
            if StudentGroupLedger.FINDLAST() then
                LastNo := StudentGroupLedger."Entry No." + 1
            else
                LastNo := 1;

            StudentGroupLedger1.Init();
            StudentGroupLedger1."Entry No." := LastNo;
            StudentGroupLedger1.Validate("Student No.", RecStudent."No.");
            StudentGroupLedger1."Student Name" := RecStudent."Student Name";
            StudentGroupLedger1."Academic Year" := RecStudent."Academic Year";
            StudentGroupLedger1.Semester := RecStudent.Semester;
            StudentGroupLedger1."Entry Date" := Today();
            StudentGroupLedger1."Entry Time" := Time();
            StudentGroupLedger1."Global Dimension 1 Code" := RecStudent."Global Dimension 1 Code";
            StudentGroupLedger1."Global Dimension 2 Code" := RecStudent."Global Dimension 2 Code";
            StudentGroupLedger1."User ID" := FORMAT(UserId());
            StudentGroupLedger1."Group Code" := StudentHoldRec."Group Code";
            StudentGroupLedger1."Group Type" := LGroup."Group Type";
            StudentGroupLedger1.Status := StudentGroupLedger.Status::Enable;
            StudentGroupLedger1.Insert();
        end;
    end;

    //Shivam 19032021+
    procedure AssignStudentGroupNew(StudGroup: Record "Temp Record"; GroupCode: Code[20]);
    var
        StudentGroup: Record "Student Group";
        StudentGroup2: Record "Student Group";
        StudentMasterRec1: Record "Student Master-CS";
        StudentMaster_lRec: Record "Student Master-CS";
    begin

        StudentMasterRec1.Get(StudGroup.Field6);
        /*
        StudentGroup.Reset();
        StudentGroup.SetRange("Student No.", StudGroup.Field6);
        StudentGroup.SetRange(StudentGroup."Groups Code", GroupCode);
        //StudentGroup.SetRange("Global Dimension 1 Code", StudentMasterRec1."Global Dimension 1 Code");
        if StudentGroup.findfirst() then begin
            Error('You can not Assign Group %1, it already exists', GroupCode);
        end;
        */

        StudentMaster_lRec.Reset();
        StudentMaster_lRec.SetRange("Original Student No.", StudentMasterRec1."Original Student No.");
        IF StudentMaster_lRec.FindSet() then begin
            repeat
                StudentGroup2.Reset();
                StudentGroup2.SetRange("Student No.", StudentMaster_lRec."No.");
                StudentGroup2.SetRange("Groups Code", GroupCode);
                // StudentGroup.SetRange("Global Dimension 1 Code", StudentMasterRec1."Global Dimension 1 Code");
                if not StudentGroup2.findfirst() then begin
                    StudentGroup.Init();
                    StudentGroup.Validate("Student No.", StudentMaster_lRec."No.");
                    StudentGroup."Academic Year" := StudentMaster_lRec."Academic Year";
                    StudentGroup.Semester := StudentMaster_lRec.Semester;
                    StudentGroup.Term := StudentMaster_lRec.Term;
                    StudentGroup."Enrollment No." := StudentMaster_lRec."Enrollment No.";
                    StudentGroup.Validate("Groups Code", GroupCode);
                    StudentGroup."Created By" := FORMAT(UserId());
                    StudentGroup."Creation Date" := Today();
                    StudentGroup.Validate("Global Dimension 1 Code", StudentMaster_lRec."Global Dimension 1 Code");
                    StudentGroup."Group Type" := StudentGroup."Group Type"::Clinical;
                    StudentGroup.Insert(true);
                end;
            until StudentMaster_lRec.Next() = 0;
        end;
    end;

    procedure UnassignStudentGroupNew(StudGroup: Record "Temp Record"; GroupCode: Code[20]);
    var
        StudentGroup: Record "Student Group";
        StudentMaster_lRec: Record "Student Master-CS";
        StudentMaster_lRec1: Record "Student Master-CS";
    begin
        StudentMaster_lRec.Reset();
        StudentMaster_lRec.Get(StudGroup.Field6);

        StudentMaster_lRec1.Reset();
        StudentMaster_lRec1.SetRange("Original Student No.", StudentMaster_lRec."Original Student No.");
        IF StudentMaster_lRec1.FindSet() then begin
            repeat
                StudentGroup.Reset();
                StudentGroup.SetRange("Student No.", StudentMaster_lRec1."No.");
                StudentGroup.SetRange(StudentGroup."Groups Code", GroupCode);
                //StudentGroup.SetRange("Global Dimension 1 Code", StudentGroup."Global Dimension 1 Code");
                if StudentGroup.findfirst() then begin
                    StudentGroup.Delete(true)
                end;
            until StudentMaster_lRec1.Next() = 0;
        end;
    end;

    procedure AssignStudentWiseHoldNew(StudGroup: Record "Temp Record"; GroupCode: Code[20]);
    var
        StudentHoldRec: Record "Student Hold";
        StudentWiseHoldRec: Record "Student Wise Holds";
        RecHoldStatusLedger: Record "Hold Status Ledger";
        StudentRec: Record "Student Master-CS";
        StudentMaster_lRec: Record "Student Master-CS";
        LastNo: Integer;
    begin
        StudentRec.Get(StudGroup.Field6);
        /*
        StudentHoldRec.Reset();
        StudentHoldRec.SetRange("Group Code", GroupCode);
        StudentHoldRec.SetRange("Global Dimension 1 Code", StudentRec."Global Dimension 1 Code");
        if StudentHoldRec.findfirst() then begin
            StudentWiseHoldRec.Reset();
            StudentWiseHoldRec.SetRange("Student No.", StudentRec."No.");
            StudentWiseHoldRec.SetRange("Hold Code", StudentHoldRec."Hold Code");
            StudentWiseHoldRec.SetRange("Global Dimension 1 Code", StudentRec."Global Dimension 1 Code");
            StudentWiseHoldRec.SetRange(Status, StudentWiseHoldRec.Status::Enable);
            if StudentWiseHoldRec.findfirst() then begin
                Error('There is already enable entry exist in Student Wise Hold');
            end;
        end;
        */
        StudentMaster_lRec.Reset();
        StudentMaster_lRec.SetRange("Original Student No.", StudentRec."Original Student No.");
        IF StudentMaster_lRec.FindSet() then Begin
            repeat
                StudentHoldRec.Reset();
                StudentHoldRec.SetRange("Group Code", GroupCode);
                StudentHoldRec.SetRange("Global Dimension 1 Code", StudentMaster_lRec."Global Dimension 1 Code");
                if StudentHoldRec.findfirst() then begin
                    StudentWiseHoldRec.Reset();
                    StudentWiseHoldRec.SetRange("Student No.", StudentMaster_lRec."No.");
                    StudentWiseHoldRec.SetRange("Hold Code", StudentHoldRec."Hold Code");
                    StudentWiseHoldRec.SetRange("Global Dimension 1 Code", StudentMaster_lRec."Global Dimension 1 Code");
                    StudentWiseHoldRec.SetRange(Status, StudentWiseHoldRec.Status::Disable);
                    if StudentWiseHoldRec.findfirst() then begin
                        StudentWiseHoldRec.Status := StudentWiseHoldRec.Status::Enable;
                        StudentWiseHoldRec.Modify();
                    end
                    else begin
                        StudentWiseHoldRec.Init();
                        StudentWiseHoldRec.Validate("Student No.", StudentMaster_lRec."No.");
                        StudentWiseHoldRec."Student Name" := StudentMaster_lRec."Student Name";
                        StudentWiseHoldRec."Academic Year" := StudentMaster_lRec."Academic Year";
                        StudentWiseHoldRec."Admitted Year" := StudentMaster_lRec."Admitted Year";
                        StudentWiseHoldRec.Semester := StudentMaster_lRec.Semester;

                        StudentWiseHoldRec.Status := StudentWiseHoldRec.Status::Enable;
                        StudentWiseHoldRec."Hold Code" := StudentHoldRec."Hold Code";
                        StudentWiseHoldRec."Hold Description" := StudentHoldRec."Hold Description";
                        StudentWiseHoldRec."Hold Type" := StudentHoldRec."Hold Type";
                        StudentWiseHoldRec."Potal Login Restriction" := StudentHoldRec."Potal Login Restriction";
                        StudentWiseHoldRec."Clinical Rotation" := StudentHoldRec."Clinical Rotation";
                        StudentWiseHoldRec."Transcript Print" := StudentHoldRec."Transcript Print";
                        StudentWiseHoldRec.Progression := StudentHoldRec.Progression;
                        StudentWiseHoldRec.Billing := StudentHoldRec.Billing;
                        StudentWiseHoldRec."Sign-off" := StudentHoldRec."Sign-off";
                        StudentWiseHoldRec.Validate("Global Dimension 1 Code", StudentMaster_lRec."Global Dimension 1 Code");
                        StudentWiseHoldRec.Insert();
                    end;
                    RecHoldStatusLedger.Reset();
                    if RecHoldStatusLedger.FINDLAST() then
                        LastNo := RecHoldStatusLedger."Entry No." + 1
                    else
                        LastNo := 1;

                    RecHoldStatusLedger.Init();
                    RecHoldStatusLedger."Entry No." := LastNo;
                    RecHoldStatusLedger.Validate("Student No.", StudentMaster_lRec."No.");
                    RecHoldStatusLedger."Student Name" := StudentMaster_lRec."Student Name";
                    RecHoldStatusLedger."Academic Year" := StudentMaster_lRec."Academic Year";
                    RecHoldStatusLedger."Admitted Year" := StudentMaster_lRec."Admitted Year";
                    RecHoldStatusLedger.Semester := StudentMaster_lRec.Semester;
                    RecHoldStatusLedger."Entry Date" := Today();
                    RecHoldStatusLedger."Entry Time" := Time();
                    RecHoldStatusLedger."Global Dimension 1 Code" := StudentMaster_lRec."Global Dimension 1 Code";
                    RecHoldStatusLedger."Global Dimension 2 Code" := StudentMaster_lRec."Global Dimension 2 Code";
                    RecHoldStatusLedger."User ID" := FORMAT(UserId());
                    RecHoldStatusLedger."Hold Code" := StudentWiseHoldRec."Hold Code";
                    RecHoldStatusLedger."Hold Description" := StudentWiseHoldRec."Hold Description";
                    RecHoldStatusLedger."Hold Type" := StudentHoldRec."Hold Type";
                    RecHoldStatusLedger.Status := StudentWiseHoldRec.Status::Enable;
                    RecHoldStatusLedger.Insert();
                end;
            until StudentMaster_lRec.Next() = 0;
        end;

    end;

    procedure UnassignStudentWiseHoldNew(StudGroup: Record "Temp Record"; GroupCode: Code[20]);
    var
        StudentHoldRec: Record "Student Hold";
        StudentWiseHoldRec: Record "Student Wise Holds";
        RecHoldStatusLedger: Record "Hold Status Ledger";
        StudentRec: Record "Student Master-CS";
        StudentMaster_lRec: Record "Student Master-CS";
        LastNo: Integer;
    begin
        StudentRec.Get(StudGroup.Field6);
        /*
        StudentHoldRec.Reset();
        StudentHoldRec.SetRange("Group Code", GroupCode);
        StudentHoldRec.SetRange("Global Dimension 1 Code", StudentRec."Global Dimension 1 Code");
        if StudentHoldRec.findfirst() then begin
            StudentWiseHoldRec.Reset();
            StudentWiseHoldRec.SetRange("Student No.", StudentRec."No.");
            StudentWiseHoldRec.SetRange("Hold Code", StudentHoldRec."Hold Code");
            StudentWiseHoldRec.SetRange("Global Dimension 1 Code", StudentRec."Global Dimension 1 Code");
            StudentWiseHoldRec.SetRange(Status, StudentWiseHoldRec.Status::Disable);
            if StudentWiseHoldRec.findfirst() then
                Error('You can not unassign any Group which is already disable in Student Wise Hold');

        end;
        */
        StudentMaster_lRec.Reset();
        StudentMaster_lRec.SetRange("Original Student No.", StudentRec."Original Student No.");
        If StudentMaster_lRec.FindSet() then begin
            repeat

                StudentHoldRec.Reset();
                StudentHoldRec.SetRange("Group Code", GroupCode);
                StudentHoldRec.SetRange("Global Dimension 1 Code", StudentMaster_lRec."Global Dimension 1 Code");
                if StudentHoldRec.findfirst() then begin
                    StudentWiseHoldRec.Reset();
                    StudentWiseHoldRec.SetRange("Student No.", StudentMaster_lRec."No.");
                    StudentWiseHoldRec.SetRange("Hold Code", StudentHoldRec."Hold Code");
                    StudentWiseHoldRec.SetRange("Global Dimension 1 Code", StudentMaster_lRec."Global Dimension 1 Code");
                    StudentWiseHoldRec.SetRange(Status, StudentWiseHoldRec.Status::Enable);
                    if StudentWiseHoldRec.findfirst() then begin
                        //StudentWiseHoldRec.Status := StudentWiseHoldRec.Status::Disable;
                        //StudentWiseHoldRec.Modify();
                        // Changed to Delete, code is in the last


                        RecHoldStatusLedger.Reset();
                        if RecHoldStatusLedger.FINDLAST() then
                            LastNo := RecHoldStatusLedger."Entry No." + 1
                        else
                            LastNo := 1;

                        RecHoldStatusLedger.Init();
                        RecHoldStatusLedger."Entry No." := LastNo;
                        RecHoldStatusLedger.Validate("Student No.", StudentMaster_lRec."No.");
                        RecHoldStatusLedger."Student Name" := StudentMaster_lRec."Student Name";
                        RecHoldStatusLedger."Academic Year" := StudentMaster_lRec."Academic Year";
                        RecHoldStatusLedger."Admitted Year" := StudentMaster_lRec."Admitted Year";
                        RecHoldStatusLedger.Semester := StudentMaster_lRec.Semester;
                        RecHoldStatusLedger."Entry Date" := Today();
                        RecHoldStatusLedger."Entry Time" := Time();
                        RecHoldStatusLedger."Global Dimension 1 Code" := StudentMaster_lRec."Global Dimension 1 Code";
                        RecHoldStatusLedger."Global Dimension 2 Code" := StudentMaster_lRec."Global Dimension 2 Code";
                        RecHoldStatusLedger."User ID" := FORMAT(UserId());
                        RecHoldStatusLedger."Hold Code" := StudentWiseHoldRec."Hold Code";
                        RecHoldStatusLedger."Hold Description" := StudentWiseHoldRec."Hold Description";
                        RecHoldStatusLedger."Hold Type" := StudentHoldRec."Hold Type";
                        RecHoldStatusLedger.Status := StudentWiseHoldRec.Status::Disable;
                        RecHoldStatusLedger.Insert();

                        StudentWiseHoldRec.Delete();
                    end;

                end;
            until StudentMaster_lRec.Next() = 0;
        end;
    end;

    procedure EnableStudentConditionalregistrationGroupCode(RecStudent: Record "Student Master-CS"; GroupCode: Code[20]);
    var
        StudentGroup: Record "Student Group";
        StudentGroupLedger: Record "Student Group Ledger";
        StudentGroupLedger1: Record "Student Group Ledger";
        LGroup: Record Group;
        StudentHoldRec: Record "Student Hold";
        StudentWiseHoldRec: Record "Student Wise Holds";
        RecHoldStatusLedger: Record "Hold Status Ledger";
        LastNo: Integer;
        LastNo1: Integer;
    begin
        LGroup.Get(GroupCode);
        StudentGroup.Reset();
        StudentGroup.SetRange("Student No.", RecStudent."No.");
        StudentGroup.SetRange("Groups Code", GroupCode);
        StudentGroup.SetRange("Global Dimension 1 Code", RecStudent."Global Dimension 1 Code");
        if not StudentGroup.findfirst() then begin
            StudentGroup.Init();
            StudentGroup.Validate("Student No.", RecStudent."No.");
            StudentGroup."Academic Year" := RecStudent."Academic Year";
            StudentGroup.Semester := RecStudent.Semester;
            StudentGroup.Term := RecStudent.Term;
            StudentGroup."Enrollment No." := RecStudent."Enrollment No.";
            StudentGroup.Validate("Groups Code", GroupCode);
            StudentGroup."Created By" := FORMAT(UserId());
            StudentGroup."Creation Date" := Today();
            StudentGroup.Validate("Global Dimension 1 Code", RecStudent."Global Dimension 1 Code");
            StudentGroup."Group Type" := LGroup."Group Type";
            StudentGroup.Insert();
        end;

        StudentGroupLedger.Reset();
        if StudentGroupLedger.FINDLAST() then
            LastNo := StudentGroupLedger."Entry No." + 1
        else
            LastNo := 1;

        StudentGroupLedger1.Init();
        StudentGroupLedger1."Entry No." := LastNo;
        StudentGroupLedger1.Validate("Student No.", RecStudent."No.");
        StudentGroupLedger1."Student Name" := RecStudent."Student Name";
        StudentGroupLedger1."Academic Year" := RecStudent."Academic Year";
        StudentGroupLedger1.Semester := RecStudent.Semester;
        StudentGroupLedger1."Entry Date" := Today();
        StudentGroupLedger1."Entry Time" := Time();
        StudentGroupLedger1."Global Dimension 1 Code" := RecStudent."Global Dimension 1 Code";
        StudentGroupLedger1."Global Dimension 2 Code" := RecStudent."Global Dimension 2 Code";
        StudentGroupLedger1."User ID" := FORMAT(UserId());
        StudentGroupLedger1."Group Code" := GroupCode;
        StudentGroupLedger1."Group Type" := LGroup."Group Type";
        StudentGroupLedger1.Status := StudentGroupLedger.Status::Enable;
        StudentGroupLedger1.Insert();

        StudentHoldRec.Reset();
        StudentHoldRec.SetRange("Group Code", GroupCode);
        StudentHoldRec.SetRange("Global Dimension 1 Code", RecStudent."Global Dimension 1 Code");
        if StudentHoldRec.findfirst() then begin
            StudentWiseHoldRec.Reset();
            StudentWiseHoldRec.SetRange("Student No.", RecStudent."No.");
            StudentWiseHoldRec.SetRange("Hold Code", StudentHoldRec."Hold Code");
            StudentWiseHoldRec.SetRange("Global Dimension 1 Code", RecStudent."Global Dimension 1 Code");
            StudentWiseHoldRec.SetRange(Status, StudentWiseHoldRec.Status::Enable);
            if StudentWiseHoldRec.findfirst() then begin
                Error('There is already enable entry exist in Student Wise Hold');
            end;
        end;

        StudentHoldRec.Reset();
        StudentHoldRec.SetRange("Group Code", GroupCode);
        StudentHoldRec.SetRange("Global Dimension 1 Code", RecStudent."Global Dimension 1 Code");
        if StudentHoldRec.findfirst() then begin
            StudentWiseHoldRec.Reset();
            StudentWiseHoldRec.SetRange("Student No.", RecStudent."No.");
            StudentWiseHoldRec.SetRange("Hold Code", StudentHoldRec."Hold Code");
            StudentWiseHoldRec.SetRange("Global Dimension 1 Code", RecStudent."Global Dimension 1 Code");
            StudentWiseHoldRec.SetRange(Status, StudentWiseHoldRec.Status::Disable);
            if StudentWiseHoldRec.findfirst() then begin
                StudentWiseHoldRec.Status := StudentWiseHoldRec.Status::Enable;
                StudentWiseHoldRec.Modify();
            end
            else begin
                StudentWiseHoldRec.Init();
                StudentWiseHoldRec.Validate("Student No.", RecStudent."No.");
                StudentWiseHoldRec."Student Name" := RecStudent."Student Name";
                StudentWiseHoldRec."Academic Year" := RecStudent."Academic Year";
                StudentWiseHoldRec."Admitted Year" := RecStudent."Admitted Year";
                StudentWiseHoldRec.Semester := RecStudent.Semester;

                StudentWiseHoldRec.Status := StudentWiseHoldRec.Status::Enable;
                StudentWiseHoldRec."Hold Code" := StudentHoldRec."Hold Code";
                StudentWiseHoldRec."Hold Description" := StudentHoldRec."Hold Description";
                StudentWiseHoldRec."Hold Type" := StudentHoldRec."Hold Type";
                StudentWiseHoldRec."Potal Login Restriction" := StudentHoldRec."Potal Login Restriction";
                StudentWiseHoldRec."Clinical Rotation" := StudentHoldRec."Clinical Rotation";
                StudentWiseHoldRec."Transcript Print" := StudentHoldRec."Transcript Print";
                StudentWiseHoldRec.Progression := StudentHoldRec.Progression;
                StudentWiseHoldRec.Billing := StudentHoldRec.Billing;
                StudentWiseHoldRec."Sign-off" := StudentHoldRec."Sign-off";
                StudentWiseHoldRec.Validate("Global Dimension 1 Code", RecStudent."Global Dimension 1 Code");
                StudentWiseHoldRec.Insert();
            end;
            RecHoldStatusLedger.Reset();
            if RecHoldStatusLedger.FINDLAST() then
                LastNo1 := RecHoldStatusLedger."Entry No." + 1
            else
                LastNo1 := 1;

            RecHoldStatusLedger.Init();
            RecHoldStatusLedger."Entry No." := LastNo1;
            RecHoldStatusLedger.Validate("Student No.", RecStudent."No.");
            RecHoldStatusLedger."Student Name" := RecStudent."Student Name";
            RecHoldStatusLedger."Academic Year" := RecStudent."Academic Year";
            RecHoldStatusLedger."Admitted Year" := RecStudent."Admitted Year";
            RecHoldStatusLedger.Semester := RecStudent.Semester;
            RecHoldStatusLedger."Entry Date" := Today();
            RecHoldStatusLedger."Entry Time" := Time();
            RecHoldStatusLedger."Global Dimension 1 Code" := RecStudent."Global Dimension 1 Code";
            RecHoldStatusLedger."Global Dimension 2 Code" := RecStudent."Global Dimension 2 Code";
            RecHoldStatusLedger."User ID" := FORMAT(UserId());
            RecHoldStatusLedger."Hold Code" := StudentWiseHoldRec."Hold Code";
            RecHoldStatusLedger."Hold Description" := StudentWiseHoldRec."Hold Description";
            RecHoldStatusLedger."Hold Type" := StudentHoldRec."Hold Type";
            RecHoldStatusLedger.Status := StudentWiseHoldRec.Status::Enable;
            RecHoldStatusLedger.Insert();
        end;
    end;

    //Shivam 19032021-

    procedure DisableStudentConditionalregistrationGroupCode(RecStudent: Record "Student Master-CS"; GroupCode: Code[20]);
    var
        StudentGroup: Record "Student Group";
        StudentGroupLedger: Record "Student Group Ledger";
        StudentGroupLedger1: Record "Student Group Ledger";
        LGroup: Record Group;
        StudentHoldRec: Record "Student Hold";
        StudentWiseHoldRec: Record "Student Wise Holds";
        RecHoldStatusLedger: Record "Hold Status Ledger";
        LastNo: Integer;
        LastNo1: Integer;
    begin
        LGroup.Get(GroupCode);
        StudentGroup.Reset();
        StudentGroup.SetRange("Student No.", RecStudent."No.");
        StudentGroup.SetRange("Groups Code", GroupCode);
        StudentGroup.SetRange("Global Dimension 1 Code", RecStudent."Global Dimension 1 Code");
        if not StudentGroup.findfirst() then begin
            StudentGroup.Init();
            StudentGroup.Validate("Student No.", RecStudent."No.");
            StudentGroup."Academic Year" := RecStudent."Academic Year";
            StudentGroup.Semester := RecStudent.Semester;
            StudentGroup.Term := RecStudent.Term;
            StudentGroup."Enrollment No." := RecStudent."Enrollment No.";
            StudentGroup.Validate("Groups Code", GroupCode);
            StudentGroup."Created By" := FORMAT(UserId());
            StudentGroup."Creation Date" := Today();
            StudentGroup.Validate("Global Dimension 1 Code", RecStudent."Global Dimension 1 Code");
            StudentGroup."Group Type" := LGroup."Group Type";
            StudentGroup.Insert();
        end;

        StudentGroupLedger.Reset();
        if StudentGroupLedger.FINDLAST() then
            LastNo := StudentGroupLedger."Entry No." + 1
        else
            LastNo := 1;

        StudentGroupLedger1.Init();
        StudentGroupLedger1."Entry No." := LastNo;
        StudentGroupLedger1.Validate("Student No.", RecStudent."No.");
        StudentGroupLedger1."Student Name" := RecStudent."Student Name";
        StudentGroupLedger1."Academic Year" := RecStudent."Academic Year";
        StudentGroupLedger1.Semester := RecStudent.Semester;
        StudentGroupLedger1."Entry Date" := Today();
        StudentGroupLedger1."Entry Time" := Time();
        StudentGroupLedger1."Global Dimension 1 Code" := RecStudent."Global Dimension 1 Code";
        StudentGroupLedger1."Global Dimension 2 Code" := RecStudent."Global Dimension 2 Code";
        StudentGroupLedger1."User ID" := FORMAT(UserId());
        StudentGroupLedger1."Group Code" := GroupCode;
        StudentGroupLedger1."Group Type" := LGroup."Group Type";
        StudentGroupLedger1.Status := StudentGroupLedger.Status::Disable;
        StudentGroupLedger1.Insert();

        StudentHoldRec.Reset();
        StudentHoldRec.SetRange("Group Code", GroupCode);
        StudentHoldRec.SetRange("Global Dimension 1 Code", RecStudent."Global Dimension 1 Code");
        if StudentHoldRec.findfirst() then begin
            StudentWiseHoldRec.Reset();
            StudentWiseHoldRec.SetRange("Student No.", RecStudent."No.");
            StudentWiseHoldRec.SetRange("Hold Code", StudentHoldRec."Hold Code");
            StudentWiseHoldRec.SetRange("Global Dimension 1 Code", RecStudent."Global Dimension 1 Code");
            StudentWiseHoldRec.SetRange(Status, StudentWiseHoldRec.Status::Disable);
            if StudentWiseHoldRec.findfirst() then begin
                Error('There is already Disable entry exist in Student Wise Hold');
            end;
        end;

        StudentHoldRec.Reset();
        StudentHoldRec.SetRange("Group Code", GroupCode);
        StudentHoldRec.SetRange("Global Dimension 1 Code", RecStudent."Global Dimension 1 Code");
        if StudentHoldRec.findfirst() then begin
            StudentWiseHoldRec.Reset();
            StudentWiseHoldRec.SetRange("Student No.", RecStudent."No.");
            StudentWiseHoldRec.SetRange("Hold Code", StudentHoldRec."Hold Code");
            StudentWiseHoldRec.SetRange("Global Dimension 1 Code", RecStudent."Global Dimension 1 Code");
            StudentWiseHoldRec.SetRange(Status, StudentWiseHoldRec.Status::Enable);
            if StudentWiseHoldRec.findfirst() then begin
                StudentWiseHoldRec.Status := StudentWiseHoldRec.Status::Disable;
                StudentWiseHoldRec.Modify();
            end
            else begin
                StudentWiseHoldRec.Init();
                StudentWiseHoldRec.Validate("Student No.", RecStudent."No.");
                StudentWiseHoldRec."Student Name" := RecStudent."Student Name";
                StudentWiseHoldRec."Academic Year" := RecStudent."Academic Year";
                StudentWiseHoldRec."Admitted Year" := RecStudent."Admitted Year";
                StudentWiseHoldRec.Semester := RecStudent.Semester;

                StudentWiseHoldRec.Status := StudentWiseHoldRec.Status::Disable;
                StudentWiseHoldRec."Hold Code" := StudentHoldRec."Hold Code";
                StudentWiseHoldRec."Hold Description" := StudentHoldRec."Hold Description";
                StudentWiseHoldRec."Hold Type" := StudentHoldRec."Hold Type";
                StudentWiseHoldRec."Potal Login Restriction" := StudentHoldRec."Potal Login Restriction";
                StudentWiseHoldRec."Clinical Rotation" := StudentHoldRec."Clinical Rotation";
                StudentWiseHoldRec."Transcript Print" := StudentHoldRec."Transcript Print";
                StudentWiseHoldRec.Progression := StudentHoldRec.Progression;
                StudentWiseHoldRec.Billing := StudentHoldRec.Billing;
                StudentWiseHoldRec."Sign-off" := StudentHoldRec."Sign-off";
                StudentWiseHoldRec.Validate("Global Dimension 1 Code", RecStudent."Global Dimension 1 Code");
                StudentWiseHoldRec.Insert();
            end;
            RecHoldStatusLedger.Reset();
            if RecHoldStatusLedger.FINDLAST() then
                LastNo1 := RecHoldStatusLedger."Entry No." + 1
            else
                LastNo1 := 1;

            RecHoldStatusLedger.Init();
            RecHoldStatusLedger."Entry No." := LastNo1;
            RecHoldStatusLedger.Validate("Student No.", RecStudent."No.");
            RecHoldStatusLedger."Student Name" := RecStudent."Student Name";
            RecHoldStatusLedger."Academic Year" := RecStudent."Academic Year";
            RecHoldStatusLedger."Admitted Year" := RecStudent."Admitted Year";
            RecHoldStatusLedger.Semester := RecStudent.Semester;
            RecHoldStatusLedger."Entry Date" := Today();
            RecHoldStatusLedger."Entry Time" := Time();
            RecHoldStatusLedger."Global Dimension 1 Code" := RecStudent."Global Dimension 1 Code";
            RecHoldStatusLedger."Global Dimension 2 Code" := RecStudent."Global Dimension 2 Code";
            RecHoldStatusLedger."User ID" := FORMAT(UserId());
            RecHoldStatusLedger."Hold Code" := StudentWiseHoldRec."Hold Code";
            RecHoldStatusLedger."Hold Description" := StudentWiseHoldRec."Hold Description";
            RecHoldStatusLedger."Hold Type" := StudentHoldRec."Hold Type";
            RecHoldStatusLedger.Status := StudentWiseHoldRec.Status::Disable;
            RecHoldStatusLedger.Insert();
        end;
    end;

    //CS_SG 20230523
}