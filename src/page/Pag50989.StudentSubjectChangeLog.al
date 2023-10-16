page 50989 "Student Subject Change Log"
{

    ApplicationArea = All;
    Caption = 'Student Subject Change Log';
    PageType = List;
    SourceTable = "Main&Optional Subject Log-CS";
    UsageCategory = History;
    Editable = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                }
                field("Enrollment No."; Rec."Enrollment No.")
                {
                    ApplicationArea = All;
                }
                field("Grade Change Type"; Rec."Grade Change Type")
                {
                    ApplicationArea = All;
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                }
                field("Modified By"; Rec."Modified By")
                {
                    ApplicationArea = All;
                }
                field("Modified On"; Rec."Modified On")
                {
                    ApplicationArea = All;
                }
                field("New Value"; Rec."New Value")
                {
                    ApplicationArea = All;
                }
                field("Old Value"; Rec."Old Value")
                {
                    ApplicationArea = All;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                }
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                }
                field("Subject Code"; Rec."Subject Code")
                {
                    ApplicationArea = All;
                }
                field("Table Type"; Rec."Table Type")
                {
                    ApplicationArea = All;
                }
                field("Stud. No."; Rec."Stud. No.")
                {
                    ApplicationArea = all;
                }
                field(Course; Rec.Course)
                {
                    ApplicationArea = all;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = all;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = all;
                }
                field(Section; Rec.Section)
                {
                    ApplicationArea = all;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = all;
                }


                //HKS >>
                // field(SystemCreatedAt;Rec.SystemCreatedAt)
                // {
                //     ApplicationArea = All;
                // }
                // field(SystemCreatedBy;Rec.SystemCreatedBy)
                // {
                //     ApplicationArea = All;
                // }
                //HKS <<

                //  field(SystemId;Rec.SystemId)
                //  {
                //      ApplicationArea = All;
                //  }

                //HKS>>
                // field(SystemModifiedAt;Rec.SystemModifiedAt)
                // {
                //     ApplicationArea = All;
                // }
                // field(SystemModifiedBy;Rec.SystemModifiedBy)
                // {
                //     ApplicationArea = All;
                // }
                //HKS <<
            }
        }
    }

}
