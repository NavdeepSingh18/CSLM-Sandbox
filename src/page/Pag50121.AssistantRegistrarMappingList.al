page 50121 "Assistant Registrar Mapping"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Test1-CS";
    CardPageId = "Assistant Registrar Card";
    Caption = 'Assistant Registrar Mapping';
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Entry No"; Rec."Entry No")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Start Alpha Range"; Rec."Start Alpha Range")
                {
                    ApplicationArea = All;
                }
                field("End Alpha Range"; Rec."End Alpha Range")
                {
                    ApplicationArea = All;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                }
                field("User Name"; Rec."User Name")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
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
            action("View Mapped Students")
            {
                ApplicationArea = All;
                Caption = 'View Mapped Students';
                ShortcutKey = 'Ctrl+M';
                PromotedOnly = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = MapDimensions;

                trigger OnAction()
                begin
                    Rec.ViewStudentsWithUserList();
                end;
            }
        }
    }
    procedure OpenCardPage()
    var
        CCP: Record "Test1-CS";
        CLNCoordinatorPlanningCRD: Page "Assistant Registrar Card";
    begin
        CCP.Reset();
        CCP.SetRange("Entry No", Rec."Entry No");
        Clear(CLNCoordinatorPlanningCRD);
        CLNCoordinatorPlanningCRD.SetRecord(CCP);
        CLNCoordinatorPlanningCRD.SetTableView(CCP);
        CLNCoordinatorPlanningCRD.RunModal();
    end;
}