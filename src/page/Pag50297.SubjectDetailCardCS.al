page 50297 "Subject Detail Card-CS"
{
    // version V.001-CS

    // Sr.No.    Emp. ID     Date          Trigger                             Remarks
    // 1         CSPL-00092    05-06-2019    OnOpenPage                          Condition Base Flag True or False
    // 2         CSPL-00092    05-06-2019    OnAfterGetRecord                    Condition Base Flag True or False
    // 3         CSPL-00092    05-06-2019    Subject Type - OnValidate           Condition Base Flag True or False
    // 4         CSPL-00092    05-06-2019    Type Of Course - OnValidate         Condition Base Flag True or False
    // 5         CSPL-00092    05-06-2019    Upload Student - OnAction           Run XMLPort

    UsageCategory = None;
    Caption = 'Subject Master Card';
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = "Subject Master-CS";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                Editable = EditList;
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("CCSSE Exam Description"; Rec."CCSSE Exam Description")
                {
                    ApplicationArea = All;
                }
                field("Subject Type"; Rec."Subject Type")
                {
                    ApplicationArea = All;

                }
                field("Subject Classification"; Rec."Subject Classification")
                {
                    ApplicationArea = All;
                }
                field(Level; Rec.Level)
                {
                    ApplicationArea = all;
                }
                field("Level Code"; Rec."Level Code")
                {
                    ApplicationArea = all;
                }
                field("Level Description"; Rec."Level Description")
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
                field("Core Rotation Group"; Rec."Core Rotation Group")
                {
                    ApplicationArea = all;
                }
                // field("Goal Code"; Rec."Goal Code")
                // {
                //     ApplicationArea = All;
                // }
                field("Category Code"; Rec."Category Code")
                {
                    ApplicationArea = All;
                }
                field("Category Description"; Rec."Category Description")
                {
                    ApplicationArea = All;
                }
                field(Credit; Rec.Credit)
                {
                    ApplicationArea = All;
                }

                field("Subject Prefix"; Rec."Subject Prefix")
                {
                    ApplicationArea = all;
                }

                field(Duration; Rec.Duration)
                {
                    ApplicationArea = All;
                }

                field("Subject Closed"; Rec."Subject Closed")
                {
                    ApplicationArea = All;
                }
                field(Examination; Rec.Examination)
                {
                    ApplicationArea = all;
                }
                field("Exam Schedule"; Rec."Exam Schedule")
                {
                    ApplicationArea = all;
                }
                field("Exam Record Not Required"; Rec."Exam Record Not Required")
                {
                    ApplicationArea = all;
                }
                field("Exam Sequence"; Rec."Exam Sequence")
                {
                    ApplicationArea = All;
                }
                field("Score Type"; Rec."Score Type")
                {
                    ApplicationArea = all;
                }
                field("Max Capacity of Lab"; Rec."Max Capacity of Lab")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field(Course; Rec.Course)
                {
                    ApplicationArea = All;
                }

                field("Type Of Course"; Rec."Type Of Course")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        //Code added for Condition Base Flag True or False::CSPL-00092::05-06-2019: Start
                        IF Rec."Type Of Course" = Rec."Type Of Course"::Year THEN BEGIN
                            EditableBTNSEM := FALSE;
                            EditableBTNYR := TRUE;
                        END ELSE BEGIN
                            EditableBTNYR := FALSE;
                            EditableBTNSEM := TRUE;
                        END;
                        //Code added for Condition Base Flag True or False::CSPL-00092::05-06-2019: End
                    end;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                    Editable = EditableBTNSEM;
                }
                field(Year; Rec.Year)
                {
                    ApplicationArea = All;
                    Editable = EditableBTNYR;
                }
                field("Group Code"; Rec."Group Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("External Pass"; Rec."External Pass")
                {
                    ApplicationArea = All;
                    Visible = true;
                }
                field("Internal Maximum"; Rec."Internal Maximum")
                {
                    ApplicationArea = All;
                }
                field("Maximum Weightage"; Rec."Maximum Weightage")
                {
                    ApplicationArea = All;
                }
                field("External Maximum"; Rec."External Maximum")
                {
                    ApplicationArea = All;
                }
                field("Total Maximum"; Rec."Total Maximum")
                {
                    ApplicationArea = All;
                }
                field("Exam Fee"; Rec."Exam Fee")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Elective Group Code"; Rec."Elective Group Code")
                {
                    ApplicationArea = All;
                    // Editable = EditableElective;
                }
                field("Assign max marks"; Rec."Assign max marks")
                {
                    ApplicationArea = All;
                }
                field("Applicable Batch"; Rec."Applicable Batch")
                {
                    ApplicationArea = All;
                }
                field("Number of Lab Component"; Rec."Number of Lab Component")
                {
                    ApplicationArea = All;
                }
                field(Specilization; Rec.Specilization)
                {
                    ApplicationArea = All;
                }
                Field("Exam Opt Out"; Rec."Exam Opt Out")
                {
                    ApplicationArea = All;
                }
                field("Elective Offering"; Rec."Elective Offering")
                {
                    ApplicationArea = All;
                }
                Field("BSIC/MED4 not Applicable"; Rec."BSIC/MED4 not Applicable")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            systempart(Links; Links)
            {

            }
            systempart(Notes; Notes)
            {

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
                RunPageLink = "Subject Code" = FIELD(Code);

            }
            action("Exam Passing Criteria")
            {
                Caption = '&Exam Passing Criteria';
                PromotedOnly = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = SetupList;
                ApplicationArea = All;
                // RunObject = Page "Exam Passing Criteria";
                // RunPageLink = "Subject Code" = FIELD(Code);

            }
            action("Subject Wise Category")
            {
                Caption = 'Subject Wise Category';
                ApplicationArea = All;
                Image = EntriesList;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                // RunObject = Page "Faculty Wise Category List";
                // RunPageLink = "Subject Code" = FIELD(Code);
            }

            // action("Course Wise Faculty List")
            // {
            //     ApplicationArea = All;
            //     Image = EntriesList;
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     PromotedIsBig = true;
            //     PromotedOnly = true;
            //     RunObject = Page "Faculty-Course Wise-CS";
            //     RunPageLink = "Subject Code" = FIELD(Code);
            // }

            group("Clerkship Assesment Setup")
            {
                action("Clerkship Assessment Weightage")
                {
                    Caption = 'Clerkship Assessment Weightage';
                    Image = OpportunityList;
                    // RunObject = page "Clerkship Assessment Weightage";
                    // RunPageLink = "Course Code" = field(Code);
                }
                action("CCSSE Score Conversion")
                {
                    Caption = 'CCSSE Score Conversion';
                    Image = Opportunity;
                    // RunObject = page "CCSSE Score Conversion";
                    // RunPageLink = "Course Code" = field(Code);
                }

                action("Clerkship Grading")
                {
                    Caption = 'Clerkship Grading';
                    Image = OpportunitiesList;
                    // RunObject = page "Clerkship Grading";
                    // RunPageLink = "Course Code" = field(Code);
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        //Code added for Condition Base Flag True or False::CSPL-00092::05-06-2019: Start
        IF Rec."Type Of Course" = Rec."Type Of Course"::Year THEN BEGIN
            EditableBTNSEM := FALSE;
            EditableBTNYR := TRUE;
        END ELSE BEGIN
            EditableBTNYR := FALSE;
            EditableBTNSEM := TRUE;
        END;
        //Code added for Condition Base Flag True or False::CSPL-00092::05-06-2019: End
    end;

    trigger OnOpenPage()
    begin
        //Code added for Condition Base Flag True or False::CSPL-00092::05-06-2019: Start
        EditableBTNSEM := FALSE;
        EditableBTNYR := FALSE;

        IF recUserSetup.GET(UserId()) THEN
            IF recUserSetup."Student Subject Permission" THEN
                EditList := TRUE
            ELSE
                EditList := FALSE;
        //Code added for Condition Base Flag True or False::CSPL-00092::05-06-2019: End
    end;

    var
        recUserSetup: Record "User Setup";
        EditableBTNSEM: Boolean;
        EditableBTNYR: Boolean;
        //  EditableElective: Boolean;
        EditList: Boolean;
}

