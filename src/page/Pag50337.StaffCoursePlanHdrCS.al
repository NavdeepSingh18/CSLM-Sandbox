page 50337 "Staff Course Plan Hdr-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                     Remarks
    // ----------------------------------------------------------------------------------------
    // 01    CSPL-00059   14/02/2019      OnOpenPage()                    Code added for open page college wise & field editable non editable.
    // 02    CSPL-00059   14/02/2019      OnAfterGetRecord()              Code added for field editable non editable.
    // 03    CSPL-00059   14/02/2019      Course Code - OnValidate()      Code added for field editable non editable.
    // 04    CSPL-00059   14/02/2019      Type Of Course-OnValidate()     Code added for field editable non editable.
    // 05    CSPL-00059   14/02/2019      <Action1102155018>-OnAction()   Code added for allow plan.
    // 06    CSPL-00059   14/02/2019      <Action1102155019>-OnAction()   Code added for plan approval.
    // 07    CSPL-00059   14/02/2019      <Action1102155020>-OnAction()   Code added for plan reject.
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Faculty Course Plan Header-COL';
    PageType = Card;
    SourceTable = "Course Plan Head Faculty-CS";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Subject Code"; Rec."Subject Code")
                {
                    ApplicationArea = All;
                }
                field("Faculty Code"; Rec."Faculty Code")
                {
                    ApplicationArea = All;
                }
                field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        //Code added for field editable non editable::CSPL-00059::14022019: Start
                        IF Rec."Type Of Course" = Rec."Type Of Course"::Year THEN BEGIN
                            EditableBTNSEM := FALSE;
                            EditableBTNYR := TRUE;
                        END ELSE BEGIN
                            EditableBTNYR := FALSE;
                            EditableBTNSEM := TRUE;
                        END;
                        //Code added for field editable non editable::CSPL-00059::14022019: End
                    end;
                }
                field("Type Of Course"; Rec."Type Of Course")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        //Code added for field editable non editable::CSPL-00059::14022019: Start
                        IF Rec."Type Of Course" = Rec."Type Of Course"::Year THEN BEGIN
                            EditableBTNSEM := FALSE;
                            EditableBTNYR := TRUE;
                        END ELSE BEGIN
                            EditableBTNYR := FALSE;
                            EditableBTNSEM := TRUE;
                        END;
                        //Code added for field editable non editable::CSPL-00059::14022019: End
                    end;
                }
                field("Semester Code"; Rec."Semester Code")
                {
                    ApplicationArea = All;
                    Editable = EditableBTNSEM;
                }
                field(Year; Rec.Year)
                {
                    ApplicationArea = All;
                    Editable = EditableBTNYR;
                }
                field(Section; Rec.Section)
                {
                    ApplicationArea = All;
                }
                field(Department; Rec.Department)
                {
                    ApplicationArea = All;
                }
                field("Total Week Hours"; Rec."Total Week Hours")
                {
                    ApplicationArea = All;
                }
                field(Group; Rec.Group)
                {
                    ApplicationArea = All;
                }
                field(Batch; Rec.Batch)
                {
                    ApplicationArea = All;
                }
                field("Plan Status"; Rec."Plan Status")
                {
                    ApplicationArea = All;
                }
            }
            part("Staff Course Plan Line-CS"; "Staff Course Plan Line-CS")
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = FIELD("No.");
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("F&unction")
            {
                Caption = 'F&unction';
                action(Apply)
                {
                    Caption = 'Apply';
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        //Code added for allow Plan::CSPL-00059::14022019: Start
                        WorkOfSchemeCS.ApplyStaffPlan(Rec."No.");
                        //Code added for allow plan::CSPL-00059::14022019: End
                    end;
                }
                action("A&pprove")
                {
                    Caption = 'A&pprove';
                    Image = Approve;
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        //Code added for plan approval::CSPL-00059::14022019: Start
                        WorkOfSchemeCS.ApproveStaffPlan(Rec."No.");
                        //Code added for plan approval::CSPL-00059::14022019: End
                    end;
                }
                action(Reject)
                {
                    Caption = 'Reject';
                    Image = Reject;
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        //Code added for plan reject::CSPL-00059::14022019: Start
                        WorkOfSchemeCS.RejectStaffPlan(Rec."No.");
                        //Code added for plan reject::CSPL-00059::14022019: End
                    end;
                }
            }
            group("F&aculty Course Plan")
            {
                Caption = 'F&aculty Course Plan';
                action("&List")
                {
                    Caption = '&List';
                    RunObject = Page 50221;
                    ShortCutKey = 'Shift+Ctrl+L';
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        //Code added for field editable non editable::CSPL-00059::14022019: Start
        IF Rec."Type Of Course" = Rec."Type Of Course"::Year THEN BEGIN
            EditableBTNSEM := FALSE;
            EditableBTNYR := TRUE;
        END ELSE BEGIN
            EditableBTNYR := FALSE;
            EditableBTNSEM := TRUE;
        END;
        //Code added for field editable non editable::CSPL-00059::14022019: End
    end;

    trigger OnOpenPage()
    begin
        //Code added for open page college wise and field editable non editable::CSPL-00059::14022019: Start
        IF recUserSetup.GET(UserId()) THEN BEGIN
            Rec.FILTERGROUP(2);
            IF recUserSetup."Global Dimension 1 Code" <> '' THEN
                Rec.SETFILTER("Global Dimension 1 Code", recUserSetup."Global Dimension 1 Code");
            Rec.FILTERGROUP(0);
        END;


        EditableBTNSEM := FALSE;
        EditableBTNYR := FALSE;
        //Code added for open page college wise and field editable non editable::CSPL-00059::14022019: End
    end;

    var
        recUserSetup: Record "User Setup";
        WorkOfSchemeCS: Codeunit "Work Of Scheme -CS";
        EditableBTNSEM: Boolean;
        EditableBTNYR: Boolean;

}

