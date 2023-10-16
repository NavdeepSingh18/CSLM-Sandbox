page 51002 "MSPE Application List"
{
    Caption = 'MSPE Application List';
    Editable = false;
    CardPageId = "MSPE Application Card";
    PageType = List;
    ModifyAllowed = false;
    PromotedActionCategories = 'New,Process,Navigate';
    SourceTable = MSPE;
    // SourceTableView = sorting("Application No")
    //                   order(ascending)
    //                   where("Processing Status" = filter(Pending | "In-Progress"));
    UsageCategory = None;

    layout
    {
        area(Content)
        {
            repeater(Group1)
            {
                field("Application No"; Rec."Application No")
                {
                    ApplicationArea = All;
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = All;
                }
                field("Application Type"; Rec."Application Type")
                {
                    ApplicationArea = All;
                }
                field("Student No"; Rec."Student No")
                {
                    ApplicationArea = All;
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = All;
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }

                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
                field("Creation On"; Rec."Creation On")
                {
                    ApplicationArea = All;
                }
                field("Modified By"; Rec."Modified By")
                {
                    ApplicationArea = All;
                }
                field("Modified On"; Rec."Modified On")
                {
                    ApplicationArea = All;
                }

                field(Status; Rec."Processing Status")
                {
                    ApplicationArea = All;
                    Caption = 'Status';
                }


            }

        }

    }


}
