page 50794 "Student Group"
{
    Caption = 'Student Group';
    Editable = true;
    InsertAllowed = true;
    DeleteAllowed = false;
    PageType = List;
    PromotedActionCategories = 'New,Process,Navigate';
    SourceTable = "Student Group";
    SourceTableView = order(ascending) where(Blocked = filter(false));
    RefreshOnActivate = true;

    DelayedInsert = true;

    layout
    {
        area(Content)
        {
            field(GroupCode; GroupCode)
            {
                ApplicationArea = all;
                Caption = 'Select Group Code to Assign / Unassign';
                TableRelation = Group.code;
                trigger OnValidate()
                begin
                    if GroupCode <> '' then begin
                        GroupRec.Reset();
                        GroupREc.Get(GroupCode);
                        GrpDesc := GroupRec.Description;
                    end
                    else
                        GrpDesc := '';
                end;
            }
            field(Grpdesc; GrpDesc)
            {
                ApplicationArea = all;
                Caption = 'Group Description';
                Editable = false;
            }
            repeater(Group1)
            {
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                    StyleExpr = BoolColor;
                }
                field("Groups Code"; Rec."Groups Code")
                {
                    ApplicationArea = All;
                    StyleExpr = BoolColor;
                    // TableRelation = "Student Hold"."Group Code" where("Hold Type" = filter(" "));

                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }

                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                    StyleExpr = BoolColor;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                    StyleExpr = BoolColor;
                }
                field(Term; Rec.Term)
                {
                    ApplicationArea = All;
                    StyleExpr = BoolColor;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                    StyleExpr = BoolColor;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                    StyleExpr = BoolColor;
                }
                field("Creation Date"; Rec."Creation Date")
                {
                    ApplicationArea = All;
                    StyleExpr = BoolColor;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    StyleExpr = BoolColor;
                }
                field("Modified On"; Rec."Modified On")
                {
                    ApplicationArea = All;
                    StyleExpr = BoolColor;
                }
                field("Modified By"; Rec."Modified By")
                {
                    ApplicationArea = All;
                    StyleExpr = BoolColor;
                }

                // field(Blocked;Rec.Blocked)
                // {
                //     ApplicationArea = All;
                //     StyleExpr = BoolColor;
                // }
                field("OLR Hold Group"; Rec."OLR Hold Group")
                {
                    ApplicationArea = All;
                    StyleExpr = BoolColor;
                    Editable = false;
                }
            }

        }
    }
    actions
    {
        area(Processing)
        {

            action("Assign Group")
            {
                Caption = 'Assign Group';
                Image = Add;
                PromotedCategory = Process;
                Promoted = true;
                PromotedIsBig = true;
                ApplicationArea = All;
                trigger OnAction()
                var
                    StudentTimeLineRec: Record "Student Time Line";
                    GroupRec: Record Group;
                begin
                    if GroupCode <> '' then begin
                        StudentHold.Reset();
                        StudentHold.SetRange("Group Code", GroupCode);
                        StudentHold.SetFilter("Hold Type", '<>%1', StudentHold."Hold Type"::" ");
                        if StudentHold.FindFirst() then
                            Error('You can not Assign Groups related to OLR Hold');

                        if confirm('Do you want to assign Group %1 ?', false, GroupCode) then begin
                            StudentGroup.AssignStudentGroup(Rec, GroupCode);
                            StudentGroup.AssignStudentWiseHold(Rec, GroupCode);
                            GroupRec.Reset();
                            If GroupRec.Get(GroupCode) then;
                            StudentTimeLineRec.InsertRecordFun(Rec."Student No.", Rec."Student Name", GroupRec.Description + ' has been assign', USerID(), Today());
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
                PromotedIsBig = true;
                ApplicationArea = All;
                trigger OnAction()
                var
                    StudentTimeLineRec: Record "Student Time Line";
                    GroupRec: Record Group;
                begin
                    if GroupCode <> '' then begin
                        StudentHold.Reset();
                        StudentHold.SetRange("Group Code", GroupCode);
                        StudentHold.SetFilter("Hold Type", '<>%1', StudentHold."Hold Type"::" ");
                        if StudentHold.FindFirst() then
                            Error('You can not Unassign Groups related to OLR Hold');

                        if confirm('Do you want to Unassign Group %1 ?', false, GroupCode) then begin
                            StudentGroup.UnassignStudentGroup(Rec, GroupCode);
                            StudentGroup.UnassignStudentWiseHold(Rec, GroupCode);
                            GroupRec.Reset();
                            If GroupRec.Get(GroupCode) then;
                            StudentTimeLineRec.InsertRecordFun(Rec."Student No.", Rec."Student Name", GroupRec.Description + ' has been unassign', UserId(), Today());
                            Message('Group %1 has been unassigned', GroupCode);
                        end;
                    end;
                end;
            }

            action("Student Group Ledger")
            {
                Caption = 'Student Group Ledger';
                Image = EntriesList;
                Promoted = true;
                PromotedIsBig = true;
                ApplicationArea = All;

                RunObject = Page "Student Group Ledger";
                RunPageLink = "Student No." = FIELD("Student No."),
                            "Group Code" = field("Groups Code"),
                            "Global Dimension 1 Code" = field("Global Dimension 1 Code");

            }
        }
    }
    var
        GroupCode: Code[20];
        GroupRec: Record Group;
        GrpDesc: Text[60];
        BoolColor: Text;
        StudentHold: Record "Student Hold";
        StudentGroup: Record "Student Group";

    trigger OnAfterGetRecord()
    begin
        if Rec."OLR Hold Group" = true then
            BoolColor := 'Unfavorable'
        else
            BoolColor := 'favorable';
    end;

    trigger OnOpenPage()
    begin
        if Rec."OLR Hold Group" = true then
            BoolColor := 'Unfavorable'
        else
            BoolColor := 'favorable';
    end;
}