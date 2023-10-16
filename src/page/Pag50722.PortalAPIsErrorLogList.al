page 50722 "Portal APIs Error Log List"
{
    // version V.001-CS

    PageType = List;
    UsageCategory = Administration;
    ApplicationArea = All;
    SourceTable = "Portal APIs Error Log";
    SourceTableView = sorting("Entry No") ORDER(Descending);
    DeleteAllowed = True;
    InsertAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No"; Rec."Entry No")
                {

                    ApplicationArea = All;

                }
                field("Table Name"; Rec."Table Name")
                {

                    ApplicationArea = All;
                }
                field("API Responses"; Rec."API Responses")
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
                field("Modified On"; Rec."Modified On")
                {
                    ApplicationArea = ALl;
                }
                field("Modified By"; Rec."Modified By")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}

