page 50112 "Guardian Teacher List-CS"
{
    // version V.001-CS

    // Sr.No  Emp.Id      Date      Trigger          Remarks
    // -----------------------------------------------------------------------------------------------
    // 1.    CSPL-00174  13-05-19   OnOpenPage()     Code added for college wise page filter.

    PageType = List;
    UsageCategory = Administration;
    ApplicationArea = All;
    SourceTable = "Student Teacher Guardian-CS";
    Caption = 'Guardian Teacher List';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Enrollment No."; Rec."Enrollment No.")
                {
                    ApplicationArea = All;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                }
                field("Faculty Code"; Rec."Faculty Code")
                {
                    ApplicationArea = All;
                }
                field("Faculty Name"; Rec."Faculty Name")
                {
                    ApplicationArea = All;
                }
                field("Program"; Rec."Program")
                {
                    ApplicationArea = All;
                }
                field(Course; Rec.Course)
                {
                    ApplicationArea = All;
                }
                field("Course Name"; Rec."Course Name")
                {
                    ApplicationArea = All;
                }
                field(Section; Rec.Section)
                {
                    ApplicationArea = All;
                }
                field("Phone Number Student"; Rec."Phone Number Student")
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field("Hostler/ Day Scholar"; Rec."Hostler/ Day Scholar")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Mentors Import \ Export")
            {
                Image = XMLFile;
                Promoted = true;
                PromotedOnly = true;
                RunObject = XMLport 50051;
                ApplicationArea = All;
            }
        }
    }

    trigger OnOpenPage()
    begin
        //Code added for college wise page filter::CSPL-00174::130519: Start
        IF recUserSetup.GET(UserId()) THEN BEGIN
            Rec.FILTERGROUP(2);
            IF recUserSetup."Global Dimension 1 Code" <> '' THEN
                Rec.SETFILTER("Global Dimension 1 Code", recUserSetup."Global Dimension 1 Code");
            Rec.FILTERGROUP(0);
        END;
        //Code added for college wise page filter::CSPL-00174::130519: End
    end;

    var
        recUserSetup: Record "User Setup";
}