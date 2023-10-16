page 50061 OLRUpdateLine
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "OLR Update Line";
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;
    Caption = 'Returning Student Activation Details';

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
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;

                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;

                }
                field("Enrollment No."; Rec."Enrollment No.")
                {
                    ApplicationArea = All;

                }
                field("OLR Academic Year"; Rec."OLR Academic Year")
                {
                    ApplicationArea = All;

                }
                Field("OLR Semester"; Rec."OLR Semester")
                {
                    ApplicationArea = All;

                }
                field("OLR Term"; Rec."OLR Term")
                {
                    ApplicationArea = All;

                }
                field(Confirmed; Rec.Confirmed)
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
    var
        educationSetup: Record "Education Setup-CS";
    begin
        educationSetup.Reset();
        educationSetup.SetRange("Global Dimension 1 Code", '9000');
        educationSetup.FindFirst();
        educationSetup.FilterGroup(2);
        Rec.SetFilter("OLR Academic Year", educationSetup."Returning OLR Academic Year");
        Rec.Setrange("OLR Term", educationSetup."Returning OLR Term");
        educationSetup.FilterGroup(0);
    end;
}