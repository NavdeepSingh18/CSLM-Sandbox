page 50637 "Student Detail"
{
    Caption = 'Student Detail';
    CardPageID = "Student Detail Card-CS";
    Editable = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = "Student Master-CS";
    SourceTableView = SORTING("No.")
                      ORDER(Ascending);
    UsageCategory = None;

    layout
    {
        area(content)
        {
            repeater(Group1)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    begin
                        StudentMasterCS.Reset();
                        StudentMasterCS.SetRange("No.", Rec."No.");
                        StudentCard.SetTableView(StudentMasterCS);
                        StudentCard.Editable := false;
                        StudentCard.Run();
                    end;
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = All;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = All;
                }
                field("E-Mail Address"; Rec."E-Mail Address")
                {
                    ApplicationArea = All;
                }
                field("Mobile Number"; Rec."Mobile Number")
                {
                    ApplicationArea = All;
                }
                field("Phone Number"; Rec."Phone Number")
                {
                    ApplicationArea = All;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
            }
        }
    }



    var
        StudentMasterCS: Record "Student Master-CS";
        StudentCard: Page "Student Detail Card-CS";

    trigger OnOpenPage()
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.Get(UserId());
        Rec.SetFilter("Global Dimension 1 Code", UserSetup."Global Dimension 1 Code");
    end;

}