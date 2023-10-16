page 50233 "Course Section Detail-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID       Date       Trigger                         Remarks
    // ......................................................................................
    // 01.    CSPL-00174   06-02-19     OnQueryClosePage ()            Code added for mandatory field.
    // 02.    CSPL-00174   06-02-19     Export Student - OnAction()    Code added to export students.
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Course Section Detail';
    DelayedInsert = true;
    PageType = List;
    SourceTable = "Course Section Master-CS";

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
                field(Year; Rec.Year)
                {
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field("Section Code"; Rec."Section Code")
                {
                    ApplicationArea = All;
                }
                field("Sequence No"; Rec."Sequence No")
                {
                    ApplicationArea = All;
                }
                field(Capacity; Rec.Capacity)
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
            action("Export Student")
            {
                Image = Export;
                Promoted = true;
                PromotedOnly = true;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    StudentMasterCS.Reset();
                    StudentMasterCS.SETRANGE("Course Code", Rec."Course Code");
                    IF Rec."Type Of Course" = Rec."Type Of Course"::Semester THEN
                        StudentMasterCS.SETRANGE(Semester, Rec.Semester)
                    ELSE
                        StudentMasterCS.SETRANGE(Year, Rec.Year);
                    StudentMasterCS.SETRANGE("Academic Year", Rec."Academic Year");
                    StudentMasterCS.SETRANGE(Section, Rec."Section Code");
                    XMLPORT.RUN(50004, FALSE, FALSE, StudentMasterCS);
                end;
            }
        }
    }

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        //Code added for mandatory field::CSPL-00174::060219: Start
        // TESTFIELD(Semester);
        // TESTFIELD(Year);
        // TESTFIELD("Section Code");
        // TESTFIELD("Academic Year");
        //Code added for mandatory field::CSPL-00174::060219: End
    end;

    var

        StudentMasterCS: Record "Student Master-CS";
}