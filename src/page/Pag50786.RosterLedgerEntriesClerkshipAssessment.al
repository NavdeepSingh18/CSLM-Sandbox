page 50786 "RLE Clerkship Assessment"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Roster Ledger Entries (Clerkship Assessment)';
    SourceTable = "Roster Ledger Entry";
    SourceTableView = sorting("Entry No.") order(descending);
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            group("Student")
            {
                field("Student ID"; Rec."Student ID")
                {
                    ApplicationArea = All;
                    Style = Unfavorable;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                    Style = Unfavorable;
                }
            }
            repeater(Entries)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                    trigger OnDrillDown()
                    begin
                        OpenRotationCard();
                    end;
                }
                field("Rotation ID"; Rec."Rotation ID")
                {
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    begin
                        OpenRotationCard();
                    end;
                }
                field("Rotation No."; Rec."Rotation No.")
                {
                    ApplicationArea = All;
                }
                field("Hospital ID"; Rec."Hospital ID")
                {
                    ApplicationArea = All;
                }
                field("Hospital Name"; Rec."Hospital Name")
                {
                    ApplicationArea = All;
                }
                field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = All;
                }
                field("Course Description"; Rec."Course Description")
                {
                    ApplicationArea = All;
                }
                field("Course Type"; Rec."Course Type")
                {
                    ApplicationArea = All;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                }
                field("Total No. of Weeks"; Rec."Total No. of Weeks")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field(Score; Rec.Score)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Rotation Grade"; Rec."Rotation Grade")
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
            action("Assessment Input")
            {
                ApplicationArea = All;
                Caption = 'Assessment Input';
                Image = CalculateBalanceAccount;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                ShortcutKey = 'Ctrl+F5';

                trigger OnAction()
                Var
                    SubjectMaster: Record "Subject Master-CS";
                    StudentSubjectExam: Record "Student Subject Exam";
                    ClerkshipAssessmentInput: Page "Clerkship Assessment Input";
                    GroupCode: Code[20];
                    GroupDescription: Text[100];
                    CCSSEScore: Decimal;
                    CCSSEScoreII: Decimal;
                    CCSSEScoreIII: Decimal;
                    CCSSEExamDate: Date;
                    IICCSSEExamDate: Date;
                    IIICCSSEExamDate: Date;
                begin
                    if Rec."Clerkship Type" = Rec."Clerkship Type"::Core then begin
                        SubjectMaster.Reset();
                        SubjectMaster.SetRange(Code, Rec."Course Code");
                        if SubjectMaster.FindFirst() then
                            SubjectMaster.TestField("Subject Group");

                        GroupCode := SubjectMaster."Subject Group";
                        SubjectMaster.Reset();
                        SubjectMaster.SetRange(Code, GroupCode);
                        if SubjectMaster.FindFirst() then
                            GroupDescription := SubjectMaster.Description;

                        CCSSEScore := 0;
                        CCSSEScoreII := 0;
                        CCSSEScoreIII := 0;
                        CCSSEExamDate := 0D;
                        IICCSSEExamDate := 0D;
                        IIICCSSEExamDate := 0D;

                        StudentSubjectExam.Reset();
                        StudentSubjectExam.SetCurrentKey("Student No.", "Sitting Date");
                        StudentSubjectExam.SetRange("Student No.", Rec."Student ID");
                        StudentSubjectExam.SetRange("Score Type", StudentSubjectExam."Score Type"::CCSSE);
                        StudentSubjectExam.SetRange("Core Clerkship Subject Code", GroupCode);
                        if StudentSubjectExam.FindSet() then
                            repeat
                                if (CCSSEScore = 0) AND (CCSSEExamDate = 0D) then begin
                                    CCSSEScore := StudentSubjectExam."Shelf Exam Value";
                                    CCSSEExamDate := StudentSubjectExam."Sitting Date";
                                end
                                else
                                    if (CCSSEScoreII = 0) AND (IICCSSEExamDate = 0D) then begin
                                        CCSSEScoreII := StudentSubjectExam."Shelf Exam Value";
                                        IICCSSEExamDate := StudentSubjectExam."Sitting Date";
                                    END
                                    else
                                        if (CCSSEScoreIII = 0) AND (IIICCSSEExamDate = 0D) then begin
                                            CCSSEScoreIII := StudentSubjectExam."Shelf Exam Value";
                                            IIICCSSEExamDate := StudentSubjectExam."Sitting Date";
                                        end;
                            until StudentSubjectExam.Next() = 0;
                    end
                    else begin
                        GroupCode := Format(Rec."Clerkship Type");
                        GroupDescription := Format(Rec."Clerkship Type");
                    end;

                    Clear(ClerkshipAssessmentInput);
                    ClerkshipAssessmentInput.SetVariables(Rec."Student ID", Rec."Student Name", Rec."Rotation ID", Rec."Rotation No.", Rec."Clerkship Type", Rec."Course Code", Rec."Rotation Description", Rec."Start Date", Rec."End Date", GroupCode, GroupDescription, CCSSEScore, CCSSEScoreII, CCSSEScoreIII, Rec."Entry No.", CCSSEExamDate, IICCSSEExamDate, IIICCSSEExamDate);
                    ClerkshipAssessmentInput.RunModal();
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.FilterGroup(2);
        Rec.SetFilter("Rotation Grade", '%1|%2', '', 'M');
        // SetFilter("End Date", '<=%1', Today);
        Rec.SetFilter("Start Date", '<=%1', Today);//For Demo purpose As per Stuti
        Rec.SetRange("Assessment Completed", false);
        Rec.FilterGroup(0);
    end;

    procedure OpenRotationCard()
    var
        RSH: Record "Roster Scheduling Header";
    begin
        RSH.Reset();
        RSH.FilterGroup(2);
        RSH.SetRange("Rotation ID", Rec."Rotation ID");
        RSH.FilterGroup(0);

        if Rec."Clerkship Type" = Rec."Clerkship Type"::Core then
            Page.RunModal(Page::"Confirm Roster Scheduling Card", RSH);

        if Rec."Clerkship Type" = Rec."Clerkship Type"::"FM1/IM1" then
            Page.RunModal(Page::"FM1/IM1 Roster Card+", RSH);

        if Rec."Clerkship Type" = Rec."Clerkship Type"::Elective then
            Page.RunModal(Page::"Elective Rotation Card", RSH);
    end;
}