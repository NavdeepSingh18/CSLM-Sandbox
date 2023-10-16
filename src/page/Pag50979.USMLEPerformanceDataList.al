page 50979 "USMLE Performance Data"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'USMLE Performance Data List';
    SourceTable = "USMLE Performance Data";
    // InsertAllowed = false;
    DeleteAllowed = false;
    // Editable = false;
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    StyleExpr = BoolColor;

                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = All;
                    StyleExpr = BoolColor;

                }
                field("Rest of Name"; Rec."Rest of Name")
                {
                    ApplicationArea = All;
                    StyleExpr = BoolColor;

                }
                field("S/G"; Rec."S/G")
                {
                    ApplicationArea = All;
                    StyleExpr = BoolColor;

                }
                field("USMLE ID"; Rec."USMLE ID")
                {
                    ApplicationArea = All;
                    StyleExpr = BoolColor;
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        StudentMaster_lRec: Record "Student Master-CS";
                    begin
                        StudentMaster_lRec.Reset();
                        StudentMaster_lRec.SetFilter(USMLEID, '<>%1', '');
                        if StudentMaster_lRec.FindSet() then
                            If Page.RunModal(Page::"Student Details-CS", StudentMaster_lRec) = Action::LookupOK then begin
                                Rec."USMLE ID" := StudentMaster_lRec.USMLEID;
                            end;

                    end;

                }
                field("Unique Medical School ID"; Rec."Unique Medical School ID")
                {
                    ApplicationArea = All;
                    StyleExpr = BoolColor;

                }
                field("Step Exam"; Rec."Step Exam")
                {
                    ApplicationArea = All;
                    StyleExpr = BoolColor;

                }
                field("Date of Exam"; Rec."Date of Exam")
                {
                    ApplicationArea = All;
                    StyleExpr = BoolColor;

                }
                field("P/F"; Rec."P/F")
                {
                    ApplicationArea = All;
                    StyleExpr = BoolColor;

                }
                field("3 Digit Score"; Rec."3 Digit Score")
                {
                    ApplicationArea = All;
                    StyleExpr = BoolColor;

                }
                field("Score Available Until"; Rec."Score Available Until")
                {
                    ApplicationArea = All;
                    StyleExpr = BoolColor;

                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                    StyleExpr = BoolColor;

                }
                field("Publishing Document No."; Rec."Published Document No.")
                {
                    Editable = False;
                    ApplicationArea = All;
                    StyleExpr = BoolColor;

                }
                Field("Result Matched"; Rec."Result Matched")
                {
                    Editable = False;
                    ApplicationArea = All;
                    StyleExpr = BoolColor;

                }
                field(Published; Rec.Published)
                {
                    Editable = False;
                    ApplicationArea = All;
                    StyleExpr = BoolColor;

                }
                Field(Duplicate; Rec.Duplicate)
                {
                    Editable = False;
                    ApplicationArea = All;
                    StyleExpr = BoolColor;

                }
            }
        }

    }

    actions
    {
        area(Processing)
        {
            action("Student Card")
            {
                Visible = false;
                ApplicationArea = All;
                Image = Card;
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Caption = 'Student Card';
                Runobject = page "Student Detail Card-CS";
                RunPageLink = "Original Student No." = FIELD("Unique Medical School ID");
            }

            action("Delete")
            {
                ApplicationArea = All;
                Caption = 'Delete';
                Visible = true;
                Promoted = true;
                Promotedonly = True;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Process;

                trigger OnAction()
                var
                    UserSetupRec: Record "User Setup";
                    USMLEPerRec: Record "USMLE Performance Data";
                    StudentSubjectExamRec: Record "Student Subject Exam";
                    USMLERec: Record USMLE;
                    Txt0001Lbl: Label 'Do you want to delete the Selected Lines ?';
                begin
                    IF UserSetupRec.GET(UserId()) THEN
                        IF not UserSetupRec."Published Score Delete Allowed" THEN
                            Error('You do not have permission to delete the document.');

                    if Confirm(Txt0001Lbl, false) then begin
                        USMLEPerRec.Reset();
                        CurrPage.SetSelectionFilter(USMLEPerRec);
                        IF USMLEPerRec.FindSet() then begin
                            repeat
                                StudentSubjectExamRec.Reset();
                                StudentSubjectExamRec.SetRange("Score Type", USMLEPerRec."Step Exam");
                                StudentSubjectExamRec.SetRange("Published Entry No.", USMLEPerRec."Entry No.");
                                if StudentSubjectExamRec.FindFirst() then begin
                                    USMLERec.Reset();
                                    USMLERec.SetCurrentKey("Creation Date");
                                    USMLERec.Ascending(false);
                                    USMLERec.SetRange(UsmleID, Rec."USMLE ID");
                                    if Rec."Step Exam" = Rec."Step Exam"::"STEP 1" then
                                        USMLERec.SetRange(USMLEStepNumber, '1');
                                    if Rec."Step Exam" = Rec."Step Exam"::"STEP 2 CK" then
                                        USMLERec.SetRange(USMLEStepNumber, 'CK');
                                    if Rec."Step Exam" = Rec."Step Exam"::"STEP 2 CS" then
                                        USMLERec.SetRange(USMLEStepNumber, 'CS');

                                    USMLERec.Setrange(Block, False);
                                    USMLERec.SetFilter(USMLEWindowStartDate, '<=%1', StudentSubjectExamRec."Sitting Date");
                                    USMLERec.SetFilter(USMLEWindowEndDate, '>=%1', StudentSubjectExamRec."Sitting Date");
                                    if USMLERec.FindFirst() then begin
                                        USMLERec.Status := USMLERec.Status::" ";
                                        USMLERec.Score := '';
                                        USMLERec.USMLETestDate := 0D;
                                        USMLERec.Modify();
                                    end;
                                    StudentSubjectExamRec.Delete(true);

                                End;
                                USMLEPerRec.Delete();
                            until USMLEPerRec.Next() = 0;
                        end;

                    end else
                        exit;

                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    begin

        IF Rec."Result Matched" = true then
            BoolColor := 'favorable'
        else
            BoolColor := 'Unfavorable';
    end;

    trigger OnOpenPage()
    begin
        IF Rec."Result Matched" = true then
            BoolColor := 'favorable'
        else
            BoolColor := 'Unfavorable';

    end;

    var
        RecCBSECCSE: Record "CBSE CCSE Scores";
        RecCBSECCSE1: Record "CBSE CCSE Scores";
        CBSECCSEPort: XmlPort "CBSC CCSE Scores";
        Type1: Integer;

        BoolColor: text;

}