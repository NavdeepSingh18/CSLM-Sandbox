page 50866 "Students to Update Hold"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Student Master-CS";
    CardPageId = "Student Detail Card-CS";
    Caption = 'Students to Update Hold';
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(Content)
        {
            repeater("Students Coordinator")
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Enrollment No."; Rec."Enrollment No.")
                {
                    ApplicationArea = All;
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = All;
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ApplicationArea = All;
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = All;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Spcl Accommodation Appln"; Rec."Spcl Accommodation Appln")
                {
                    ApplicationArea = All;
                }
                field("Document Specialist"; Rec."Document Specialist")
                {
                    ApplicationArea = All;
                }
                field("FM1/IM1 Coordinator"; Rec."FM1/IM1 Coordinator")
                {
                    ApplicationArea = All;
                }
                field("Clinical Coordinator"; Rec."Clinical Coordinator")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(FactBoxes)
        {
            part("Hold FactBox"; "Hold FactBox")
            {
                ApplicationArea = All;
                Caption = 'Student Holds';
                SubPageLink = "Student No." = field("No."), "Hold Code" = filter(<> '');
                SubPageView = sorting("Student No.", Status) order(descending);
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Put on Clinical Hold")
            {
                ApplicationArea = All;
                Caption = 'Put on Clinical Hold';
                Image = Holiday;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;

                trigger OnAction()
                var
                    StudentMaster: Record "Student Master-CS";
                begin
                    StudentMaster.Reset();
                    StudentMaster.FilterGroup(2);
                    StudentMaster.SetRange("No.", Rec."No.");
                    StudentMaster.FilterGroup(0);
                    Page.RunModal(Page::"Clinical Hold Reason Input", StudentMaster);
                end;
            }

            action("Remove Clinical Hold")
            {
                ApplicationArea = All;
                Caption = 'Remove Clinical Hold';
                Image = DeleteExpiredComponents;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;

                trigger OnAction()
                var
                    LGroup: Record Group;
                    StudentGroup: Record "Student Group";
                    StudentHold: Record "Student Hold";
                    StudentWiseHolds: Record "Student Wise Holds";
                    HoldStatusLedger: Record "Hold Status Ledger";
                    CALE: Record "Clerkship Activity Log Entries";
                    StudentMaster_lRec: Record "Student Master-CS";
                    ClinicalNotification: Codeunit "Clinical Notification";
                    LastEntryNo: Integer;
                    RSL: Record "Roster Scheduling Line";
                begin
                    if not Confirm('Do you want to remove Clinical Hold from Student No. %1 (%2)?', true, Rec."No.", Rec."Student Name") then
                        exit;

                    LGroup.Reset();
                    LGroup.SetRange("Group Type", LGroup."Group Type"::Clinical);
                    if not LGroup.FindFirst() then
                        Error('Student Group not found for Clinical Clerkship.\Please Group Hold Code for Institute Code %1.', Rec."Global Dimension 1 Code");

                    StudentHold.Reset();
                    StudentHold.SetRange("Group Code", LGroup.Code);
                    if not StudentHold.FindFirst() then
                        Error('Student Hold not found for Group %1.', LGroup.Code);

                    StudentGroup.Reset();
                    StudentGroup.SetRange("Student No.", Rec."No.");
                    StudentGroup.SetRange("Groups Code", LGroup.Code);
                    if not StudentGroup.findfirst() then
                        Error('Clinical hold not yet applied on Student No. %1 (%2).', Rec."No.", Rec."Student Name")
                    else
                        StudentGroup.Delete(true);

                    StudentMaster_lRec.Reset();
                    StudentMaster_lRec.SetRange("Original Student No.", Rec."Original Student No.");
                    IF StudentMaster_lRec.FindSet() then begin
                        repeat
                            StudentWiseHolds.Reset();
                            StudentWiseHolds.SetRange("Student No.", StudentMaster_lRec."No.");
                            StudentWiseHolds.SetRange("Hold Code", StudentHold."Hold Code");
                            if StudentWiseHolds.FindFirst() then begin
                                StudentWiseHolds.Validate(Status, StudentWiseHolds.Status::Disable);
                                StudentWiseHolds.Modify(true);

                                HoldStatusLedger.Reset();
                                if HoldStatusLedger.FINDLAST() then
                                    LastEntryNo := HoldStatusLedger."Entry No." + 1
                                else
                                    LastEntryNo := 1;

                                HoldStatusLedger.Init();
                                HoldStatusLedger."Entry No." := LastEntryNo;
                                HoldStatusLedger."Student No." := StudentMaster_lRec."No.";
                                HoldStatusLedger."Student Name" := StudentMaster_lRec."Student Name";
                                HoldStatusLedger."Academic Year" := StudentMaster_lRec."Academic Year";
                                HoldStatusLedger."Admitted Year" := StudentMaster_lRec."Admitted Year";
                                HoldStatusLedger.Semester := StudentMaster_lRec.Semester;
                                HoldStatusLedger."Entry Date" := Today();
                                HoldStatusLedger."Entry Time" := Time();
                                HoldStatusLedger."Global Dimension 1 Code" := StudentMaster_lRec."Global Dimension 1 Code";
                                HoldStatusLedger."Global Dimension 2 Code" := StudentMaster_lRec."Global Dimension 2 Code";
                                HoldStatusLedger."User ID" := UserId();
                                HoldStatusLedger."Hold Code" := StudentHold."Hold Code";
                                HoldStatusLedger."Hold Description" := StudentHold."Hold Description";
                                HoldStatusLedger."Hold Type" := StudentHold."Hold Type";
                                HoldStatusLedger.Status := HoldStatusLedger.Status::Disable;
                                HoldStatusLedger.Insert();
                            end;

                            // ClinicalNotification.YourHoldhasbeenlifted(StudentMaster_lRec."No.");
                            // ClinicalNotification.HoldhasbeenLifted(StudentMaster_lRec."No.");
                            CALE.InsertLogEntry(11, 9, StudentMaster_lRec."No.", StudentMaster_lRec."Student Name", 'NA', 'HOLD-LIFTED', 'Hold - Lifted', '', '');
                            RSL.AutoPublishedRotation_On_CLN_Hold_Removed(StudentMaster_lRec);//CSPL-00307-RTP
                        until StudentMaster_lRec.Next() = 0;
                    end;
                    Message('Clinical Hold removed from Student No. %1 (%2).', Rec."No.", Rec."Student Name")
                end;
            }
            action("Students on Clinical Hold")
            {
                ApplicationArea = All;
                Caption = 'Students on Clinical Hold';
                Image = AbsenceCategories;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;

                trigger OnAction()
                var
                    EducationSetup: Record "Education Setup-CS";
                    UserSetup: Record "User Setup";
                    ClinicalSemester: Code[1024];
                    WindowDialog: Dialog;
                    Text001Lbl: Label 'Student Name      ############1################\';
                begin
                    WindowDialog.Open('Checking Students on Clinical Hold..\' + Text001Lbl);

                    UserSetup.Reset();
                    if UserSetup.Get(UserId) then;

                    EducationSetup.Reset();
                    EducationSetup.SetRange("Global Dimension 1 Code", '9000');
                    if EducationSetup.FindFirst() then;

                    // if EducationSetup."FM1/IM1 Semester Filter" <> '' then
                    //     ClinicalSemester := EducationSetup."FM1/IM1 Semester Filter";

                    // if EducationSetup."Clerkship Semester Filter" <> '' then
                    //     ClinicalSemester := ClinicalSemester + '|' + EducationSetup."Clerkship Semester Filter";

                    ClinicalSemester := 'CLN5|CLN6|CLN7|CLN8';

                    Rec.Reset();
                    Rec.FilterGroup(2);
                    Rec.SetFilter(Semester, ClinicalSemester);
                    Rec.SetFilter(Status, EducationSetup."Active Statuses");
                    Rec.SetRange("Clinical Hold Exist", true);
                    Rec.FilterGroup(0);
                    CurrPage.Update(true);
                    WindowDialog.Close();
                end;
            }
            action("Clear Filters")
            {
                ApplicationArea = All;
                Caption = 'Clear Filters';
                Image = ShowMatrix;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;

                trigger OnAction()
                var
                    EducationSetup: Record "Education Setup-CS";
                    UserSetup: Record "User Setup";
                    ClinicalSemester: Code[1024];
                    WindowDialog: Dialog;
                    Text001Lbl: Label 'Student Name      ############1################\';
                begin
                    WindowDialog.Open('Resuming Students..\' + Text001Lbl);

                    UserSetup.Reset();
                    if UserSetup.Get(UserId) then;

                    EducationSetup.Reset();
                    EducationSetup.SetRange("Global Dimension 1 Code", '9000');
                    if EducationSetup.FindFirst() then;

                    // if EducationSetup."FM1/IM1 Semester Filter" <> '' then
                    //     ClinicalSemester := EducationSetup."FM1/IM1 Semester Filter";

                    // if EducationSetup."Clerkship Semester Filter" <> '' then
                    //     ClinicalSemester := ClinicalSemester + '|' + EducationSetup."Clerkship Semester Filter";

                    ClinicalSemester := 'CLN5|CLN6|CLN7|CLN8';

                    Rec.Reset();
                    Rec.FilterGroup(2);
                    Rec.SetFilter(Semester, ClinicalSemester);
                    Rec.SetFilter("Course Code", ClinicalCourse);
                    Rec.SetFilter(Status, EducationSetup."Active Statuses");
                    Rec.FilterGroup(0);
                    CurrPage.Update(true);
                    WindowDialog.Close();
                end;
            }
            action("View/Update Notes")
            {
                ApplicationArea = All;
                Caption = 'View/Update Notes';
                Image = Notes;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                trigger OnAction()
                var
                    ClinicalBaseAppSubscribe: Codeunit "Clinical Base App. Subscribe";
                    TemplateType: Option " ",Residency,"Clinical Clerkship",Student,Other;
                    GroupType: Option " ","Residency Note","Residency Employement Note","Clinical Clerkship",Student,Other;
                begin
                    Rec.TestField("No.");
                    TemplateType := TemplateType::"Clinical Clerkship";
                    GroupType := GroupType::"Clinical Clerkship";
                    ClinicalBaseAppSubscribe.ViewEditNote(Rec."No.", Rec."No.", TemplateType, GroupType);
                end;
            }
            action("Student Card")
            {
                ApplicationArea = All;
                Caption = 'Student Card';
                Image = Card;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ShortCutKey = 'Ctrl+F5';
                trigger OnAction()
                var
                    StudentMaster: Record "Student Master-CS";
                    StudentDetailCard: Page "Student Detail Card-CS";
                begin
                    StudentMaster.Reset();
                    StudentMaster.FilterGroup(2);
                    StudentMaster.SetRange("No.", Rec."No.");
                    StudentMaster.FilterGroup(0);
                    StudentDetailCard.SetTableView(StudentMaster);
                    StudentDetailCard.Editable(false);
                    StudentDetailCard.RunModal();
                end;
            }
        }
    }

    var
        ClinicalCourse: Code[2048];

    trigger OnOpenPage()
    var
        EducationSetup: Record "Education Setup-CS";
        CourseMaster: Record "Course Master-CS";
        UserSetup: Record "User Setup";
        ClinicalSemester: Code[1024];
    begin
        UserSetup.Reset();
        if UserSetup.Get(UserId) then;

        EducationSetup.Reset();
        EducationSetup.SetRange("Global Dimension 1 Code", '9000');
        if EducationSetup.FindFirst() then;

        // if EducationSetup."FM1/IM1 Semester Filter" <> '' then
        //     ClinicalSemester := EducationSetup."FM1/IM1 Semester Filter";

        // if EducationSetup."Clerkship Semester Filter" <> '' then
        //     ClinicalSemester := ClinicalSemester + '|' + EducationSetup."Clerkship Semester Filter";

        ClinicalSemester := 'BSIC|CLN5|CLN6|CLN7|CLN8|CLN9|CLN10';
        ClinicalCourse := '';
        CourseMaster.Reset();
        CourseMaster.SetRange("Clinical Clerkship Applicable", true);
        if CourseMaster.FindSet() then
            repeat
                if ClinicalCourse = '' then
                    ClinicalCourse := CourseMaster.Code
                else
                    ClinicalCourse := ClinicalCourse + '|' + CourseMaster.Code;
            until CourseMaster.Next() = 0;

        if ClinicalCourse = '' then
            ClinicalCourse := 'NA';

        Rec.FilterGroup(2);
        Rec.SetFilter(Semester, ClinicalSemester);
        Rec.SetFilter("Course Code", ClinicalCourse);
        Rec.SetFilter(Status, EducationSetup."Active Statuses");
        Rec.FilterGroup(0);
    end;
}