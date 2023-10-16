page 50143 "Stud Placement List-CS"
{
    // version V.001-CS

    // Sr.No  Emp.ID      Date      Trigger                Remarks
    // -----------------------------------------------------------------------------------------------
    // 01.   CSPL-00174  08-07-19   Post - OnAction()     Code added to modify field.

    CardPageID = "Association List-CS";
    PageType = List;
    UsageCategory = Administration;
    ApplicationArea = All;
    SourceTable = "Student Placement History-CS";
    SourceTableView = WHERE(Closed = FILTER(false));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Schedule ID"; Rec."Schedule ID")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Registration ID"; Rec."Registration ID")
                {
                    ApplicationArea = All;
                }
                field("Student ID"; Rec."Student ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                }
                field("Company Id"; Rec."Company Id")
                {
                    ApplicationArea = All;
                }
                field("Company Name"; Rec."Company Name")
                {
                    ApplicationArea = All;
                }
                field("Campus Date"; Rec."Campus Date")
                {
                    ApplicationArea = All;
                }
                field("Exam Clear"; Rec."Exam Clear")
                {
                    ApplicationArea = All;
                }
                field("Technical Clear"; Rec."Technical Clear")
                {
                    ApplicationArea = All;
                }
                field("HR Clear"; Rec."HR Clear")
                {
                    ApplicationArea = All;
                }
                field(Placed; Rec.Placed)
                {
                    ApplicationArea = All;
                }
                field("Offer Letter"; Rec."Offer Letter")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Placement History")
            {
                Caption = '&Placement History';
                action(Post)
                {
                    Caption = '&Post';
                    Image = Post;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        //Code added to modify filed::CSPL-00174::080719: Start
                        Rec.Closed := TRUE;
                        Rec.Modify();
                        IF Rec."Schedule ID" <> '' THEN
                            MESSAGE(Text001Lbl);
                        //Code added to modify filed::CSPL-00174::080719: End
                    end;
                }
            }
        }
    }

    var
        Text001Lbl: Label 'Details are Posted Sucessfully';
}