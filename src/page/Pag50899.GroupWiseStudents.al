page 50899 "Group Wise Students"
{
    Caption = 'Group Wise Students';
    Editable = true;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;
    UsageCategory = Lists;
    ApplicationArea = all;
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
                Caption = 'Select Group to Filter the Students';
                TableRelation = Group.code;
                trigger OnValidate()
                begin
                    if GroupCode <> '' then begin
                        GroupRec.Reset();
                        GroupRec.Get(GroupCode);
                        GrpDesc := GroupRec.Description;

                        Rec.SetRange("Groups Code", GroupCode);
                        CurrPage.update();
                    end
                    else begin
                        GrpDesc := '';
                        Rec.Reset();
                        CurrPage.update();
                    end;
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
                field(studentName; StudentName)
                {
                    ApplicationArea = all;
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

                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = All;
                    StyleExpr = BoolColor;
                }
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
            action("Student Group Ledger")
            {
                Caption = 'Student Group Ledger';
                Image = EntriesList;
                Promoted = true;
                PromotedIsBig = true;
                ApplicationArea = All;

                RunObject = Page "Student Group Ledger";
                RunPageLink = "Student No." = FIELD("Student No."),
                            "Group Code" = field("Groups Code");
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
        StudentName: Text[100];

    trigger OnAfterGetRecord()
    var
        Stud: Record "Student Master-CS";
    begin
        if Rec."OLR Hold Group" = true then
            BoolColor := 'Unfavorable'
        else
            BoolColor := 'favorable';
        if GroupCode <> '' then
            Rec.SetRange("Groups Code", GroupCode);
        if Stud.Get(Rec."Student No.") then
            StudentName := stud."Student Name";
    end;

    trigger OnOpenPage()
    begin
        if Rec."OLR Hold Group" = true then
            BoolColor := 'Unfavorable'
        else
            BoolColor := 'favorable';
    end;
}