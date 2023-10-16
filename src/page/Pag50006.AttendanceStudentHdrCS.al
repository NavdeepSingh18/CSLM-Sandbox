page 50006 "Attendance Student Hdr-CS"
{
    // version V.001-CS

    // Sr.No    Emp.ID        Date       Triggers                             Remarks
    // -----------------------------------------------------------------------------------------------
    // 01.     CSPL-00174   05-02-19     OnOpenPage()                        Code added for boolian field false.
    // 02.     CSPL-00174   05-02-19     Page-OnAfterGetRecord()             Code added for editable or non-editable field.
    // 03.     CSPL-00174   05-02-19     No.- OnAssistEdit()                 Code added for generate no. series .
    // 04.     CSPL-00174   05-02-19     Page-OnNewRecord()                  Code added to get value of Date.
    // 05.     CSPL-00174   05-02-19     Course Code - OnValidate()          Code added for editable or non-editable field.
    // 06.     CSPL-00174   05-02-19     Graduation - OnValidate()           Code added for editable or non-editable field.
    // 07.     CSPL-00174   05-02-19     Type Of Course - OnValidate()       Code added for editable or non-editable field.
    // 08.     CSPL-00174   05-02-19     Present All - OnValidate()          Code added for function call.
    // 09.     CSPL-00174   05-02-19     Function-ClassAttendance()          Code added on function to update Attendance line table.
    // 10.     CSPL-00174   05-02-19     Function-LOCAL PresentAllValidate() Code added to curr_page update.
    // 11.     CSPL-00174   05-02-19     Get Student - OnAction()            Code added to get students.
    // 12.     CSPL-00174   05-02-19     Attendance Generate - OnAction()    Code added to generate Attendance.

    Caption = 'Attendance Student Header';
    PageType = Document;
    UsageCategory = Administration;
    ApplicationArea = All;
    SourceTable = "Class Attendance Header-CS";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                Editable = AttendanceGenrate;
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    trigger OnAssistEdit()
                    begin
                        //Code added for generate no. series ::CSPL-00174::050219: Start
                        IF Rec.Assistedit(xRec) THEN
                            CurrPage.Update();

                        //Code added for generate no. series ::CSPL-00174::050219: END
                    end;
                }
                field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        //Code added for editable or non-editable field::CSPL-00174::050219: Start
                        IF Rec."Type Of Course" = Rec."Type Of Course"::Year THEN BEGIN
                            EditableBTNSEM := FALSE;
                            EditableBTNYR := TRUE;
                        END ELSE BEGIN
                            EditableBTNYR := FALSE;
                            EditableBTNSEM := TRUE;
                        END;
                        //Code added for editable or non-editable field::CSPL-00174::050219: End
                    end;
                }
                field("Course Name"; Rec."Course Name")
                {
                    ApplicationArea = All;
                }
                field(Graduation; Rec.Graduation)
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        //Code added for editable or non-editable field::CSPL-00174::050219: Start
                        IF Rec.Graduation = 'UG' THEN
                            EditableBTNSEM := TRUE
                        ELSE
                            EditableBTNSEM := FALSE;
                        //Code added for editable or non-editable field::CSPL-00174::050219: End
                    end;
                }
                field("Type Of Course"; Rec."Type Of Course")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        //Code added for editable or non-editable field::CSPL-00174::050219: Start
                        IF Rec."Type Of Course" = Rec."Type Of Course"::Year THEN BEGIN
                            EditableBTNSEM := FALSE;
                            EditableBTNYR := TRUE;
                        END ELSE BEGIN
                            EditableBTNYR := FALSE;
                            EditableBTNSEM := TRUE;
                        END;
                        //Code added for editable or non-editable field::CSPL-00174::050219: End
                    end;
                }
                field(Semester; Rec.Semester)
                {
                    Editable = EditableBTNSEM;
                    ApplicationArea = All;
                }
                field(Year; Rec.Year)
                {
                    Editable = EditableBTNYR;
                    ApplicationArea = All;
                }
                field(Section; Rec.Section)
                {
                    ApplicationArea = All;
                }
                Field(Term; Rec.Term)
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    Visible = true;
                    ApplicationArea = All;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    Visible = true;
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Subject Class"; Rec."Subject Class")
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
                field("Batch Code"; Rec."Batch Code")
                {
                    ApplicationArea = All;
                }
                field("Attendance Date"; Rec."Attendance Date")
                {
                    ApplicationArea = All;
                    Editable = False;
                }
                field("Time Table No"; Rec."Time Table No")
                {
                    ApplicationArea = All;
                }
                Field("Time Table Doc. No."; Rec."Time Table Doc. No.")
                {
                    ApplicationArea = All;
                }
                Field("Time Table Date"; Rec."Time Table Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Attendance By"; Rec."Attendance By")
                {
                    ApplicationArea = All;
                }
                field("Attendance By Name"; Rec."Attendance By Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Cancelled; Rec.Cancelled)
                {
                    ApplicationArea = All;
                }
                field("Attendance Marked"; Rec."Attendance Marked")
                {
                    ApplicationArea = All;
                }
                field("Room No."; Rec."Room No.")
                {
                    ApplicationArea = All;
                }
                field("Time Slot"; Rec."Time Slot")
                {
                    ApplicationArea = All;
                }
                field("Start Time"; Rec."Start Time")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("End Time"; Rec."End Time")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Present All"; Rec."Present All")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        //Code added for function call::CSPL-00174::050219: Start
                        PresentAllValidate();
                        //Code added for update field::CSPL-00174::050219: End
                    end;
                }
                field("Portal ID"; Rec."Portal ID")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }

            }
            part("Student Attendance"; "Attendance Student Line-CS")
            {
                ApplicationArea = All;
                Editable = AttendanceGenrate;
                SubPageLink = "Document No." = FIELD("No.");
            }
        }
    }

    actions
    {
        area(Processing)
        {

            action("Get Student")
            {
                ApplicationArea = All;
                Image = Employee;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                //Visible = false;
                trigger OnAction()
                begin
                    //Code added to get students::CSPL-00174::050219: Start
                    Rec.TESTFIELD("Academic Year");
                    //IF "Type Of Course" = "Type Of Course"::Semester THEN
                    Rec.TESTFIELD(Semester);
                    // ELSE
                    Rec.TESTFIELD(Year);
                    //Rec.TESTFIELD(Graduation);
                    Rec.TESTFIELD("Subject Class");
                    //Rec.TESTFIELD("Subject Type");
                    Rec.TESTFIELD("Subject Code");
                    // Rec.TESTFIELD("Attendance By");
                    // Rec.TESTFIELD("Attendance Date");

                    // IF "Present All" THEN
                    //     ERROR('All Student Are Present')
                    // ELSE
                    AttendanceActionCS.AttendanceofStudentUpdated(Rec);
                    Message('Updated');
                    //Code added to get students::CSPL-00174::050219: End
                end;
            }
            action("Attendance Generate")
            {
                ApplicationArea = All;
                Caption = 'Generate Attendance';
                Image = Approvals;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = False;

                trigger OnAction()
                begin
                    //Code added to generate Attendance::CSPL-00174::050219: Start
                    IF CONFIRM(Text0001Lbl, TRUE) THEN BEGIN
                        Rec."Attendance Generated" := TRUE;
                        Rec.Updated := TRUE;
                        ClassAttendance(Rec."Attendance Generated");
                    END;
                    //Code added to generate Attendance::CSPL-00174::050219: End
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        //Code added for editable or non-editable field::CSPL-00174::050219: Start
        IF Rec."Type Of Course" = Rec."Type Of Course"::Year THEN BEGIN
            EditableBTNSEM := FALSE;
            EditableBTNYR := TRUE;
        END ELSE BEGIN
            EditableBTNYR := FALSE;
            EditableBTNSEM := TRUE;
        END;

        IF Rec."Attendance Generated" THEN
            AttendanceGenrate := FALSE;
        //Code added for editable or non-editable field::CSPL-00174::050219: END
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        //Code added to get value of Date::CSPL-00174::050219: Start
        Rec.Date := TODAY();
        //Code added to get value of Date::CSPL-00174::050219: END
    end;

    trigger OnOpenPage()
    begin
        //Code added for boolian field false::CSPL-00174::050219: Start
        EditableBTNSEM := FALSE;
        AttendanceGenrate := TRUE;
        //Code added for boolian field false::CSPL-00174::050219: End
    end;

    var
        AttendanceActionCS: Codeunit "Attendance Action-CS";
        EditableBTNSEM: Boolean;
        EditableBTNYR: Boolean;
        AttendanceGenrate: Boolean;
        Text0001Lbl: Label 'Do You Want To Generate Attendance ?';


    local procedure PresentAllValidate()
    begin
        //Code added for curr_page update ::CSPL-00174::050219: Start
        CurrPage.Update();
        //Code added for curr_page update  ::CSPL-00174::050219: END
    end;

    procedure ClassAttendance(getAttendance: Boolean)
    var
        ClassAttendanceLineCS: Record "Class Attendance Line-CS";
    begin
        //Code added on function to update Attendance line table ::CSPL-00174::050219: Start
        ClassAttendanceLineCS.RESET();
        ClassAttendanceLineCS.SETRANGE(ClassAttendanceLineCS."Document No.", Rec."No.");
        IF ClassAttendanceLineCS.FINDFIRST() THEN
            REPEAT
                ClassAttendanceLineCS."Attendance Generated" := getAttendance;
                ClassAttendanceLineCS.Updated := TRUE;
                ClassAttendanceLineCS.Modify();
            UNTIL ClassAttendanceLineCS.NEXT() = 0;
        //Code added on function to update Attendance line table ::CSPL-00174::050219: End
    end;
}