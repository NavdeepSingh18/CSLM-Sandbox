page 50080 "Email Setup List"
{
    // version V.001-CS

    // Sr.No  Emp.ID      Date      Trigger                                Remarks
    // -----------------------------------------------------------------------------------------------
    // 01.   CSPL-00174  15-06-19  Update Subject Old Data - OnAction()    Code added for Update student Subject Old Data.
    Caption = 'Email Setup (Transcript Degree Request)';
    ApplicationArea = All;
    UsageCategory = Administration;
    DeleteAllowed = true;
    Editable = true;
    PageType = List;
    // SourceTable = "Main&Optional Sub Archive-CS";
    SourceTable = "Slab Transport-CS";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                //     field("Student No."; "Student No.")
                //     {
                //         ToolTip = 'Student No.';
                //         ApplicationArea = All;
                //     }
                //     field("Line No"; "Line No")
                //     {
                //         ToolTip = 'Line No.';
                //         ApplicationArea = All;
                //     }
                //     field("Enrollment No"; "Enrollment No")
                //     {
                //         ToolTip = 'Enrollment No.';
                //         ApplicationArea = All;
                //     }
                //     field(Semester; Semester)
                //     {
                //         ToolTip = 'Semester';
                //         ApplicationArea = All;
                //     }
                //     field(Course; Course)
                //     {
                //         ToolTip = 'Course';
                //         ApplicationArea = All;
                //     }
                //     field(Section; Section)
                //     {
                //         ToolTip = 'Section';
                //         ApplicationArea = All;
                //     }
                //     field("Subject Code"; "Subject Code")
                //     {
                //         ToolTip = 'Subject Code';
                //         ApplicationArea = All;
                //     }
                //     field(Description; Description)
                //     {
                //         ToolTip = 'Description';
                //         ApplicationArea = All;
                //     }
                //     field("Subject Type"; "Subject Type")
                //     {
                //         ToolTip = 'Subject Type';
                //         ApplicationArea = All;
                //     }
                //     field("Subject Class"; "Subject Class")
                //     {
                //         ToolTip = 'Subject Class';
                //         ApplicationArea = All;
                //     }
                //     field("Re-Registration Date"; "Re-Registration Date")
                //     {
                //         ToolTip = 'Re-Registration Date';
                //         ApplicationArea = All;
                //     }
                //     field("Actual Subject Code"; "Actual Subject Code")
                //     {
                //         ToolTip = 'Actual Subject Code';
                //         ApplicationArea = All;
                //     }
                //     field("Actual Subject Description"; "Actual Subject Description")
                //     {
                //         ToolTip = 'Actual Subject Description';
                //         ApplicationArea = All;
                //     }
                //     field("Academic Year"; "Academic Year")
                //     {
                //         ToolTip = 'Academic Year';
                //         ApplicationArea = All;
                //     }
                //     field("Attendance Type"; "Attendance Type")
                //     {
                //         ToolTip = 'Attendance Type';
                //         ApplicationArea = All;
                //     }
                //     field("Internal Mark"; "Internal Mark")
                //     {
                //         ToolTip = 'Internal Mark';
                //         ApplicationArea = All;
                //     }
                //     field("Total Internal"; "Total Internal")
                //     {
                //         ToolTip = 'Total Internal';
                //         ApplicationArea = All;
                //     }
                //     field("External Mark"; "External Mark")
                //     {
                //         ToolTip = 'External Mark';
                //         ApplicationArea = All;
                //     }
                //     field(Total; Total)
                //     {
                //         ToolTip = 'Total';
                //         ApplicationArea = All;
                //     }
                //     field("Attendance Percentage"; "Attendance Percentage")
                //     {
                //         ToolTip = 'Attendance Percentage';
                //         ApplicationArea = All;
                //     }
                //     field(Grade; Grade)
                //     {
                //         ToolTip = 'Grade';
                //         ApplicationArea = All;
                //     }
                //     field(Credit; Credit)
                //     {
                //         ToolTip = 'Credit';
                //         ApplicationArea = All;
                //     }
                //     field("Credit Earned"; "Credit Earned")
                //     {
                //         ToolTip = 'Credit Earned';
                //         ApplicationArea = All;
                //     }
                //     field("Credit Grade Points Earned"; "Credit Grade Points Earned")
                //     {
                //         ToolTip = 'Credit Grade Points Earned';
                //         ApplicationArea = All;
                //     }
                //     field("Student Status"; "Student Status")
                //     {
                //         ToolTip = 'Student Status';
                //         ApplicationArea = All;
                //     }
                //     field("Update Att. Per"; "Update Att. Per")
                //     {
                //         ToolTip = 'Update Att. Per';
                //         ApplicationArea = All;
                //     }
                //     field("Update Marks"; "Update Marks")
                //     {
                //         ToolTip = 'Update Marks';
                //         ApplicationArea = All;
                //     }
                field("Slab Code"; Rec."Slab Code")
                {
                    Caption = 'Code';
                    ToolTip = 'Specifies the value of the Slab Code field.';
                    ApplicationArea = All;
                }
                field(StudentLastNameMini; Rec.StudentLastNameMini)
                {
                    caption = 'Student Last Name Minimum Range';
                    ToolTip = 'Specifies the value of the Student Last Name Minimum Range field.';
                    ApplicationArea = All;
                }
                field(StudentLastNameMax; Rec.StudentLastNameMax)
                {
                    caption = 'Student Last Name Max Range';
                    ToolTip = 'Specifies the value of the Student Last Name Max Range field.';
                    ApplicationArea = All;
                }
                field(Email; Rec.Email)
                {
                    ToolTip = 'Specifies the value of the Email field.';
                    ApplicationArea = All;
                }
                Field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
            }

        }
    }

    actions
    {
        area(processing)
        {
            action("Update Subject Old Data")
            {
                ToolTip = 'Update Subject Old Data';
                Image = GetEntries;
                Promoted = true;

                PromotedOnly = true;
                PromotedIsBig = true;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    //Code added for Update student Subject Old Data::CSPL-00174::150619: Start
                    StudentSubOldRecCS.CreateStudentSubjectOldData();
                    StudentSubOldRecCS.CreateStudentOptionalSubjectOldData();
                    MESSAGE('Student Subject Data Updated Successfully !!')
                    //Code added for Update student Subject Old Data::CSPL-00174::150619: End
                end;
            }
        }
    }

    var
        StudentSubOldRecCS: Codeunit "Student Sub. Old Rec-CS";


}