page 50008 "Course Subject Detail L-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID        Date        Trigger                Remarks
    // -----------------------------------------------------------------------------------------------
    // 01.     CSPL-00174   05-01-19     OnOpenPage()           Code added for academic year wise page filter.

    Caption = 'Course Subject Detail L-CS';
    Editable = false;
    PageType = List;
    UsageCategory = Administration;
    ApplicationArea = All;
    SourceTable = "Course Wise Subject Line-CS";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                field("Subject Code"; Rec."Subject Code")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Specilization; Rec.Specilization)
                {
                    ApplicationArea = All;
                }
                field("Subject Type"; Rec."Subject Type")
                {
                    ApplicationArea = All;
                }
                field(Credit; Rec.Credit)
                {
                    ApplicationArea = All;
                }
                field("Group Code"; Rec."Group Code")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field("Elective Group Code"; Rec."Elective Group Code")
                {
                    ApplicationArea = All;
                }
                field("Synch to Blackboard"; Rec."Synch to Blackboard")
                {
                    ApplicationArea = All;
                }
                field("Blackboard Group"; Rec."Blackboard Group")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        //Code added to academic year wise page filter and editable or non-editable field::CSPL-00174::010519: Start

        UserSetup.GET(UserId());

        EducationSetupCS.Reset();
        EducationSetupCS.SetRange("Global Dimension 1 Code", UserSetup."Global Dimension 1 Code");
        IF EducationSetupCS.FINDFIRST() THEN
            AddYear := EducationSetupCS."Academic Year";
        Rec.SETFILTER("Academic Year", AddYear);
        //Code added to academic year wise page filter and editable or non-editable field::CSPL-0017::010519: END
    end;

    var
        UserSetup: Record "User Setup";
        EducationSetupCS: Record "Education Setup-CS";
        AddYear: Code[20];
}

