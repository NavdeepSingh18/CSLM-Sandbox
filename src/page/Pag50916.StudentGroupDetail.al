page 50916 "Student Group Detail"
{

    PageType = List;
    UsageCategory = Administration;
    ApplicationArea = All;
    SourceTable = "Temp Record";
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            group("Group Filter")
            {
                field(GroupCode; GroupCode)
                {
                    ApplicationArea = All;
                    Caption = 'Group Code';
                    ShowMandatory = true;
                    Style = Unfavorable;
                    Lookup = true;
                    DrillDown = true;
                    TableRelation = Group.Code;

                    trigger OnValidate()
                    var
                        ClinicalGroups: Record Group;
                    begin

                        GroupDescription := '';
                        ClinicalGroups.Reset();
                        ClinicalGroups.SetRange(Code, GroupCode);
                        if ClinicalGroups.FindFirst() then
                            GroupDescription := ClinicalGroups.Description;
                        // DeleteTempTable();
                    end;
                }
                field(GroupDescription; GroupDescription)
                {
                    ApplicationArea = All;
                    Caption = 'Group Description';
                    Style = Unfavorable;
                    Editable = false;
                    //MultiLine = true;
                }
            }
            group("Student Filter")
            {
                field("Enrolment No."; EnrolmentNo)
                {
                    ApplicationArea = All;
                    Caption = 'Enrollment No.';
                    //TableRelation = "Student Master-CS"."Enrollment No.";

                    trigger OnLookup(var Text: Text): Boolean
                    begin

                        IF PAGE.RUNMODAL(0, StudentMasterCS) = ACTION::LookupOK THEN
                            EnrolmentNo := StudentMasterCS."Enrollment No.";
                        DeleteTempTable();
                    end;

                    trigger OnValidate()
                    begin
                        Rec.Reset();
                        DeleteTempTable();
                    end;
                }
                field("Status"; StatusCode)
                {
                    ApplicationArea = All;
                    Caption = 'Status';
                    //TableRelation = "Student Master-CS"."Enrollment No.";

                    trigger OnLookup(var Text: Text): Boolean
                    begin

                        IF PAGE.RUNMODAL(0, StatusMaster) = ACTION::LookupOK THEN
                            StatusCode := StatusMaster.Code;
                        DeleteTempTable();
                    end;

                    trigger OnValidate()
                    begin
                        Rec.Reset();
                        DeleteTempTable();
                    end;
                }
                field(CourseCode; CourseCode)
                {
                    ApplicationArea = All;
                    Caption = 'Course Code';
                    TableRelation = "Course Master-CS".Code;
                    trigger OnValidate()
                    begin
                        Rec.Reset();
                        DeleteTempTable();
                    end;
                }
                field(AcademicYear; AcademicYear)
                {
                    ApplicationArea = All;
                    Caption = 'Academic Year';
                    TableRelation = "Academic Year Master-CS";
                    trigger OnValidate()
                    begin
                        Rec.Reset();
                        DeleteTempTable();
                    end;
                }
                field(SemesterCode; SemesterCode)
                {
                    ApplicationArea = All;
                    Caption = 'Semester';
                    // TableRelation = "Course Sem. Master-CS"."Semester Code";
                    TableRelation = "Semester Master-CS".code;
                    trigger OnValidate()
                    begin
                        Rec.Reset();
                        DeleteTempTable();
                    end;
                }
                field(Term; VarTerm)
                {
                    ApplicationArea = All;
                    Caption = 'Term';
                    trigger OnValidate()
                    begin
                        Rec.Reset();
                        DeleteTempTable();
                    end;
                }

            }
            repeater(Group)
            {
                field(Field12; Rec.Field12)
                {
                    Caption = 'Student ID';
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Field2; Rec.Field2)
                {
                    Caption = 'Enrollment No.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Field11; Rec.Field11)
                {
                    Caption = 'Student Name';
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Field3; Rec.Field3)
                {
                    Caption = 'Course Code';
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Field4; Rec.Field4)
                {
                    Caption = 'Academic Year';
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Field5; Rec.Field5)
                {
                    Caption = 'Semester';
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Field7; Rec.Field7)
                {
                    Caption = 'Status';
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Field13; Rec.Field13)
                {
                    Caption = 'Term';
                    ApplicationArea = All;
                    Editable = false;
                }


            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Get Students")
            {
                ApplicationArea = All;
                Caption = 'Get Students';
                Image = GetLines;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                PromotedIsBig = true;
                trigger OnAction()
                var

                begin
                    ApplyFilter();
                end;
            }
            action("Clear Filters")
            {
                ApplicationArea = All;
                Caption = 'Clear Filters';
                Image = ClearFilter;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    TemTable2: Record "Temp Record";
                begin
                    GroupCode := '';
                    GroupDescription := '';
                    EnrolmentNo := '';
                    AcademicYear := '';
                    CourseCode := '';
                    SemesterCode := '';
                    StatusCode := '';
                    VarTerm := VarTerm::" ";
                    Rec.Reset();
                    Rec.FilterGroup(2);

                    DeleteTempTable();

                    Rec.FilterGroup(0);
                end;
            }
            action("Assign Group")
            {
                Caption = 'Assign Group';
                Image = Add;
                PromotedCategory = Process;
                Promoted = true;
                PromotedIsBig = true;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    if GroupCode <> '' then begin

                        StudentHold.Reset();
                        StudentHold.SetRange("Group Code", GroupCode);
                        StudentHold.SetFilter("Hold Type", '<>%1', StudentHold."Hold Type"::" ");
                        if StudentHold.FindFirst() then
                            Error('You can not Assign Groups related to OLR Hold');

                        if confirm('Do you want to assign Group %1 ?', false, GroupCode) then begin
                            TempTable.Reset();
                            CurrPage.SetSelectionFilter(TempTable);
                            TempTable.SetRange("Unique ID", UserId());
                            if TempTable.FindSet() then begin
                                repeat
                                    StudentGroupNew.AssignStudentGroupNew(TempTable, GroupCode);
                                    StudentGroupNew.AssignStudentWiseHoldNew(TempTable, GroupCode);
                                until TempTable.Next() = 0;
                            end;
                            Message('Group %1 has been assigned', GroupCode);
                        end;
                    end;
                end;
            }
            action("Unassign Group")
            {
                Caption = 'Unassign Group';
                PromotedCategory = Process;
                Promoted = true;
                Image = DeleteRow;
                PromotedIsBig = true;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    if GroupCode <> '' then begin
                        StudentHold.Reset();
                        StudentHold.SetRange("Group Code", GroupCode);
                        StudentHold.SetFilter("Hold Type", '<>%1', StudentHold."Hold Type"::" ");
                        if StudentHold.FindFirst() then
                            Error('You can not Unassign Groups related to OLR Hold');

                        if confirm('Do you want to Unassign Group %1 ?', false, GroupCode) then begin
                            TempTable.Reset();
                            CurrPage.SetSelectionFilter(TempTable);
                            TempTable.SetRange("Unique ID", UserId());
                            if TempTable.FindSet() then begin
                                repeat
                                    StudentGroupNew.UnassignStudentGroupNew(TempTable, GroupCode);
                                    StudentGroupNew.UnassignStudentWiseHoldNew(TempTable, GroupCode);
                                until TempTable.Next() = 0;
                            end;
                            Message('Group %1 has been unassigned', GroupCode);
                        end;
                    end;
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        GroupCode := '';
        EnrolmentNo := '';
        AcademicYear := '';
        CourseCode := '';
        SemesterCode := '';
        StatusCode := '';
        VarTerm := VarTerm::" ";
        DeleteTempTable();
        Rec.SetRange("Unique ID", UserId());
    end;

    trigger OnClosePage()
    var
        TemTable2: Record "Temp Record";
    begin
        DeleteTempTable();
    end;

    trigger OnAfterGetRecord()
    begin

    end;

    var
        StudentMasterCS: Record "Student Master-CS";
        TempTable: Record "Temp Record";
        TempTable1: Record "Temp Record";
        StatusMaster: Record "Student Status";
        StudentGroup: Record "Student Group";
        StudentHold: Record "Student Hold";

        StudentGroupNew: Record "Student Group";

        EnrolmentNo: Code[20];

        GroupCode: Code[2048];
        GroupDescription: Text[100];
        CourseCode: Code[20];
        AcademicYear: Code[20];
        SemesterCode: Code[10];

        StatusCode: Code[20];
        VarTerm: Option " ","FALL","SPRING","SUMMER";

        EntryNo: Integer;


    procedure ApplyFilter()
    begin
        Clear(EntryNo);
        DeleteTempTable();
        if GroupCode = '' then begin
            StudentMasterCS.Reset();
            if EnrolmentNo <> '' then
                StudentMasterCS.SetFilter("Enrollment No.", EnrolmentNo);
            if CourseCode <> '' then
                StudentMasterCS.SetFilter("Course Code", CourseCode);
            if AcademicYear <> '' then
                StudentMasterCS.SetFilter("Academic Year", AcademicYear);
            if SemesterCode <> '' then
                StudentMasterCS.SetFilter(Semester, SemesterCode);
            if StatusCode <> '' then
                StudentMasterCS.SetFilter(Status, StatusCode);
            IF VarTerm <> VarTerm::" " then begin
                IF VarTerm = VarTerm::FALL then
                    StudentMasterCS.SetRange(Term, StudentMasterCS.Term::FALL);
                IF VarTerm = VarTerm::SPRING then
                    StudentMasterCS.SetRange(Term, StudentMasterCS.Term::SPRING);
                IF VarTerm = VarTerm::SUMMER then
                    StudentMasterCS.SetRange(Term, StudentMasterCS.Term::SUMMER);
            end;
            if StudentMasterCS.FindSet() then begin
                repeat
                    TempTable.Reset();
                    if TempTable.FindLast() then
                        EntryNo := TempTable."Entry No" + 1
                    else
                        EntryNo := 1;
                    TempTable1.Reset();
                    TempTable1.SetRange(Field2, EnrolmentNo);
                    if not TempTable1.FindFirst() then begin
                        TempTable1.Init();
                        TempTable1."Entry No" := EntryNo;
                        TempTable1.Field2 := StudentMasterCS."Enrollment No.";
                        TempTable1.Field3 := StudentMasterCS."Course Code";
                        TempTable1.Field4 := StudentMasterCS."Academic Year";
                        TempTable1.Field5 := StudentMasterCS.Semester;
                        TempTable1.Field6 := StudentMasterCS."No.";
                        TempTable1.Field7 := StudentMasterCS.Status;
                        TempTable1.Field11 := StudentMasterCS."Student Name";
                        TempTable1.Field12 := StudentMasterCS."Original Student No.";
                        TempTable1.Field13 := Format(StudentMasterCS.Term);
                        TempTable1."Unique ID" := UserId();
                        TempTable1.Insert();
                    end;
                until StudentMasterCS.Next() = 0;
            end;
        end;

        if GroupCode <> '' then begin
            StudentMasterCS.Reset();
            if EnrolmentNo <> '' then
                StudentMasterCS.SetRange(StudentMasterCS."Enrollment No.", EnrolmentNo);
            if CourseCode <> '' then
                StudentMasterCS.SetRange("Course Code", CourseCode);
            if AcademicYear <> '' then
                StudentMasterCS.SetFilter("Academic Year", AcademicYear);
            if SemesterCode <> '' then
                StudentMasterCS.SetFilter(Semester, SemesterCode);
            if StatusCode <> '' then
                StudentMasterCS.SetFilter(Status, StatusCode);
            IF VarTerm <> VarTerm::" " then begin
                IF VarTerm = VarTerm::FALL then
                    StudentMasterCS.SetRange(Term, StudentMasterCS.Term::FALL);
                IF VarTerm = VarTerm::SPRING then
                    StudentMasterCS.SetRange(Term, StudentMasterCS.Term::SPRING);
                IF VarTerm = VarTerm::SUMMER then
                    StudentMasterCS.SetRange(Term, StudentMasterCS.Term::SUMMER);
            end;
            if StudentMasterCS.FindSet() then begin
                repeat
                    StudentGroup.Reset();
                    StudentGroup.SetRange("Student No.", StudentMasterCS."No.");
                    StudentGroup.SetRange("Enrollment No.", StudentMasterCS."Enrollment No.");
                    StudentGroup.SetRange("Groups Code", GroupCode);
                    StudentGroup.SetRange(Blocked, false);
                    if StudentGroup.FindFirst() then begin
                        TempTable.Reset();
                        if TempTable.FindLast() then
                            EntryNo := TempTable."Entry No" + 1
                        else
                            EntryNo := 1;
                        TempTable1.Reset();
                        TempTable1.SetRange(Field2, EnrolmentNo);
                        if not TempTable1.FindFirst() then begin
                            TempTable1.Init();
                            TempTable1."Entry No" := EntryNo;
                            TempTable1.Field2 := StudentMasterCS."Enrollment No.";
                            TempTable1.Field3 := StudentMasterCS."Course Code";
                            TempTable1.Field4 := StudentMasterCS."Academic Year";
                            TempTable1.Field5 := StudentMasterCS.Semester;
                            TempTable1.Field6 := StudentMasterCS."No.";
                            TempTable1.Field7 := StudentMasterCS.Status;
                            TempTable1.Field11 := StudentMasterCS."Student Name";
                            TempTable1.Field12 := StudentMasterCS."Original Student No.";
                            TempTable1.Field13 := Format(StudentMasterCS.Term);
                            TempTable1."Unique ID" := UserId();
                            TempTable1.Insert();
                        end;
                    end;
                until StudentMasterCS.Next() = 0;
            end;
        end;

        Rec.FilterGroup(2);
        Rec.SetFilter("Unique ID", UserId());
        Rec.FilterGroup(0);
        /*
        //Reset();
        FilterGroup(2);
        if EnrolmentNo <> '' then
            SetFilter(Field2, EnrolmentNo);
        if CourseCode <> '' then
            SetFilter(Field3, CourseCode);
        if AcademicYear <> '' then
            SetFilter(Field4, AcademicYear);
        if SemesterCode <> '' then
            SetFilter(Field5, SemesterCode);
        FilterGroup(0);
        */
    end;

    procedure DeleteTempTable()
    begin
        TempTable.Reset();
        TempTable.SetRange("Unique ID", UserId());
        TempTable.DeleteAll();
    end;

}