page 50981 "USMLE List"
{
    PageType = List;
    SourceTable = USMLE;
    SourceTableView = SORTING("Entry No.") ORDER(Descending);
    // UsageCategory = Lists;
    // ApplicationArea = All;
    // AutoSplitKey = true;
    InsertAllowed = false;
    DeleteAllowed = true;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {

                field("Step Att. Ext."; Rec."Step Att. Ext.")
                {
                    // Editable = EditableVar;
                    Style = Strong;
                    Caption = 'Step Att. Ext.';
                    ApplicationArea = All;

                }
                field(USMLESentDate; Rec.USMLESentDate)
                {
                    // Editable = EditableVar;
                    Style = Strong;
                    Caption = 'Cert Sent';
                    ApplicationArea = All;
                }
                field(USMLETestWindow; Rec.USMLETestWindow)
                {
                    // Editable = EditableVar;
                    Style = Strong;
                    Caption = 'Test Window';
                    ApplicationArea = All;
                    trigger OnValidate()
                    var
                    begin
                        // if Block = true then
                        //     Error('You can not update windows ');  Rec.                       
                    end;
                }
                field(USMLETestDate; Rec.USMLETestDate)
                {
                    // Editable = EditableVar;
                    Style = Strong;
                    Caption = 'Test Date';
                    ApplicationArea = All;
                }
                field(Score; Rec.Score)
                {
                    // Editable = EditableVar;
                    Style = Strong;
                    ApplicationArea = All;
                    trigger OnValidate()
                    var
                    begin
                        SetEditable();
                    end;
                }
                field(Status; Rec.Status)
                {
                    // Editable = EditableVar;
                    ApplicationArea = All;
                    StyleExpr = StyleVar;
                    trigger OnValidate()
                    var
                        USMLERec: Record USMLE;
                    begin
                        SetEditable();
                        if Rec.Status = Rec.Status::"Can/Req" then
                            StyleVar := 'Ambiguous';
                        if Rec.Status = Rec.Status::Extended then
                            StyleVar := 'Ambiguous';
                        if Rec.Status = Rec.Status::Expired then
                            StyleVar := 'Ambiguous';
                        if Rec.Status = Rec.Status::Wating then
                            StyleVar := 'Ambiguous';
                        if Rec.Status = Rec.Status::Passed then
                            StyleVar := 'Favorable';
                        if Rec.Status = Rec.Status::Failed then
                            StyleVar := 'Attention';

                        USMLERec.Reset();
                        USMLERec.SetRange("Student ID", StudentID);
                        USMLERec.SetRange(USMLEStepNumber, Rec.USMLEStepNumber);
                        USMLERec.SetFilter("Entry No.", '%1', Rec."Entry No.");
                        USMLERec.SetFilter(Status, '%1|%2|%3', Rec.Status::"Can/Req", Rec.Status::Expired, Rec.Status::Extended);
                        USMLERec.SetRange(Block, false);
                        if USMLERec.FindFirst() then
                            repeat
                                USMLERec.Block := true;
                                USMLERec.Modify();
                            until USMLERec.Next() = 0;
                    end;
                }

            }
        }
        area(Factboxes)
        {
            part("USMLE Fact Box"; "USMLE Fact Box")
            {
                ApplicationArea = all;
                SubPageLink = "Entry No." = field("Entry No.");

            }

        }


    }

    actions
    {
        area(Processing)
        {
            action("Add USMLE Attempt")
            {
                Caption = 'Add USMLE Attempt';
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = MoveDown;
                // RunObject = page Confirmation;
                // RunPageLink = "Student ID" = field("Student ID");
                trigger OnAction();
                var
                    // USMLERec: Record USMLE;
                    ConfirmationPage: Page Confirmation;
                begin
                    Clear(ConfirmationPage);
                    ConfirmationPage.SetVariable(StudentID);
                    ConfirmationPage.RunModal();
                end;
            }

            action("USMLE Score")
            {
                ApplicationArea = All;
                Image = List;
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Trigger OnAction()
                var
                    StudentSubjecTExam: REcord "Student Subject Exam";
                    StudentSubjectExamList: Page "Student Subject Exam List";
                begin
                    StudentSubjecTExam.Reset();
                    StudentSubjecTExam.SetRange("Student No.", StudentID);  //"Original Student No."
                    StudentSubjecTExam.SetFilter("Score Type", '%1|%2|%3', StudentSubjecTExam."Score Type"::"STEP 1", StudentSubjecTExam."Score Type"::"STEP 2 CK", StudentSubjecTExam."Score Type"::"STEP 2 CS");
                    Clear(StudentSubjectExamList);
                    StudentSubjectExamList.SetTableView(StudentSubjecTExam);
                    StudentSubjectExamList.RunModal();
                end;
            }
        }
    }
    var
        USMLERec: Record USMLE;
        StudentID: Code[20];
        StyleVar: Text;
        EditableVar: Boolean;
    // StyleExprVar: Text;

    trigger OnOpenPage()
    var
    begin
        SetEditable();
        if Rec.Status = Rec.Status::"Can/Req" then
            StyleVar := 'Ambiguous';
        if Rec.Status = Rec.Status::Extended then
            StyleVar := 'Ambiguous';
        if Rec.Status = Rec.Status::Expired then
            StyleVar := 'Ambiguous';
        if Rec.Status = Rec.Status::Wating then
            StyleVar := 'Ambiguous';
        if Rec.Status = Rec.Status::Passed then
            StyleVar := 'Favorable';
        if Rec.Status = Rec.Status::Failed then
            StyleVar := 'Attention';
    end;

    trigger OnAfterGetRecord()
    var
    begin
        SetEditable();
        if Rec.Status = Rec.Status::"Can/Req" then
            StyleVar := 'Ambiguous';
        if Rec.Status = Rec.Status::Extended then
            StyleVar := 'Ambiguous';
        if Rec.Status = Rec.Status::Expired then
            StyleVar := 'Ambiguous';
        if Rec.Status = Rec.Status::Wating then
            StyleVar := 'Ambiguous';
        if Rec.Status = Rec.Status::Passed then
            StyleVar := 'Favorable';
        if Rec.Status = Rec.Status::Failed then
            StyleVar := 'Attention';

        USMLERec.Reset();
        USMLERec.SetRange("Student ID", StudentID);
        USMLERec.SetRange(USMLEStepNumber, Rec.USMLEStepNumber);
        USMLERec.SetFilter("Entry No.", '%1', Rec."Entry No.");
        USMLERec.SetFilter(Status, '%1|%2|%3', Rec.Status::"Can/Req", Rec.Status::Expired, Rec.Status::Extended);
        USMLERec.SetRange(Block, false);
        if USMLERec.FindFirst() then
            repeat
                USMLERec.Block := true;
                USMLERec.Modify();
            until USMLERec.Next() = 0;
    end;

    procedure SetVariable(LStudentID: Code[20])
    var
    begin
        StudentID := LStudentID;
    end;

    procedure SetEditable()
    var
    begin
        if Rec.Block = true then
            EditableVar := false;
    end;
}