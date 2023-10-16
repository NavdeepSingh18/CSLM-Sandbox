page 50300 "Course Sub Subform-CS"
{
    // version V.001-CS

    Caption = 'Course Sub Subform-CS';
    PageType = ListPart;
    // PageType = List;
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
                    Visible = false;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                    Visible = false;
                }

                field("Subject Code"; Rec."Subject Code")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Caption = 'Subject Description';
                }
                field("Subject Type"; Rec."Subject Type")
                {
                    ApplicationArea = All;
                }
                field("Subject Classification"; Rec."Subject Classification")
                {
                    ApplicationArea = All;
                }
                field("Exam Sequence"; Rec."Exam Sequence")
                {
                    ApplicationArea = all;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Additional Subject"; Rec."Additional Subject")
                {
                    ApplicationArea = all;
                }
                field(Year; Rec.Year)
                {
                    ApplicationArea = all;
                }
                field("Subject Group"; Rec."Subject Group")
                {
                    ApplicationArea = all;
                }
                field("Subject Group Description"; Rec."Subject Group Description")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                // field("Goal Code"; Rec."Goal Code")
                // {
                //     ApplicationArea = all;
                // }
                field(Level; Rec.Level)
                {
                    ApplicationArea = all;
                }
                field("Level Description"; Rec."Level Description")
                {
                    ApplicationArea = all;
                }
                field("Core Rotation Group"; Rec."Core Rotation Group")
                {
                    ApplicationArea = all;
                }
                field(Term; Rec.Term)
                {
                    ApplicationArea = All;
                }
                field("Term Description"; Rec."Term Description")
                {
                    ApplicationArea = All;
                }
                field(Examination; Rec.Examination)
                {
                    ApplicationArea = all;
                }
                field(Credit; Rec.Credit)
                {
                    ApplicationArea = All;
                }
                field("Internal Maximum"; Rec."Internal Maximum")
                {
                    ApplicationArea = All;
                }

                field("External Pass"; Rec."External Pass")
                {
                    ApplicationArea = All;
                }
                field("External Maximum"; Rec."External Maximum")
                {
                    ApplicationArea = All;
                }
                field("Total Pass"; Rec."Total Pass")
                {
                    ApplicationArea = All;
                }
                field("Total Maximum"; Rec."Total Maximum")
                {
                    ApplicationArea = All;
                }
                field("Minimum Passing Marks"; Rec."Minimum Passing Marks")
                {
                    ApplicationArea = All;
                }
                field("Applicable Batch"; Rec."Applicable Batch")
                {
                    ApplicationArea = All;
                }
                field("Synch to Blackboard"; Rec."Synch to Blackboard")//GAURAV//10.6.22//
                {
                    ApplicationArea = All;
                }
                field("Blackboard Group"; Rec."Blackboard Group")
                {
                    ApplicationArea = All;//END//
                }

            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Subject Wise Goal List")
            {
                Caption = '&Subject Wise Goal List';
                PromotedOnly = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = SetupList;
                ApplicationArea = All;
                RunObject = Page "Subject Goal List";
                RunPageLink = "Subject Code" = FIELD("Subject Code");

            }
        }
    }
}

