page 50075 "OLR Returning Student List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "OLR Update Header";
    Caption = 'OLR Returning Students Activation List';
    Editable = false;
    CardPageId = "OLR Returning Student Detail";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field(Term; Rec.Term)
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("OLR Academic Year"; Rec."OLR Academic Year")
                {
                    ApplicationArea = All;
                }
                field("OLR Semester"; Rec."OLR Semester")
                {
                    ApplicationArea = All;
                }
                field("OLR Term"; Rec."OLR Term")
                {
                    ApplicationArea = All;
                }
                field("OLR Start Date"; Rec."OLR Start Date")
                {
                    ApplicationArea = All;
                }

            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action("OLR Upload Process")
            {
                ApplicationArea = All;
                Image = Import;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = True;
                trigger OnAction()
                var
                    XML50081: XmlPort "Bulk Returning Student OLR";
                begin
                    Clear(XML50081);
                    XML50081.Run();
                end;
            }
        }
    }
}