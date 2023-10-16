page 50124 "Qualifying Detail Stud List-CS"
{
    // version V.001-CS

    PageType = List;
    UsageCategory = Administration;
    ApplicationArea = All;
    SourceTable = "Qualifying Detail Stud-CS";
    Caption = 'Qualifying Detail Student List';
    DelayedInsert = true;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                    NotBlank = true;
                    ShowMandatory = true;
                    editable = false;
                }
                field("SLcM ID"; Rec."SLcM ID")
                {
                    ApplicationArea = All;
                }
                field("Qualifying Exam"; Rec."Qualifying Exam")
                {
                    ApplicationArea = All;
                    NotBlank = true;
                    ShowMandatory = true;
                }
                field("Qualifying Year of Passing"; Rec."Qualifying Year of Passing")
                {
                    ApplicationArea = All;
                    Caption = 'Year of Passing';
                }
                field("Exam Marks/Grade/Points"; Rec."Exam Marks/Grade/Points")
                {
                    ApplicationArea = All;
                }
                field("College last Studied"; Rec."College last Studied")
                {
                    ApplicationArea = All;
                }
                field("University/Board"; Rec."University/Board")
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

                field("18 Digit Test ID"; Rec."18 Digit Test ID")
                {
                    ApplicationArea = All;
                }
                field(Test; Rec.Test)
                {
                    ApplicationArea = All;
                }
                field("18 Digit Student ID"; Rec."18 Digit Student ID")
                {
                    ApplicationArea = All;
                }
                field("MCAT Test Score"; Rec."MCAT Test Score")
                {
                    ApplicationArea = All;
                }
                field("NBME Comp Test Score"; Rec."NBME Comp Test Score")
                {
                    ApplicationArea = All;
                }
                field("New MCAT 2015 Test Score"; Rec."New MCAT 2015 Test Score")
                {
                    ApplicationArea = All;
                }
                field("Overall Score"; Rec."Overall Score")
                {
                    ApplicationArea = All;
                }
                field("MCAT Biological Science"; Rec."MCAT Biological Science")
                {
                    ApplicationArea = All;
                }
                field("MCAT Physical Science"; Rec."MCAT Physical Science")
                {
                    ApplicationArea = All;
                }
                field("MCAT Total Score"; Rec."MCAT Total Score")
                {
                    ApplicationArea = All;
                }
                field("MCAT Verbal Reasoning"; Rec."MCAT Verbal Reasoning")
                {
                    ApplicationArea = All;
                }
                field("MCAT Writing"; Rec."MCAT Writing 1")
                {
                    ApplicationArea = All;
                }
                Field("MCAT Psychological"; Rec."MCAT Psychological")
                {
                    ApplicationArea = All;
                }
                field("Test Date"; Rec."Test Date")
                {
                    ApplicationArea = All;
                }
                field("USMLE Step 1 Score"; Rec."USMLE Step 1 Score")
                {
                    ApplicationArea = All;
                }
                field("USMLE Step 2 CK Score"; Rec."USMLE Step 2 CK Score")
                {
                    ApplicationArea = All;
                }
                field("USMLE Step 2 CS Score"; Rec."USMLE Step 2 CS Score")
                {
                    ApplicationArea = All;
                }
                field("USMLE Test Score"; Rec."USMLE Test Score")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}