page 50138 "Roll No. & Student Section-CS"
{
    // version V.001-CS

    // Sr.No  Emp.ID      Date      Trigger                           Remarks
    // -----------------------------------------------------------------------------------------------
    // 01.   CSPL-00174  03-07-19   Batch Allotment  - OnAction()     Code added for Batch Allotment.
    ApplicationArea = All;
    UsageCategory = Administration;
    DeleteAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Student Master-CS";

    layout
    {
        area(content)
        {
            repeater(Option)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'No.';
                    ApplicationArea = All;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ToolTip = 'Student Name';
                    ApplicationArea = All;
                }
                field("Course Code"; Rec."Course Code")
                {
                    ToolTip = 'Student Name';
                    ApplicationArea = All;
                }
                field(Year; Rec.Year)
                {
                    ToolTip = 'Year';
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    ToolTip = 'Semester';
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ToolTip = 'Academic Year';
                    ApplicationArea = All;
                }
                field("Fee Classification Code"; Rec."Fee Classification Code")
                {
                    ToolTip = 'Fee Classification Code';
                    ApplicationArea = All;
                }
                field(Gender; Rec.Gender)
                {
                    ToolTip = 'Gender';
                    ApplicationArea = All;
                }
                field("Enrollment No."; Rec."Enrollment No.")
                {
                    ToolTip = 'Enrollment No.';
                    ApplicationArea = All;
                }
                field(Section; Rec.Section)
                {
                    ToolTip = 'Section';
                    ApplicationArea = All;
                }
                field("Roll No."; Rec."Roll No.")
                {
                    ToolTip = 'Roll No.';
                    ApplicationArea = All;
                }
                field(Group; Rec.Group)
                {
                    ToolTip = 'Group';
                    ApplicationArea = All;
                }
                field("Latest GPA"; Rec."Latest GPA")
                {
                    ToolTip = 'Latest GPA';
                    ApplicationArea = All;
                    Caption = 'Latest GPA';
                }
                field("Section & Roll No."; Rec."Section & Roll No.")
                {
                    ToolTip = 'Section & Roll No.';
                    ApplicationArea = All;
                }
                field(Batch; Rec.Batch)
                {
                    ToolTip = 'Batch';
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("Ist Year")
            {
                action("Section Allot 1st Yr")
                {
                    ToolTip = 'Section Allot 1st Yr';
                    Image = Allocate;
                    Promoted = true;

                    PromotedOnly = true;
                    PromotedCategory = Process;
                    RunObject = Report 50116;
                    ApplicationArea = All;
                }
                action("Roll No. Allot 1st Yr")
                {
                    ToolTip = 'Roll No. Allot 1st Yr';
                    Image = Allocate;
                    Promoted = true;

                    PromotedOnly = True;
                    PromotedCategory = Process;
                    RunObject = Report 50120;
                    ApplicationArea = All;
                }
            }
            group("Rest Year")
            {
                action("Section Allot Rest Yr")
                {
                    ToolTip = 'Section Allot Rest Yr';
                    Image = Allocate;
                    Promoted = true;

                    PromotedOnly = True;
                    PromotedCategory = "Report";
                    RunObject = Report 50024;
                    ApplicationArea = All;
                }
                action("Roll No. Allot Rest Yr")
                {
                    ToolTip = 'Roll No. Allot Rest Yr';
                    Image = Allocate;
                    Promoted = true;

                    PromotedOnly = True;
                    PromotedCategory = "Report";
                    RunObject = Report 50025;
                    ApplicationArea = All;
                }
                /*  action("Edit Student")
                  {
                      ToolTip = 'Edit Student';
                      Image = Edit;
                      Promoted = true;

                      PromotedOnly = True;
                      PromotedCategory = New;
                      ApplicationArea = All;
                  }*/
            }
            group("Batch Allotment")
            {
                action("Batch Allotment ")
                {
                    ToolTip = 'Batch Allotment ';
                    Promoted = true;

                    PromotedOnly = True;
                    ApplicationArea = All;
                    trigger OnAction()
                    VAR
                        InformationOfStudentCS: Codeunit StudentsInfoCSCSLM;
                    begin
                        //Code added for Batch Allotment ::CSPL-00174::030719: Start
                        InformationOfStudentCS.BatchAllotmentWithoutRollNoCS('09');
                        //Code added for Batch Allotment::CSPL-00174::060519: End
                    end;
                }
            }
        }
    }

    var
}