page 50059 "Faculty-Course Wise"
{
    // version V.001-CS

    // Sr.No  Emp.Id      Date      Trigger           Remarks
    // -----------------------------------------------------------------------------------------------
    // 01.   CSPL-00174  11-05-19   OnOpenPage()     Code added for Academic Year Wise Page Filter.

    AutoSplitKey = true;
    PageType = List;
    UsageCategory = Administration;
    ApplicationArea = All;
    SourceTable = "Faculty Course Wise-CS";
    Caption = 'Faculty-Course Wise';

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
                field("Line No"; Rec."Line No")
                {
                    ApplicationArea = All;
                }
                field(Graduation; Rec.Graduation)
                {
                    ApplicationArea = All;
                }
                field("Year Code"; Rec."Year Code")
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field("Semester Code"; Rec."Semester Code")
                {
                    ApplicationArea = All;
                }
                field("Section Code"; Rec."Section Code")
                {
                    ApplicationArea = All;
                }
                field("Subject Class"; Rec."Subject Class")
                {
                    ApplicationArea = All;
                }
                field("Subject Type"; Rec."Subject Type")
                {
                    ApplicationArea = All;
                }
                field("Subject Code"; Rec."Subject Code")
                {
                    ApplicationArea = All;
                }
                field("Subject Description"; Rec."Subject Description")
                {
                    ApplicationArea = All;
                }
                field(Batch; Rec.Batch)
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
                field("Category Code"; Rec."Category Code")
                {
                    ApplicationArea = All;
                }
                field("Category Description"; Rec."Category Description")
                {
                    ApplicationArea = All;
                }
                field(Role; Rec.Role)
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
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
            action("Create Course Wise Faculty")
            {
                ToolTip = 'Create Course Wise Faculty';
                Image = GetLines;
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                RunObject = Page "Course Faculty Generation-CS";
                ApplicationArea = All;
            }

            action("Import Export Course wise Faculty")
            {
                ToolTip = 'Import Export Course wise Faculty';
                Image = XMLFile;
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                RunObject = XMLport "Faculty Course Wise-CS";
                ApplicationArea = All;
            }
        }
    }

    trigger OnOpenPage()
    begin
        //Code added for Academic Year Wise Page Filter::CSPL-00174::110519: Start
        EducationSetupCS.Reset();
        IF EducationSetupCS.FINDFIRST() THEN
            AddYear := EducationSetupCS."Academic Year";
        Rec.SETFILTER("Academic Year", AddYear);
        //Code added for Academic Year Wise Page Filter::CSPL-00174::110519: End
    end;

    var
        EducationSetupCS: Record "Education Setup-CS";
        AddYear: Code[20];
}

