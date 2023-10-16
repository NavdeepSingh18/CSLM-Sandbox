page 51054 GradeBooksPendApp
{
    PageType = List;
    Caption = 'Grade Books Pending For Approval';
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = GradeBookHeader;
    SourceTable = "Grade Book Header";
    //SourceTableView = where(Status = Filter("Pending For Approval"));

    Editable = false;
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                // Field(Course; Course)
                // {
                //     ApplicationArea = All;
                //     Visible = "Global Dimension 1 Code" = '9100';
                // }

                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                field("Academic year"; Rec."Academic year")
                {
                    ApplicationArea = All;
                }
                field(Term; Rec.Term)
                {
                    ApplicationArea = All;
                }
            }
        }
        area(Factboxes)
        {

        }
    }


    trigger OnOpenPage()
    begin
        Rec.SetRange(Status, Rec.Status::"Pending For Approval");
        Rec.SetFilter("To Be Approved By", '%1', Userid());
    end;
}