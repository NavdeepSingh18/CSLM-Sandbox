page 50977 "Broadcast E-Mail"
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
                field(EmailSubject; EmailSubject)
                {
                    ApplicationArea = All;
                    Caption = 'Email Subject';
                    MultiLine = true;
                }
                field("Email Template"; EmpTempCode)
                {
                    ApplicationArea = all;
                    Editable = true;
                    TableRelation = "Intership-CS";
                    trigger OnValidate()
                    var
                    // myInt: Integer;
                    begin
                        Clear(Intership);
                        IF Intership.Get(EmpTempCode) then
                            BodyText1 := Intership.GetWorkDescription()
                        else
                            BodyText1 := '';
                    end;
                }
                field(BodyText1; BodyText1)
                {
                    ApplicationArea = All;
                    Caption = 'Body1';
                    MultiLine = true;
                    Width = 50;
                }
                field(BodyText2; BodyText2)
                {
                    ApplicationArea = All;
                    Caption = 'Body2';
                    Visible = false;
                    MultiLine = true;
                }
                field(TotalCount; TotalCount)
                {
                    Caption = 'Total Count';
                    ApplicationArea = all;
                    Editable = false;

                }
                field(CourseDetailCSFilter; CourseCode)
                {
                    ApplicationArea = all;
                    Caption = 'Course Code';
                    Editable = true;
                    TableRelation = "Course Master-CS".Code;
                }
                field(ListAcademicYearCSFilter; AcademicYear)
                {
                    ApplicationArea = all;
                    Caption = 'Academic Year';
                    Editable = true;
                    TableRelation = "Academic Year Master-CS".Code;
                }
                field(SemesterDetailCSFilter; SemesterCode)
                {
                    ApplicationArea = all;
                    Caption = 'Semester';
                    Editable = true;
                    TableRelation = "Semester Master-CS".Code;
                }

                field(StatusCodeFilter; StatusCode)
                {
                    ApplicationArea = all;
                    Caption = 'Student Status';
                    Editable = true;
                    TableRelation = "Student Status";

                }

                // field(WorkDescription;Rec.WorkDescription)
                // {
                //     ApplicationArea = all;
                //     Caption = 'Email Template Body';
                //     Editable = true;
                //     MultiLine = true;
                // }
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
                    Caption = 'Student No.';
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
                Field(Field13; Rec.Field13)
                {
                    Caption = 'E-mail Address';
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
            action("Import XML")
            {
                ApplicationArea = All;
                Caption = 'Import data';
                Image = Import;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    BroadCastEmailUpload: xmlport BroadcastEmail;
                begin
                    Clear(BroadCastEmailUpload);
                    BroadCastEmailUpload.Run();
                    CurrPage.Update();
                end;
            }
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
            action("View Expanded Body")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                Image = ExpandAll;
                trigger OnAction()
                var
                begin
                    Message('%1', BodyText1);
                end;
            }
            action("Send Broadcast E-mail")
            {
                ApplicationArea = All;
                Image = Email;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                trigger OnAction()
                var
                    StudentStatusMangementCod: Codeunit "Student Status Mangement";
                    RecBroadCastTemplate: Record "Intership-CS";
                    Selection: Integer;
                    InstituteCodeQuest: Label '&Student E-mail ID,A&lternate E-mail ID';
                    DefaultOption: Integer;
                    StudentEmailID: Boolean;
                    AlternateEmailID: Boolean;
                    VarOutStream: OutStream;
                begin
                    if BodyText1 = '' then
                        Error('Body must have value in it.');
                    if EmailSubject = '' then
                        Error('Email Subject must have value in it.');

                    If confirm('Do you want to Send Email for the selected Students?', false) then begin
                    end ELse
                        Exit;

                    StudentEmailID := False;
                    AlternateEmailID := false;
                    Selection := StrMenu(InstituteCodeQuest, DefaultOption);
                    if Selection > 0 then begin
                        if Selection = 1 then
                            StudentEmailID := true
                        else
                            if Selection = 2 then
                                AlternateEmailID := true;
                    end;
                    RecBroadCastTemplate.reset;
                    If RecBroadCastTemplate.Get(EmpTempCode) then begin
                        clear(RecBroadCastTemplate.TempBody);
                        RecBroadCastTemplate.TempBody.CreateOutStream(VarOutStream);
                        VarOutStream.Write(BodyText1);
                        RecBroadCastTemplate.Modify();
                    end;
                    // if GroupCode <> '' then begin
                    TempTable1.Reset();
                    CurrPage.SetSelectionFilter(TempTable1);
                    TempTable1.Setrange("Unique ID", UserId());
                    If TempTable1.FindSet() then
                        repeat
                            //Message('%1', TempTable1.Field12);
                            // StudentStatusMangementCod.BroadcastEmailNotification(TempTable1.Field2, EmailSubject, BodyText1, BodyText2, StudentEmailID, AlternateEmailID, EmpTempCode);
                        until TempTable1.next() = 0;
                    // /end;
                    Message('Email Sent');

                    DeleteTempTable();
                    CurrPage.Close();


                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        GroupCode := '';
        DeleteTempTable();
        Rec.SetRange(Rec."Unique ID", UserId());
    end;

    trigger OnClosePage()
    var
        TemTable2: Record "Temp Record";
    begin
        DeleteTempTable();
    end;

    trigger onaftergetrecord()
    begin
        Clear(Intership);
        IF Intership.Get(Rec."Email Template") then begin
            if BodyText1 = '' then
                BodyText1 := Intership.GetWorkDescription();
        end;
        // Rec.SetRange(Field7, StatusCode);
        // Rec.SetRange(Field5, SemesterCode);
        // Rec.SetRange(Field3, CourseCode);
        // Rec.SetRange(Field4, AcademicYear);
        // TotalCount := 0;
        // StudentGroupRec.Reset();
        // StudentGroupRec.SetRange("Groups Code", GroupCode);
        // StudentGroup.SetRange(Blocked, false);
        // if StudentGroupRec.FindSet() then
        //     TotalCount := StudentGroupRec.Count;
    end;

    var
        StudentNO: code[20];
        StudentMasterCS: Record "Student Master-CS";
        StatusMaster: Record "Student Status";
        StudentGroup: Record "Student Group";
        StudentHold: Record "Student Hold";
        StudentGroupNew: Record "Student Group";
        StudentGroupRec: Record "Student Group";
        Intership: record "Intership-CS";
        TotalCount: Integer;
        EmailSubject: Text[250];
        BodyText1: Text;
        BodyText2: Text[2048];
        EnrolmentNo: Code[20];
        GroupCode: Code[2048];
        GroupDescription: Text[100];
        CourseCode: Code[20];
        AcademicYear: Code[20];
        SemesterCode: Code[10];
        StatusCode: Code[20];
        TempTable: Record "Temp Record";
        TempTable1: Record "Temp Record";
        EntryNo: Integer;
        StudentId: code[20];
        EmpTempCode: code[20];


    procedure ApplyFilter()
    begin
        Clear(EntryNo);
        DeleteTempTable();
        if GroupCode = '' then begin
            TotalCount := 0;
            StudentMasterCS.Reset();
            if EnrolmentNo <> '' then
                StudentMasterCS.SetFilter("No.", EnrolmentNo);
            if CourseCode <> '' then
                StudentMasterCS.SetFilter("Course Code", CourseCode);
            if AcademicYear <> '' then
                StudentMasterCS.SetFilter("Academic Year", AcademicYear);
            if SemesterCode <> '' then
                StudentMasterCS.SetFilter(Semester, SemesterCode);
            if StatusCode <> '' then
                StudentMasterCS.SetFilter(Status, StatusCode);
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
                        TempTable.Field13 := StudentMasterCS."E-Mail Address";
                        TempTable1."Unique ID" := UserId();
                        TempTable1.Insert();
                        TotalCount += 1;
                    end;
                until StudentMasterCS.Next() = 0;
            end;
        end;

        if GroupCode <> '' then begin
            TotalCount := 0;
            StudentMasterCS.Reset();
            if EnrolmentNo <> '' then
                StudentMasterCS.SetRange(StudentMasterCS."No.", EnrolmentNo);
            if CourseCode <> '' then
                StudentMasterCS.SetRange("Course Code", CourseCode);
            if AcademicYear <> '' then
                StudentMasterCS.SetFilter("Academic Year", AcademicYear);
            if SemesterCode <> '' then
                StudentMasterCS.SetFilter(Semester, SemesterCode);
            if StatusCode <> '' then
                StudentMasterCS.SetFilter(Status, StatusCode);
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
                            TempTable1.Field2 := StudentMasterCS."No.";
                            TempTable1.Field3 := StudentMasterCS."Course Code";
                            TempTable1.Field4 := StudentMasterCS."Academic Year";
                            TempTable1.Field5 := StudentMasterCS.Semester;
                            TempTable1.Field6 := StudentMasterCS."No.";
                            TempTable1.Field7 := StudentMasterCS.Status;
                            TempTable1.Field11 := StudentMasterCS."Student Name";
                            TempTable1.Field12 := StudentMasterCS."Original Student No.";
                            TempTable.Field13 := StudentMasterCS."E-Mail Address";
                            TempTable1."Unique ID" := UserId();
                            TempTable1.Insert();
                            TotalCount += 1;
                        end;
                    end;
                until StudentMasterCS.Next() = 0;
            end;
        end;

        Rec.FilterGroup(2);
        Rec.SetFilter(Rec."Unique ID", UserId());
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


    // var
    // WorkDescription: Text;
    // Intership: record "Intership-CS";

}